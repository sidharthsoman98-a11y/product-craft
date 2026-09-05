# Routing: which skills, in which order, and how coverage is proved

This file makes skill selection deterministic. The orchestrator reads it, produces a plan
before doing any work, and produces a coverage ledger before delivering anything.

## Contents
1. Modes and the dependency graph
2. Scenario routing table
3. Per-skill applicability tests
4. Gates
5. Coverage ledger

---

## 1. Modes and the dependency graph

### 1a. The three modes

**The mode changes which skills are candidates at all, not how deeply they run.** A skill
outside the mode's candidate set is not considered and does not appear in the ledger. This is
the first thing decided, because a scenario chosen before the mode is a sequence optimised
for the wrong reader.

| Mode | The task | The reader | What exists at the end |
|---|---|---|---|
| **Employee** | Work producing something a team consumes | People who will do the work | A decision, a change, an item in a backlog |
| **Interview prep** | Practice and drilling | An examiner testing how you think | A performance, and a score with a trend |
| **Assignment** | A deadline-bound deliverable | A panel reading without you present | A document or build that is submitted |

**Candidate sets.** In every mode `role-lens` runs first and `evidence-ledger` second, and
neither is a ledger row. `orchestrate` is never a row either: it is what prints the ledger.

| Mode | Candidates | Not considered, and why |
|---|---|---|
| **Employee** | `evidence-ledger`, `rca`, `analytics-sql`, `metric-architecture`, `marketplace-ops`, `platform-integration`, `compliance-guard`, `ticket-writer`, `experiment-readout`, `launch-plan`, `spec-writer`, `unit-economics`, `discovery-brief`, `idea-forge`, `product-teardown`, `decision-forensics`, `market-sizing`, `prototype-build`, `ship-it`, `artefact-forge`, `red-team` | `drill` — there is no round to run. `interview-sprint` — its clock is a submission clock, and a sprint deadline is not one |
| **Interview prep** | `evidence-ledger`, `drill`, `rca`, `metric-architecture`, `analytics-sql`, `market-sizing`, `unit-economics`, `product-teardown`, `decision-forensics`, `marketplace-ops`, `platform-integration`, `compliance-guard`, `idea-forge`, `discovery-brief`, `spec-writer`, `artefact-forge`, `red-team` | `ticket-writer` — nobody builds what you say. `launch-plan` — nothing ships. `ship-it` — no link is needed. `prototype-build` — a round has no build time. `interview-sprint` — nothing is submitted |
| **Assignment** | `evidence-ledger`, `interview-sprint`, and the whole analytic set: `product-teardown`, `rca`, `metric-architecture`, `analytics-sql`, `unit-economics`, `market-sizing`, `decision-forensics`, `marketplace-ops`, `platform-integration`, `compliance-guard`, `idea-forge`, `discovery-brief`, `spec-writer`, `prototype-build`, `ship-it`, `artefact-forge`, `red-team`; `ticket-writer` and `launch-plan` when the brief asks for the delivery plan; `drill` for rehearsal only | Nothing is excluded outright. `drill` is in the set only as rehearsal before a panel, never as the deliverable |

**When the mode is ambiguous**, per D6 ask once, in one line, and name the guess inside the
question — "reading this as interview prep, say if it's real work". That asks and offers in
the same breath, which is what D6 requires; **a silent default is not permitted**, because a
mode assumed without saying so is invisible to the person who could correct it in three
words. Where the ordering has to lean somewhere, it leans interview prep: it is the highest
frequency use, and being wrong there is the cheapest of the three to correct.

### 1b. What runs before any scenario

```
role-lens ──► evidence-ledger ──► mode fixed ──► scenario chosen ──► the sequence
```

- **`role-lens` first, in every mode.** It fixes archetype, mode and time budget and hands
  them forward. Nothing downstream can be sequenced without them.
- **`evidence-ledger` second, before any search.** It reads `knowledge/` and reports what is
  held, what is stale and what is missing. Running a search first means a run can contradict
  a fact the previous run already verified, with neither citing the other.

Neither produces a deliverable, and neither appears in the coverage ledger.

### 1c. Dependency graph

A skill may not run before its prerequisites have produced output. This is the only ordering
rule that is never negotiable, because each arrow represents information the downstream skill
needs to avoid inventing something.

