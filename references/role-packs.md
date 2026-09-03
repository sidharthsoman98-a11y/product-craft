# Role packs

Loaded by `role-lens` before any other skill runs. Its job is to change what the next
skill does, not to describe an industry. Every section here should either constrain a
choice, supply a number, or name a thing to say out loud in a room.

Two archetypes only: **consumer tech PM** and **fintech PM**. Anything that does not fit
either is a generalist brief and needs no lens.

## How to read the citations

Per D1 in `DECISIONS.md`, this pack is written from public sources only: published job
descriptions, candidate interview reports, and company blogs and press statements. Every
factual claim about a named company carries its source class in brackets. Claims that are
directional rather than confirmed are marked **Uncertain**. No compensation figures and no
unpublished internal metrics appear here, and none should be added.

Source classes are recorded, not linked. Full citations live in `references/sources.md`.
Treat a claim without a source class as an error in this file.

If a skill named below is not present in your install, it was cut under D9. Fall back to
`artefact-forge` for anything visual or quantitative, and `spec-writer` for anything written.

---

# Archetype 1 — Consumer tech PM

Quick commerce, hyperlocal delivery and horizontal marketplaces. The seat to picture is a
Swiggy or Flipkart product role, not a social or media product.

## 1. Charter shape

The defining fact: **these are operations products, not feature charters.** The user is
often an internal worker rather than a consumer, and the deliverable is throughput at a
cost, not delight.

Swiggy PM I roles are scoped to dark store workforce management, gig picker and in-store
staff tooling, compliance flows, order fulfilment, packaging workflows and inventory
systems, judged on picker productivity, fulfilment SLAs and unit economics
[published JD]. Read that list again: five of the six are internal tools.

Flipkart frames the same seat differently, as owning strategy and roadmap across use cases
and internal businesses, and explicitly balancing short-term commercial goals against
long-term platform development [published JD]. The commercial-versus-platform tension is
named in the charter itself, which means it is a thing you are expected to arbitrate
rather than escalate.

What this changes about your answers:

- The primary user is a picker, a store manager or a city ops lead. Design for someone
  doing the task 200 times a shift under time pressure, on a shared device, possibly
  standing in a cold room. Consumer-app instincts about onboarding and delight are wrong here.
- Adoption is not a question. Ops tooling is mandated, so usage tells you nothing and
  task time, error rate and rework tell you everything.
- The roadmap is capacity-shaped. Demand work that outruns store capacity destroys the
  promise; see the trap in spine 4.2.
- Compliance flows in the charter mean labour, food safety and packaging rules constrain
  the design space before you start. Do not treat them as an edge case bolted on at the end.

## 2. Metrics owned

Spine: **4.2 Quick commerce and hyperlocal delivery** in `references/metric-library.md`,
with **4.10 Logistics and fulfilment** for the delivery leg and **4.1 Marketplace and
horizontal commerce** where the seat is Flipkart-shaped rather than dark-store-shaped.

Do not invent metrics for this seat. Take them from the spine and be precise about which
of the three tiers each one sits in.

**Owned outright** — you are the person who moves these:

- Pickers per store and the picking cost line inside the CM1 chain. The JD phrase
  "picker productivity" maps here [published JD]; the spine does not use that wording, so
  translate it rather than inventing a metric.
- In-stock rate, and out-of-stock on the top 100 SKUs specifically.
- Promise adherence and promise breach rate.
- Batching rate and distance per order where store-side tooling drives them.
- Spoilage and shrink, via inventory and packaging workflows.

**Influenced, shared with ops** — you can move them but do not own the target:

- Orders per dark store per day, the spine north star. City and category teams own demand.
- Rider utilisation in orders per rider hour, and rider cost per order.
- Contribution margin per order, and the break-even order count per store, which is the
  number leadership actually watches.

**Not owned, but you will be asked about them** — conversion, basket size, demand density
per pincode. Know the input tree well enough to say which lever is not yours.

The spine trap applies directly and you should raise it unprompted: treating this as a
funnel product, and generating demand into an under-capacity store.

## 3. Stakeholders and where friction sits

