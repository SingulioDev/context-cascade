#!/usr/bin/env bash
# strip-vcl.sh - Remove VeriLingua/VERIX notation from skill and agent files
# Usage: strip-vcl.sh <file>
set -euo pipefail

FILE="$1"

if [ ! -f "$FILE" ]; then
  echo "Error: File not found: $FILE" >&2
  exit 1
fi

# Use a single perl script for all transformations
# Write perl to a temp file to avoid shell escaping issues
PERLSCRIPT=$(mktemp)
trap 'rm -f "$PERLSCRIPT"' EXIT

cat > "$PERLSCRIPT" << 'PERLEOF'
use strict;
use warnings;

my $file = $ARGV[0];
open(my $fh, '<', $file) or die "Cannot read $file: $!";
my $content = do { local $/; <$fh> };
close($fh);

# Remove /*===...===*/ block comment lines
$content =~ s{^/\*=+\*/\s*$}{}gm;

# Remove S4 SUCCESS CRITERIA through end (includes S5, S6, S7, S8, PROMISE)
$content =~ s{/\*-+\*/\s*\n/\* S4 SUCCESS CRITERIA\s+\*/\s*\n.*}{}s;

# Remove S0 META-IDENTITY section (to next S section)
$content =~ s{/\*-+\*/\s*\n/\* S0 META-IDENTITY\s+\*/\s*\n/\*-+\*/\s*\n((?:(?!/\*-+\*/\s*\n/\* S\d).)*)}{}s;

# Remove S1 COGNITIVE FRAME section (to next S section)
$content =~ s{/\*-+\*/\s*\n/\* S1 COGNITIVE FRAME\s+\*/\s*\n/\*-+\*/\s*\n((?:(?!/\*-+\*/\s*\n/\* S\d).)*)}{}s;

# Remove S2 header lines only (keep content after)
$content =~ s{/\*-+\*/\s*\n/\* S2 TRIGGER CONDITIONS\s+\*/\s*\n/\*-+\*/\s*\n}{}s;

# Remove S3 header lines only (keep content after)
$content =~ s{/\*-+\*/\s*\n/\* S3 CORE CONTENT\s+\*/\s*\n/\*-+\*/\s*\n}{}s;

# Remove remaining /*---..---*/ divider lines
$content =~ s{^/\*-+\*/\s*$}{}gm;

# Remove /* ... */ single-line block comment headers
$content =~ s{^/\*\s+.+?\s+\*/\s*$}{}gm;

# Remove Kanitsal Cerceve
$content =~ s{^## Kanitsal Cerceve.*\n}{}gm;
$content =~ s{^Kaynak dogrulama modu etkin\.\s*\n}{}gm;

# Remove [assert|...] content [ground:...] [conf:...] [state:...] - preserve content
$content =~ s{\[assert\|[^\]]*\]\s*(.*?)\s*\[ground:[^\]]*\]\s*\[conf:[^\]]*\]\s*\[state:[^\]]*\]}{$1}g;

# Remove [define|neutral] ... := { ... } blocks (multi-line)
$content =~ s{\[define\|neutral\]\s+\w+\s*:=\s*\{[^{}]*\}[^\n]*\n}{}gs;

# Remove [direct|emphatic] ... := { ... } blocks (multi-line)
$content =~ s{\[direct\|emphatic\]\s+\w+\s*:=\s*\{[^{}]*\}[^\n]*\n}{}gs;

# Remove remaining [define|...], [direct|...], [commit|...] lines
$content =~ s{^\[define\|[^\n]*\n}{}gm;
$content =~ s{^\[direct\|[^\n]*\n}{}gm;
$content =~ s{^\[commit\|[^\n]*\n}{}gm;

# Remove <promise> lines
$content =~ s{^.*<promise>.*</promise>.*\n}{}gm;

# Remove cognitive_frame: YAML block from frontmatter
$content =~ s{cognitive_frame:\n(?:  [^\n]*\n)*}{}g;

# Remove VCL COMPLIANCE APPENDIX to end of file
$content =~ s{---\s*\n\n## VCL COMPLIANCE APPENDIX.*}{}s;

# Remove Library-First Directive sections
$content =~ s{---\s*\n+## Library-First Directive\n\nThis agent operates under library-first constraints:.*?(?=---\n|^## [A-Z]|\z)}{}gsm;
$content =~ s{^## Library-First Directive\n\nThis agent operates under library-first constraints:.*?(?=---\n|^## [A-Z]|\z)}{}gsm;

# Remove <details> blocks
$content =~ s{<details>.*?</details>\s*\n?}{}gs;

# Remove [[HON:...]] etc inline VCL markers
$content =~ s{\[\[(?:HON|MOR|COM|CLS|EVD|ASP|SPC):[^\]]*\]\]}{}g;

# Remove remaining [ground:...] [conf:...] [state:...] markers
$content =~ s{\s*\[ground:[^\]]*\]\s*\[conf:[^\]]*\]\s*\[state:[^\]]*\]}{}g;
$content =~ s{\s*\[ground:[^\]]*\]}{}g;
$content =~ s{\s*\[conf:[^\]]*\]}{}g;

# Remove Confidence: lines
$content =~ s{^Confidence:\s+\d.*\n}{}gm;

# Remove Windows paths (both single and double escaped backslashes)
$content =~ s{^.*D:\\\\?Projects.*\n}{}gm;
$content =~ s{^.*C:\\\\?Users.*\n}{}gm;

# Remove consecutive --- separators with whitespace between
$content =~ s{---\s*\n\s*\n\s*---}{---}g;

# Collapse 3+ consecutive newlines to 2
$content =~ s{\n{3,}}{\n\n}g;

# Remove trailing whitespace on each line
$content =~ s{[ \t]+$}{}gm;

open(my $out, '>', $file) or die "Cannot write $file: $!";
print $out $content;
close($out);
PERLEOF

perl "$PERLSCRIPT" "$FILE"
