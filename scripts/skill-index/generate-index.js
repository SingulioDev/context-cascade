#!/usr/bin/env node
/**
 * generate-index.js - Build searchable skill index from all SKILL.md files
 *
 * Extracts:
 * - Skill name, description, category
 * - Trigger keywords from TRIGGER_POSITIVE, "When to Use", description
 * - Negative triggers from "When NOT to Use"
 * - Supporting files (anti-patterns, examples, etc.)
 *
 * Outputs: skill-index.json
 */

const fs = require('fs');
const path = require('path');

const PLUGIN_DIR = 'C:/Users/17175/claude-code-plugins/context-cascade';
const SKILLS_DIR = path.join(PLUGIN_DIR, 'skills');
const OUTPUT_FILE = path.join(PLUGIN_DIR, 'scripts/skill-index/skill-index.json');

// Stopwords to filter out
const STOPWORDS = new Set([
  'the', 'a', 'an', 'is', 'are', 'was', 'were', 'be', 'been', 'being',
  'have', 'has', 'had', 'do', 'does', 'did', 'will', 'would', 'could', 'should',
  'may', 'might', 'must', 'shall', 'can', 'need', 'dare', 'ought', 'used',
  'to', 'of', 'in', 'for', 'on', 'with', 'at', 'by', 'from', 'as', 'into',
  'through', 'during', 'before', 'after', 'above', 'below', 'between',
  'and', 'or', 'but', 'if', 'then', 'else', 'when', 'where', 'why', 'how',
  'all', 'each', 'every', 'both', 'few', 'more', 'most', 'other', 'some',
  'such', 'no', 'not', 'only', 'own', 'same', 'so', 'than', 'too', 'very',
  'just', 'also', 'now', 'here', 'there', 'this', 'that', 'these', 'those',
  'it', 'its', 'you', 'your', 'we', 'our', 'they', 'their', 'i', 'my',
  'use', 'using', 'used', 'skill', 'skills', 'agent', 'agents', 'task', 'tasks'
]);

// Category keywords for routing
const CATEGORY_KEYWORDS = {
  'delivery': ['feature', 'implement', 'build', 'develop', 'create', 'add', 'new', 'frontend', 'backend', 'api', 'sparc'],
  'quality': ['test', 'audit', 'review', 'verify', 'validate', 'check', 'quality', 'coverage', 'lint', 'style'],
  'security': ['security', 'auth', 'authentication', 'permission', 'vulnerability', 'pentest', 'compliance', 'encrypt'],
  'research': ['research', 'find', 'discover', 'analyze', 'investigate', 'study', 'literature', 'paper', 'synthesis'],
  'orchestration': ['coordinate', 'orchestrate', 'swarm', 'parallel', 'workflow', 'pipeline', 'cascade', 'hive'],
  'operations': ['deploy', 'devops', 'cicd', 'infrastructure', 'docker', 'kubernetes', 'terraform', 'monitor'],
  'platforms': ['platform', 'database', 'ml', 'neural', 'flow', 'nexus', 'codex', 'gemini', 'multi-model'],
  'foundry': ['create', 'agent', 'skill', 'template', 'forge', 'generator', 'builder', 'prompt'],
  'specialists': ['business', 'finance', 'domain', 'expert', 'specialist', 'industry'],
  'tooling': ['documentation', 'docs', 'github', 'pr', 'issue', 'release', 'tool']
};

/**
 * Find all SKILL.md files recursively
 */
function findSkillFiles(dir) {
  const results = [];

  function walk(currentDir) {
    try {
      const files = fs.readdirSync(currentDir);
      for (const file of files) {
        const filePath = path.join(currentDir, file);
        const stat = fs.statSync(filePath);
        if (stat.isDirectory()) {
          walk(filePath);
        } else if (file === 'SKILL.md') {
          results.push(filePath);
        }
      }
    } catch (e) {
      // Skip inaccessible directories
    }
  }

  walk(dir);
  return results;
}

/**
 * Parse YAML frontmatter from markdown
 */