```
                 idea-forge ──► discovery-brief ──► spec-writer ──► prototype-build ──► ship-it
                     ▲                │                  ▲                 │
                     │                ▼                  │                 ▼
product-teardown ──► decision-forensics          unit-economics      artefact-forge
        │                    ▲                          ▲                 │
        │             rca ───┘                          │                 │
        │                                               │                 │
        └──────────► metric-architecture ───────────────┘                 │
                              ▲                                           │
                     market-sizing                                        │
                                                                          ▼
interview-sprint (holds the clock, invoked by orchestrate) ─────────► red-team ──► deliver
```

**The diagram covers the original core only.** `orchestrate` is absent because it is not
routed — it reads this file and walks the gates. `role-lens` and `evidence-ledger` are absent
because they precede the graph entirely, per 1b. The skills added on Days 2 and 3 are absent
because drawing every skill in the pack produces a picture harder to check than the list, and a
picture that disagrees with the list is worse than no picture. Their edges are below, and the
table is the authority wherever the two could be read differently.

**Edges for the skills added on Days 2 and 3:**

| Skill | Requires first | Feeds |
|---|---|---|
| `rca` | A stated fact base. Entry point, not downstream | `decision-forensics`, `analytics-sql`, `metric-architecture` if the tree itself is wrong |
| `analytics-sql` | A metric with a definition, denominator and window — from `metric-architecture`, or the fact base `rca` pinned down | The number any downstream claim rests on |
| `marketplace-ops` | The product understood as an operation, usually `product-teardown` layer 5 | `metric-architecture`, `rca` when the constraint is capacity |
| `platform-integration` | A decided design at API level, usually from `spec-writer` | `ticket-writer`, `compliance-guard` where money or identity crosses the boundary |
| `compliance-guard` | Nothing. It is a constraint input and runs early | `idea-forge` stage 5, `product-teardown` layer 3, `platform-integration` |
| `ticket-writer` | A written decision. `spec-writer` or `platform-integration` output | `launch-plan` |
| `experiment-readout` | A finished test with a design behind it, from `metric-architecture` | The decision, and `launch-plan` when the result is a go |
| `launch-plan` | A built feature, and the tickets closed | The post-launch decision. **Not `experiment-readout`**: a staged rollout has no control, so a causal claim needs a test designed by `metric-architecture` rather than a readout of the rollout |
| `drill` | A round type and a clock | `red-team`, which scores it |

Hard rules:
- `role-lens` runs first and `evidence-ledger` second, in every mode, per 1b.
- `red-team` runs last, on every deliverable, in all three modes.
- `metric-architecture` requires a chosen segment and a decided direction. Running it first
  produces generic metrics.
- `prototype-build` requires a written decision. If none exists, route to `idea-forge` first.
- `ship-it` requires a working build.
- `unit-economics` requires a defined unit, which usually comes from teardown layer 2 or
  from the idea-forge concept.
- `rca` is an entry point, not a downstream step. It requires a stated fact base — metric,
  definition, denominator, magnitude, window, baseline — and refuses to proceed without one.
  If a diagnosis concludes the metric set itself is wrong, it hands back to
  `metric-architecture` rather than redesigning the tree inside the diagnosis.
- `analytics-sql` never chooses what to measure. `metric-architecture` gives the query its
  purpose, denominator and window; `analytics-sql` writes and proves it, per D12.
- `orchestrate` is the entry point when there is a submission deadline, and it invokes
  `interview-sprint` first, because the clock changes the depth of everything else.
  `interview-sprint` owns the schedule inside the run; `orchestrate` owns the routing.
- `drill` and `red-team` are scoped by object, per D11. `drill` runs the live round, holds
  the clock and owns calibration; `red-team` owns scoring, and `drill` calls it for the
  scoring step rather than restating the rubric. Runs are written to `drills/` in the
  workspace so the trend outlives any single score.
- `launch-plan` and `ship-it` are scoped by object. `ship-it` ends at a working URL for a
  prototype; `launch-plan` takes a built feature to real users.

## 2. Scenario routing table

Classify the request into one scenario, then run the sequence. M = mandatory,
C = conditional (apply the test in section 3), S = skip and record why. The Modes column
says where the scenario occurs; a scenario outside the current mode is the wrong
classification, not a mode exception.

