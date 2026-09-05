---
name: role-lens
description: Establish which seat a task sits in before any other skill runs - archetype (consumer tech or fintech), mode (employee, interview prep or assignment) and time budget - so downstream work optimises for the right audience and depth. Use at the start of any substantial product task where the seat is not already established, and whenever a company or a role is named. It sets context and hands it forward; it produces no artefact and never does the work itself.
---

# Role lens

The same question has different correct answers depending on who is asking and why. An
answer built for an interviewer testing structure is the wrong answer for a team that has to
act on Monday, and both are wrong for a panel reading a document without you in the room to
explain it. **Getting this wrong does not produce a slightly-off answer; it produces a
well-executed answer to a question nobody asked.**

This skill decides the seat and hands it forward. It is the only thing it does.

`../../references/role-packs.md` and `../../references/india-context.md` both open with
"Loaded by `role-lens`" — this is that loader. Read the chosen archetype in `role-packs.md`,
and `india-context.md` alongside it whenever the answer touches Indian users, economics or
regulation.

## What this is not

- **Not an artefact.** It writes no file and produces nothing anyone reads later. Its whole
  output is the handover in section 4, which is a few lines at the top of a run.
- **Not the work.** It never answers the product question. The moment the seat is fixed it
  gets out of the way, and whichever skill was asked for takes over — this skill must never
  be the reason a run gets slower.
- **Not routing.** Like `orchestrate`, it establishes context rather than being routed to.
  `orchestrate` decides which skills run; this decides what they are optimising for. Both
  run before the work, and neither appears as a row in a coverage ledger.
- **Not the clock.** It records the time budget as a fact. `interview-sprint` owns the
  schedule inside a run and `orchestrate` owns the routing, per `routing.md` section 1.

## 1. What it determines, in one pass

Three things, decided together and in one go:

- **Archetype.** **Consumer tech** or **fintech**, per `role-packs.md`, which defines two and
  only two. Anything that fits neither is a generalist brief and needs no lens — say so and
  move on, per section 6.
- **Mode.** **Employee**, **interview prep**, or **assignment**.
- **Time budget.** Minutes, hours, or a date. "Unbounded" is a valid answer and should be
  said rather than left implied.

**One pass.** Per D6, when inference genuinely fails, **ask once, in one line, and proceed**
on the answer. Do not interrogate: a three-question intake before any work has started reads
as a form, and the person came here with a product question. A single line that names the
ambiguity and offers the likely reading — "reading this as interview prep, say if it is real
work" — costs nothing and is correctable in the next sentence.

**Never ask about something you can infer.** Section 2 is what to try first.

## 2. Inference rules, before asking

Apply in order. Most tasks are settled by the first two.

| Signal | Reads as |
|---|---|
| A named company | Its archetype, per `role-packs.md` — quick commerce, hyperlocal delivery and horizontal marketplaces are consumer tech; payments infrastructure and merchant products are fintech |
| A named role, charter or JD | Same, read from the charter shape in section 1 of the chosen archetype |
| A deadline, a brief, a submission, a take-home | **Assignment mode**, and the deadline is the time budget |
| "Drill me", "practise", "mock", a named round type, a duration attached to a question | **Interview prep** |
| The output is something a team consumes — tickets, a spec, a launch plan, a readout, a query | **Employee mode** |
| Real system detail: your warehouse, your merchants, your on-call, an incident | **Employee mode.** Only someone in the seat has that access |

Two rules on top:

- **Signals conflict less often than they appear to.** A deadline on a mock round is still
  interview prep; the deadline sets the budget, not the mode. Read the *object* — what will
  exist at the end — and the mode usually follows.
- **Ask only when inference genuinely fails**, which is rarer than it feels. "Should we build
  X" with no company, no deadline and no audience is a real ambiguity. A named company and a
  request for tickets is not.

## 3. What the mode changes downstream

**The same question produces different correct answers in different modes.** This is the
reason the skill exists, and it is not a matter of tone — the depth, the object, the audience
and the candidate skills all change.

| | Employee | Interview prep | Assignment |
|---|---|---|---|
| **Depth** | Narrow and deep. You have the data, so query rather than hypothesise | Broad and fast. Exhaustive structure beats a correct answer arrived at unsystematically | Deep enough to defend in writing, with the reasoning visible |
| **Object** | A decision someone acts on | A performance under time | A document read without you present |
| **Audience** | People who will do the work | An examiner testing how you think | A panel comparing you against other submissions |
| **Fails when** | The analysis is admired and nothing changes | You are right but unstructured, or you narrate instead of deciding | It assumes context the reader does not have |
| **Candidates** | The job skills: `analytics-sql`, `ticket-writer`, `platform-integration`, `launch-plan`, `experiment-readout`, `compliance-guard` | `drill`, scored by `red-team`; the analysis skills run for their structure rather than their output | `interview-sprint` for the clock, the analysis skills at depth, `artefact-forge`, `red-team` before submission |

