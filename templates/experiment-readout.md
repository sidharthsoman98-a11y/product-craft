# <Experiment>: <the outcome, not the topic>

> The title states the outcome. "Checkout redesign: no effect, killing it" beats
> "Checkout redesign experiment results", which forces the reader into the document to
> learn what could have been in its title.

**Recommendation:** <the decision, stated as a decision and not as a menu, in one line>

## 1. What happened

The result in a paragraph, with **the interval, not the point estimate**, and the call.
Write for someone who did not follow the test and will not ask a follow-up question.

| | |
|---|---|
| Primary metric | |
| Effect, with interval | |
| Pre-registered decision rule | what it said, before the data |
| Outcome class | win / loss / flat / inconclusive |
| What that class authorises | |

## 2. What it means

The interpretation, and **which checks changed it**. Name the checks that were run and what
each returned, rather than asserting the result is clean.

| Check | Result | Did it change the conclusion? |
|---|---|---|

## 3. What we are doing

| Decision | Owner | By when |
|---|---|---|

## 4. What we learned

The durable finding — including process findings, such as a decision rule that was never
pre-registered or an instrument that was not verified before launch.

---

## Appendix: methodology

**Methodology goes here, not at the top.** A readout that opens with methodology gets
skimmed, and a skimmed readout is read to the wrong conclusion.

Design, unit of randomisation, exposure and duration, power, guardrails, segments examined
and whether they were pre-registered, and the queries behind every number.

Hand chart rendering to `artefact-forge` and the queries to `analytics-sql`.