| # | Scenario | Trigger phrasing | Modes | Sequence |
|---|---|---|---|---|
| 1 | Analyse an existing product | "break down X", "what would you improve", "teardown" | All | `product-teardown` M → `metric-architecture` M → `unit-economics` C → `decision-forensics` C → `marketplace-ops` C → `artefact-forge` C → `red-team` M |
| 2 | Metric or measurement question | "how would you measure", "what metrics", "north star" | All | `metric-architecture` M → `analytics-sql` C → `unit-economics` C → `red-team` M |
| 3 | Metric diagnosis | "X dropped sharply", "why did Y move", "orders are down", incident | All | `rca` M → `analytics-sql` C → `decision-forensics` C → `red-team` M |
| 4 | Why did they build it this way | "why does X work like that", "what if they had" | All | `decision-forensics` M → `metric-architecture` C (to quantify the counterfactual) → `red-team` M |
| 5 | New product or feature idea | "what should we build", "I have an idea" | All | `idea-forge` M → `compliance-guard` C → `discovery-brief` M → `market-sizing` C → `unit-economics` M → `metric-architecture` M → `spec-writer` M → `prototype-build` C → `ship-it` C → `red-team` M |
| 6 | Build a prototype | "make a prototype", "build a demo" | Employee, assignment | decision check → `idea-forge` C (if no written decision) → `prototype-build` M → `ship-it` C → `artefact-forge` C → `red-team` M |
| 7 | Timed assignment or take-home | "I have a day", "take-home", "case submission" | Assignment | `interview-sprint` M (owns the clock, then invokes the scenario that matches the brief) → … → `drill` C (rehearsal) → `red-team` M |
| 8 | Sizing or estimation | "how big is", "how many", "guesstimate" | All | `market-sizing` M → `unit-economics` C → `red-team` M |
| 9 | Strategy or market question | "should they enter", "how do they compete" | All | `product-teardown` (layers 1-3 only) M → `market-sizing` C → `unit-economics` M → `decision-forensics` C → `red-team` M |
| 10 | Review my work | "critique this", "how would an interviewer attack" | All | `red-team` M → targeted re-run of whichever skill the failures point to |
| 11 | Query, dashboard or number to compute | "write the SQL", "what would the query be", "build a dashboard", "is this number right" | All | `analytics-sql` M → `metric-architecture` C (if the definition is not settled) → `red-team` M |
| 12 | Operations, supply or capacity | "supply is short", "riders are idle", "promise is slipping", "launch a new city or zone" | All | `marketplace-ops` M → `metric-architecture` C → `unit-economics` C → `rca` C (if a number has already moved) → `red-team` M |
| 13 | API, integration or partner work | "the webhook", "idempotency", "reconciliation", "settlement", "a partner is going live" | Employee, assignment | `platform-integration` M → `compliance-guard` C → `ticket-writer` C → `red-team` M |
| 14 | Regulatory or policy constraint | "is this allowed", "KYC", "consent", "audit trail", "is this a dark pattern" | All | `compliance-guard` M → `spec-writer` C → `red-team` M |
| 15 | Break decided work into sprint items | "write the tickets", "break this into stories", "acceptance criteria" | Employee, assignment | decision check → `spec-writer` C (if the decision is not written) → **`platform-integration` C (if the work crosses a system boundary — a webhook, a retry, an idempotency key, a reconciliation — and runs before the tickets, not after)** → `ticket-writer` M → `red-team` M |
| 16 | An experiment has finished | "the test came back", "the result was flat", "did it work", "should we ship it" | All | `experiment-readout` M → `metric-architecture` C (if the test was mis-designed) → `launch-plan` C (if the call is ship) → `red-team` M |
| 17 | Take a built feature to users | "roll this out", "launch plan", "staged release", "what happens on day one" | Employee, assignment | `launch-plan` M → `compliance-guard` C → `experiment-readout` C → `red-team` M |
| 18 | Practise a round | "drill me", "mock interview", "run a round", a round type with a duration | Interview prep, assignment (rehearsal) | `drill` M (holds the clock, runs the round, refuses to coach mid-round) → `red-team` M (scores it, and reads the trend in `drills/`) |

If a request spans two scenarios, run the earlier one in the dependency graph first and say
so. If it matches none, say which is closest and what is different about this one.

## 3. Per-skill applicability tests

For every skill not run, the ledger must record which test failed. "Not relevant" is not an
acceptable reason; name the test. **A skill outside the mode's candidate set in section 1a is
not evaluated here at all** — it is not a candidate, so it is not a row.

**Registration rule: a new skill adds its row to this table in the same commit that creates
the skill.** A skill the router does not know about is the most likely silent failure in the
pack, and it is silent precisely because everything still appears to work. `scripts/validate.sh`
enforces this: check 1 fails the build when a directory under `skills/` has no row here.

