---
name: rca
description: Diagnose a metric that has moved or a production incident, working from fact base to isolated slice to falsifiable mechanism. Use this whenever a number has dropped, spiked or drifted, when someone asks why orders are down, why conversion dropped, why delivery time increased or why a metric fell, when an RCA or root cause analysis is requested by name, when there is a production incident or outage, or when a post-mortem is needed.
---

# RCA

Diagnosing a metric that moved is a named interview round at consumer tech companies and a
weekly task in the job. The order below is the skill. Candidates and teams do not fail this
because they lack hypotheses — they fail because they generate hypotheses before they have
a fact base, and then explain a measurement artefact for a week.

Load `../../references/metric-library.md` for the diagnostic playbook in section 5 and the
archetype spine that gives the decomposition. Load `../../references/india-context.md`
section 5 before ruling on seasonality, and `../../references/instrumentation-and-experiments.md`
section 2 when step 2 turns up a measurement candidate.

## What this is not

Per `../../references/external-skills.md`:

- **Designing a metric system that does not exist yet is `metric-architecture`.** If the
  question is what to measure or what the north star should be, this is the wrong skill.
- **Reading a live dashboard is the external `metrics-review` skill.** If the numbers exist
  and the question is what they say this month, delegate. `metrics-review` surfaces that a
  number moved; the diagnosis is this skill.
- If a diagnosis concludes the metric set itself is wrong, hand back to
  `metric-architecture` explicitly rather than redesigning the tree inside an RCA.

## Procedure

Strict order. Do not proceed to a later step because an earlier one is boring.

1. **Establish the fact base before any hypothesis.** Which metric exactly, what is its
   definition and its denominator, what magnitude in absolute and relative terms, over what
   window, compared against what baseline. **Refuse to proceed on a vague statement.** Ask
   the single question that pins it down — usually "what is the denominator, and what are we
   comparing against" — and wait. "Orders are down" is not a fact base: down against last
   week, last year, plan, or the same weekday? Most bad diagnoses are traceable to this step
   being skipped politely.
2. **Is it real?** Deploy or tracking change, event schema change, a new app version, a
   pipeline backfill or late-arriving events, a bot or incentive-abuse wave, duplicate
   events. **Check the metric's raw event volume before its rate.** Most large sudden moves
   are measurement. In an interview this step is the differentiator: candidates who skip it
   lose the round, and candidates who name it first buy credibility for everything after.
3. **Whole population or a slice?** Cut by new versus existing, platform and app version,
   geography and city tier, acquisition channel, cohort age, device tier, network
   conditions. Do not list the cuts — **name the cut you would run first and why**, then the
   next. A change concentrated in one slice is a different problem from a broad drift, and
   the cut that isolates it is usually the answer. Note that client-side event loss
   correlates with device tier, network and geography, so a slice that looks worse may be
   measured worse; see `../../references/india-context.md` section 1.
4. **Mix or rate?** Reweight to the prior period's mix and see whether the change survives.
   A blended rate moves with every underlying rate flat if the segment mix shifted. If the
   change disappears under reweighting, the story is mix and the recommendation is different.
5. **Us or the world?** Competitor action, seasonality, festival timing, pay cycle, an
   outage at a counterparty, regulation, macro. **Use a segment the change could not have
   touched as a natural control.** For Indian products, check the seasonality section of
   `india-context.md` before concluding anything from a week-on-week comparison: a shifted
   festival date and a pay-cycle effect both look exactly like a real change.
6. **Where in the chain?** Walk the decomposition top-down to the single factor carrying the
   change. **Refuse to explain a large move with several small stories.** If a 10% drop is
   being explained by five 2% causes, the decomposition is wrong or the fact base is.
7. **Mechanism.** Only now propose a causal story, stated as a falsifiable claim with the
   one query or test that would disprove it. "Checkout conversion fell because the new
   address form is failing validation for addresses without a pincode" is falsifiable.
   "Users are less engaged" is not.
8. **Cost of delay.** What does a quarter of doing nothing cost, in money where possible.
   That determines urgency, and urgency determines whether you ship a fix now or open a
   study. Separate what to do now from what to investigate, and say which is which.

## Incident mode

For an outage or production incident, the method is the same and the framing changes.

- **Timeline of events** with timestamps: change deployed, first impact, first signal,
  detection, escalation, mitigation, resolution. Detection time is its own finding — an
  incident found by a customer is a monitoring failure regardless of its cause.
- **Impact quantified** in users affected, transactions or orders lost, and money, with the
  derivation shown. An incident report without a number cannot be prioritised against
  anything else.
- **Trigger versus underlying condition.** The trigger is what changed on the day. The
  underlying condition is what made the system fragile enough for that trigger to matter.
  A report that stops at the trigger produces a fix that prevents one incident; naming the
  condition prevents the class. Say both, explicitly labelled.
- **Contributing factors, not a single cause.** Real incidents have a chain — a change, a
  gap in a test, an alert that did not fire, a runbook that was stale. Insisting on one root
  cause hides most of the fixable surface.
- **Blameless framing.** Describe what the system made easy to get wrong, not who got it
  wrong. Name systems and steps, never individuals.
- **Corrective actions with owners** and dates, split into prevent, detect faster, and
  reduce blast radius. Actions without an owner are decoration.

## Interview mode

A compressed version, spoken in five to seven minutes. Structure out loud, narrow
explicitly, and name the data you would ask for at each step.

- **Open by pinning the fact base** and asking your one clarifying question. Do not ask
  five; ask the one that changes the answer, then proceed on a stated assumption.
- **State the hypothesis tree before descending it:** measurement, then slice, then mix,
  then external, then internal chain. Saying the tree first is what makes the answer sound
  like a method rather than a list.
- **Narrow audibly.** "That rules out measurement, so I am now asking whether it is a slice."
  The interviewer is scoring the narrowing, not the guesses.
- **Name the data at each step** — the cut, the query, the comparison window.
- **Land on one mechanism, its falsification test, and what you would do on Monday.**

**Strong versus average**, drawing on `../../references/role-packs.md`:

- *Average* opens with a framework, lists internal and external causes, asks for no data,
  assumes the drop is real, produces six plausible causes and ranks none. Structured and useless.
- *Strong* asks whether the number is real before anything else, cuts by store, pincode and
  cohort rather than by nothing, finds the slice, names the owner of the fix, sizes the loss
  in contribution margin rather than in orders, and says what it would stop doing if the
  cause turned out to be capacity.
- The consumer-tech tell is sequencing growth against capacity unprompted. The fintech tell
  is decomposing payment failure by owner — issuer, network, own stack, insufficient funds,
  abandonment, risk decline — rather than quoting a blended success rate.

## Output

Written diagnosis using `../../templates/rca.md`: fact base, ruled out, isolated to,
mechanism, evidence needed, recommendation, cost of delay. Every step that was run and
cleared belongs in "ruled out" — the ruled-out list is evidence of method and is the part an
interviewer scores.

Score against `../../references/rubrics.md`. Watch particularly for the average trap, unowned
numbers, and metric without a decision. If the diagnosis is inconclusive, say so and name the
one query that would resolve it, rather than promoting the least-bad hypothesis to a finding.
