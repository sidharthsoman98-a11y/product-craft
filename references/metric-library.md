# Metric library

Read this whenever a task involves choosing, defending, decomposing, instrumenting or
diagnosing a metric. Sections 1-3 are general method. Section 4 is the archetype spine
you look up for the specific business. Sections 5-7 are diagnosis, decision and failure.

## Contents
1. Value-exchange primitive
2. North star selection and its tests
3. Decomposition patterns
4. Archetype spines (marketplace, quick commerce, payments, lending, B2B SaaS, ads and social, streaming, AI-native, dev tools, logistics)
5. Diagnostic playbook (a metric moved, now what)
6. Metric to decision mapping
7. Failure modes catalogue

---

## 1. Value-exchange primitive

Before any metric, name the unit of value exchange. It is the smallest event where a
user gets something they would miss if it disappeared, and the business captures
something. Everything downstream is a count, rate or value of that primitive.

| Product | Primitive | Not the primitive |
|---|---|---|
| Ride-hailing | Completed trip | App open, ride requested |
| Payments app | Successful transaction of intent | Registered user |
| Quick commerce | Delivered order within promise | Item added to cart |
| B2B SaaS | Workflow completed in-product | Seat provisioned |
| Social feed | Session with meaningful interaction | Session |
| Lending | Loan repaid on schedule | Loan disbursed |
| AI assistant | Task completed without human rescue | Message sent |

Three consequences follow, and they are the ones candidates skip:
- **Time to value.** How long from first touch to first primitive event? This becomes
  the activation metric, and it is usually the highest-leverage number in a young product.
- **Value asymmetry.** In two-sided products, the primitive means different things to
  each side. Measure both or you will optimise one into collapse.
- **Value recognition lag.** The user may realise value long after the event
  (lending: repayment; insurance: claim). Metrics that ignore the lag reward volume
  and punish quality. Say explicitly where the lag sits.

## 2. North star selection and its tests

A candidate north star must pass all six. Run the tests out loud; failing one is the
most useful thing you can say in an interview.

1. **Value fidelity.** It cannot go up unless a user got value. Test by asking: can a
   team move this by 20% with a change no user would thank them for? If yes, reject.
2. **Revenue causality.** There is a plausible, statable causal chain to revenue. Not
   correlation. State the chain in one sentence, including the lag.
3. **Sensitivity.** A quarter of good work visibly moves it. If it only moves annually,
   it is a board metric, not a north star, and the team needs a proxy.
4. **Influenceability.** The team owns the levers. A metric dominated by macro or by
   another team's decisions produces learned helplessness.
5. **Gaming resistance.** Enumerate the three cheapest ways to move it dishonestly.
   If any is cheap and invisible, either change the metric or pair it with a guardrail.
6. **Segment stability.** It means the same thing for a new user and a power user, in
   metro and in tier-3. If not, you need a segmented north star, not an average.

Common good answers, and what each quietly sacrifices:
- Weekly active users: cheap to instrument, blind to depth and to monetisation.
- Sessions with a completed core action: better fidelity, harder to compare across surfaces.
- Value delivered (GMV, TPV, hours watched): closest to money, most vulnerable to
  concentration in a few whales, and mixes price with volume.
- Retained cohort value at day 30: best predictive power, slowest feedback.

Pair the north star with exactly one **counter-metric** and two **guardrails**. More
than that and no one remembers them.

## 3. Decomposition patterns

Pick the pattern that matches the physics of the business. Mixing patterns without
saying so is the most common structural error in metric interviews.

**Multiplicative (most consumer products)**
`Value = Users x Frequency x Breadth x Value per unit`
Each factor is owned by a different lever family: acquisition and resurrection,
habit and triggers, cross-category discovery, pricing and mix. Useful because you can
attribute a change to exactly one factor.

**Funnel (single conversion journey)**
`Outcome = Traffic x C1 x C2 x ... x Cn`
Use when the journey is linear and one-shot. Its weakness is that it hides re-entry and
multi-session decisions, which is most of commerce. If users routinely leave and return,
a funnel will lie to you; use a cohort view.