function parseFrontmatter(content) {
  const match = content.match(/^---\n([\s\S]*?)\n---/);
  if (!match) return {};

  const yaml = match[1];
  const result = {};

  // Simple YAML parsing (key: value)
  const lines = yaml.split('\n');
  let currentKey = null;
  let currentValue = [];

  for (const line of lines) {
    const keyMatch = line.match(/^(\w[\w-]*)\s*:\s*(.*)$/);
    if (keyMatch) {
      if (currentKey) {
        result[currentKey] = currentValue.length > 1 ? currentValue : currentValue[0] || '';
      }
      currentKey = keyMatch[1];
      const value = keyMatch[2].trim();
      if (value.startsWith('[') || value.startsWith('{') || value === '|' || value === '>') {
        currentValue = [];
      } else {
        currentValue = [value.replace(/^["']|["']$/g, '')];
      }
    } else if (currentKey && line.match(/^\s+-\s+/)) {
      currentValue.push(line.replace(/^\s+-\s+/, '').trim());
    } else if (currentKey && line.match(/^\s+\w/)) {
      currentValue.push(line.trim());
    }
  }
  if (currentKey) {
    result[currentKey] = currentValue.length > 1 ? currentValue : currentValue[0] || '';
  }

  return result;
}

/**
 * Extract section content from markdown
 */
function extractSection(content, sectionName) {
  const patterns = [
    new RegExp(`## ${sectionName}[\\s\\S]*?(?=##|$)`, 'i'),
    new RegExp(`### ${sectionName}[\\s\\S]*?(?=###|##|$)`, 'i')
  ];

  for (const pattern of patterns) {
    const match = content.match(pattern);
    if (match) {
      return match[0];
    }
  }
  return '';
}

/**
 * Extract keywords from text
 */
function extractKeywords(text) {
  if (!text) return [];

  // Convert to lowercase and extract words
  const words = text.toLowerCase()
    .replace(/[^a-z0-9\s-]/g, ' ')
    .split(/\s+/)
    .filter(w => w.length > 2)
    .filter(w => !STOPWORDS.has(w));

  // Count occurrences
  const counts = {};
  for (const word of words) {
    counts[word] = (counts[word] || 0) + 1;
  }

  // Return unique keywords sorted by frequency
  return Object.keys(counts).sort((a, b) => counts[b] - counts[a]);
}

/**
 * Get category from file path
 */
function getCategoryFromPath(filePath) {
  const relativePath = path.relative(SKILLS_DIR, filePath);
  const parts = relativePath.split(path.sep);
  return parts[0] || 'unknown';
}

/**
 * Get supporting files in skill directory
 */
function getSupportingFiles(skillDir) {
  const files = [];
  try {
    const entries = fs.readdirSync(skillDir);
    for (const entry of entries) {
      const fullPath = path.join(skillDir, entry);
      const stat = fs.statSync(fullPath);
      if (stat.isFile() && entry.endsWith('.md')) {
        files.push(entry);
      } else if (stat.isDirectory() && entry === 'examples') {
        files.push('examples/');
      }
    }
  } catch (e) {
    // Directory not readable
  }
  return files;
}

/**
 * Process a single SKILL.md file
 */
function processSkillFile(filePath) {
  try {
    const content = fs.readFileSync(filePath, 'utf-8');
    const frontmatter = parseFrontmatter(content);
    const skillDir = path.dirname(filePath);
    const category = getCategoryFromPath(filePath);

    // Extract name
    const name = frontmatter.name || path.basename(skillDir);

    // Extract description
    const description = frontmatter.description || '';

    // Extract triggers from multiple sources
    const triggerSources = [
      description,
      extractSection(content, 'When to Use'),
      extractSection(content, 'TRIGGER_POSITIVE'),
      extractSection(content, 'Purpose'),
      Array.isArray(frontmatter['x-tags']) ? frontmatter['x-tags'].join(' ') : ''
    ];

    const triggers = extractKeywords(triggerSources.join(' '));

    // Extract negative triggers
    const negativeSources = [
      extractSection(content, 'When NOT to Use'),
      extractSection(content, 'TRIGGER_NEGATIVE')
    ];
    const negativeTriggers = extractKeywords(negativeSources.join(' '));

    // Get supporting files
    const files = getSupportingFiles(skillDir);

    return {
      name,
      path: path.relative(PLUGIN_DIR, skillDir).replace(/\\/g, '/') + '/',
      category,
      description: description.substring(0, 200),
      triggers: triggers.slice(0, 20),
      negativeTriggers: negativeTriggers.slice(0, 10),
      files,
      tags: Array.isArray(frontmatter['x-tags']) ? frontmatter['x-tags'] : []
    };
  } catch (e) {
    console.error(`Error processing ${filePath}: ${e.message}`);
    return null;
  }
}

/**
 * Build keyword index (keyword -> [skills])
 */
function buildKeywordIndex(skills) {
  const index = {};

  for (const [name, skill] of Object.entries(skills)) {
    for (const keyword of skill.triggers) {
      if (!index[keyword]) {
        index[keyword] = [];
      }
      if (!index[keyword].includes(name)) {
        index[keyword].push(name);
      }
    }
  }

  // Sort by number of skills (most specific keywords first)
  const sorted = {};
  for (const key of Object.keys(index).sort((a, b) => index[a].length - index[b].length)) {
    sorted[key] = index[key];
  }

  return sorted;
}

/**
 * Build category index
 */
function buildCategoryIndex(skills) {
  const categories = {};

  for (const [name, skill] of Object.entries(skills)) {
    const cat = skill.category;
    if (!categories[cat]) {
      categories[cat] = {
        description: '',
        skills: [],
        keywords: CATEGORY_KEYWORDS[cat] || []
      };
    }
    categories[cat].skills.push(name);
  }

  return categories;
}

/**
 * Main function
 */
function main() {
  console.log('Generating skill index...');
  console.log(`Skills directory: ${SKILLS_DIR}`);

  // Find all SKILL.md files
  const skillFiles = findSkillFiles(SKILLS_DIR);
  console.log(`Found ${skillFiles.length} SKILL.md files`);

  // Process each skill
  const skills = {};
  for (const filePath of skillFiles) {
    const skill = processSkillFile(filePath);
    if (skill) {
      skills[skill.name] = skill;
    }
  }

  console.log(`Processed ${Object.keys(skills).length} skills`);

  // Build indices
  const keywordIndex = buildKeywordIndex(skills);
  const categories = buildCategoryIndex(skills);

  // Build final index
  const index = {
    version: '1.0.0',
    generated: new Date().toISOString(),
    total_skills: Object.keys(skills).length,
    categories,
    skills,
    keyword_index: keywordIndex,
    category_keywords: CATEGORY_KEYWORDS
  };

  // Write output
  fs.writeFileSync(OUTPUT_FILE, JSON.stringify(index, null, 2));
  console.log(`Index written to ${OUTPUT_FILE}`);

  // Print summary
  console.log('\n=== Summary ===');
  console.log(`Total skills: ${index.total_skills}`);
  console.log(`Categories: ${Object.keys(categories).length}`);
  console.log(`Keywords indexed: ${Object.keys(keywordIndex).length}`);

  console.log('\nSkills per category:');
  for (const [cat, data] of Object.entries(categories)) {
    console.log(`  ${cat}: ${data.skills.length}`);
  }
}

main();
