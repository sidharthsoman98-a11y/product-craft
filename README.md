# product-craft

A Claude Code plugin for doing product management work properly, and for surviving PM and
APM interview loops where a full case has to be turned around in a day.

Fifteen skills, fourteen reference libraries and ten slash commands covering the two halves
of the job: taking products apart, and putting new ones together, plus an orchestrator that
routes between them and proves coverage before anything is delivered.

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
| `metric-architecture` | `/metrics` | Value primitive, north star with six tests, tree, instrumentation, SQL, experiment, decision rules |
| `decision-forensics` | `/why` | Why a team decided what they did, and what the counterfactual would have cost |
| `unit-economics` | `/economics` | Contribution stack, cohort payback, break-even, sensitivity |
| `market-sizing` | | Bottom-up and top-down estimates with reconciliation and sense-checks |
| `rca` | | Diagnose a metric that moved or a production incident: fact base, ruled out, isolating cut, falsifiable mechanism |

**Building**

| Skill | Command | Does |
|---|---|---|
| `idea-forge` | `/brainstorm` | Staged ideation from theme to decided concept, with a decision log |
| `discovery-brief` | | Assumption inventory, research plan, evidence ledger, synthesis |
| `spec-writer` | `/spec` | PRD, PRFAQ or one-pager, self-critiqued before delivery |
| `prototype-build` | `/prototype` | Working prototype, core loop first, unhappy path, metrics stub |
| `ship-it` | | Git, GitHub and Vercel to a public link |
| `artefact-forge` | | Diagrams, journey maps, matrices, models, decks |

**Under deadline**

| Skill | Command | Does |
|---|---|---|
| `interview-sprint` | `/sprint` | Time-boxed plan with gates for a one-day assignment |
| `red-team` | `/critique` | Hostile review, rubric score, one highest-leverage fix |

**Orchestration**

| Skill | Command | Does |
|---|---|---|
| `orchestrate` | `/run` | Classifies the request, sequences the other skills by dependency, enforces seven gates, and prints a coverage ledger with a row per candidate skill: applied, considered-and-skipped with the failed test named, or deferred |

`/run` is the default entry point for anything substantial. The individual commands are for
when you already know which instrument you want.

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
- `references/routing.md` — the dependency graph, ten scenario routes, per-skill
  applicability tests, seven gates and the coverage ledger format.
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
  disabled, the metrics-review boundary, and the Claude Code versus claude.ai split.
- `references/tooling.md` — environment capability matrix, document generation, MCP servers,
  hooks, parallel execution.

## How the pieces fit

```
theme or brief
   |
/run .................... routes the work and enforces the gates
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

## Making it the default

Copy `templates/workspace-CLAUDE.md` to `CLAUDE.md` in the folder where you work. Claude
Code reads it at the start of every session there, so `orchestrate` runs by default and the
ledger is required rather than requested.

## Contributing

The reference libraries are the valuable part; they should grow with archetypes, failure
modes and market-specific economics that people have actually encountered. Keep additions
structural rather than anecdotal, and never add a benchmark number as if it were a fact.

MIT licensed.