**Cohort and retention (habit products)**
Describe the retention curve by three parameters: day-1 drop, decay rate, and terminal
floor. The floor is the business. A change that lifts day-1 but not the floor is a
packaging change, not a product change. Always ask which of the three moved.

**Marketplace liquidity (two-sided)**
`Liquidity = P(match within acceptable time and quality)`
Decompose into search-to-match rate on the demand side and utilisation on the supply
side. The scarce side sets the ceiling. Almost every marketplace question is answered by
identifying the hard side first and refusing to optimise the easy side.

**Capacity and utilisation (operations-heavy)**
`Throughput = Capacity x Utilisation x Yield`
Quick commerce, delivery, cloud, support. Here the binding constraint is physical, so
demand-side growth without capacity is negative value. This is the pattern candidates
miss most often when they treat an operations business as a funnel business.

**Reliability-weighted (infrastructure and payments)**
`Effective volume = Attempted volume x Success rate x (1 - reversal rate)`
Where success rate is itself decomposed by failure owner: user error, our system,
network, counterparty. Attribution of failure is the entire game.

**Portfolio and risk (credit, insurance, trust and safety)**
`Contribution = Volume x (Revenue rate - Expected loss rate - Cost to serve)`
Expected loss is a forecast, so every metric is provisional until the book seasons.
Never present a credit metric without its vintage.

## 4. Archetype spines

Each spine gives: primitive, north star, input tree, guardrails, the number leadership
actually watches, and the trap.

### 4.1 Marketplace and horizontal commerce
- Primitive: delivered order that is not returned.
- North star: monthly transacting users, or net GMV from repeat cohorts.
- Inputs: traffic x search-to-product rate x add-to-cart x checkout conversion x
  (1 - cancellation) x (1 - return rate); crossed with sessions per user and categories per user.
- Supply health: assortment depth in demanded categories, seller fill rate, price competitiveness index, days of cover.
- Guardrails: return rate, delivery promise breach, customer acquisition cost, seller churn.
- Leadership watches: contribution margin per order and repeat rate by cohort.
- Trap: optimising conversion by discounting, which raises GMV and destroys CM2 while
  training the cohort to wait for sales. Always check whether a conversion gain survived
  discount normalisation.

### 4.2 Quick commerce and hyperlocal delivery
- Primitive: order delivered within the promise window.
- North star: orders per dark store per day, or contribution margin per order at fixed AOV.
- Inputs: demand density per pincode x conversion x basket size x in-stock rate;
  supply side: pickers per store, rider utilisation (orders per rider hour), batching rate,
  distance per order, promise adherence.
- Economics chain: AOV x (gross margin %) - (delivery cost + picking cost + packaging +
  payment cost + discount + platform fee absorbed) = CM1. Store fixed cost / orders = the
  break-even order count.
- Guardrails: promise breach rate, spoilage and shrink, rider cost per order, out-of-stock
  on the top 100 SKUs (the assortment that actually drives repeat).
- Leadership watches: break-even orders per store per day and the number of stores past it.
- Trap: treating this as a funnel product. Demand generation into an under-capacity store
  degrades the promise, which kills retention faster than the demand adds revenue.
  Growth must be sequenced against capacity, and you should say so unprompted.

### 4.3 Payments and UPI-style rails
- Primitive: a payment that settles correctly, first attempt.
- North star: successful transactions per active payer per month, or TPV from repeat merchants.
- Inputs: intent volume x attempt rate x technical success rate x business approval rate;
  crossed with payer frequency and merchant coverage.
- Decompose failure by owner: bank or issuer downtime, network timeout, our stack,
  insufficient funds, user abandonment, risk decline. Each has a different owner and a
  different fix, and being able to name the split is what separates a payments PM from a
  generalist.
- Economics: interchange and MDR where permitted; zero-MDR rails earn nothing per
  transaction, so monetisation must come from adjacency (lending, ads, subscriptions,
  merchant services, float where regulation permits). State this before anyone asks.
- Guardrails: fraud in basis points, chargeback rate, dispute resolution time, settlement
  breach, false-positive risk declines (the most expensive invisible metric in payments).
- Leadership watches: success rate versus the market benchmark, and cost per transaction.
- Trap: quoting a blended success rate. It hides that one issuer or one instrument is
  dragging the average, and mix shift alone can move the blended number with nothing
  changing underneath.

