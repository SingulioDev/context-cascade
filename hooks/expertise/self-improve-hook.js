/**
 * Self-Improve Hook for Expertise System
 *
 * TRIGGERS: After successful Loop 2 build (100% test pass)
 * PURPOSE: Auto-update expertise files based on build learnings
 * CRITICAL: Updates MUST pass adversarial validation before applying
 *
 * Based on Agent Experts paradigm:
 * "You don't need to tell an expert to learn. It's in their DNA."
 *
 * Pre-Mortem Hardened:
 * - Correctability over correctness
 * - Falsifiable claims only
 * - Adversarial validation required
 * - Learning delta tracked
 */

const fs = require('fs');
const path = require('path');
const yaml = require('js-yaml');
const { execSync } = require('child_process');

// Configuration
const EXPERTISE_DIR = '.claude/expertise';
const ARTIFACTS_DIR = '.claude/.artifacts';
const ADVERSARIAL_SURVIVAL_THRESHOLD = 0.7;  // 70% survival required

/**
 * Main self-improve hook entry point
 * Called after Loop 2 Step 9 completes successfully
 */
async function selfImproveHook(context) {
  console.log('===========================================');
  console.log('SELF-IMPROVE HOOK: Initiating expertise update');
  console.log('===========================================');

  const { buildResult, changedFiles, testResults } = context;

  // Gate: Only run on successful builds
  if (testResults.successRate < 1.0) {
    console.log('SKIP: Build not 100% successful, skipping expertise update');
    return { skipped: true, reason: 'build_not_successful' };
  }

  // Phase 1: Identify affected domains
  const affectedDomains = identifyAffectedDomains(changedFiles);
  console.log(`Affected domains: ${affectedDomains.join(', ')}`);

  if (affectedDomains.length === 0) {
    console.log('SKIP: No expertise domains affected');
    return { skipped: true, reason: 'no_domains_affected' };
  }

  const results = {
    domains_processed: [],
    updates_proposed: [],
    updates_accepted: [],
    updates_rejected: [],
    learning_delta: 0
  };

  // Phase 2: Process each affected domain
  for (const domain of affectedDomains) {
    console.log(`\n--- Processing domain: ${domain} ---`);

    // Phase 2.1: Extract learnings
    const learnings = await extractLearnings(domain, changedFiles, buildResult);
    console.log(`Extracted ${learnings.length} potential learnings`);

    if (learnings.length === 0) {
      console.log(`No learnings for ${domain}, skipping`);
      continue;
    }

    // Phase 2.2: Generate update proposal
    const proposal = generateUpdateProposal(domain, learnings);
    results.updates_proposed.push({ domain, proposal });

    // Phase 2.3: CRITICAL - Adversarial validation
    console.log('Running adversarial validation...');
    const adversarialResult = await runAdversarialValidation(domain, proposal);

    if (adversarialResult.survivalRate < ADVERSARIAL_SURVIVAL_THRESHOLD) {
      // Proposal rejected - too many claims disproven
      console.log(`REJECTED: Survival rate ${adversarialResult.survivalRate} < ${ADVERSARIAL_SURVIVAL_THRESHOLD}`);
      results.updates_rejected.push({
        domain,
        reason: 'adversarial_failure',
        survivalRate: adversarialResult.survivalRate,
        disprovenClaims: adversarialResult.disprovenClaims
      });
      continue;
    }

    // Phase 2.4: Apply update (survived adversarial validation)
    console.log(`ACCEPTED: Survival rate ${adversarialResult.survivalRate}`);
    const updateResult = await applyExpertiseUpdate(domain, proposal, adversarialResult);
    results.updates_accepted.push({ domain, updateResult });
    results.learning_delta += updateResult.learningDelta;

    results.domains_processed.push(domain);
  }

  // Phase 3: Persist to Memory MCP
  await persistToMemory(results);

  // Phase 4: Report
  console.log('\n===========================================');
  console.log('SELF-IMPROVE HOOK: Complete');
  console.log(`Domains processed: ${results.domains_processed.length}`);
  console.log(`Updates accepted: ${results.updates_accepted.length}`);
  console.log(`Updates rejected: ${results.updates_rejected.length}`);
  console.log(`Total learning delta: ${results.learning_delta.toFixed(3)}`);
  console.log('===========================================');

  return results;
}

/**
 * Identify which expertise domains are affected by changed files
 */
