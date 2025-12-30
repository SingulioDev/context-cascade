#!/usr/bin/env node
// Fix command frontmatter to meet Claude Code plugin requirements:
// 1. Remove block comments before frontmatter
// 2. Add description field if missing
// 3. Ensure frontmatter starts at line 1

const fs = require('fs');
const path = require('path');

const COMMANDS_DIR = path.join(__dirname, '..', 'commands');

function findCommandFiles(dir) {
    const files = [];
    const entries = fs.readdirSync(dir, { withFileTypes: true });

    for (const entry of entries) {
        const fullPath = path.join(dir, entry.name);
        if (entry.isDirectory()) {
            if (entry.name !== '.backup' && entry.name !== 'node_modules') {
                files.push(...findCommandFiles(fullPath));
            }
        } else if (entry.name.endsWith('.md') &&
                   entry.name !== 'README.md' &&
                   !entry.name.startsWith('VERIX')) {
            files.push(fullPath);
        }
    }
    return files;
}

function extractDescription(content, commandName) {
    // Try to find description in the content
    const descMatch = content.match(/description:\s*["']?([^"'\n]+)["']?/i);
    if (descMatch) return descMatch[1].trim();

    // Try to find PURPOSE section
    const purposeMatch = content.match(/PURPOSE\s*:=\s*\{[^}]*action:\s*["']?([^"'\n]+)["']?/i);
    if (purposeMatch) return purposeMatch[1].trim();

    // Generate from command name
    return `Execute ${commandName.replace(/-/g, ' ')} workflow`;
}

function fixFrontmatter(filePath) {
    let content = fs.readFileSync(filePath, 'utf8');
    const fileName = path.basename(filePath, '.md');

    // Check if file starts with /* comment block
    const hasLeadingComment = content.trim().startsWith('/*');

    // Find existing frontmatter
    const frontmatterMatch = content.match(/---\s*\n([\s\S]*?)\n---/);

    if (!frontmatterMatch) {
        console.log(`[SKIP] No frontmatter found: ${filePath}`);
        return false;
    }

    let frontmatter = frontmatterMatch[1];
    const frontmatterFull = frontmatterMatch[0];

    // Check if description exists
    const hasDescription = /^description:/m.test(frontmatter);

    if (hasDescription && !hasLeadingComment) {
        return false; // Already good
    }

    // Add description if missing
    if (!hasDescription) {
        const description = extractDescription(content, fileName);
        // Add description after name line
        frontmatter = frontmatter.replace(
            /(name:\s*[^\n]+)/,
            `$1\ndescription: ${description}`
        );
    }

    // Rebuild content with frontmatter at start
    const newFrontmatter = `---\n${frontmatter}\n---`;

    // Get content after the original frontmatter
    const afterFrontmatter = content.substring(content.indexOf(frontmatterFull) + frontmatterFull.length);

    // If there was a leading comment, keep it after frontmatter
    let leadingComment = '';
    if (hasLeadingComment) {
        const commentEnd = content.indexOf('*/') + 2;
        leadingComment = '\n' + content.substring(0, commentEnd).trim() + '\n';
    }

    const newContent = newFrontmatter + leadingComment + afterFrontmatter;

    fs.writeFileSync(filePath, newContent, 'utf8');
    console.log(`[FIXED] ${filePath}`);
    return true;
}

// Main
console.log('Finding command files...');
const files = findCommandFiles(COMMANDS_DIR);
console.log(`Found ${files.length} command files\n`);

let fixed = 0;
let skipped = 0;
let errors = 0;

for (const file of files) {
    try {
        if (fixFrontmatter(file)) {
            fixed++;
        } else {
            skipped++;
        }
    } catch (err) {
        console.error(`[ERROR] ${file}: ${err.message}`);
        errors++;
    }
}

console.log(`\nSummary:`);
console.log(`  Fixed: ${fixed}`);
console.log(`  Skipped: ${skipped}`);
console.log(`  Errors: ${errors}`);
