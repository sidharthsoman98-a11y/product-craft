# External skills: the delegation map

The pack runs alongside other plugins and bundled skills. This file says which of them to
hand work to, which are switched off and why, and where the boundaries sit.

**The rule: a skill delegates rather than reimplements.** If an external skill already does
a job well, name it and hand over. Rebuilding it costs context on every session, drifts out
of step with the upstream version, and produces a worse artefact than the tool built for it.
The pack's own skills exist for product *reasoning*; most production mechanics belong
elsewhere.

Two things to check before delegating: that the skill is actually available in the current
environment (section 4), and that the boundary in section 3 is not being crossed.

## 1. Disabled, and why

Disabled means switched off in the plugin configuration, not merely unused. Each of these
costs context on every session and returns nothing the pack does not already do better.

| Disabled | Superseded by | Why |
|---|---|---|
| `product-management:brainstorm`, `product-brainstorming` | `idea-forge` | Same job, and `idea-forge` stages the session and forces the trade-off rather than generating a list |
| `product-management:write-spec` | `spec-writer` | Same job, and `spec-writer` critiques the document against the gaps that get specs rejected before delivering it |
| `product-management:synthesize-research` | `discovery-brief` | Same job, inside a research plan and evidence ledger rather than as a standalone synthesis step |
| `common-room` plugin, entire | — | Sales prospecting. No relevance to this work, and seven skills of context cost for nothing |

If one of these fires anyway, the fix is the plugin configuration, not a note in a skill file.

**Verified state, 2026-09-05, step 4.5.** `claude plugin list` reports one installed plugin:
`product-craft@product-craft` v1.1.0, user scope, enabled. **Neither `product-management` nor
`common-room` is installed or enabled in this environment**, and neither appears in either
configured marketplace. There was nothing to disable. The rows above stand as instruction for
an environment that has them, not as a record of an action taken here — a distinction worth
keeping, because a map that reads as "already handled" stops being checked.

## 2. Keep and delegate to

Available in principle, not rebuilt here, and to be handed work rather than duplicated.
**None of them is installed in this Claude Code environment as of 2026-09-05** — see section
4 — so every row below is a delegation to check before promising, per section 5.

| Delegate to | For | Called by |
|---|---|---|
| `product-management:stakeholder-update` | Weekly and monthly status, launch announcements, risk escalation | Job-side work; `launch-plan` for the announcement |
| `product-management:sprint-planning` | Sprint scoping, capacity, carryover | Job-side work; after `ticket-writer` has produced the tickets |
| `product-management:roadmap-update` | Roadmap changes, Now/Next/Later, reprioritisation | Job-side work; `launch-plan` for sequencing |
| `frontend-design` | Prototype UI: visual design, component structure, styling | `prototype-build` step 6; `artefact-forge` for a wireframe that must look real |
| `web-artifacts-builder` | Self-contained interactive artefacts and published pages | **Not currently called by any pack skill.** Available and worth reaching for by hand; no skill routes to it |
| `frontend-slides` | Deck mechanics: HTML presentations, slide structure, transitions | `artefact-forge` |
| `theme-factory` | Deck and page visual theming | `artefact-forge` |
| `docx`, `pptx`, `xlsx`, `pdf` | Binary document output — **claude.ai only**, see section 4 | `artefact-forge` |
| `skill-creator` | Writing and running evals for the pack's own skills | Pack maintenance |
| `productivity:task-management` | The working backlog across sessions | **Not currently called by any pack skill.** Job-side work by hand; `orchestrate` does not route to it |

None of these three job-side skills — `stakeholder-update`, `sprint-planning`,
`roadmap-update` — is rebuilt in this pack. That is deliberate: they are execution
mechanics, they already work, and the pack's job-side skills are the ones with no external
equivalent. Point at them rather than writing a thinner version.

## 3. Scoped, not disabled: metrics-review and metric-architecture

Both are about metrics and they do different jobs. Getting this boundary wrong is the most
likely delegation mistake in the pack, because the trigger words overlap almost completely.

| | `product-management:metrics-review` | `metric-architecture` |
|---|---|---|
| Object | A dashboard or metric set that already exists | A metric system that does not exist yet |
| Question | What do these numbers say, and what should we do? | What should we measure, and how would we know it worked? |
| Output | Trend analysis, scorecard, recommended actions | Value primitive, north star with selection tests, input tree, guardrails, instrumentation, SQL, experiment design, decision rules |
| Cadence | Weekly, monthly, quarterly review | Once per product or feature, revisited at inflection |
| Fires on | "review our metrics", "why did this spike", "how are we tracking against target" | "what should we measure", "how do we know if this worked", "design the north star" |

**The boundary:** `metrics-review` reads an existing system; `metric-architecture` designs a
new one. If the numbers already exist and the question is what they mean, delegate. If the
question is what should exist, do not.

Two follow-ons worth stating, because they are where the boundary actually gets tested:

- **A metric that moved is neither of these.** It is `rca`. `metrics-review` will surface
  that a number moved; the diagnosis belongs to `rca`, which is why the diagnosis section in
  `metric-architecture` is now a one-line handover rather than a method (D3). The diagnostic
  playbook in `references/metric-library.md` has exactly one reader: `rca`.
