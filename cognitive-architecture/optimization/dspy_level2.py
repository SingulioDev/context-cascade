"""
DSPy Level 2: Per-cluster prompt expression caching.

Cadence: Minutes to hours
Scope: Compile prompts per cluster key (frame_set + verix_strictness)

This layer caches compiled prompts by cluster, reducing latency
and ensuring consistency within evaluation runs.
"""

import os
import json
import time
import hashlib
from dataclasses import dataclass, field
from typing import Dict, List, Any, Optional, Tuple
from pathlib import Path
import sys

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from core.config import FullConfig, VectorCodec
from core.prompt_builder import PromptBuilder


@dataclass
class CompiledPrompt:
    """A compiled prompt with metadata."""

    cluster_key: str
    system_prompt: str
    user_template: str
    config_vector: List[float]
    compiled_at: float = field(default_factory=time.time)
    version: int = 1
    metadata: Dict[str, Any] = field(default_factory=dict)

    def to_dict(self) -> Dict[str, Any]:
        return {
            "cluster_key": self.cluster_key,
            "system_prompt": self.system_prompt,
            "user_template": self.user_template,
            "config_vector": self.config_vector,
            "compiled_at": self.compiled_at,
            "version": self.version,
            "metadata": self.metadata,
        }

    @classmethod
    def from_dict(cls, data: Dict[str, Any]) -> "CompiledPrompt":
        return cls(
            cluster_key=data["cluster_key"],
            system_prompt=data["system_prompt"],
            user_template=data["user_template"],
            config_vector=data["config_vector"],
            compiled_at=data.get("compiled_at", time.time()),
            version=data.get("version", 1),
            metadata=data.get("metadata", {}),
        )

    def age_seconds(self) -> float:
        """Get age of compiled prompt in seconds."""
        return time.time() - self.compiled_at


@dataclass
class ClusterCache:
    """Cache for compiled prompts by cluster."""

    cache_dir: Path
    max_age_seconds: float = 3600.0  # 1 hour default
    _cache: Dict[str, CompiledPrompt] = field(default_factory=dict)

    def __post_init__(self):
        self.cache_dir = Path(self.cache_dir)
        self.cache_dir.mkdir(parents=True, exist_ok=True)
        self._load_from_disk()

    def get(self, cluster_key: str) -> Optional[CompiledPrompt]:
        """
        Get cached prompt by cluster key.

        Returns None if not cached or expired.
        """
        if cluster_key in self._cache:
            prompt = self._cache[cluster_key]
            if prompt.age_seconds() < self.max_age_seconds:
                return prompt
            # Expired - remove
            del self._cache[cluster_key]

        return None

    def put(self, prompt: CompiledPrompt) -> None:
        """Cache a compiled prompt."""
        self._cache[prompt.cluster_key] = prompt
        self._save_to_disk(prompt)

    def invalidate(self, cluster_key: str) -> bool:
        """
        Invalidate cached prompt.

        Returns True if prompt was cached.
        """
        if cluster_key in self._cache:
            del self._cache[cluster_key]
            cache_file = self._cache_file(cluster_key)
            if cache_file.exists():
                cache_file.unlink()
            return True
        return False

    def invalidate_all(self) -> int:
        """Invalidate all cached prompts. Returns count."""
        count = len(self._cache)
        self._cache.clear()
        for f in self.cache_dir.glob("*.json"):
            f.unlink()
        return count

    def list_clusters(self) -> List[str]:
        """List all cached cluster keys."""
        return list(self._cache.keys())

    def stats(self) -> Dict[str, Any]:
        """Get cache statistics."""
        return {
            "cached_count": len(self._cache),
            "oldest_age": max(
                (p.age_seconds() for p in self._cache.values()),
                default=0.0
            ),
            "newest_age": min(
                (p.age_seconds() for p in self._cache.values()),
                default=0.0
            ),
        }

    def _cache_file(self, cluster_key: str) -> Path:
        """Get cache file path for cluster key."""
        safe_key = hashlib.md5(cluster_key.encode()).hexdigest()
        return self.cache_dir / f"{safe_key}.json"

    def _save_to_disk(self, prompt: CompiledPrompt) -> None:
        """Persist prompt to disk."""
        cache_file = self._cache_file(prompt.cluster_key)
        with open(cache_file, "w") as f:
            json.dump(prompt.to_dict(), f, indent=2)

    def _load_from_disk(self) -> None:
        """Load cached prompts from disk."""
        for cache_file in self.cache_dir.glob("*.json"):
            try:
                with open(cache_file) as f:
                    data = json.load(f)
                prompt = CompiledPrompt.from_dict(data)
                if prompt.age_seconds() < self.max_age_seconds:
                    self._cache[prompt.cluster_key] = prompt
                else:
                    cache_file.unlink()  # Remove expired
            except Exception:
                pass  # Skip corrupted cache files


