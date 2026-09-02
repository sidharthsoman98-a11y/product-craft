# Instrumentation and experiments

Read when defining events, defending a measurement, or designing a test. Being able to say
how a number is produced, and how it breaks, is the fastest way to sound like someone who
has shipped rather than someone who has read.

## 1. Event design

Name events as `object_action` in past tense: `order_placed`, `payment_attempted`,
`kyc_submitted`. Keep the taxonomy small; a schema nobody remembers is a schema nobody uses.

For each event define: trigger point in code, actor, required properties, optional
properties, where it fires, and the owner.

**Client or server**
- Server-side for anything financial, contractual, or used in a decision that costs money.
  Client events drop on poor networks and low-end devices, which biases every metric against
  exactly the users who matter most in emerging markets.
- Client-side for intent, attention and UI interaction, which the server cannot see.
- If a funnel spans both, expect a step change at the boundary and reconcile it explicitly
  rather than explaining it away later.

**Properties that save you later**: schema version, app version, platform, network type,
session id, idempotency key, server timestamp and client timestamp both, experiment
assignment, and the surface the action came from.

**Identity**: define how anonymous activity is stitched to a user at login, and what
happens to pre-login events afterwards. Un-stitched identity is the most common cause of
funnel numbers that do not reconcile.

## 2. Instrumentation failure modes

- **Duplicates.** Retries and offline queues resend events. Deduplicate on an idempotency
  key at ingestion, not in a dashboard.
- **Late arrival.** Offline events land days later and quietly restate yesterday's numbers.
  Declare a lateness window and say when a number is final.
- **Clock skew.** Device time is unreliable. Order by server time.
- **Sampling.** Know whether the pipeline samples, and at what rate, before quoting anything
  rare like fraud or errors.
- **Silent schema drift.** A renamed property breaks a metric with no error. Version the
  schema and alert on volume anomalies per event.
- **Definition drift.** "Active" changed meaning between two decks and nobody said so.
  Keep one definitions file and date every change.
- **Ad blockers and privacy platform changes** remove a non-random slice of client events.
- **Bots and incentive abuse** inflate top-of-funnel, especially where rewards exist.

## 3. Experiment design

State these before running anything:

1. **Hypothesis**, falsifiable, with a mechanism: "adding X will raise Y by at least Z
   because W".
2. **Unit of randomisation.** User, device, session, merchant, store, city, or time slice.
   Choose the smallest unit that has no interference between units.
3. **Primary metric** (one), **guardrails** (two or three), **diagnostics** (as many as
   useful but not decision-bearing).
4. **MDE.** The smallest effect worth detecting, argued from the business, not chosen for
   convenience. Sample size scales with the inverse square of the MDE, so halving the MDE
   quadruples the traffic needed. Say this when someone asks for a smaller detectable effect.
5. **Duration.** At least one full weekly cycle, plus any known cycle (pay dates, festivals).
   Never stop on a Friday spike.
6. **Decision rule**, written in advance: ship if, kill if, extend if.

## 4. When a simple A/B will not work

- **Interference.** Marketplaces, social graphs, delivery fleets and pricing all leak
  treatment into control. Randomise by geography, cluster or time (switchback) instead.
- **Switchback tests** alternate treatment across time slices in the same market. Correct
  for logistics and pricing; requires more duration and careful handling of carryover.
- **Small N, high value.** Enterprise or merchant-facing changes rarely have the population
  for significance. Use pre-post with a matched control group, or a staged rollout with
  qualitative gates, and be honest that it is directional.
- **Long-horizon effects.** Habit, trust and brand changes take longer than a sprint.
  Hold a long-run holdout, typically 1-5%, for a quarter or more.
- **Rare events.** Fraud, crashes and churn need either long windows or proxy metrics with
  a stated correlation to the real outcome.

## 5. Reading results honestly

- Report the confidence interval, not just the point estimate, and check whether the
  interval excludes the MDE before declaring a null.
- Check for novelty and primacy by looking at the effect week by week.
- Check heterogeneity across pre-declared segments only. Segments found after the fact are
  hypotheses, not findings, and must be re-tested.
- Peeking inflates false positives. Either fix the duration in advance or use a sequential
  method designed for continuous monitoring.
- Variance reduction (using pre-period data as a covariate) buys sensitivity without extra
  traffic and is usually the cheapest way to run a hard test.
- A guardrail breach outranks a primary win. Quantify the trade in money and escalate it;
  do not quietly ship.
- If the mechanism you predicted did not move, treat a positive result as unexplained, not
  as a win. Unexplained wins rarely replicate.

## 6. Alternatives to experimentation

Not everything can or should be tested. Name the method you are using and its weakness.
- Staged rollout with monitoring, for infrastructure and risky migrations.
- Difference in differences across markets, when a change lands in one geography first.
- Regression discontinuity, where a threshold already exists (credit cut-offs, tiers).
- Instrumented qualitative research: five moderated sessions catch usability failures that
  no amount of traffic will reveal.
- Painted door and fake door tests to measure demand before building, with the ethical
  requirement that the user is not left stranded or misled about money.
- Backtesting against historical data for ranking and risk models, with a forward holdout.