| Stakeholder | What they want | Where the friction is |
|---|---|---|
| City and ops teams | Predictable shifts, fewer exceptions, a store that hits its promise | They own the outcome your tool is judged on but not the tool. They will work around a bad flow rather than report it, so your bug reports arrive as an SLA miss weeks later |
| Category | Assortment breadth and promotional slots | Breadth fights in-stock and picking time. Every added SKU is picking seconds and shelf space you did not budget |
| Supply | Fill rate, seller or vendor terms, days of cover | Their fill decisions set your out-of-stock rate, and their planning cycle is slower than your sprint |
| Analytics | One definition per metric | Ops and product often run different definitions of the same SLA. Settle the definition before the review, not in it |
| Trust and safety | Fraud, food safety, worker safety | Arrives late and can veto. Bring them in at design, because their objection is usually structural rather than cosmetic |

The friction that defines the seat: **you own the tool, ops owns the outcome, and the
feedback loop between them is broken by default.** A strong candidate says how they would
close it — shadowing shifts, instrumenting rework, a standing exception review.

## 4. Weekly artefacts

| Artefact | Produced by |
|---|---|
| A metric readout on picker productivity and promise adherence, with the diagnosis when one moved | `rca`, `analytics-sql` |
| A CM1 walk for a store cohort, or the break-even count for a new format | `unit-economics` |
| A spec for a picker or store-manager flow, with the unhappy paths enumerated | `spec-writer` |
| Tickets broken out of that spec, with acceptance criteria an ops lead would recognise | `ticket-writer` |
| A state diagram for an order or exception flow, or a workforce shift model | `artefact-forge` |
| An experiment readout on a store pilot, with the decision rule stated in advance | `experiment-readout`, `metric-architecture` |
| A rollout plan sequenced by store cohort, with the rollback trigger | `launch-plan` |
| Marketplace supply and demand balance work | `marketplace-ops` |

## 5. Interview loop shape

Reported structure [interview reports]: a recruiter or hiring-manager screen; a
problem-solving round built on a marketplace analytics case; an onsite covering product
sense, analytics, strategy and behavioural; a leadership round for senior roles.

Named question patterns that recur [interview reports]:

- RCA on an order-volume drop.
- RCA on delivery time increasing against the promise.
- Three-sided trade-offs between customers, delivery partners and restaurants.

What the loop is really testing, given the charter: whether you think in capacity and
cost, and whether you can decompose a number under pressure without a framework crutch.

Preparation that maps to this: run `drill` on the two RCA patterns until the diagnostic
playbook in section 5 of `metric-library.md` is automatic, and rehearse the three-sided
trade-off with `red-team` attacking whichever side you under-served.

## 6. Strong versus average in this seat

**The average answer** to the order-volume drop opens with a framework — internal versus
external, then a list of segments — asks for no data, assumes the drop is real, produces
six plausible causes and ranks none of them. It is structured and it is useless.

**The strong answer** starts by asking whether the drop is real: a tracking or app-release
change, a pipeline backfill, a duplicate-event bug, checked against raw event volume
before any rate. Then it cuts by store, pincode and cohort rather than by nothing, finds
the slice, and names the owner of the fix. It sizes the loss in CM1 rather than in orders,
and it says what it would stop doing if the cause turned out to be capacity.

Concretely, the separators in this seat:

- **Translates a metric into a shift.** "Picking time down 40 seconds" means little;
  "40 seconds is roughly one more order per picker hour at current utilisation, so a store
  at 90 orders a day gets back a headcount-hour" is the register that lands. State the
  assumption when you do this.
- **Sequences growth against capacity unprompted.** The single most reliable signal in a
  quick-commerce loop.
- **Names the internal user as the user.** Average candidates answer every question about a
  picker tool as though the customer were the shopper.
- **Refuses something.** The charter says balance short-term commercial goals against
  long-term platform development [published JD]. If your roadmap answer has no refusal in
  it, you have not done the balancing the JD asks for.
- **Knows a blended number hides a slice**, and cuts before quoting.

## 7. Failure modes of a new PM in this seat

- Designing the picker tool from a desk. The flow survives contact with a spec review and
  dies in a cold room on a shared Android device with gloves on.
- Shipping demand features because they are more legible to leadership than picking-time
  work, and watching promise adherence decay.
- Treating compliance flows as a late-stage checklist rather than a design constraint.
- Optimising the average and missing that one store format or one city is carrying the loss.
- Accepting an ops workaround as a feature request. The workaround is evidence of a broken
  flow, not a specification for a new one.
- Discounting to hit a conversion target and reporting the win without normalising for it.

## 8. Skills that matter most

In order: `rca`, `analytics-sql`, `marketplace-ops`, `unit-economics`,
`metric-architecture`, `product-teardown`, `red-team`, `drill`.

---

# Archetype 2 — Fintech PM

