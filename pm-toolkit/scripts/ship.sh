#!/usr/bin/env bash
# Prepare a prototype for shipping. Does NOT authenticate or publish on your behalf:
# it checks prerequisites, builds, and prints the exact commands for you to run.
set -euo pipefail

echo "== prerequisites =="
for c in git node npm; do
  command -v "$c" >/dev/null && echo "  ok   $c $($c --version 2>&1 | head -1)" || echo "  MISSING $c"
done
command -v gh >/dev/null     && echo "  ok   gh"     || echo "  optional: gh (GitHub CLI) not installed"
command -v vercel >/dev/null && echo "  ok   vercel" || echo "  optional: vercel CLI not installed (npm i -g vercel)"

echo
echo "== production build check =="
if [ -f package.json ] && grep -q '"build"' package.json; then
  npm run build
  echo "  build passed"
else
  echo "  no build script found, skipping"
fi

echo
echo "== local repository =="
if [ ! -d .git ]; then
  git init -b main
  printf 'node_modules\n.next\nout\n.env*\n.vercel\n.DS_Store\n' > .gitignore
  git add -A
  git commit -m "Prototype: initial commit"
  echo "  repository initialised"
else
  echo "  repository already exists"
fi

cat <<'NEXT'

== run these yourself (they need your credentials) ==
  gh auth login                 # once, in a browser
  gh repo create <name> --private --source=. --remote=origin --push
     # use --public only if the brief is not confidential

  vercel login                  # once, in a browser
  vercel                        # preview URL
  vercel --prod                 # production URL

Do not commit secrets. Put environment variables in the host dashboard and
keep a .env.example in the repository instead.
NEXT
