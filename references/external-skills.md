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

## 2. Keep and delegate to

Available, not rebuilt here, and to be handed work rather than duplicated.

| Delegate to | For | Called by |
|---|---|---|
| `product-management:stakeholder-update` | Weekly and monthly status, launch announcements, risk escalation | Job-side work; `launch-plan` for the announcement |
| `product-management:sprint-planning` | Sprint scoping, capacity, carryover | Job-side work; after `ticket-writer` has produced the tickets |
| `product-management:roadmap-update` | Roadmap changes, Now/Next/Later, reprioritisation | Job-side work; `launch-plan` for sequencing |
| `frontend-design` | Prototype UI: visual design, component structure, styling | `prototype-build` |
| `web-artifacts-builder` | Self-contained interactive artefacts and published pages | `prototype-build`, `artefact-forge` |
| `frontend-slides` | Deck mechanics: HTML presentations, slide structure, transitions | `artefact-forge` |
| `theme-factory` | Deck and page visual theming | `artefact-forge` |
| `docx`, `pptx`, `xlsx`, `pdf` | Binary document output — **claude.ai only**, see section 4 | `artefact-forge` |
| `skill-creator` | Writing and running evals for the pack's own skills | Pack maintenance |
| `productivity:task-management` | The working backlog across sessions | Job-side work; `orchestrate` for open cases |

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
  that a number moved; the diagnosis belongs to `rca`, which is why the diagnosis section
  was removed from `metric-architecture` entirely (D3). All three read the diagnostic
  playbook in `references/metric-library.md`.
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