### Worked example

**"Orders per dark store are down week on week. What do you do?"** Consumer tech in all
three, and three different right answers.

- **Interview prep.** The object is a spoken performance. `rca` for the structure, delivered
  under `drill`, scored by `red-team`. You pin the fact base, decompose exhaustively,
  rank hypotheses, and name the one number you would ask for first. **You will not have the
  data and are not meant to** — the round is testing whether the decomposition has holes.
  Time budget is the round length, and running over is itself a failure.
- **Assignment.** The object is a document a panel grades without you there. Same `rca`, then
  `analytics-sql` for the query that would confirm the leading hypothesis, `artefact-forge`
  if the decomposition needs a tree to be legible, `red-team` before submission. **You show
  the working**, because the reader cannot ask you what you meant. Time budget is the
  deadline, and `interview-sprint` holds it.
- **Employee.** The object is a fix. You have the warehouse, so `analytics-sql` runs early and
  the hypothesis list is short because the data eliminates most of it in an hour. You talk to
  the city team, who may already know. It ends in `ticket-writer`, not in an analysis.
  **A diagnosis nobody actions is the failure mode of this seat**, and the deepest
  decomposition in the world does not fix a store.

Same question, same archetype, three defensible answers that would each score badly in the
other two modes.

## 4. What it hands forward

The handover **is** the output. Five items, stated at the top of the run:

1. **Archetype**, and the signal it was inferred from.
2. **Mode**, and the signal it was inferred from.
3. **Time budget**, or "unbounded".
4. **The owned-metrics subset** — section 2 of the chosen archetype in `role-packs.md`, which
   names the spine to take metrics from and splits them into owned outright, influenced, and
   not owned but asked about. **Hand forward the subset, not the whole file.** A downstream
   skill that receives every metric in both archetypes has been handed the problem it asked
   this skill to solve. `role-packs.md` numbers its sections 1 to 8 twice, once per
   archetype, so always cite it as "section N of the chosen archetype".
5. **Whether `knowledge/` holds an entry for the company**, per `evidence-ledger`. Not the
   facts themselves — just whether there is a file, and whether it is stale. That is what
   decides whether the next step reads the store or opens a search.

Nothing else. If the handover is longer than a short block, it has started doing the work.

## 5. When the seat is not clean

**Name it, then pick the closer one explicitly. Never average.** An answer built for the
midpoint of two archetypes is optimised for a seat that does not exist, and it is worse than
either of the two honest choices because it is defensible in neither room.

- **A task spanning both archetypes** — a payments feature inside a commerce product, a
  merchant-facing marketplace flow — takes the archetype of **the decision being made**, not
  of the company. If the question is about settlement and reconciliation it is fintech, even
  at a delivery company. Say which you picked and what you set aside: "reading this as
  fintech because the decision is a reconciliation one, so the marketplace supply layer is
  out of scope unless you want it in."
- **A company fitting neither** — social, media, developer tools, B2B SaaS outside payments —
  is a generalist brief. `role-packs.md` says so in its own opening. Say that no lens
  applies, and let the analysis skills run unmodified.
- **A borderline company** is decided by the charter, not the logo. A payments team inside a
  marketplace is fintech for that charter.

In all three cases the statement is one line and the run continues. **This section must never
turn into a discussion** — picking the closer archetype out loud and being corrected costs
one sentence, and is faster than establishing the right one by interview.

## 6. When no lens applies

Some questions need no archetype at all: a definition, a piece of arithmetic, a question
about the pack itself, a general product-craft question with no company and no seat behind
it. **Say so in one line and get out of the way.** Running the lens anyway produces a
paragraph of context nobody needed and delays the answer.

The test is whether the archetype would change the answer. If it would not, there is no seat
to establish, and this skill has nothing to contribute.

## Output

A short block, before any other skill runs:

```
Archetype: <consumer tech | fintech | none — generalist brief>, from <signal>
Mode:      <employee | interview prep | assignment>, from <signal>
Budget:    <minutes | hours | date | unbounded>
Metrics:   <the spine and the owned-outright subset, from role-packs section 2 of that archetype>
Knowledge: <knowledge/<slug>.md exists, last checked <date> | no entry>
```

Then stop, and let the skill that was asked for do the work.
