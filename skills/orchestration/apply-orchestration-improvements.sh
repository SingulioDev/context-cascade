#!/bin/bash

# Apply orchestration-specific prompt improvements to all .md files
# in the orchestration skills directory

ORCH_DIR="C:/Users/17175/claude-code-plugins/ruv-sparc-three-loop-system/skills/orchestration"
TEMP_FILE=$(mktemp)
COUNT=0

# Function to detect skill type from file path and content
detect_skill_type() {
    local file="$1"
    local filename=$(basename "$file")
    local dirpath=$(dirname "$file")

    # Read first 50 lines to analyze
    local content=$(head -50 "$file")

    # Determine skill category
    if echo "$dirpath" | grep -q "cascade"; then
        echo "cascade"
    elif echo "$dirpath" | grep -q "swarm"; then
        echo "swarm"
    elif echo "$dirpath" | grep -q "hive-mind"; then
        echo "hive-mind"
    elif echo "$dirpath" | grep -q "coordination"; then
        echo "coordination"
    elif echo "$dirpath" | grep -q "parallel-swarm"; then
        echo "parallel-swarm"
    elif echo "$dirpath" | grep -q "flow-nexus"; then
        echo "flow-nexus"
    elif echo "$content" | grep -qi "swarm"; then
        echo "swarm"
    elif echo "$content" | grep -qi "cascade"; then
        echo "cascade"
    elif echo "$content" | grep -qi "hive"; then
        echo "hive-mind"
    else
        echo "generic-orchestration"
    fi
}

# Function to generate skill-specific improvements
generate_improvements() {
    local skill_type="$1"

    case "$skill_type" in
        cascade)
            cat <<'EOF'

## Orchestration Skill Guidelines

### When to Use This Skill
- **Multi-stage workflows** requiring sequential, parallel, or conditional execution
- **Complex pipelines** coordinating multiple micro-skills or agents
- **Iterative processes** with Codex sandbox testing and auto-fix loops
- **Multi-model routing** requiring intelligent AI selection per stage
- **Production workflows** needing GitHub integration and memory persistence

### When NOT to Use This Skill
- **Single-agent tasks** with no coordination requirements
- **Simple sequential work** that doesn't need stage management
- **Trivial operations** completing in <5 minutes
- **Pure research** without implementation stages

### Success Criteria
- **All stages complete** with 100% success rate
- **Dependency resolution** with no circular dependencies
- **Model routing optimal** for each stage (Gemini/Codex/Claude)
- **Memory persistence** maintained across all stages
- **No orphaned stages** - all stages tracked and completed

### Edge Cases to Handle
- **Stage failure mid-cascade** - Implement retry with exponential backoff
- **Circular dependencies** - Validate DAG structure before execution
- **Model unavailability** - Have fallback model selection per stage
- **Memory overflow** - Implement stage result compression
- **Timeout on long stages** - Configure per-stage timeout limits

### Guardrails (NEVER Violate)
- **NEVER lose stage state** - Persist after each stage completion
- **ALWAYS validate dependencies** - Check DAG acyclic before execution
- **ALWAYS track cascade progress** - Update memory with real-time status
- **NEVER skip error handling** - Every stage needs try/catch with fallback
- **ALWAYS cleanup on failure** - Release resources, clear temp state

### Evidence-Based Validation
- **Verify stage outputs** - Check actual results vs expected schema
- **Validate data flow** - Confirm outputs passed correctly to next stage
- **Check model routing** - Verify correct AI used per stage requirements
- **Measure cascade performance** - Track execution time vs estimates
- **Audit memory usage** - Ensure no memory leaks across stages

EOF
            ;;
        swarm|parallel-swarm)
            cat <<'EOF'

## Orchestration Skill Guidelines

### When to Use This Skill
- **Parallel multi-agent execution** requiring concurrent task processing
- **Complex implementation** with 6+ independent tasks
- **Theater-free development** requiring 0% tolerance validation
- **Dynamic agent selection** from 86+ agent registry
- **High-quality delivery** needing Byzantine consensus validation

### When NOT to Use This Skill
- **Single-agent tasks** with no parallelization benefit
- **Simple sequential work** completing in <2 hours
- **Planning phase** (use research-driven-planning first)
- **Trivial changes** to single files

