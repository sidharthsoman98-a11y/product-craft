#!/usr/bin/env bash
# Validate plugin structure: manifests parse, every skill has frontmatter with name and
# description, and every referenced file exists.
set -uo pipefail
cd "$(dirname "$0")/.."
fail=0
note(){ echo "  $1"; }

echo "== manifests =="
python3 -c "import json,sys; json.load(open('.claude-plugin/plugin.json')); json.load(open('.claude-plugin/marketplace.json')); print('  ok  json parses')" || fail=1

echo "== skills =="
for f in skills/*/SKILL.md; do
  d=$(basename "$(dirname "$f")")
  head -1 "$f" | grep -q '^---$' || { note "FAIL $d: no frontmatter"; fail=1; }
  n=$(awk -F': ' '/^name: /{print $2; exit}' "$f")
  [ "$n" = "$d" ] || { note "FAIL $d: name '$n' does not match directory"; fail=1; }
  grep -q '^description: ' "$f" || { note "FAIL $d: no description"; fail=1; }
  lines=$(wc -l < "$f")
  [ "$lines" -lt 500 ] || note "WARN $d: $lines lines, over the 500-line guideline"
done
note "checked $(ls -d skills/*/ | wc -l) skills"

echo "== reference links =="
grep -oh '\.\./\.\./references/[a-z-]*\.md' skills/*/SKILL.md | sort -u | while read -r r; do
  p="references/$(basename "$r")"
  [ -f "$p" ] || { note "FAIL missing $p"; exit 1; }
done || fail=1
grep -oh '\.\./\.\./templates/[a-z-]*\.md' skills/*/SKILL.md | sort -u | while read -r r; do
  p="templates/$(basename "$r")"
  [ -f "$p" ] || { note "FAIL missing $p"; exit 1; }
done || fail=1
note "reference and template links resolve"

echo "== commands =="
for f in commands/*.md; do grep -q '^description: ' "$f" || { note "FAIL $f: no description"; fail=1; }; done
note "checked $(ls commands/*.md | wc -l) commands"

[ "$fail" -eq 0 ] && echo "PASS" || echo "FAILURES PRESENT"
exit $fail
