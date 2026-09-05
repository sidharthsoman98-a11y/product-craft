# product-craft

A Claude Code plugin for doing product management work properly, and for surviving PM and
APM interview loops where a full case has to be turned around in a day.

Twenty-five skills, fourteen reference libraries and ten slash commands covering three
halves of the job, which is one more than the job is supposed to have: taking products apart,
putting new ones together, and operating what you shipped. An orchestrator routes between
them and proves coverage before anything is delivered.

## Install

```bash
# inside Claude Code
/plugin marketplace add <your-github-username>/product-craft
/plugin install product-craft
```

Or use it without the plugin system by copying the skills into a project:

```bash
git clone https://github.com/<your-github-username>/product-craft.git
mkdir -p your-project/.claude
cp -r product-craft/skills your-project/.claude/skills
cp -r product-craft/references product-craft/templates your-project/
```

Skills load automatically when a request matches. The slash commands are shortcuts for
when you want to invoke one deliberately.

## What is in it

**Analysis**

| Skill | Command | Does |
|---|---|---|
| `product-teardown` | `/teardown` | Nine-layer teardown where each layer constrains the next |
| `metric-architecture` | `/metrics` | Value primitive, north star with six tests, tree, instrumentation, experiment, decision rules |
| `decision-forensics` | `/why` | Why a team decided what they did, and what the counterfactual would have cost |
| `unit-economics` | `/economics` | Contribution stack, cohort payback, break-even, sensitivity |
| `market-sizing` | | Bottom-up and top-down estimates with reconciliation and sense-checks |
| `rca` | | Diagnose a metric that moved or a production incident: fact base, ruled out, isolating cut, falsifiable mechanism |
| `analytics-sql` | | Query patterns, the errors that return a plausible wrong number, verification before a number ships, and the technical analytics round |
| `marketplace-ops` | | Supply, capacity, promise adherence, workforce tooling and a city or zone launch, where the constraint is physical rather than a funnel |

**Building**

| Skill | Command | Does |
|---|---|---|
| `idea-forge` | `/brainstorm` | Staged ideation from theme to decided concept, with a decision log |
| `discovery-brief` | | Assumption inventory, research plan, evidence ledger, synthesis |
| `spec-writer` | `/spec` | PRD, PRFAQ or one-pager, self-critiqued before delivery |
| `prototype-build` | `/prototype` | Working prototype, core loop first, unhappy path, metrics stub |
| `ship-it` | | Git, GitHub and Vercel to a public link |
| `artefact-forge` | | Diagrams, journey maps, matrices, models, decks |

**Operating what you shipped**

| Skill | Command | Does |
|---|---|---|
| `platform-integration` | | API contracts, webhooks, idempotency, state machines, reconciliation, settlement, and the path from sandbox to live |
| `compliance-guard` | | Regulatory and policy constraints as design inputs: identity, consent, data handling, audit, grievance, conduct, dark patterns |
| `ticket-writer` | | Stories, testable acceptance criteria, the edge-case walk, slicing and definition of done |
| `experiment-readout` | | A finished test turned into a decision, with the interval rather than the point estimate |
| `launch-plan` | | Readiness gates, staged rollout, kill switches, day one, comms, and the dated post-launch decision |

**Under deadline**

| Skill | Command | Does |
|---|---|---|
| `interview-sprint` | `/sprint` | Time-boxed plan with gates for a one-day assignment |
| `red-team` | `/critique` | Hostile review, rubric score, one highest-leverage fix |
| `drill` | | A live interview round against the clock, in character, scored by `red-team` afterwards and tracked as a trend |

**Orchestration**

| Skill | Command | Does |
|---|---|---|
| `role-lens` | | Runs first. Fixes the archetype, the mode and the time budget, so everything downstream optimises for the right seat |
| `evidence-ledger` | | Runs second. Reads `knowledge/` before anything reaches for the web, and writes back what the run verified |
| `orchestrate` | `/craft` | Classifies the request, sequences the other skills by dependency, enforces the gates G1 to G7, and prints a coverage ledger with a row per candidate skill: applied, considered-and-skipped with the failed test named, or deferred |

`/craft` is the default entry point for anything substantial. The individual commands are for
when you already know which instrument you want.

## Three modes

**The mode decides which skills are candidates at all, not how deeply they run.** It is
settled by `role-lens` before anything else, and where it is genuinely ambiguous the pack
asks once, in one line, with its guess named inside the question.

| Mode | The task | The reader | Not considered |
|---|---|---|---|
| **Employee** | Work producing something a team consumes | People who will do the work | `drill`, `interview-sprint` |
| **Interview prep** | Practice and drilling | An examiner testing how you think | `ticket-writer`, `launch-plan`, `ship-it`, `prototype-build` |
| **Assignment** | A deadline-bound deliverable | A panel reading without you present | Nothing outright; `drill` only as rehearsal |

The same question has three different correct answers across these. "Orders per dark store
are down — what do you do?" is a spoken decomposition in one, a graded document in the
second and a ticket in the third, and each would score badly in the other two. The candidate
sets are in `references/routing.md` section 1.

## Reference libraries

Skills load these on demand rather than carrying everything in context.

- `references/metric-library.md` — value primitives, north star tests, seven decomposition
  patterns, ten archetype spines (marketplace, quick commerce, payments, lending, SaaS, ads,
  streaming, AI-native, dev tools, logistics), the diagnostic playbook, metric-to-decision
  mapping, and eleven failure modes.
