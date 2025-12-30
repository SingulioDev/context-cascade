#!/usr/bin/env node
// Fix malformed descriptions in command frontmatter

const fs = require('fs');
const path = require('path');

const COMMANDS_DIR = path.join(__dirname, '..', 'commands');

function findCommandFiles(dir) {
    const files = [];
    try {
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
    } catch (e) {}
    return files;
}

function generateDescription(commandName) {
    // Convert command-name to readable description
    const words = commandName.replace(/-/g, ' ');
    // Capitalize first letter
    return words.charAt(0).toUpperCase() + words.slice(1) + ' command';
}

function fixMalformedDescription(filePath) {
    let content = fs.readFileSync(filePath, 'utf8');
    const fileName = path.basename(filePath, '.md');

    // Check if description is malformed (contains { or is empty)
    const descMatch = content.match(/^description:\s*(.+)$/m);
    if (!descMatch) return false;

    const currentDesc = descMatch[1].trim();

    // If description looks malformed (starts with { or is too short)
    if (currentDesc.startsWith('{') || currentDesc.length < 5) {
        const newDesc = generateDescription(fileName);
        content = content.replace(
            /^description:\s*.+$/m,
            `description: ${newDesc}`
        );
        fs.writeFileSync(filePath, content, 'utf8');
        console.log(`[FIXED] ${fileName}: "${newDesc}"`);
        return true;
    }

    return false;
}

// Main
console.log('Finding command files...');
const files = findCommandFiles(COMMANDS_DIR);
console.log(`Found ${files.length} command files\n`);

let fixed = 0;

for (const file of files) {
    try {
        if (fixMalformedDescription(file)) {
            fixed++;
        }
    } catch (err) {
        console.error(`[ERROR] ${file}: ${err.message}`);
    }
}

console.log(`\nFixed ${fixed} malformed descriptions`);
