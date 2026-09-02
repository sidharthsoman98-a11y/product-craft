# Economics library

Read this whenever an answer touches money: pricing, margin, viability, sizing a bet,
or the question "is this a good business". Numbers below are structural, not benchmarks.
Never quote a benchmark as fact; derive it, label it an assumption, and sense-check it.

## Contents
1. The contribution margin stack
2. Cohorts, CAC and payback
3. Archetype economics
4. Pricing
5. The "what would have to be true" test
6. Sensitivity and break-even method

## 1. The contribution margin stack

Work in layers and name which layer you are at. Vagueness here reads as inexperience.

```
Gross transaction value (GMV / TPV / bookings)
 - cost of goods or payout to supply            -> Net revenue (take rate x GMV)
 - directly variable cost to fulfil one unit    -> CM1
   (delivery, picking, packaging, payment cost, support contacts per order)
 - variable marketing attributable to the unit  -> CM2
   (discounts, cashback, coupons, performance marketing per order)
 - allocated semi-fixed operating cost          -> CM3
   (dark store or warehouse rent, ops staff, tech infrastructure per unit at current volume)
 = contribution before central overhead
```

Rules that hold across businesses:
- Discounts belong in the margin stack, not in marketing narrative. A conversion win paid
  for with a coupon is a price cut and must be evaluated as one.
- Support cost is variable and usually forgotten. Contacts per order times cost per contact
  is a real line and is often the difference between CM1 positive and negative.
- Payment cost is variable. On card rails it scales with basket; on zero-MDR rails it is
  near zero to the merchant but not to the operator, who still pays switch and infra costs.
- Reverse logistics is variable and asymmetric: a return costs more than the forward leg
  and destroys the margin of roughly two good orders.
- Semi-fixed costs become variable at a step. Model the step, not a smooth average.

## 2. Cohorts, CAC and payback

- **CAC** must be stated as blended or paid, and per what: per install, per activated user,
  per first transaction. Most arguments are people comparing different denominators.
- **Payback period** = CAC divided by monthly contribution per retained user. Under twelve
  months is generally financeable; over twenty-four requires either a strategic reason or
  a different plan. Say which regime you are in.
- **LTV** is a forecast, and quoting it without the retention curve and the discount rate
  is the most common way to be wrong with confidence. Prefer cumulative contribution at a
  fixed horizon (six or twelve months), which is measurable and arguable.
- **Cohort value retention** is more honest than user retention: the share of a cohort's
  first-month spend that the same cohort still spends in month n. Above 100% means
  expansion is beating churn, which is the only clean signal of product-market fit in
  transactional businesses.
- **Contribution-positive cohort test**: does the cohort cross into cumulative positive
  contribution before the typical relationship ends? If not, growth destroys value and
  scale makes it worse, which is the correct thing to say when asked "should we spend more".

## 3. Archetype economics

**Commerce and marketplaces.** Take rate = net revenue over GMV. Understand the three
pressures on it: competitive (a rival undercuts), regulatory (caps), and structural
(mix shifting to lower-rate categories). Rising GMV with falling take rate is usually a mix
story, not a pricing story, and you should check that first.

**Quick commerce.** The whole business is one equation: orders per store per day against
break-even orders per store per day. Break-even = store fixed cost divided by CM1 per order.
Levers: raise AOV (assortment and bundling), raise CM1 (private label, ads on the app,
delivery fee, batching), lower fixed cost (smaller stores, shared dark stores), raise
density (marketing focused by pincode, not by city). Marketing that raises orders in a
store already at capacity has negative return, because it degrades the promise.

**Payments.** Three revenue shapes: per-transaction (MDR, interchange, switch fees),
balance-based (float, where regulation permits), and adjacency (lending, ads, subscriptions,
merchant software, payouts). On zero-MDR rails, per-transaction revenue is structurally
absent, so the honest framing is: payments buys distribution and data, and monetisation
happens one layer over. Cost side: infrastructure per transaction, fraud losses in basis
points, chargeback handling, KYC and onboarding cost per merchant (which is why merchant
activation rate, not merchant signups, is the metric that matters).

**Lending.** Net interest margin = yield minus cost of funds, then minus expected credit
loss, then minus servicing and collections. The bet is entirely on whether the loss
estimate holds as the book seasons. Unit economics per loan must be shown by vintage.

**B2B SaaS.** Gross margin is set by hosting, support and services. For AI features,
inference cost sits in COGS and can quietly move gross margin ten points, which changes
the valuation logic of the whole company. CAC payback and NDR together tell you whether to
spend; magic number tells you whether sales is efficient at the margin.

**Ads.** Revenue = impressions x fill rate x eCPM. Ad load is a tax on engagement, so the
right frame is the trade curve: how much engagement is lost per point of ad load, and where
the revenue-maximising point sits over a two-year horizon rather than a quarter.

**AI-native.** Cost per successful task = inference cost per attempt divided by success
rate. This means a quality improvement is also a cost reduction, and it is the argument
that justifies eval investment to a finance audience.

## 4. Pricing

Decide in this order: value metric, model, level, then packaging.
- **Value metric**: what the customer is charged per unit of. It should scale with the
  value they receive and be predictable enough to budget. Choosing it wrongly is
  unrecoverable without a migration.
- **Model**: subscription, usage, hybrid, take rate, freemium, ad-supported. Hybrid
  (platform fee plus usage) is now standard for AI products because it protects gross margin.
- **Level**: anchored to the next-best alternative, including the alternative of doing
  nothing manually. Willingness to pay is a distribution, not a number; price to a segment.
- **Packaging**: what forces the upgrade. If the free tier satisfies the core job, nothing
  will convert regardless of price.
- India-specific: absolute price ceilings are real, prepaid and low-ticket behaviour
  dominates, and payment-method mix changes conversion materially. A price that works at
  a monthly cadence may fail at an annual one purely because of ticket size.

## 5. The "what would have to be true" test

When data is missing (always, in an interview), invert. Instead of estimating whether the
idea works, compute the threshold at which it works and judge whether that threshold is
plausible.

Method: write the contribution equation, solve for the unknown that decides the sign, then
ask whether that value is achievable given what is known about the market. This converts
an unanswerable forecast into a falsifiable claim, and it is the single most effective
move available in a case interview.

Example shape: "This is worth building if repeat rate exceeds roughly 30% in three months,
because below that the acquisition cost never repays. Comparable categories run at 20-25%,
so this needs a mechanism that makes it structurally different. Here is the mechanism I
would test first, and here is the two-week test."

## 6. Sensitivity and break-even method

1. Build the equation with named variables, not numbers.
2. Populate with a base case, and label every input as measured, benchmarked or assumed.
3. Identify the two variables the answer is most sensitive to, by swinging each plus or
   minus 20% and observing the output.
4. Present those two as the decision drivers. Everything else is detail and should be
   cut from the answer.
5. State the break-even value of the most sensitive variable and whether it is achievable.
6. State what you would measure in week one to reduce uncertainty on that one variable.

Presenting sensitivity rather than a point estimate is the difference between an answer
that survives follow-up questions and one that collapses on the first "what if".