class DSPyLevel2Optimizer:
    """
    Level 2 prompt optimization: per-cluster caching.

    Compiles prompts for each unique cluster (config combination)
    and caches them for fast repeated access during evaluation.
    """

    def __init__(
        self,
        cache_dir: Optional[Path] = None,
        max_cache_age: float = 3600.0,
    ):
        """
        Initialize L2 optimizer.

        Args:
            cache_dir: Directory for cache storage
            max_cache_age: Maximum cache age in seconds
        """
        if cache_dir is None:
            cache_dir = Path(__file__).parent.parent / "storage" / "prompts"

        self.cache = ClusterCache(
            cache_dir=cache_dir,
            max_age_seconds=max_cache_age,
        )
        self._compile_count = 0
        self._cache_hits = 0

    def get_prompt(
        self,
        config: FullConfig,
        task_type: str = "default",
    ) -> CompiledPrompt:
        """
        Get compiled prompt for configuration.

        Uses cache if available, otherwise compiles and caches.

        Args:
            config: Full configuration
            task_type: Type of task

        Returns:
            Compiled prompt
        """
        cluster_key = VectorCodec.cluster_key(config)
        cache_key = f"{cluster_key}:{task_type}"

        # Check cache
        cached = self.cache.get(cache_key)
        if cached:
            self._cache_hits += 1
            return cached

        # Compile new prompt
        prompt = self._compile(config, task_type)
        self.cache.put(prompt)
        self._compile_count += 1

        return prompt

    def get_prompts_for_vector(
        self,
        vector: List[float],
        task_type: str = "default",
    ) -> CompiledPrompt:
        """
        Get compiled prompt for config vector.

        Args:
            vector: Configuration vector
            task_type: Type of task

        Returns:
            Compiled prompt
        """
        config = VectorCodec.decode(vector)
        return self.get_prompt(config, task_type)

    def compile_batch(
        self,
        configs: List[FullConfig],
        task_type: str = "default",
    ) -> List[CompiledPrompt]:
        """
        Pre-compile prompts for multiple configurations.

        Args:
            configs: List of configurations
            task_type: Type of task

        Returns:
            List of compiled prompts
        """
        prompts = []
        for config in configs:
            prompt = self.get_prompt(config, task_type)
            prompts.append(prompt)
        return prompts

    def warm_cache(
        self,
        vectors: List[List[float]],
        task_type: str = "default",
    ) -> int:
        """
        Warm cache with config vectors.

        Args:
            vectors: List of config vectors
            task_type: Type of task

        Returns:
            Number of new prompts compiled
        """
        new_count = 0
        for vector in vectors:
            config = VectorCodec.decode(vector)
            cluster_key = VectorCodec.cluster_key(config)
            cache_key = f"{cluster_key}:{task_type}"

            if self.cache.get(cache_key) is None:
                self.get_prompt(config, task_type)
                new_count += 1

        return new_count

    def stats(self) -> Dict[str, Any]:
        """Get optimizer statistics."""
        cache_stats = self.cache.stats()
        total_requests = self._compile_count + self._cache_hits
        hit_rate = self._cache_hits / total_requests if total_requests > 0 else 0.0

        return {
            "compile_count": self._compile_count,
            "cache_hits": self._cache_hits,
            "hit_rate": hit_rate,
            **cache_stats,
        }

    def _compile(
        self,
        config: FullConfig,
        task_type: str,
    ) -> CompiledPrompt:
        """Compile prompt for configuration."""
        builder = PromptBuilder(config)
        system_prompt, user_template = builder.build("{task}", task_type)

        cluster_key = VectorCodec.cluster_key(config)
        cache_key = f"{cluster_key}:{task_type}"

        return CompiledPrompt(
            cluster_key=cache_key,
            system_prompt=system_prompt,
            user_template=user_template,
            config_vector=VectorCodec.encode(config),
            metadata={
                "task_type": task_type,
                "frame_count": config.framework.frame_count(),
                "verix_strictness": config.prompt.verix_strictness.value,
            },
        )


# Utility functions

def create_l2_optimizer(
    cache_dir: Optional[Path] = None,
    max_cache_age: float = 3600.0,
) -> DSPyLevel2Optimizer:
    """Create L2 optimizer with default settings."""
    return DSPyLevel2Optimizer(
        cache_dir=cache_dir,
        max_cache_age=max_cache_age,
    )


def get_cluster_key(config: FullConfig) -> str:
    """Get cluster key for configuration."""
    return VectorCodec.cluster_key(config)