Payments infrastructure and merchant products. The seat to picture is a Razorpay platform
or regional role.

## 1. Charter shape

Razorpay platform roles own settlement, reconciliation, risk decisions and APIs that other
teams and billions of transactions depend on [published JD]. A separate charter is merchant
onboarding and KYC automation. Regional roles are scoped to translating local regulatory
requirements and merchant pain points into product requirements [published JD].

Three consequences that should show up in every answer you give about this seat:

- **Your users are other builders.** Internal teams and merchant engineers integrate
  against what you ship. A breaking change is an incident, not a release note. Spine 4.9
  in `metric-library.md` applies to the API surface even though the business is payments.
- **Correctness outranks speed.** Settlement and reconciliation are products where being
  approximately right is the same as being wrong. Money that does not reconcile is a
  support ticket, a merchant escalation and eventually a regulatory question.
- **The charter is written in regulatory language.** "Translate local regulatory
  requirements into product requirements" is the job, stated plainly [published JD]. A
  candidate who treats compliance as someone else's department has misread the role.

## 2. Metrics owned

Spine: **4.3 Payments and UPI-style rails** in `references/metric-library.md`. Where the
charter touches credit, **4.4 Lending and credit** applies; use its vintage discipline
rather than improvising.

**Owned outright:**

- Technical success rate, and the failure decomposition by owner — bank or issuer
  downtime, network timeout, our stack, insufficient funds, user abandonment, risk
  decline. Owning this split is the seat.
- Settlement breach, and dispute resolution time.
- False-positive risk declines. The spine calls this the most expensive invisible metric
  in payments; on a platform charter it is yours, shared with risk.
- Cost per transaction, which is what leadership watches alongside success rate versus the
  market benchmark.

