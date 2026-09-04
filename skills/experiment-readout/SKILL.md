---
name: experiment-readout
description: Read a finished experiment honestly and turn it into a decision - ship, kill, iterate or escalate - then write the readout. Use this when an A/B test has finished, when interpreting a lift, a flat result or a mixed one, when a guardrail has moved, when deciding whether to ship a tested change, or when writing up a result for a team or a stakeholder. Designing the test is metric-architecture; a metric that moved with no experiment attached is rca.
---

# Experiment readout

The test is over. The hard part was never the arithmetic — it is converting a result into a
decision inside an organisation that already has a preferred answer, and doing it in a way
that survives the next three people who read it.

Readouts fail in two directions. They present the data and leave the decision to the room,
which is abdication dressed as rigour. Or they present the decision the author wanted and
arrange the data behind it, which is worse, and which everyone eventually notices.

**Division of labour, so nothing here is duplicated:**

- **Design** — hypothesis, unit of randomisation, MDE, duration, guardrails — is
  `../../references/instrumentation-and-experiments.md` sections 3 and 4.
- **The honest-reading rules** are section 5 of that same file. That is the checklist.
- **The metric-state to authorised-decision table** is `../../references/metric-library.md`
  section 6.

**This skill is the order you apply those in, the artefact you produce, and the call you
make.** Where a rule is already stated in one of those files, it is referenced here and not
repeated.

## What this is not

- **`metric-architecture` designs the test.** Unit of randomisation, MDE argued from the
  business, duration, guardrails, pre-registered decision rules. If the test has not run yet,
  this is the wrong skill.
- **`rca` handles a metric that moved with no experiment attached.** An experiment has a
  counterfactual and an RCA does not, which is the entire reason they are different jobs. Do
  not run a diagnosis inside a readout, and do not read an RCA as if it were a test.
- **`analytics-sql` writes the queries** behind the numbers. This reads their output.
- **The external `metrics-review` skill** reads a dashboard on a cadence. A readout is about
  one intervention with a control.

## 1. Read the decision rule before you read the data

Open the pre-registration first, and read it before you look at a single number. **The
sequence is the point.** Once you have seen the result you cannot un-see it, and every
threshold silently becomes negotiable in the direction you already prefer. Per
`metric-library.md` section 6, a metric earns its place only when a specific number
authorises a specific action, and that rule is written before the data arrives.

**If no rule was pre-registered, say so in the readout, in the first section, in one line.**

That line is not a formality — it changes what the readout is permitted to claim. Without a
pre-registered rule, the honest framing is *"this is the strongest hypothesis we now hold"*,
not *"this is what we proved"*. You can still decide, and often you should. What you cannot
do is present the decision as tested, because a rule written after the result is a
rationalisation with a table around it.

Then write the rule down for next time, and put its absence in "what we learned". A missing
pre-registration is a process finding, and process findings are the ones that compound.

## 2. Report the interval, not the point estimate

A point estimate with no interval is a number pretending to be a fact. **Before calling
anything null, check whether the interval excludes the MDE.** The distinction most readouts
get wrong is this one:

| | Interval | What you actually have | Decision |
|---|---|---|---|
| **Precise zero** | Tight, excludes the MDE | A real finding: the effect is not there at a size worth having | Kill, and stop paying the maintenance cost |
| **Underpowered** | Includes both zero and the MDE | **Nothing.** You have learned nothing about the hypothesis | Extend, raise exposure, reduce variance — or declare it unanswerable at this traffic |

**Naming which of the two you have is the single most useful sentence in most readouts, and
it is the one most often skipped.** "No significant effect" is written identically for both,
and they authorise opposite actions: the first is knowledge worth having, the second is an
unfinished test being reported as a conclusion.

Two further rules that carry their weight:

- **Report relative and absolute together.** A 20% lift on a 0.5% base is 0.1 percentage
  points, and the business case runs on the second number. Quoting only the first is the most
  common way a readout misleads without containing a false statement.
- **Significance alone authorises nothing.** A p-value below the threshold on an effect below
  the MDE means you have precisely measured something too small to be worth shipping.

## 3. The checks that change the conclusion

Run these before writing anything. Each one can reverse the reading, which is why they come
before the narrative rather than after it. The underlying rules are in
`instrumentation-and-experiments.md` section 5; what follows is the order and the consequence.

| Check | Looking for | What it does to the call |
|---|---|---|
| **Sample ratio mismatch** | The realised split is not the split you asked for | **Run this first.** SRM means assignment or logging is broken, the groups are not comparable, and nothing downstream in the readout means anything. No analysis rescues it |
| **Effect by week** | Novelty (decays) or primacy (grows as users adapt) | A novelty effect shipped is a lift you will give back next quarter. If it is decaying, hold a holdout and say so |
| **Pre-declared segments** | Heterogeneity — up in one, down in another | Segment the rollout rather than averaging. Segments found *after* the fact are hypotheses, reported as hypotheses, and re-tested |
| **Guardrails** | Any metric outside its stated band | A breach outranks a primary win. See section 4 |
| **Mechanism** | Did the thing you predicted would move actually move? | **A win with no mechanism is unexplained, not proven.** Unexplained wins rarely replicate |
| **Instrumentation sanity** | Event volume changing in ways the treatment does not explain | Suspect the pipeline before the product; see section 2 of the instrumentation reference |

The mechanism check deserves its emphasis. The hypothesis was "X will raise Y by at least Z
**because W**". If W did not move, you have a correlation inside a randomised container,
which is better than nothing and is not the thing you set out to demonstrate. Ship it if the
cost of being wrong is low, but ship it with a holdout and say in writing that the mechanism
is unconfirmed.