### 4.4 Lending and credit
- Primitive: a loan repaid on schedule.
- North star: risk-adjusted disbursal, not disbursal.
- Inputs: application volume x approval rate x acceptance rate x average ticket;
  against credit cost by vintage, bucket flow rates (0 to 30 to 60 to 90 days past due),
  collection efficiency, and net interest margin after cost of funds.
- Guardrails: early delinquency at 30 days for the newest vintage, concentration by
  geography or employer, collections complaint rate, regulatory exposure.
- Leadership watches: net interest margin minus credit cost, by vintage.
- Trap: growth metrics look excellent for two quarters because losses arrive late. Any
  credit answer that does not mention vintage seasoning is wrong on its face.

### 4.5 B2B SaaS
- Primitive: a workflow completed in-product by a paid seat.
- North star: weekly active workflows per account, feeding net dollar retention.
- Inputs: accounts x seats activated per account x weekly active seats x workflows per seat.
- Commercial layer: new ARR, expansion, contraction, churn, NDR, gross retention,
  CAC payback in months, magic number, sales cycle length.
- Guardrails: time to first value, support tickets per account, admin overhead,
  single-champion dependency (usage concentrated in one user is churn waiting to happen).
- Leadership watches: NDR and CAC payback.
- Trap: measuring logins. Seats are bought by an economic buyer and used by someone else,
  so activation must be measured at the workflow level, not the login level.

### 4.6 Ads, social and content
- Primitive: a session containing a meaningful interaction.
- North star: daily sessions with meaningful interaction, or time well spent proxies.
- Inputs: DAU x sessions per DAU x depth per session; supply side: creators, posts per
  creator, content freshness, moderation latency.
- Monetisation: impressions x ad load x fill rate x eCPM, with ad load as the explicit
  tension variable against engagement.
- Guardrails: reported content rate, creator churn, negative feedback per impression,
  session frequency for new users (the cold-start cohort is where feeds die).
- Leadership watches: DAU over MAU, and revenue per DAU.
- Trap: time spent as a north star. It fails the value fidelity test, since the cheapest
  way to raise it is to make the product worse at finishing tasks.

### 4.7 Streaming and subscription media
- Primitive: a completed viewing or listening session.
- North star: monthly retained subscribers who watched at least n hours.
- Inputs: acquisitions x activation (first title finished) x engagement depth x renewal.
- Content economics: cost per title amortised against incremental retention it drove.
- Guardrails: involuntary churn from payment failure (often the largest single churn
  bucket and the cheapest to fix), catalogue concentration, buffering rate.
- Trap: attributing retention to the newest release without a holdout.

### 4.8 AI-native products
- Primitive: a task the user would otherwise have done manually, completed acceptably.
- North star: successful tasks per active user per week, where success is defined by an
  eval, not by the absence of a complaint.
- Inputs: attempts x containment (finished without escalation) x acceptance (user kept
  the output) x repeat usage; quality layer: eval pass rate on a frozen set, regression
  rate between model versions, hallucination or unsafe rate.
- Economics: cost per successful task, which is inference cost divided by success rate.
  This is the number that decides whether the product can be priced, and almost no
  candidate raises it.
- Guardrails: p95 latency, escalation rate to humans, cost per task, refusal rate.
- Trap: measuring engagement. In an assistive product, less usage for the same outcome is
  usually a better product.

### 4.9 Developer tools and infrastructure
- Primitive: a successful integrated call in production.
- North star: weekly active integrations that have crossed a production threshold.
- Inputs: signups x time to first successful call x time to production x call volume growth.
- Guardrails: error rate by integration, p99 latency, breaking-change incidents,
  documentation search failure rate.
- Trap: counting signups and sandbox keys, which are free and meaningless.

### 4.10 Logistics and fulfilment
- Primitive: a shipment delivered on the first attempt within the promise.
- North star: first-attempt delivery rate at target cost per shipment.
- Inputs: capacity x route density x attempts per delivery x returns to origin.
- Guardrails: cost per shipment, damage rate, rider or driver attrition, promise breach.
- Trap: averaging cost per shipment across dense and sparse geographies, which hides that
  half the network is losing money on every parcel.