**Owned by the onboarding and KYC charter specifically:** approval rate and drop-off
through the onboarding funnel, and time to first successful transaction for a new merchant
(spine 4.9's time-to-first-successful-call, applied to merchants).

**Influenced:** business approval rate, fraud in basis points, chargeback rate. Risk owns
the thresholds; you own the product consequence of where they sit.

**Not owned:** intent volume and merchant coverage, which are sales and growth.

Two spine points to raise before you are asked, because almost no candidate does:

- **Monetisation.** Zero-MDR rails earn nothing per transaction, so monetisation comes
  from adjacency — lending, ads, subscriptions, merchant services, float where regulation
  permits.
- **The blended-rate trap.** Never quote a blended success rate. It hides a dragging
  issuer or instrument, and mix shift alone moves it with nothing changing underneath.

## 3. Stakeholders and where friction sits

| Stakeholder | What they want | Where the friction is |
|---|---|---|
| Risk | Losses inside appetite | Every threshold you loosen is their exposure. The negotiation is false positives against fraud basis points, and it needs a shared number, not a debate about tone |
| Compliance | Defensible process and an audit trail | They can stop a launch outright. Bring them the design, not the finished spec |
| Partner banks | Their own uptime, volumes and terms | Outside your control and inside your success rate. Their downtime shows up as your number, which is why the failure split matters |
| Settlement ops | Books that reconcile, exceptions they can clear | Every product edge case becomes a manual reconciliation queue. Design the exception path or they inherit it |
| Merchant support | Fewer tickets, clear error messages | Error taxonomy is a product decision. A vague decline code is thousands of tickets |
| **The regulator** | Not in the room, and constrains every decision | An absent stakeholder. Requirements arrive as deadlines, not as backlog items, and they outrank the roadmap |

Handling the absent stakeholder is the thing to demonstrate. In practice it means: a
written record of why a decision was made, data residency and retention thought through at
design time, and a rollout that can be halted rather than only rolled forward.

## 4. Weekly artefacts

| Artefact | Produced by |
|---|---|
| Success-rate readout with the failure split by owner, not a blended number | `analytics-sql`, `rca` |
| API or webhook contract for an integrating team, with versioning and deprecation | `platform-integration`, `spec-writer` |
| A regulatory change translated into requirements, with the compliance evidence trail | `compliance-guard`, `evidence-ledger` |
| Reconciliation or settlement exception flow, as a state diagram with every terminal state | `artefact-forge` |
| Risk threshold change proposed with the false-positive cost quantified | `unit-economics`, `metric-architecture` |
| Experiment or phased rollout readout with a pre-registered decision rule | `experiment-readout` |
| Merchant onboarding funnel diagnosis | `rca`, `discovery-brief` |

## 5. Interview loop shape

The loop shape below is drawn from published process material across comparable Indian
payments companies rather than any single employer; specifics vary by company and charter.

Reported structure [interview reports]: technical rounds in SQL and sometimes Python,
covering window functions, joins and CTEs; guesstimates and logic puzzles; managerial case
rounds on strategy and metrics.

Assessed throughout rather than in a single round [interview reports]: accuracy, edge
cases, audit trails and regulatory awareness. This is the important structural fact about
the loop — the compliance signal is not a question you can prepare an answer for, it is a
property of every answer you give.

Preparation that maps to this: `analytics-sql` for the window-function and CTE patterns
until they are writable without reference, `market-sizing` for the guesstimates, and
`drill` for the case rounds. After any mock answer, run `red-team` with the specific
instruction to attack edge cases and audit trail, because that is the axis this loop
scores and the one candidates neglect.

## 6. Strong versus average in this seat

**The average answer** to "success rate has dropped" quotes the blended rate, proposes
retries, and treats the payment as a funnel. It never asks which issuer, never separates
technical from business declines, and never mentions that a retry strategy has a cost and
a fraud consequence.

**The strong answer** decomposes by owner first — issuer downtime, timeout, our stack,
insufficient funds, abandonment, risk decline — because each has a different owner and a
different fix. It checks mix shift before concluding anything changed. It quantifies the
false-positive cost of the risk threshold rather than asserting it is too tight. It says
what the merchant sees, in what error message, and what support will do at 2am.

The separators in this seat:

- **Names the failure split unprompted.** The single clearest payments-versus-generalist tell.
- **Talks about money that does not reconcile.** Average candidates discuss transactions;
  strong candidates discuss the books, the exception queue and who clears it.
- **Treats reversibility as a design property.** What happens to an in-flight transaction
  when this ships, and how the change is halted.
- **Quantifies compliance rather than invoking it.** "We cannot, it is regulated" is as
  weak as ignoring it. Name the requirement, the constraint it imposes and what remains possible.
- **Volunteers the monetisation constraint** on a zero-MDR rail before being asked.
- **Handles the guesstimate with stated assumptions and a sense-check**, then says which
  assumption the answer is most sensitive to.

## 7. Failure modes of a new PM in this seat

- Shipping a change that is correct in the happy path and leaves settlement ops a manual
  queue nobody staffed.
- Optimising approval rate without pricing the fraud and false-positive consequences,
  then losing the ground back a quarter later.
- Breaking an API contract other teams depend on, having treated internal consumers as
  less real than external ones.
- Learning about a regulatory deadline when it is already a deadline, because compliance
  was consulted at spec review rather than at design.
- Reporting a blended success rate improvement that is mix shift.
- Designing decline messaging as a copy task rather than as the taxonomy that determines
  support load.
- Assuming credit-adjacent metrics behave like payments metrics. They do not: losses
  arrive late, and any credit answer without vintage seasoning is wrong on its face.

## 8. Skills that matter most

In order: `analytics-sql`, `rca`, `compliance-guard`, `platform-integration`,
`metric-architecture`, `unit-economics`, `red-team`, `market-sizing`, `drill`.

---

# What both archetypes now share

Both Swiggy and Razorpay are restructuring around AI in their product and operating models
[company statements and press coverage]. **Uncertain:** the depth and pace of these
changes is reported rather than confirmed, and the specifics will date faster than the rest
of this file. Re-check before leaning on it, per the 90-day staleness rule in D5.

The practical consequence is the same in both loops: expect AI-native questions, and
expect them inside an ordinary product question rather than as a separate round.

What to have ready:

- **Spine 4.8 in `metric-library.md`**, and specifically cost per successful task, which is
  inference cost divided by success rate. The spine notes almost no candidate raises it.
  It is the number that decides whether an AI feature can be priced, and it is the one
  place where an AI answer stops being a demo and becomes a product answer.
- **Success defined by an eval, not by the absence of complaints.** In a picker tool that
  means a frozen set of real exception cases; in a payments flow it means a labelled set
  where the cost of a false positive is known.
- **Where the human stays.** In both seats there is an irreducible escalation path — an
  ops exception, a risk review, a compliance decision. Say which decisions you would not
  automate and why, and note that in the fintech seat this is partly a regulatory answer
  and not only a quality one.
- **The engagement trap.** Spine 4.8 is explicit: in an assistive product, less usage for
  the same outcome is usually a better product. Both archetypes are full of internal tools
  where this is exactly right, and the average candidate reaches for adoption metrics.
