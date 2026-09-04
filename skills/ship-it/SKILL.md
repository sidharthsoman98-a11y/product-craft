---
name: ship-it
description: Get a prototype from a local folder to a public URL - git repository, GitHub, and deployment to Vercel or an equivalent host - with preview links, environment handling and a README. Use this whenever someone wants to deploy, publish, host or share a prototype, asks for a link they can send someone, mentions Vercel, Netlify, GitHub Pages or pushing to GitHub, or has finished building something and needs it live.
---

# Ship it

Getting to a URL is a five-minute job when it goes well and a two-hour job when it does not.
The difference is doing it early. Deploy a skeleton at the halfway mark, then keep pushing.

**This skill is deployment mechanics for a prototype, and it ends at a working URL.** Taking
a built feature to real users — readiness gates, staged rollout, kill switches, day-one
monitoring, comms and the post-launch decision — is `launch-plan`. The boundary is the
object, not the size of the change: a prototype going live for one reviewer is this skill,
and a feature reaching customers is that one.

## Prerequisites check

Verify before starting, and tell the user exactly what to install if something is missing:
`git --version`, `gh --version` (GitHub CLI), `node --version` (20 or later), `vercel --version`.
Authentication is the user's job: `gh auth login` and `vercel login` both require a browser
and their credentials. Never ask for a token, password or API key, and never enter
credentials on their behalf. Prepare the commands, hand them over, and wait.

## Standard path

```bash
# 1. local repository
git init -b main
printf 'node_modules\n.next\n.env*\n.vercel\n' > .gitignore
git add -A && git commit -m "Prototype: <concept name>"

# 2. GitHub (user runs this if gh is authenticated)
gh repo create <name> --public --source=. --remote=origin --push

# 3. Vercel
vercel            # first run links the project and gives a preview URL
vercel --prod     # promotes to the production URL
```

A repository connected to Vercel then deploys on every push, and every branch gets its own
preview URL, which is the fastest way to show two variants to a reviewer.

## Rules

- Confirm with the user before creating a public repository or deploying publicly. A
  prototype containing a company name, a real assignment brief or scraped data should be
  private, and interview assignments in particular are often confidential. Ask.
- Never commit secrets. If an environment variable is needed, add it in the host's
  dashboard, not in the repository, and put a `.env.example` in the repo instead.
- Verify the production build locally before deploying: `npm run build`. Most deployment
  failures are type errors that the dev server tolerated.
- If the build fails on the host but passes locally, check the Node version and
  case-sensitive import paths, which differ between macOS and the build container.

## Alternatives

- **Static single-file HTML**: GitHub Pages from the repository settings, or a `gh-pages`
  branch. Zero build, near-zero failure modes. Use for wireframes.
- **Netlify**: `netlify deploy --prod` behaves like Vercel for static and Next.js sites.
- **No account available**: `npm run build && npx serve out` locally, and record a short
  screen capture as a fallback deliverable. Always have this fallback ready before a
  deadline; a link that does not exist at submission time is worth nothing.

## Output

The repository URL, the production URL, the preview URL, and a README containing what the
prototype demonstrates, how to run it locally, what is real, and what is simulated.