| Skill | Include when | Skip when |
|---|---|---|
| `product-teardown` | An existing product must be understood before anything is recommended | The product is new or hypothetical, or only one narrow layer is in question |
| `metric-architecture` | Any claim about success, improvement or measurement is made | The output contains no claim that anything would get better |
| `decision-forensics` | An existing design choice is puzzling, or a counterfactual is asked for, or a recommendation contradicts what a competent team already chose | Nothing shipped is being questioned |
| `unit-economics` | Money, margin, pricing, cost, growth spend or viability appears anywhere in the answer | The decision is genuinely cost-neutral, which is rare and must be argued |
| `market-sizing` | A magnitude is asserted, an opportunity is compared, or a metric target needs a denominator | Every number in the output is a rate rather than a magnitude |
| `idea-forge` | The solution is not yet decided, or the user arrived with a solution and no problem work | A written decision with rejected alternatives already exists |
| `discovery-brief` | The concept rests on an unvalidated belief about user behaviour | The behaviour is already measured, and the measurement is cited |
| `spec-writer` | Anything will be handed to someone else to build, review or evaluate | The deliverable is a verbal answer only |
| `prototype-build` | A prototype is requested, or a demo would settle the decision faster than prose | No decision is settled by seeing it, or the time budget cannot hold it |
| `ship-it` | A link is needed by another person | The prototype will only ever run locally, and a recording is the fallback |
| `artefact-forge` | The argument depends on a sequence, a comparison, a journey or a model | Prose carries it and a diagram would be decoration |
| `interview-sprint` | There is a **submission** deadline — a take-home, a case, a panel, anything handed in at a stated time | No submission deadline. **An employee-mode delivery date is not one**: work with a sprint deadline is paced by the team, not by a clock this skill holds |
| `rca` | A number has already moved, or there is an incident to explain | Nothing has moved; the question is what to measure, which is `metric-architecture` |
| `analytics-sql` | A number has to be computed, verified or expressed as a query, or a dashboard has to be specified | The number already exists and is trusted, or the question is what to measure (`metric-architecture`) or why it moved (`rca`), neither of which is a query job |
| `platform-integration` | The surface between two systems is the subject — an API contract, webhooks, idempotency, reconciliation, settlement, or a partner going live | The work is decomposing a decided design into stories, which is `ticket-writer`, or ruling on a regulatory obligation, which is `compliance-guard` |
| `launch-plan` | A built feature has to reach real users — rollout stages, flags, day-one monitoring, enablement or launch comms | The artefact is a prototype needing a public URL, which is `ship-it`; or a causal claim is required, which needs a designed test rather than a rollout |
| `experiment-readout` | A test has finished and its result has to become a decision, or a result has to be written up for someone else | The test is being designed rather than read, which is `metric-architecture`; or the number moved with no experiment attached, which is `rca` |
| `ticket-writer` | Decided work has to be handed to a team to build — stories, acceptance criteria, slicing, or a definition of done. **Asking for tickets does not exclude the skill that owns the design they decompose**: where the work crosses a system boundary, `platform-integration` runs first and this writes from its output | **Mode:** not a candidate in interview prep, where nobody builds what you say. **Object:** the decision itself is not made yet, or the deliverable is the document rather than the items under it, which is `spec-writer` |
| `compliance-guard` | A regulatory or policy constraint touches the design — identity, consent, data handling, audit, grievance, conduct, disclosure, or a growth mechanic that may be a dark pattern | The mechanics of an integration are the subject, which is `platform-integration`; or nothing in the answer touches regulated money, data or identity, which must be argued rather than assumed |
| `marketplace-ops` | The constraint is physical rather than a funnel — supply, capacity, promise adherence, workforce tooling, or a city or zone launch | The question is a whole product across all its layers, which is `product-teardown`, or a number that has already moved, which is `rca` |
| `drill` | A live round is wanted under time — a mock interview, a case delivered aloud, a named round type, or a company and round together | **Mode:** not a candidate in employee mode, where there is no round to run; in assignment mode it is rehearsal before a panel and never the deliverable. **Object:** a finished deliverable rather than a live performance is `red-team`; a real submission needing a plan first is `interview-sprint` |
| `evidence-ledger` | A fact about a named company, market or regulation is needed, or a run has learned one worth keeping | The only claims involved are structural rather than about a named party — the exempt class in `sources.md` section 3 — so there is nothing to store or retrieve |
| `red-team` | **Every deliverable, in all three modes.** An employee-mode ticket set earns a critique pass as much as a graded submission does | Never. **The depth varies by mode, not the fact of it**: a graded deliverable gets the full rubric, an internal ticket set gets the dimensions that bear on it |
| `role-lens` | Establishes context rather than being routed to. It runs before the sequence and fixes archetype, mode and time budget, so it never appears as a row in a coverage ledger and never has a skip test. It contributes nothing when no archetype would change the answer, which it says in one line rather than running anyway | — |
| `orchestrate` | Routes rather than being routed. It reads this file and selects the others, so it never appears as a row in a coverage ledger and never has a skip test | — |

