---
name: marketplace-ops
description: Reason about the operations half of a consumer marketplace, where the constraint is physical rather than a funnel. Use this for supply and demand balance, capacity and utilisation, dark store or warehouse operations, delivery promise and SLA adherence, fill rate, rider or picker productivity, city or zone launches, three-sided trade-offs between customers, delivery partners and sellers, and liquidity. Taking a whole product apart is product-teardown; a number that has already moved is rca.
---

# Marketplace operations

The consumer tech PM seat is an operations charter, not a feature charter: five of the six
scope items in a published quick-commerce PM I role are internal tools, and the deliverable
is throughput at a cost rather than delight. The questions in this domain are not why users
fail to convert. They are what the system can physically deliver, to whom, by when, and at
what margin.

**The failure that defines this domain is treating an operations business as a funnel
business.** It produces answers that generate demand into a node that cannot serve it, which
is worse than doing nothing — the promise degrades faster than the demand pays.

Load `../../references/role-packs.md` archetype 1, sections 1 and 2, for the charter and the
three tiers of metric ownership; `../../references/metric-library.md` section 3 for the
capacity and liquidity patterns and spines 4.1, 4.2 and 4.10;
`../../references/economics-library.md` section 3 for the quick-commerce break-even equation,
which is not restated here; and `../../references/india-context.md` section 8 before writing
anything about workers.

## What this is not

- **`product-teardown` takes a whole product apart across nine layers.** This is one working
  domain in depth. They meet at layer 5: a teardown surfaces that supply is the constraint,
  and this skill is what you reason with once it has.
- **`rca` owns a number that has already moved.** See section 7. Hand over rather than
  diagnosing here.
- **`unit-economics` owns the contribution stack, break-even arithmetic and sensitivity.**
  This skill owns the physical system that produces those numbers. Call it for the money;
  do not rebuild the CM1 chain inside an operations answer.

## 1. Find the binding constraint first

Before any recommendation, name which of four is binding. **Everything the non-scarce side
wants is worthless until the scarce side is served**, so an answer that optimises the
abundant side is not a weak answer, it is an answer to a different question.

| Constraint | What you would see | The test |
|---|---|---|
| **Demand** | Supply idle, utilisation below band, riders waiting between orders, sellers with no orders, stores under break-even volume | Add demand in one zone only. If throughput rises and promise adherence holds, demand was binding |
| **Supply** | Search-to-match falls at peak, unfilled or cancelled orders, out-of-stock on the top 100 SKUs, seller fill rate low | Hold demand flat and add supply in one zone. If match rate rises, supply was binding |
| **Capacity** | Throughput flat while demand rises, queue depth at a node, promise breach climbing with volume rather than with distance | Plot throughput against demand. A plateau with rising breach is capacity, and no amount of demand spend moves it |
| **Trust** | Both sides present and not transacting; repeat rate collapses after one bad experience; COD share high where prepaid is cheaper | Compare the 90-day order rate of a cohort that experienced a breach against a matched cohort that did not |

Name one, name the test, and say what you would do differently if the test came back the
other way. A structured answer that never commits to a constraint has not started.

## 2. The three-sided balance

Customers, delivery partners and sellers or stores. **Every intervention on one side lands on
the others**, and the standard tensions are these:

- **Customer promise versus rider utilisation.** A tighter promise needs idle riders held in
  reserve, which is utilisation deliberately left on the floor. Batching raises utilisation
  and lengthens the promise. You cannot tighten the promise and raise orders per rider hour
  with the same lever; say which you are choosing.
- **Assortment depth versus inventory cost.** More SKUs raise in-stock rate and basket size,
  and raise spoilage, shrink and working capital against a dark store whose shelf space is
  fixed. Depth in the top 100 SKUs is a different decision from depth in the long tail.
- **Seller economics versus customer price.** A discount funded by the seller improves
  conversion and churns supply. If the economics depend on seller-funded discounting, they
  depend on a subsidy that is not on your P&L, and seller churn is where it appears.
- **Rider earnings versus cost per order**, and **store staffing versus picking cost**. Both
  are the same shape: the line that looks like a cost lever is somebody's income.

**An answer that improves one side without naming the cost to another is incomplete.** State
which side pays, roughly how much, and what signal would tell you they have stopped
absorbing it.

## 3. Capacity and utilisation

The pattern is `Throughput = Capacity x Utilisation x Yield`, per `metric-library.md`
section 3. Three consequences carry most of the reasoning:

- **Demand generation into an under-capacity node is negative value.** It degrades the
  promise, and promise breach kills retention faster than the incremental demand adds
  revenue. Marketing into a store already at capacity has negative return, not merely low
  return. **So the sequence is capacity first, then demand — and saying so unprompted is the
  single most reliable tell in a quick-commerce loop**, per `role-packs.md` section 6.
- **Utilisation is not a metric to maximise.** A node run at full utilisation has no slack,
  and queues at a saturated node grow with variance rather than with volume — which is why
  the breach shows up on the busiest evening rather than gradually. Name the target band and
  the variance the slack is absorbing, not a maximum.
