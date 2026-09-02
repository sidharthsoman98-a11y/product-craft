# Routing: which skills, in which order, and how coverage is proved

This file makes skill selection deterministic. The orchestrator reads it, produces a plan
before doing any work, and produces a coverage ledger before delivering anything.

## Contents
1. Dependency graph
2. Scenario routing table
3. Per-skill applicability tests
4. Gates
5. Coverage ledger

---

## 1. Dependency graph

A skill may not run before its prerequisites have produced output. This is the only
ordering rule that is never negotiable, because each arrow represents information the
downstream skill needs to avoid inventing something.

```
                 idea-forge ──► discovery-brief ──► spec-writer ──► prototype-build ──► ship-it
                     ▲                │                  ▲                 │
                     │                ▼                  │                 ▼
product-teardown ──► decision-forensics          unit-economics      artefact-forge
        │                                               ▲                 │
        └──────────► metric-architecture ───────────────┘                 │
                              ▲                                           │
                     market-sizing                                        │
                                                                          ▼
interview-sprint (wraps everything, owns the clock) ────────────────► red-team ──► deliver
```

Hard rules:
- `red-team` runs last, on every deliverable, without exception.
- `metric-architecture` requires a chosen segment and a decided direction. Running it first
  produces generic metrics.
- `prototype-build` requires a written decision. If none exists, route to `idea-forge` first.
- `ship-it` requires a working build.
- `unit-economics` requires a defined unit, which usually comes from teardown layer 2 or
  from the idea-forge concept.
- `interview-sprint` runs first when there is a deadline, because it changes the depth of
  everything else.

## 2. Scenario routing table

Classify the request into one scenario, then run the sequence. M = mandatory,
C = conditional (apply the test in section 3), S = skip and record why.

| # | Scenario | Trigger phrasing | Sequence |
|---|---|---|---|
| 1 | Analyse an existing product | "break down X", "what would you improve", "teardown" | `product-teardown` M → `metric-architecture` M → `unit-economics` C → `decision-forensics` C → `artefact-forge` C → `red-team` M |
| 2 | Metric or measurement question | "how would you measure", "what metrics", "north star" | `metric-architecture` M → `unit-economics` C → `red-team` M |
| 3 | Metric diagnosis | "X dropped 20%", "why did Y move" | `metric-architecture` (diagnosis mode) M → `decision-forensics` C → `red-team` M |
| 4 | Why did they build it this way | "why does X work like that", "what if they had" | `decision-forensics` M → `metric-architecture` C (to quantify the counterfactual) → `red-team` M |
| 5 | New product or feature idea | "what should we build", "I have an idea" | `idea-forge` M → `discovery-brief` M → `market-sizing` C → `unit-economics` M → `metric-architecture` M → `spec-writer` M → `prototype-build` C → `ship-it` C → `red-team` M |
| 6 | Build a prototype | "make a prototype", "build a demo" | decision check → `idea-forge` C (if no written decision) → `prototype-build` M → `ship-it` C → `artefact-forge` C → `red-team` M |
| 7 | Timed assignment or take-home | "I have a day", "take-home", "case submission" | `interview-sprint` M (owns the clock, then invokes the scenario that matches the brief) → ... → `red-team` M |
| 8 | Sizing or estimation | "how big is", "how many", "guesstimate" | `market-sizing` M → `unit-economics` C → `red-team` M |
| 9 | Strategy or market question | "should they enter", "how do they compete" | `product-teardown` (layers 1-3 only) M → `market-sizing` C → `unit-economics` M → `decision-forensics` C → `red-team` M |
| 10 | Review my work | "critique this", "how would an interviewer attack" | `red-team` M → targeted re-run of whichever skill the failures point to |

If a request spans two scenarios, run the earlier one in the dependency graph first and say
so. If it matches none, say which is closest and what is different about this one.

## 3. Per-skill applicability tests

For every skill not run, the ledger must record which test failed. "Not relevant" is not an
acceptable reason; name the test.

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
| `interview-sprint` | There is a deadline | No deadline, or the task is under thirty minutes |
| `red-team` | Always | Never |

## 4. Gates

The orchestrator stops at each gate and states pass or fail. A failed gate is fixed before
proceeding, not noted and carried forward.

| Gate | After | Passes when |
|---|---|---|
| G1 Framing | Classification | The question has been quoted back, the deliverable named, and the audience and time budget stated |
| G2 Arc | Diagnosis | Objective, binding constraint and product's job are written and consistent |
| G3 Decision | Convergence | One direction chosen, alternatives recorded with reasons, before any building |
| G4 Numbers | Economics and metrics | Every number carries measured, benchmarked or assumed, and the leaves compose into the parent |
| G5 Build | Prototype | Core loop completable end to end, one unhappy path present, deployed if a link is needed |
| G6 Coverage | Before delivery | Ledger complete, all thirteen rows accounted for |
| G7 Quality | Before delivery | Red team run, no rubric dimension below 3, one fix identified |

## 5. Coverage ledger

Printed immediately before the deliverable, every time. Thirteen rows, always thirteen.
Status is one of: APPLIED, CONSIDERED-SKIPPED, DEFERRED.

```
| Skill                | Status             | Reason / where its output lives          |
|----------------------|--------------------|------------------------------------------|
| product-teardown     | APPLIED            | Sections 1-9 of the document             |
| metric-architecture  | APPLIED            | Section 9, tree and decision rule        |
| decision-forensics   | CONSIDERED-SKIPPED | Nothing shipped is being questioned      |
| unit-economics       | APPLIED            | Section 2, CM stack and break-even       |
| market-sizing        | CONSIDERED-SKIPPED | Output contains rates, no magnitudes     |
| idea-forge           | CONSIDERED-SKIPPED | Existing product, direction not open     |
| discovery-brief      | DEFERRED           | Needs user access; test proposed instead |
| spec-writer          | CONSIDERED-SKIPPED | Verbal answer, nothing handed over       |
| prototype-build      | DEFERRED           | Offered, not requested                   |
| ship-it              | CONSIDERED-SKIPPED | No prototype built                       |
| artefact-forge       | APPLIED            | Loop diagram and metric tree             |
| interview-sprint     | CONSIDERED-SKIPPED | No deadline stated                       |
| red-team             | APPLIED            | Score table at the end                   |
```

DEFERRED means the skill would add value but was blocked by time, access or scope. Every
DEFERRED row must be repeated in a "what I would do next" line so nothing quietly vanishes.