## 4. Gates

The orchestrator stops at each gate and states pass or fail. A failed gate is fixed before
proceeding, not noted and carried forward.

| Gate | After | Passes when |
|---|---|---|
| G1 Framing | Classification | The question has been quoted back, the deliverable named, and the mode, audience and time budget stated |
| G2 Arc | Diagnosis | Objective, binding constraint and product's job are written and consistent |
| G3 Decision | Convergence | One direction chosen, alternatives recorded with reasons, before any building |
| G4 Numbers | Economics and metrics | Every number carries measured, benchmarked or assumed, and the leaves compose into the parent |
| G5 Build | Prototype | Core loop completable end to end, one unhappy path present, deployed if a link is needed |
| G6 Coverage | Before delivery | Ledger complete: one row per candidate skill for this mode, every row accounted for |
| G7 Quality | Before delivery | Red team run, no rubric dimension below 3, one fix identified |

**G3 and G5 take a mode-specific form.** Both are stated here rather than silently varied,
because a gate that quietly means something different in each mode is a gate nobody can fail.

- **G3 Decision, in interview prep,** is the moment the candidate commits to a direction out
  loud, with the alternatives named and set aside. There is nothing to build, so "before any
  building" has no referent — the analogue is committing before elaborating, and the failure
  it catches is the same one: exploring pleasantly and never choosing. In employee and
  assignment modes it reads as written.
- **G5 Build is inapplicable without a build**, which is every interview-prep run and most
  employee and assignment runs. **It is marked N/A with that reason, not skipped silently.**
  A gate that disappears when it does not apply teaches the reader that gates are optional,
  which is the failure `2ad2dc3` recorded against ceremonial process elsewhere in the pack.

The other gates hold unchanged in all three modes.

## 5. Coverage ledger

Printed immediately before the deliverable, every time. **One row per candidate skill for
this mode** — per D2, the ledger is scoped to the candidate set rather than listing every
skill in the pack, because an exhaustive ledger stops being read and a ledger nobody reads
cannot audit anything.

The candidate set is the mode's set in section 1a, narrowed to the scenario's sequence plus
every skill whose applicability test in section 3 was evaluated and failed. **A skill outside
the mode's candidate set is not a row**, and its absence needs no reason: the mode is the
reason. `role-lens`, `evidence-ledger` and `orchestrate` are never rows.

Status is one of: APPLIED, CONSIDERED-SKIPPED, DEFERRED.

Example, for a scenario 1 teardown in interview prep mode. The rows are a property of the
mode and the scenario, not a target to hit:

```
| Skill                | Status             | Reason / where its output lives          |
|----------------------|--------------------|------------------------------------------|
| product-teardown     | APPLIED            | Sections 1-9 of the answer               |
| metric-architecture  | APPLIED            | Section 9, tree and decision rule        |
| unit-economics       | APPLIED            | Section 2, CM stack and break-even       |
| decision-forensics   | CONSIDERED-SKIPPED | Nothing shipped is being questioned      |
| marketplace-ops      | APPLIED            | Section 5, capacity as the constraint    |
| market-sizing        | CONSIDERED-SKIPPED | Output contains rates, no magnitudes     |
| analytics-sql        | DEFERRED           | No warehouse access in a round           |
| idea-forge           | CONSIDERED-SKIPPED | Existing product, direction not open     |
| discovery-brief      | DEFERRED           | Needs user access; test proposed instead |
| spec-writer          | CONSIDERED-SKIPPED | Spoken answer, nothing handed over       |
| platform-integration | CONSIDERED-SKIPPED | No system boundary in the question       |
| compliance-guard     | CONSIDERED-SKIPPED | No regulated money, data or identity     |
| artefact-forge       | APPLIED            | Loop diagram and metric tree             |
| drill                | CONSIDERED-SKIPPED | Analysis requested, not a timed round    |
| red-team             | APPLIED            | Score table at the end                   |
```

`ticket-writer`, `launch-plan`, `ship-it`, `prototype-build` and `interview-sprint` are
absent because interview prep does not have them as candidates, per section 1a. That is the
mode doing its job, and it needs no row to say so.

DEFERRED means the skill would add value but was blocked by time, access or scope. Every
DEFERRED row must be repeated in a "what I would do next" line so nothing quietly vanishes.