function identifyAffectedDomains(changedFiles) {
  const domains = new Set();

  // Load all expertise files
  const expertiseDir = path.join(process.cwd(), EXPERTISE_DIR);
  if (!fs.existsSync(expertiseDir)) {
    return [];
  }

  const expertiseFiles = fs.readdirSync(expertiseDir)
    .filter(f => f.endsWith('.yaml') && !f.startsWith('_'));

  for (const file of expertiseFiles) {
    const domain = file.replace('.yaml', '');
    const expertisePath = path.join(expertiseDir, file);
    const expertise = yaml.load(fs.readFileSync(expertisePath, 'utf8'));

    // Check if any changed file is in this domain's scope
    const domainPaths = [
      expertise.file_locations?.primary?.path,
      expertise.file_locations?.tests?.path,
      expertise.file_locations?.config?.path
    ].filter(Boolean);

    for (const changedFile of changedFiles) {
      for (const domainPath of domainPaths) {
        if (changedFile.startsWith(domainPath)) {
          domains.add(domain);
          break;
        }
      }
    }
  }

  return Array.from(domains);
}

/**
 * Extract learnings from build results for a specific domain
 */
async function extractLearnings(domain, changedFiles, buildResult) {
  const learnings = [];
  const expertisePath = path.join(EXPERTISE_DIR, `${domain}.yaml`);
  const expertise = yaml.load(fs.readFileSync(expertisePath, 'utf8'));

  // Filter to domain-relevant files
  const domainFiles = changedFiles.filter(f => {
    const domainPaths = [
      expertise.file_locations?.primary?.path,
      expertise.file_locations?.tests?.path
    ].filter(Boolean);
    return domainPaths.some(p => f.startsWith(p));
  });

  // Learning Type 1: New file locations
  for (const file of domainFiles) {
    const isKnown = isFileInExpertise(file, expertise);
    if (!isKnown) {
      learnings.push({
        type: 'new_file_location',
        file: file,
        section: 'file_locations.additional',
        falsifiable_check: {
          command: `test -f "${file}"`,
          expected: 'exists'
        }
      });
    }
  }

  // Learning Type 2: New patterns detected
  const newPatterns = detectNewPatterns(domainFiles, expertise);
  for (const pattern of newPatterns) {
    learnings.push({
      type: 'new_pattern',
      pattern: pattern,
      section: 'patterns.additional',
      falsifiable_check: pattern.check
    });
  }

  // Learning Type 3: New entities (classes, functions, types)
  const newEntities = detectNewEntities(domainFiles, expertise);
  for (const entity of newEntities) {
    learnings.push({
      type: 'new_entity',
      entity: entity,
      section: `entities.${entity.type}`,
      falsifiable_check: entity.check
    });
  }

  // Learning Type 4: Pattern confirmations (existing patterns still used)
  const confirmations = confirmExistingPatterns(domainFiles, expertise);
  for (const confirmation of confirmations) {
    learnings.push({
      type: 'pattern_confirmation',
      pattern: confirmation.pattern,
      evidence: confirmation.evidence,
      confidence_delta: 0.05  // Small confidence boost
    });
  }

  return learnings;
}

/**
 * Generate update proposal from learnings
 */
function generateUpdateProposal(domain, learnings) {
  return {
    domain: domain,
    proposed_at: new Date().toISOString(),
    proposed_by: 'self-improve-hook',
    learnings: learnings,
    proposed_changes: learnings.map(l => ({
      section: l.section,
      action: l.type.startsWith('new_') ? 'add' : 'update',
      data: l,
      falsifiable_check: l.falsifiable_check
    })),
    metadata: {
      learnings_count: learnings.length,
      new_items: learnings.filter(l => l.type.startsWith('new_')).length,
      confirmations: learnings.filter(l => l.type === 'pattern_confirmation').length
    }
  };
}

/**
 * Run adversarial validation on proposed update
 * CRITICAL: This prevents confident drift
 */
async function runAdversarialValidation(domain, proposal) {
  console.log('  Adversarial: Challenging proposed changes...');

  const challenges = [];
  let survived = 0;
  let disproven = 0;

  for (const change of proposal.proposed_changes) {
    // Run the falsifiable check
    if (change.falsifiable_check) {
      try {
        const result = execSync(change.falsifiable_check.command, {
          encoding: 'utf8',
          timeout: 5000
        });

        const passed = checkExpectation(result, change.falsifiable_check.expected);
        if (passed) {
          survived++;
          challenges.push({ change, result: 'survived', check: 'falsifiable_passed' });
        } else {
          disproven++;
          challenges.push({ change, result: 'disproven', check: 'falsifiable_failed', output: result });
        }
      } catch (err) {
        // Command failed - claim might be wrong
        disproven++;
        challenges.push({ change, result: 'disproven', check: 'command_error', error: err.message });
      }
    } else {
      // No falsifiable check - REJECT (Issue 3: unfalsifiable claims)
      disproven++;
      challenges.push({ change, result: 'disproven', check: 'no_falsifiable_check' });
    }
  }

  // Additional adversarial checks
  // 1. Check for contradicting code
  const contradictions = await findContradictingCode(domain, proposal);
  disproven += contradictions.length;

  // 2. Check git history for recent contradictions
  const historicalIssues = await checkGitHistory(domain, proposal);
  disproven += historicalIssues.length;

  const survivalRate = proposal.proposed_changes.length > 0
    ? survived / (survived + disproven)
    : 0;

  return {
    survivalRate,
    totalChallenges: survived + disproven,
    survived,
    disproven,
    challenges,
    disprovenClaims: challenges.filter(c => c.result === 'disproven')
  };
}