### Success Criteria
- **Agent+skill matrix generated** with optimal assignments
- **Parallel execution successful** with 8.3x speedup achieved
- **Theater detection passes** with 0% theater detected
- **Integration tests pass** at 100% rate
- **All agents complete** with no orphaned workers

### Edge Cases to Handle
- **Agent failures** - Implement agent health monitoring and replacement
- **Task timeout** - Configure per-task timeout with escalation
- **Consensus failure** - Have fallback from Byzantine to weighted consensus
- **Resource exhaustion** - Limit max parallel agents, queue excess
- **Conflicting outputs** - Implement merge conflict resolution strategy

### Guardrails (NEVER Violate)
- **NEVER lose agent state** - Persist agent progress to memory continuously
- **ALWAYS track swarm health** - Monitor all agent statuses in real-time
- **ALWAYS validate consensus** - Require 4/5 agreement for theater detection
- **NEVER skip theater audit** - Zero tolerance, any theater blocks merge
- **ALWAYS cleanup workers** - Terminate agents on completion/failure

### Evidence-Based Validation
- **Check all agent statuses** - Verify each agent completed successfully
- **Validate parallel execution** - Confirm tasks ran concurrently, not sequentially
- **Measure speedup** - Calculate actual speedup vs sequential baseline
- **Audit theater detection** - Run 6-agent consensus, verify 0% detection
- **Verify integration** - Execute sandbox tests, confirm 100% pass rate

EOF
            ;;
        hive-mind)
            cat <<'EOF'

## Orchestration Skill Guidelines

### When to Use This Skill
- **Queen-led coordination** requiring hierarchical multi-agent control
- **Consensus-driven decisions** needing Byzantine fault tolerance
- **Collective intelligence** tasks benefiting from shared memory
- **Strategic planning** with tactical execution delegation
- **Large-scale swarms** with 10+ specialized worker agents

### When NOT to Use This Skill
- **Single-agent tasks** with no coordination requirements
- **Simple workflows** without consensus needs
- **Flat topologies** where hierarchy adds no value
- **Ephemeral tasks** not needing collective memory

### Success Criteria
- **Queen successfully coordinates** all worker agents
- **Consensus achieved** using configured algorithm (majority/weighted/Byzantine)
- **Collective memory shared** across all agents with <10ms access time
- **All workers complete tasks** with 100% assignment success
- **Session state persisted** with checkpoint recovery capability

### Edge Cases to Handle
- **Queen failure** - Implement queen failover and re-election
- **Worker unresponsiveness** - Timeout detection and task reassignment
- **Consensus deadlock** - Fallback to weighted or majority consensus
- **Memory corruption** - Validate memory integrity with checksums
- **Session crash** - Resume from last checkpoint with full state recovery

### Guardrails (NEVER Violate)
- **NEVER lose collective memory** - Persist to SQLite with WAL mode
- **ALWAYS validate queen health** - Monitor queen heartbeat continuously
- **ALWAYS track worker states** - Real-time worker status in shared memory
- **NEVER skip consensus** - Critical decisions require configured consensus
- **ALWAYS checkpoint sessions** - Save state at key milestones

### Evidence-Based Validation
- **Verify queen coordination** - Check queen issued commands to all workers
- **Validate consensus results** - Confirm vote counts meet algorithm threshold
- **Check memory consistency** - Query collective memory, verify no conflicts
- **Measure worker efficiency** - Calculate task completion rate per worker
- **Audit session recovery** - Test checkpoint restore, verify full state

EOF
            ;;
        coordination|flow-nexus)
            cat <<'EOF'

## Orchestration Skill Guidelines

### When to Use This Skill
- **Multi-agent coordination** requiring topology-aware task distribution
- **Cloud-based orchestration** with Flow Nexus platform integration
- **Event-driven workflows** needing message-based coordination
- **Distributed systems** spanning multiple execution environments
- **Scalable swarms** with adaptive topology management

### When NOT to Use This Skill
- **Single-agent tasks** with no coordination overhead
- **Local-only execution** not using cloud features
- **Simple sequential work** without event-driven needs
- **Static topologies** not requiring adaptive scaling

### Success Criteria
- **Coordination topology established** (mesh/hierarchical/star)
- **All agents registered** in coordination namespace
- **Event routing functional** with <50ms message latency
- **No coordination deadlocks** - All agents progressing
- **Scalability validated** - Handles target agent count

