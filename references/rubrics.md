# Rubrics and the failure catalogue

Score every artefact before presenting it. Scores are 1 to 4, where 3 is a hire signal and
4 is rare. Report a table, a verdict, and exactly one highest-leverage fix.

## Universal dimensions

| Dimension | 1 | 2 | 3 | 4 |
|---|---|---|---|---|
| Structure | A named framework applied to everything | Structure present but generic | Custom, MECE, built for this problem, stated in under 90 seconds | Structure itself reveals the insight |
| Problem framing | Answers the question asked, literally | Restates the prompt | Reframes to the real problem and says why | Reframes and shows what the original framing would have cost |
| User insight | Demographic personas | A segment with a plausible need | Named segment, job, trigger, current workaround | Insight a competitor would not have and cannot easily get |
| Evidence | Assertion | Anecdote | Numbers with stated derivation and source class | Numbers plus the falsification test |
| Metrics | Vanity or listed | North star named | Tree, guardrail, instrumentation, decision rule | Counterfactual: what the metric would have made the team do |
| Economics | Absent | Revenue mentioned | Contribution stack and break-even | Sensitivity, and the one variable that decides it |
| Trade-offs | Everything is a priority | Ranking present | Explicit criteria, defended, with refusals | Names the cost of its own recommendation and who bears it |
| Risk | None | Generic risks | Pre-mortem with early signals | Kill criteria and the cheapest falsifying test |
| Communication | Rambling, bottom-up | Structured but long | Answer first, two minutes, no filler | Anticipates and pre-empts the follow-up |

Verdict scale: NO HIRE (any 1 on structure, evidence or trade-offs), LEAN NO, LEAN HIRE,
HIRE (mean at or above 3 with no 1s), STRONG HIRE (a 4 on at least two dimensions).

## Artefact-specific gates

**Teardown**: all nine layers present, arc rule satisfied, refusals section non-empty,
consistency checks passed, 120-second version written.

**Metric answer**: primitive named, north star tested against all six criteria, tree is
arithmetically consistent, at least one instrumentation failure mode named, decision rule
pre-registered.

**RCA or incident report**: fact base established before any hypothesis was offered —
metric, definition, denominator, magnitude, window and baseline all stated; measurement
ruled out explicitly rather than assumed away, with raw event volume checked before the
rate; the isolating cut named, not a list of cuts that could have been run; mix versus rate
tested by reweighting to the prior period; mechanism stated as a falsifiable claim with the
one query or test that would disprove it; the ruled-out list present, since it is the
evidence of method and the part an evaluator scores; cost of delay stated in money where
possible. An inconclusive diagnosis that names the one resolving query passes this gate. A
confident diagnosis that skipped step 1 does not.

**Case or assignment**: assumptions labelled and sourced, answer stated first,
sensitivity on the two decisive variables, recommendation with an owner and a first
milestone, what would change my mind.

**PRD or PRFAQ**: non-goals present, every requirement traceable to a stated user problem,
success metrics with baselines, failure and edge states covered, open questions held in a
table rather than resolved by assertion.

**Prototype demo**: runs without explanation, the core loop is completable end to end,
the demo script is under three minutes, the fake data is plausible, and the honest
limitations slide exists.

**Ticket set**: every ticket traces to a stated user problem or contract clause; acceptance
criteria testable by a stranger with no context, in given/when/then rather than a
description of the build; the edge-case walk complete, with failure, retry and
reconciliation each either specified or explicitly ruled out with a reason; slices in
shipping order with the first genuinely usable on its own; dependencies carrying named
owners and dates; definition of done applied rather than assumed; and what is deliberately
not in the ticket stated, since that is what a reader would otherwise assume is included. A
slice that is not usable alone is a stage, and a ticket set of stages fails this gate.

**Experiment readout**: recommendation in the first two lines and stated as a decision
rather than a menu; title states the outcome, not the topic; the interval reported rather
than the point estimate; the pre-registered decision rule quoted as it stood before the
data, and where none was registered that named as a process finding rather than omitted;
the checks that could have changed the conclusion listed with what each returned; decision
carrying an owner and a date; and methodology in an appendix. A readout that opens with
methodology fails this gate even when every number in it is right.

**Launch plan**: six readiness gates each answered yes or no with a name against it and
nothing left "in progress"; stages whose gates are questions answered rather than dates
reached; the kill switch named with who holds it, how fast it acts and when it was last
actually run; day-one dashboard with a named watcher, a stop threshold and a named stop
authority; comms including the internal break-glass note; and a dated post-launch decision
with an owner. A rollback nobody has run is a hypothesis and does not satisfy this gate.

**Integration or API review**: field-level contract with optionality and versioning; error
taxonomy stating retryability and the partner's action for each code; idempotency key with
its derivation, scope, lifetime and collision behaviour; webhook contract distinguishing
hint from truth, with the polling fallback; state machine with legal transitions, timeouts
and an owner per transition; reconciliation with break classes, owners and SLAs; go-live
gates including sandbox parity and the in-flight rollback path; and the unhappy path
including the support lookup. A design correct on the happy path that silently creates a
manual queue for someone else does not pass.

**Drill transcript**: the prompt given as written and the clock held to it; no coaching,
running commentary or visible notes during the round; the round scored by `red-team` against
the universal dimensions rather than by a rubric restated inside the drill; the weakest
sentence quoted back verbatim; exactly one fix named; the run written to `drills/` under a
filename that cannot overwrite an earlier run; and the trend across stored runs read before
the next round is chosen. A drill that explained instead of examining fails this gate
regardless of the score it produced.

## Failure catalogue

Check for these by name. They are the recurring reasons strong-sounding answers fail.

1. **Framework recitation.** The answer would fit any product. Fix: delete every sentence
   that would survive a find-and-replace of the product name.
2. **Solution-first.** A feature appears before the problem is characterised.
3. **Unowned numbers.** A statistic with no derivation, no source class, no error bar.
4. **Segment drift.** The segment in the recommendation is not the segment in the analysis.
5. **Constraint amnesia.** The recommendation assumes away the binding constraint.
6. **Free lunch.** No trade-off named. Nothing is sacrificed.
7. **Metric without a decision.** A metric proposed that no action depends on.
8. **Vanity growth.** Volume metrics without their lagged quality partner.
9. **The average trap.** A blended number quoted where the mix is the story.
10. **Scope inflation.** A two-week test proposed as a two-quarter programme.
11. **Ethics as an afterthought.** Externalities on workers, merchants or low-income users
    unpriced and unnamed until asked.
12. **No falsification.** Nothing in the answer could be shown to be wrong.
13. **Demo theatre.** A prototype that only works on the one path the presenter walks.
14. **Missing the unhappy path.** Failure, refund, dispute and recovery ignored.
15. **Buried lede.** The recommendation arrives after four minutes of build-up.