- `references/economics-library.md` — contribution margin stack, cohorts and payback,
  archetype economics, pricing, the "what would have to be true" inversion, sensitivity method.
- `references/teardown-layers.md` — the nine layers, the arc rule, eight consistency checks,
  and the eight-rung depth ladder.
- `references/decision-lenses.md` — thirteen generative lenses, seven strategic frames, the
  staged nudge bank, the counterfactual method, and option scoring.
- `references/instrumentation-and-experiments.md` — event design, client versus server,
  eight instrumentation failure modes, experiment design, when A/B breaks, honest reading.
- `references/rubrics.md` — nine scoring dimensions, artefact gates, and a fifteen-item
  failure catalogue.
- `references/routing.md` — the three modes and their candidate sets, the dependency graph,
  the scenario routes, one applicability test per skill, the gates G1 to G7, and the
  coverage ledger scoped to the mode.
- `references/prototype-stack.md` and `references/artefact-recipes.md` — how to build and
  what to build with.
- `references/role-packs.md` — consumer tech and fintech PM archetypes: charter, owned
  metrics, stakeholders, weekly artefacts, interview loop shape, and the failure modes of a
  new PM in that seat. Public sources only.
- `references/india-context.md` — devices and networks, language, trust and payment
  behaviour, commerce, seasonality, payments rails, the regulatory boundary, and the
  unpriced cost. No statistics, by design: it says how to derive them instead.
- `references/sources.md` — the five-tier source hierarchy, what may never be recalled from
  memory, the verification protocol, and the staleness rules.
- `references/external-skills.md` — which external skills to delegate to, which are
  disabled, the metrics-review boundary, the Claude Code versus claude.ai split, and the
  collisions with skills that cannot be disabled at all.
- `references/tooling.md` — environment capability matrix, document generation, MCP servers,
  hooks, parallel execution.

## How the pieces fit

```
theme or brief
   |
role-lens ............... which archetype, which mode, what time budget
   |
evidence-ledger ......... read knowledge/ before searching the web
   |
/craft .................. routes the work and enforces the gates
   |
/sprint ................. holds the clock when there is a deadline
   |
/brainstorm ............. decide the concept (never skip to building)
   |
   +-- discovery-brief ... validate the riskiest assumption
   +-- /economics ........ does the money work
   +-- /metrics .......... how would we know
   |
/spec ................... write it down
   |
/prototype -> ship-it ... make it real, get a link
   |
artefact-forge .......... the diagrams and models the argument needs
   |
/critique ............... attack it before the evaluator does
```

For analysing something that already exists, the path is `/teardown` then `/metrics` then
`/why`, and `/critique` at the end.

## Principles the skills enforce

1. Decide before you build. A prototype built during the deciding phase becomes the decision.
2. Answer first. Recommendation, then support.
3. Every number carries its basis: measured, benchmarked or assumed.
4. Every recommendation names what it sacrifices and who bears the cost.
5. Every metric is attached to a decision that a threshold authorises.
6. Refusals are part of the deliverable. What you would not build is the differentiator.
7. Deploy at the halfway mark. A prototype that is not deployed does not exist.
8. Nothing is finished until it has been red-teamed and the coverage ledger is complete.

## If you run other plugins

Some skills outside this pack answer to the same words, and **the ones bundled with Claude
Code or installed under `~/.claude/skills/` cannot be disabled per skill** — `claude plugin
disable` works per plugin. So the boundary is the only control, and it is worth knowing:

| External | Reaches for the same words as | The difference |
|---|---|---|
| `gstack:investigate` | `rca` | Both own "root cause". One debugs code; `rca` diagnoses a product metric that moved and demands a fact base first |
| `gstack:spec` | `spec-writer` | An executable engineering spec, against a product document that is critiqued before delivery |
| `gstack:ship`, `gstack:land-and-deploy` | `ship-it` | A repository workflow — tests, version, changelog, PR — against getting a prototype to a public URL |
| `gstack:diagram`, bundled `dataviz`, bundled `design` | `artefact-forge` | They render. `artefact-forge` decides which artefact carries the argument, then hands over |

`references/external-skills.md` section 6 carries the full list. If a request lands in the
wrong one, name the skill you want; the pack does not fight for the trigger.

## Making it the default

Copy `templates/workspace-CLAUDE.md` to `CLAUDE.md` in the folder where you work. Claude
Code reads it at the start of every session there, so `orchestrate` runs by default and the
ledger is required rather than requested. It also sets up the working folders, including
`knowledge/`, the store of verified facts that `evidence-ledger` reads before searching and
writes back to afterwards, so a second run on the same company agrees with the first.

## Contributing

The reference libraries are the valuable part; they should grow with archetypes, failure
modes and market-specific economics that people have actually encountered. Keep additions
structural rather than anecdotal, and never add a benchmark number as if it were a fact.

Two things a change has to survive. `scripts/validate.sh` must pass — among other things it
fails the build if a skill has no applicability row in `references/routing.md`, which is the
most likely silent breakage. And `evals/routing-prompts.md` holds twenty prompts with the
skill each should reach; if you change a description, check it against those before opening
a pull request. The most useful bug report for a skill pack is the prompt, the skill you
expected and the skill that actually fired.

MIT licensed.