### Edge Cases to Handle
- **Network partitions** - Implement partition tolerance with eventual consistency
- **Message loss** - Add message acknowledgment and retry logic
- **Agent disconnection** - Detect disconnects, redistribute work
- **Topology reconfiguration** - Support live topology changes without restart
- **Rate limiting** - Handle cloud API rate limits with backoff

### Guardrails (NEVER Violate)
- **NEVER lose coordination state** - Persist topology and agent registry
- **ALWAYS validate topology** - Check for cycles, orphaned nodes
- **ALWAYS monitor message queues** - Prevent queue overflow
- **NEVER skip health checks** - Continuous agent liveness monitoring
- **ALWAYS handle failures gracefully** - No cascading failures

### Evidence-Based Validation
- **Verify topology structure** - Validate graph properties (connected, acyclic if needed)
- **Check message delivery** - Confirm all messages reached targets
- **Measure coordination overhead** - Calculate % time spent on coordination vs work
- **Validate agent reachability** - Ping all agents, verify responses
- **Audit scalability** - Test with max agent count, measure performance

EOF
            ;;
        *)
            cat <<'EOF'

## Orchestration Skill Guidelines

### When to Use This Skill
- **Multi-agent coordination** requiring centralized orchestration
- **Complex workflows** with multiple dependent tasks
- **Parallel execution** benefiting from concurrent agent spawning
- **Quality-controlled delivery** needing validation and consensus
- **Production workflows** requiring audit trails and state management

### When NOT to Use This Skill
- **Single-agent tasks** with no coordination requirements
- **Simple sequential work** completing in <30 minutes
- **Trivial operations** with no quality gates
- **Exploratory work** not needing formal orchestration

### Success Criteria
- **All agents complete successfully** with 100% task completion
- **Coordination overhead minimal** (<20% of total execution time)
- **No orphaned agents** - All spawned agents tracked and terminated
- **State fully recoverable** - Can resume from any failure point
- **Quality gates pass** - All validation checks successful

### Edge Cases to Handle
- **Agent failures** - Detect and replace failed agents automatically
- **Timeout scenarios** - Configure per-agent timeout with escalation
- **Resource exhaustion** - Limit concurrent agents, queue excess work
- **Conflicting results** - Implement conflict resolution strategy
- **Partial completion** - Support incremental progress with rollback

### Guardrails (NEVER Violate)
- **NEVER lose orchestration state** - Persist to memory after each phase
- **ALWAYS track all agents** - Maintain real-time agent registry
- **ALWAYS cleanup resources** - Terminate agents and free memory on completion
- **NEVER skip validation** - Run quality checks before marking complete
- **ALWAYS handle errors** - Every orchestration step needs error handling

### Evidence-Based Validation
- **Verify all agent outputs** - Check actual results vs expected contracts
- **Validate execution order** - Confirm dependencies respected
- **Measure performance** - Track execution time vs baseline
- **Check resource usage** - Monitor memory, CPU, network during execution
- **Audit state consistency** - Verify orchestration state matches reality

EOF
            ;;
    esac
}

# Process all .md files
find "$ORCH_DIR" -name "*.md" -type f | while read -r file; do
    echo "Processing: $file"

    # Detect if file has YAML frontmatter
    if head -1 "$file" | grep -q "^---$"; then
        # Find the end of YAML frontmatter (second ---)
        YAML_END=$(awk '/^---$/ {count++; if(count==2) {print NR; exit}}' "$file")

        if [ -n "$YAML_END" ]; then
            # Detect skill type
            SKILL_TYPE=$(detect_skill_type "$file")

            # Extract frontmatter
            head -n "$YAML_END" "$file" > "$TEMP_FILE"

            # Add improvements
            generate_improvements "$SKILL_TYPE" >> "$TEMP_FILE"

            # Add rest of file
            tail -n +"$((YAML_END + 1))" "$file" >> "$TEMP_FILE"

            # Replace original
            mv "$TEMP_FILE" "$file"

            COUNT=$((COUNT + 1))
            echo "  -> Added $SKILL_TYPE orchestration improvements"
        else
            echo "  -> Skipped (no YAML end marker)"
        fi
    else
        echo "  -> Skipped (no YAML frontmatter)"
    fi
done

echo ""
echo "COMPLETE: Applied orchestration improvements to $COUNT files"