- **Capacity is sized for the peak hour, not the daily mean.** A store comfortable at a daily
  average is short-staffed from 7 to 9pm, and a daily number will never show it. Ask for the
  hourly distribution before accepting any capacity claim.

The money question — orders per store per day against break-even orders per store per day —
is one equation, and `economics-library.md` section 3 holds it. Use it; do not restate it
here. The number leadership actually watches is how many stores are past that line.

## 4. Promise adherence

- **What breaks it:** picking time, batching decisions, rider supply at the peak hour,
  distance and route density, out-of-stock forcing a substitution, address quality, building
  access, weather. Note which of these the store can control and which it cannot — the split
  determines whether the fix is tooling or network design.
- **How it is measured:** the share of orders delivered inside the promised window, cut by
  store and by hour. Watch for a padded promise: widening the window improves adherence and
  loses orders, and a team optimising adherence alone will pad it until nobody converts.
  Track promise length and adherence together, or you are measuring neither.
- **The tail matters more than the average.** Report p95, not the mean. A twelve-minute
  average with a forty-five-minute tail is a retention problem, because the customer
  remembers their worst delivery, not the distribution. Every promise claim in an answer
  should carry a percentile.
- **What a breach costs is measured in retention, not in apology credits.** The credit is the
  accounting cost and it is the smaller number. The real cost is the breached cohort's order
  rate over the next 90 days against a matched cohort. Say it in that form — it converts a
  service metric into a number the business case can use, and it is the version that survives
  contact with a finance review.

## 5. Workforce products

The primary user is a picker, a rider or a store manager: someone performing the task two
hundred times a shift, under time pressure, on a shared device, possibly standing in a cold
room. Consumer-app instincts about onboarding and delight are wrong here.

- **Adoption is not a question.** Ops tooling is mandated, so usage tells you nothing.
  Task time, error rate and rework tell you everything.
- **The products are batching, routing, shift planning, picking flows and incentive design.**
  Each has a worker on the other side of it, and incentive design in particular is pay
  design regardless of which line it is booked on.
- **Name the unpriced cost where the design depends on one.** Waiting time, fuel,
  maintenance, device and data, weather and safety exposure are borne by the worker and
  rarely appear in a CM1 stack. A tool that saves the customer thirty seconds by adding two
  picker steps has moved cost, not removed it.

Per `india-context.md` section 8, name it in this form: **who bears the cost, whether it is
priced, what would happen if it were, and the early signal that it is being repriced.** That
is sharper than either ignoring it or moralising, and it makes the same point twice over —
an unpriced cost is an unhedged risk, repriced by regulation, litigation, labour supply or
attrition, generally at the worst possible moment. Attrition is the leading indicator, which
is why spines 4.2 and 4.10 both carry it as a guardrail rather than as a people metric.

## 6. Launch and expansion

- **Name the atomic unit first.** One dark store, one zone, one pincode cluster — the
  smallest thing that can work end to end and be measured on its own. Every expansion
  question is really a question about whether that unit works.
- **What must be true before a second zone opens:** the unit is past break-even orders per
  day and staying there; promise adherence holds *at the peak hour*, not on the daily
  average; rider and picker attrition is stable rather than being bought with launch
  incentives; and the playbook is written down — staffing by hour, assortment, marketing
  spend by pincode, the exception paths.
- **A national launch is the repetition of a working unit, not an event.** If the unit is not
  working, scaling multiplies the loss and adds a fixed cost per node while doing it. The
  question "should we launch in twenty cities" is always answered by pointing at the unit.
- **Density beats geography.** Demand is generated by pincode, not by city, because route
  density is what makes cost per order fall. A city-level launch plan with no pincode
  sequencing has not engaged with the economics.
- **The trap:** a launch judged on stores opened rather than on stores past break-even.
  Opening is the input; the number of nodes over the line is the outcome.

## 7. Diagnosis handover

**When the question is a number that has already moved — orders down, breach rate up,
utilisation fallen — that is `rca`, and it owns the fact base, the measurement check and the
ruled-out list.** Hand over explicitly and say you are doing so, rather than starting a
diagnosis with an operations hypothesis, which is exactly the failure `rca` step 1 exists to
prevent.

This skill supplies what the diagnosis walks down: the decomposition, the capacity structure
and the three-sided consequences. It does not run the diagnosis. If `rca` concludes the
constraint has shifted, the recommendation comes back here.

## Output

An operations answer is complete when it carries:

- **the binding constraint, named, with the test** that would show it was the wrong one;
- **which side pays** for the recommendation, and what signal says they have stopped
  absorbing it;
- **capacity sequenced before demand**, said explicitly;
- **the promise stated at a percentile**, with breach cost in retention rather than credits;
- **the unpriced cost named** wherever the design leans on one, with its repricing signal;
- **the atomic unit** for anything that scales.

Score against `../../references/rubrics.md`. The failures this domain produces most are free
lunch (nothing sacrificed, no side named as paying), unowned numbers (a utilisation or
adherence figure with no derivation), the average trap (a blended promise time hiding the
tail) and ethics as an afterthought (the worker cost noticed only when asked).
