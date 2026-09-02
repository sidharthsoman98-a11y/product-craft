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

**Case or assignment**: assumptions labelled and sourced, answer stated first,
sensitivity on the two decisive variables, recommendation with an owner and a first
milestone, what would change my mind.

**PRD or PRFAQ**: non-goals present, every requirement traceable to a stated user problem,
success metrics with baselines, failure and edge states covered, open questions held in a
table rather than resolved by assertion.

**Prototype demo**: runs without explanation, the core loop is completable end to end,
the demo script is under three minutes, the fake data is plausible, and the honest
limitations slide exists.

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