/**
 * Apply expertise update (only called after adversarial validation passes)
 */
async function applyExpertiseUpdate(domain, proposal, adversarialResult) {
  const expertisePath = path.join(EXPERTISE_DIR, `${domain}.yaml`);
  const expertise = yaml.load(fs.readFileSync(expertisePath, 'utf8'));

  let learningDelta = 0;

  // Only apply changes that survived adversarial validation
  const survivedChanges = adversarialResult.challenges
    .filter(c => c.result === 'survived')
    .map(c => c.change);

  for (const change of survivedChanges) {
    // Apply the change
    applyChange(expertise, change);
    learningDelta += change.data.confidence_delta || 0.1;
  }

  // Update metadata
  expertise.last_updated = new Date().toISOString();
  expertise.metadata.update_count = (expertise.metadata.update_count || 0) + 1;

  // Add to learning history
  expertise.learning_history = expertise.learning_history || [];
  expertise.learning_history.push({
    timestamp: new Date().toISOString(),
    source: 'loop2_build',
    event_type: 'auto_update',
    summary: `Self-improve: ${survivedChanges.length} changes applied`,
    details: {
      proposed: proposal.proposed_changes.length,
      survived: survivedChanges.length,
      disproven: adversarialResult.disproven
    },
    adversarial_validated: true
  });

  // Update adversarial section
  expertise.adversarial = expertise.adversarial || {};
  expertise.adversarial.last_challenge = {
    timestamp: new Date().toISOString(),
    challenger: 'self-improve-hook',
    claims_challenged: adversarialResult.totalChallenges,
    claims_survived: adversarialResult.survived,
    claims_disproven: adversarialResult.disproven,
    survival_rate: adversarialResult.survivalRate
  };

  // Update learning metrics
  expertise.learning = expertise.learning || {};
  expertise.learning.metrics = expertise.learning.metrics || {};
  expertise.learning.metrics.total_learning_events =
    (expertise.learning.metrics.total_learning_events || 0) + 1;
  expertise.learning.metrics.new_knowledge_items =
    (expertise.learning.metrics.new_knowledge_items || 0) + survivedChanges.length;

  // Save
  fs.writeFileSync(expertisePath, yaml.dump(expertise, { lineWidth: -1 }));

  console.log(`  Applied ${survivedChanges.length} changes to ${domain}`);

  return {
    domain,
    changesApplied: survivedChanges.length,
    learningDelta
  };
}

/**
 * Persist results to Memory MCP
 */
async function persistToMemory(results) {
  // Store in memory namespace
  const memoryKey = `expertise/self-improve/${Date.now()}`;
  const memoryValue = JSON.stringify(results);

  try {
    execSync(`npx @anthropic-ai/claude-code mcp memory-mcp store "${memoryKey}" '${memoryValue}'`, {
      encoding: 'utf8',
      timeout: 10000
    });
    console.log('Results persisted to Memory MCP');
  } catch (err) {
    console.log('Warning: Could not persist to Memory MCP:', err.message);
  }
}

// Helper functions

function isFileInExpertise(file, expertise) {
  const allPaths = [
    expertise.file_locations?.primary?.path,
    expertise.file_locations?.tests?.path,
    expertise.file_locations?.config?.path,
    ...(expertise.file_locations?.additional || []).map(a => a.path)
  ].filter(Boolean);

  return allPaths.some(p => file.startsWith(p) || file === p);
}

function detectNewPatterns(files, expertise) {
  // Simplified pattern detection
  // In production, this would use AST analysis
  return [];
}

function detectNewEntities(files, expertise) {
  // Simplified entity detection
  // In production, this would use AST analysis
  return [];
}

function confirmExistingPatterns(files, expertise) {
  // Check if existing patterns are still being followed
  return [];
}

function checkExpectation(result, expected) {
  if (expected === 'exists') return true;  // Command succeeded
  if (expected === 'no_matches') return result.trim() === '';
  return result.includes(expected);
}

async function findContradictingCode(domain, proposal) {
  // Simplified - in production, run grep for contradictions
  return [];
}

async function checkGitHistory(domain, proposal) {
  // Simplified - in production, check git log
  return [];
}

function applyChange(expertise, change) {
  // Apply change to appropriate section
  const path = change.section.split('.');
  let current = expertise;

  for (let i = 0; i < path.length - 1; i++) {
    current[path[i]] = current[path[i]] || {};
    current = current[path[i]];
  }

  const lastKey = path[path.length - 1];
  if (Array.isArray(current[lastKey])) {
    current[lastKey].push(change.data);
  } else {
    current[lastKey] = change.data;
  }
}

module.exports = { selfImproveHook };