## 5. Diagnostic playbook: a metric moved

Follow the order. Skipping step 1 is how teams spend a week explaining a logging bug.

1. **Is it real?** Deploy or tracking change, event schema change, a new app version, a
   pipeline backfill, a bot or spam wave, a duplicate-event bug. Check the metric's own
   volume of raw events before its rate.
2. **Is it the whole population or a slice?** Cut by: new versus existing, platform and
   app version, geography, acquisition channel, cohort age, segment, device tier,
   network conditions. A change concentrated in one slice is a different problem from a
   broad drift, and the cut that isolates it is usually the answer.
3. **Is it mix or is it rate?** A blended rate can move with every underlying rate flat if
   the mix of segments shifted. Reweight to last period's mix and see if the change survives.
4. **Is it us or the world?** Competitor launch, seasonality, festival, pay cycle,
   regulation, outage at a counterparty, macro. Check the same metric for a segment the
   change could not have touched, as a natural control.
5. **Where in the chain?** Walk the decomposition top-down and find the single factor
   carrying the change. Resist explaining a 10% drop with five 2% stories.
6. **What is the mechanism?** Only now propose a causal story, and state the one query or
   experiment that would falsify it.
7. **What is the counterfactual cost?** If we do nothing for a quarter, what does it cost?
   That determines urgency, and urgency determines whether you ship a fix or a study.

## 6. Metric to decision mapping

A metric earns its place only if a specific number authorises a specific action. Write
the decision rule before the data arrives.

| Metric state | Authorised decision | Pre-registered threshold |
|---|---|---|
| North star up, guardrails clean | Ship to 100%, redeploy team to next bet | Effect above MDE, guardrails within tolerance |
| North star up, guardrail breached | Hold. Quantify the trade in money, escalate the trade-off, do not decide alone | Any guardrail beyond its stated band |
| Flat with tight confidence interval | Kill. A precise zero is information; stop paying for it | CI excludes the MDE |
| Flat with wide interval | Underpowered. Extend, increase exposure, or accept that the question is unanswerable at this traffic | CI includes both zero and the MDE |
| Up in one segment, down in another | Segment the rollout, do not average | Heterogeneity beyond noise across pre-declared segments |
| Leading indicator up, lagging flat after the expected lag | The causal chain is wrong. Revisit the north star | Lag window elapsed plus a buffer |

Two more decisions to name explicitly:
- **One-way versus two-way door.** Reversible decisions deserve less evidence and more
  speed. Pricing, data model changes, public API contracts and anything users must
  re-learn are one-way; decide those with more evidence and a written rationale.
- **Cost of delay.** State what a month of waiting costs in the metric's own units. It is
  usually the argument that ends the debate.

## 7. Failure modes catalogue

- **Goodhart.** The metric was a good proxy until it became a target. Guardrails and
  rotating diagnostics are the defence.
- **Simpson's paradox.** Every segment improves, the aggregate worsens, because mix shifted.
- **Denominator drift.** "Active users" changed definition, or the base grew, so a rate
  fell without any behaviour changing.
- **Survivorship.** Retention measured only on users who returned. Cohort denominators
  must be fixed at entry.
- **Novelty and primacy.** Early experiment effects reverse. Read the effect by week, not
  in aggregate, and hold a long-run holdout for anything that changes a habit.
- **Interference.** In marketplaces and social graphs, treatment leaks to control.
  Randomise by region, time slice or cluster instead of by user.
- **Cannibalisation.** The feature won because it took volume from another surface.
  Measure at the level above the feature.
- **Ratio of ratios.** Conversion of a conversion is uninterpretable. Keep one denominator.
- **Seasonality and pay cycles.** In India, salary dates, festival weeks and month-end
  swings dominate weekly noise. Compare like periods or use year-over-year.
- **Instrumentation asymmetry.** Client-side events drop on poor networks and low-end
  devices, so any metric built on them systematically under-counts exactly the users you
  are trying to serve. Anything financial should be server-side.
- **Lagging quality.** Volume metrics look good before the returns, delinquencies,
  chargebacks or churn arrive. Pair every volume metric with its lagged quality partner.