## 4. The four outcomes and what each authorises

Extends the decision table in `metric-library.md` section 6 with what you are permitted to
claim in each case.

**1. Clear win.** Effect above the MDE, interval excluding both zero and the MDE, guardrails
clean, mechanism moved. → Ship to 100% and redeploy the team. Still state what you will watch
for a month and whether a long-run holdout stays in place.

**2. Clear null.** A precise zero. → Kill it and stop paying its maintenance cost. **You may
claim** the effect is not there at a size worth having. **You may not claim** the idea is
impossible — only that this implementation, at this size, on this population, is not it.

**3. Underpowered.** A wide interval. → Authorises nothing about the hypothesis, so choose
deliberately and say which you chose: extend (for how long, and what would stop you), raise
exposure, apply variance reduction, or declare the question unanswerable at current traffic
and kill it on cost-of-delay grounds rather than pretending it was evidence.

**4. Mixed, with a guardrail breach.** Primary up, a guardrail outside its band. → **This
authorises escalation, not shipping.** Quantify the trade in money — the primary's value
against the guardrail's cost, in the same unit — and take it to whoever owns that trade-off.
**Do not ship quietly, and do not net the two into a single positive number on a slide.**
Quiet shipping is the specific failure this section exists to prevent, and it is usually
committed by someone who genuinely believed the breach was small.

Two decisions to name explicitly in every readout, both from `metric-library.md` section 6:
**one-way versus two-way door** — a reversible change with a marginal result can ship on less
evidence, a one-way door cannot — and **cost of delay**, stated in the metric's own units,
which is usually the argument that ends the debate.

## 5. Writing the readout

One page, four sections, in this order:

1. **What happened** — the result in a paragraph, with the interval and the call.
2. **What it means** — the interpretation, and which checks from section 3 changed it.
3. **What we are doing** — the decision, an owner, a date.
4. **What we learned** — the durable finding, including process findings such as a missing
   pre-registration.

**The recommendation goes first. The methodology goes in an appendix.** A readout that opens
with methodology gets skimmed, and a skimmed readout is read to the *wrong* conclusion — the
reader takes the first number they encounter and stops. Put the number you want acted on in
the first two lines.

- **The title states the outcome, not the topic.** "Checkout redesign: no effect, killing it"
  beats "Checkout redesign experiment results", which forces everyone to read the document to
  learn what could have been in its title.
- **State the decision as a decision, not as a menu.** Options with no recommendation is the
  abdication described at the top of this file.
- **Write for someone who did not follow the test** and will not ask a follow-up question.
- Hand chart rendering to `artefact-forge` and the queries behind the numbers to
  `analytics-sql`.

## 6. A result you did not want

**Killing your own feature is the behaviour that makes every future result from you
trustworthy.** It is a deposit, not a loss. A PM who has never killed anything gets read with
a silent discount applied, and that discount lands hardest on the result they most need
believed.

The failures to refuse by name, all of them committed by people who thought they were being
reasonable:

- **Extending the test until it turns.** This is peeking with extra steps.
- **Re-cutting segments until one is positive.** See section 7.
- **Quietly reframing the primary metric** to one that moved.
- **Shipping "for learning"** with no decision attached, which is shipping without saying so.
- **Shipping because the team worked hard. Sunk effort is not evidence**, and treating it as
  evidence teaches the team that effort is how you win an argument.

What to do instead: report it in the same format and at the same cadence as a win, state the
cost of the effort honestly, and file the learning where the next person to have this idea
will find it — because someone will have it again, and the only question is whether they pay
for the lesson twice.

**The strongest version of this is written in advance:** put in the pre-registration what you
will do if the result is null. It costs nothing before the data and is nearly impossible
afterwards.

**And distinguish a null result from a failed experiment.** A null is a finding. A failed
experiment is one that could not have answered the question — underpowered, broken
assignment, mechanism never measured. Teams attach their morale to the wrong one of those, so
say which it was, out loud.

## 7. Misreadings to check for by name

Check these off explicitly rather than trusting that you avoided them:

- **Peeking.** Looking repeatedly and stopping when it crosses. It inflates false positives.
  Fix the duration in advance, or use a sequential method designed for continuous monitoring.
- **Post-hoc segments.** A segment discovered after the fact is a hypothesis, not a finding.
  Report it as a hypothesis and re-test it, or it becomes a fact by repetition.
- **Averaging over a reversal.** An effect that was positive for two weeks and negative for
  two averages to a small positive that describes no period that actually happened. The
  week-by-week check in section 3 is what catches it.
- **Treating a guardrail breach as a rounding error.** "Only 0.3% worse on refunds" is a rate
  multiplied by volume. Compute it in money *before* deciding it is small; the number is
  frequently larger than the primary win.
- **HARKing** — presenting a hypothesis formed after the result as if it had been the
  prediction. Section 1 exists to make this visible.
- **Multiple comparisons.** Twenty diagnostics and one will clear the threshold by chance.
  Diagnostics are not decision-bearing; do not promote one to primary after the fact.

## Output

The one-page readout in section 5's order, carrying: the pre-registered decision rule or an
explicit statement of its absence; the interval and which of the four outcomes it is; the
checks run and what they changed; the decision with an owner and a date; the trade quantified
in money where a guardrail moved; and the durable learning.

Score against `../../references/rubrics.md`. The failures this work produces are metric
without a decision, unowned numbers, and no falsification — the readout that could not have
concluded anything other than what its author already wanted.