- **A review that concludes the metric set is wrong** hands back to `metric-architecture`.
  That handoff is common and should be made explicitly rather than by quietly redesigning
  the tree inside a review.

## 4. Environment split

From `references/tooling.md` section 1. **The bundled document skills do not exist in Claude
Code.** A skill that promises a `.docx`, `.pptx`, `.xlsx` or `.pdf` must check where it is
running before promising it.

| Capability | Claude Code | claude.ai chat |
|---|---|---|
| This pack's skills | Yes, via plugin | Only if uploaded individually; references do not travel |
| Read and write files in a folder | Yes | Sandbox only, per conversation |
| Shell, npm, git, deploy | Yes | No |
| `xlsx` / `docx` / `pptx` / `pdf` skills | **No** | Yes, with code execution enabled |
| Web browsing and fetching | Yes | Yes |
| MCP servers | Yes, per project or user | Yes, via connectors |
| Parallel subagents | Yes | No |

What to do in Claude Code when a binary format is genuinely required: generate it with a
library — `openpyxl`, `python-pptx`, `python-docx` or `pandoc` — per `tooling.md` section 2.
Prefer markdown, HTML and Mermaid otherwise, and prefer a deployed HTML deck over a `.pptx`
file, since a link is usually the better deliverable anyway.

The reverse also holds: `ship-it`, `prototype-build` and anything else needing shell, git or
a deploy cannot run in claude.ai chat. Say so rather than producing a plan the environment
cannot execute.

**Installed-plugin state, checked 2026-09-05.** The only installed plugin is this pack. Of
the section 2 delegation targets, `frontend-design` and `skill-creator` exist in the
`claude-plugins-official` marketplace and can be installed with `claude plugin install`; the
rest — `frontend-slides`, `theme-factory`, `web-artifacts-builder`, `stakeholder-update`,
`sprint-planning`, `roadmap-update`, `metrics-review`, `productivity:task-management` — were
not found in either configured marketplace and may be claude.ai-side. **Until they are
installed, section 5's absent-skill rule is the live path, not the exception**: name what is
missing and say the pack is standing in.

## 5. How to delegate in practice

- **Name the skill explicitly** in the handoff, so the router has something to match on.
- **Hand over the decided input, not the raw brief.** The external skill does mechanics; the
  product decision stays here. A deck skill should receive the argument and its structure,
  not the assignment.
- **Check availability before promising the artefact**, per section 4.
- **If the external skill is disabled or absent, say what is missing** rather than silently
  producing a thinner version of its output. `artefact-forge` is the fallback for anything
  visual or quantitative, `spec-writer` for anything written, and both should say they are
  standing in.
- **Never reimplement across the boundary.** If a pack skill is drifting into work section 2
  already covers, that is a scoping bug in the pack skill, not a gap in the external one.
- **The "Called by" column is a claim about this pack and is checkable.** A row naming a
  pack skill means that skill hands the work over in its own text. If it does not, the row
  is wrong and the map is overstating what the pack does — which is what F3 and F18 were.
  Fix the column or fix the skill; do not leave them disagreeing.

## 6. Collisions outside this map, found at 4.5

These are not plugins and cannot be disabled with `claude plugin disable`: they are
user-level skills in `~/.claude/skills/` and skills bundled with Claude Code. They load
regardless. **The boundary is the object, and it is stated here so the router has something
to separate them on.**

| External | Collides with | The boundary |
|---|---|---|
| `gstack:spec` | `spec-writer` | `gstack:spec` turns intent into an executable engineering spec. `spec-writer` writes the product document — PRD, PRFAQ, one-pager — and critiques it against what gets specs rejected. Engineering execution versus product argument |
| `gstack:investigate` | `rca` | **The sharpest of these.** Both own "root cause". `gstack:investigate` debugs code. `rca` diagnoses a moved product metric and requires a fact base — metric, definition, denominator, magnitude, window, baseline. A failing test is not an RCA round |
| `gstack:ship`, `gstack:land-and-deploy` | `ship-it` | Both answer to "ship". The gstack skills run a repository workflow — tests, version bump, changelog, PR, deploy. `ship-it` takes a prototype to a public URL for someone to look at. Neither is `launch-plan`, which is product rollout |
| `gstack:diagram`, bundled `dataviz`, bundled `design` | `artefact-forge` | `artefact-forge` decides which artefact carries the argument and what it must show. These render it. The same delegate-do-not-reimplement rule in section 2 applies, and they are the better tools once the decision is made |
| `gstack:make-pdf` | `artefact-forge` binary output | A real route to a PDF in Claude Code, where section 4 says the bundled `pdf` skill does not exist |
| Bundled `run` | the old `/run` command | This was the collision plan item 7 named. Resolved by renaming the command to `/craft`; the bundled skill keeps `run` |

Two things follow. **`claude plugin disable` is per plugin, not per skill** — there is no
per-skill switch in the plugin CLI — so none of these can be turned off individually; the
boundary above is the only control. And a skill that shares a trigger word with a pack skill
is the failure class the validator's phrase check cannot see, which is why each row names the
object rather than the topic.
