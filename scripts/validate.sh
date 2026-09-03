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

echo "== routing coverage =="
# Check 1 is enforced: a skill on disk with no applicability row is the silent failure the
# registration rule in routing.md section 3 exists to prevent, and it fails the build.
# Check 2 stays advisory: routing.md legitimately forward-references skills the build plan
# has scheduled but not yet written, and those are warnings, not errors.

# The applicability table is section 3 of routing.md; skills are the first cell, backticked.
table_skills=$(sed -n '/^## 3\. Per-skill applicability/,/^## 4\./p' references/routing.md \
  | grep -o '^| `[a-z][a-z0-9-]*`' | tr -d '|` ' | sort -u)
# Any backticked skill-shaped token anywhere in routing.md counts as "named".
named_skills=$(grep -o '`[a-z][a-z0-9-]*`' references/routing.md | tr -d '`' | sort -u)
dir_skills=$(ls -d skills/*/ 2>/dev/null | xargs -n1 basename | sort -u)

# 1. every skills/ directory appears in the applicability table. Enforced.
for d in $dir_skills; do
  echo "$table_skills" | grep -qx "$d" || {
    note "FAIL $d: not in the applicability table in references/routing.md"
    note "     the registration rule in routing.md section 3: the row lands with the skill"
    fail=1
  }
done

# 2. every skill named in routing.md exists as a directory. Advisory: a planned skill
#    named ahead of its build step is expected, not broken.
for n in $named_skills; do
  echo "$dir_skills" | grep -qx "$n" || \
    note "WARN routing.md names '$n' but skills/$n/ does not exist yet (planned)"
done
note "applicability table lists $(echo "$table_skills" | grep -c .) of $(echo "$dir_skills" | grep -c .) skills"

echo "== description length =="
# 4. descriptions under 500 characters. Advisory, matching the 500-line guideline above.
python3 - <<'PY'
import glob, os, re
over = 0
for f in sorted(glob.glob("skills/*/SKILL.md")):
    d = os.path.basename(os.path.dirname(f))
    m = re.search(r'^description:[ ]?(.*)$', open(f, encoding='utf-8').read(), re.M)
    n = len(m.group(1).strip()) if m else 0
    if n >= 500:
        print(f"  WARN {d}: description {n} chars, over the 500-character guideline")
        over += 1
print(f"  checked descriptions, {over} over 500 characters")
PY

echo "== description trigger collisions =="
# 3. distinctive 3-word phrases shared by two or more descriptions. Advisory only.
python3 - <<'PY'
import glob, os, re, collections
docs = {}
for f in sorted(glob.glob("skills/*/SKILL.md")):
    d = os.path.basename(os.path.dirname(f))
    m = re.search(r'^description:[ ]?(.*)$', open(f, encoding='utf-8').read(), re.M)
    docs[d] = re.findall(r"[a-z]+", (m.group(1) if m else "").lower())

STOP = set("""a an the and or but of to for in on at by with from as is are was were be been
being it its this that these those there here when where which who whom whose what how why
if then than so such not no nor any all each every some other another into over under out
up down about after before during while both few more most own same can could should would
will shall may might must do does did done have has had having you your yours they them
their we our us i me my he she his her""".split())
# Words that are near-universal in this corpus are not distinctive. The floor of 3 keeps
# the filter from eating the very overlap it is meant to find when the corpus is small.
df = collections.Counter()
for w in docs.values():
    df.update(set(w))
cutoff = max(3, int(len(docs) * 0.6))
common = {w for w, c in df.items() if c >= cutoff}
drop = STOP | common

grams = collections.defaultdict(set)
for d, words in docs.items():
    kept = [w for w in words if w not in drop]
    for i in range(len(kept) - 2):
        grams[" ".join(kept[i:i+3])].add(d)

hits = sorted((g, sorted(v)) for g, v in grams.items() if len(v) > 1)
for g, v in hits:
    print(f'  WARN shared trigger phrase "{g}": {", ".join(v)}')
print(f"  checked {len(docs)} descriptions, {len(hits)} shared phrase(s)"
      f"; ignored {len(drop)} common words")
PY

[ "$fail" -eq 0 ] && echo "PASS" || echo "FAILURES PRESENT"
exit $fail
