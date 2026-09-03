# India context

Loaded by `role-lens` alongside `references/role-packs.md`, and read by any skill making a
claim about Indian users, economics or regulation. Its purpose is narrow: to stop answers
that are generically correct and wrong for this market.

## Rules for using this file

**No statistics appear here, by design.** Where a magnitude decides an answer, this file
says how to derive or source it. Quoting a remembered number is the fastest way to lose a
room, because the person asking usually knows the real one. Derive in rough order of
authority: regulator circulars; national payments and telecom statistics; company filings;
engineering blogs; credible press. `references/sources.md` holds the verification protocol
and what may never be recalled from memory.

**Staleness.** Per D5, time-sensitive claims carry a date and are flagged past 90 days: all
of sections 6 and 7, and the tier definitions in section 4. Devices, language, trust and
seasonality age slowly; rails and regulation age fast.

**The hard rule on regulation.** A regulatory claim must be checked against a current primary
source before it goes into a deliverable. Section 7 gives the *shape* of each obligation so
you know what to look for, and carries no section numbers, thresholds or dates — those are
exactly what changes and what you must not hold in your head.

## 1. Users and devices

**Design for the mid-tier Android budget.** The device distribution is wide, skews Android,
and the interesting users sit well below the phone your team carries. Derive the real spread
from your own analytics by device model and RAM class, not from a market report — it is the
only version specific to your product. What the budget constrains:

- **App size.** Install and update are paid in data and in storage the user does not have.
  An app competing against photographs gets uninstalled.
- **Memory.** Background processes get killed. Anything assuming your app survives a context
  switch — an in-progress form, an unsent event queue, a resumable upload — must survive
  being terminated without warning.
- **Compute.** Heavy client work, on-device inference and long unrecycled lists become
  visible jank on the devices that matter.
- **Screen and input.** Small, sometimes cracked, often one-handed, and sometimes a shared
  device where the account holder is not the person using it.

**Networks.** Assume intermittent connectivity, variable latency, and transitions between
network types mid-session rather than a clean online or offline state. So: every write needs
an idempotency key, because the user will retry and the network will duplicate; "did it
work?" must be answerable from the client, since ambiguous states — a payment that may or
may not have gone through — are the most expensive failure here and generate support load
out of all proportion to their frequency; and optimistic UI needs a reconciliation path,
not a spinner and hope.

**Why your instrumentation lies, and in which direction.** Have this ready — it is a real
analytical edge and almost nobody raises it.

Client events drop on poor networks and low-end devices. Section 1 of
`references/instrumentation-and-experiments.md` states the principle; the India-specific
consequence is that the loss is **not random**. It correlates with device tier, network
quality, geography and income — that is, with exactly the users a product expanding beyond
tier-1 is trying to serve. Section 2 there lists the mechanisms: dropped events, late
arrival, duplicates from offline queues, clock skew from unreliable device time.

For metric trust:

- **Client funnels flatter your core cohort and under-count your growth cohort.** A
  conversion rate that looks worse in tier-2 may be partly measurement. Never conclude a
  segment behaves worse from client data alone.
- **Use server-side truth for anything financial or contractual**, and reconcile the
  client-server step change explicitly rather than explaining it away later.
- **Cut every metric by device tier and network type**, and log both as event properties.
  If you cannot cut by them, you cannot trust a segment comparison.
- **Check event volume before rate.** A rate gain caused by the worst-connected users
  dropping out of measurement looks identical to a real one.
- **Experiments.** Differential event loss between arms is a live threat to validity when
  the treatment changes app weight, network calls or session length. Say so when proposing
  the test, not when defending the result.

## 2. Language and literacy

**Beyond English and Hindi.** Planning for two languages is planning for a minority of the
country: many major languages, large speaker bases, several distinct scripts. The language a
user reads is often not the one they speak at home or type in. Derive your priority list
from your own users by state and device locale, not from a general ranking.

**Text is not the default interface it is elsewhere.** Literacy varies, and digital literacy
— reading a form, understanding an error, trusting a confirmation screen — varies more.
Substitutes that do real work: voice for input and output, noting that recognition quality
is uneven across Indian languages and accents, so voice is a quality question rather than a
toggle; visual and iconographic flows where an icon plus a number replaces a sentence; video
onboarding, which travels through sharing in a way text does not; and amounts and numbers,
which are read reliably by users who will not read a paragraph.

**Transliteration in search is a first-class requirement.** Users type Indian-language words
in Latin script, inconsistently spelt, with no standard romanisation. A stack that matches
only native script or only English misses both. This is a retrieval problem — fuzzy
matching, phonetic normalisation, spelling-variant handling — not a translation problem, and
it is where vernacular products quietly fail.

**A translated string set is not a localised product.** The gap is the work:

- **Numerals, dates and currency**, including the Indian digit grouping for large amounts,
  which is not the international convention; and text expansion and script height, which
  break layouts built for English.
- **Names, addresses and phone formats.** Addresses are descriptive rather than structured,
  so a rigid address form is a completed-order problem, not a cosmetic one.
- **Content, not just chrome.** Translating the interface while catalogue, notifications and
  support replies stay in English is bilingual in the worst way.
- **Errors and support**, which is where a user in trouble actually reads.
- **Mixed-language reality.** Users switch script and language within a sentence; a strict
  single-locale model fights its own users.

The test to state: can a user complete the whole journey — discovery, transaction, failure,
support, refund — in their language? Anything less is a translated shell.

## 3. Trust and payment behaviour

**The trust ladder.** For money, health and identity products, trust is earned in steps and
the product must let users climb rather than demanding the top rung at signup. Roughly: look
without committing; commit something trivial and reversible; commit a small amount of money;
commit a large amount or sensitive data; grant recurring or automated permission. So:

- **Let the first transaction be small and reversible.** A high minimum order value or a
  large mandatory first commitment truncates the ladder.
- **Recurring permissions sit at the top.** Asking for auto-debit or always-on access early
  reads as a trap.
- **Reversibility is the trust feature.** Visible cancellation, visible refund status and a
  reachable human beat reassurance copy.
- **Identity collection is a high rung.** Asking for documents before the user has seen
  value is a drop-off cliff, not a form-length problem.
- **Social proof is local**, travelling through known people rather than brand assertion —
  part of why sharing and referral behave differently here.

**Cash on delivery** is a product and economic decision, not a payment option. What it does,
all of which belongs in any economics answer that touches it: returns and refusals rise,
because refusing at the door is free for the customer and expensive for you — the item
travels twice and may not be resaleable; cancellation rises for the same reason, landing
after you have committed capacity; working capital is consumed while cash moves back through
the logistics chain; cash handling, shortfalls and remittance timing are a real operating
cost line; and abuse takes the shape of refusal rather than chargeback.

Do not assert a COD share or a return-rate differential. Derive both from the product's own
data. From outside, say the split is the first number you would ask for, and what you would
do differently at each end of the range. The right framing is not "reduce COD" but "make
prepaid worth choosing": the incentive funded to convert a COD order should be priced
against the return, capital and handling cost it avoids. That is a `unit-economics`
calculation, and doing it unprompted is a strong signal.

**Prepaid versus postpaid.** Prepaid is the dominant mental model well beyond telephony: pay
a small amount for a known quantity, top up when needed, never carry an open-ended
liability. Postpaid and subscription ask the user to accept an unknown future bill, which is
a higher rung on the ladder.

**Ticket size and pricing cadence.** The smaller the ticket relative to monthly cash flow,
the harder an annual commitment becomes, whatever the per-unit saving. Monthly, weekly or
usage pricing converts where annual does not, and the annual-discount play converts a
smaller slice here. Name the tension before someone else does: monthly billing multiplies
payment-failure exposure and involuntary churn, since every renewal is another chance to
fail — which links to success rate in section 6 and to the involuntary-churn guardrail in
spine 4.7 of `references/metric-library.md`.

## 4. Commerce behaviour

**The discount-trained cohort.** Sustained discounting has trained a large cohort to wait
for a sale, compare across apps before every purchase, and treat the discount as the
product. This is the standing trap in spine 4.1 of `metric-library.md`, and its analytical
consequence is specific: **a conversion or retention gain must survive discount
normalisation before you claim it.** A cohort acquired on a deep discount is not the same
cohort as one acquired at full price, and comparing them without saying so is fatal in a case.

**Tier-1 versus tier-2 and tier-3.** There is no single official definition and commercial
usage varies, so **state the boundary you are using** — population band, your own order
density, or a published classification — because an argument on an unstated boundary is
dismissible. *(Time-sensitive under D5: whichever classification you cite, date it.)*
Directional differences, not magnitudes:

- **Assortment.** Demand mix differs by geography; an assortment tuned to metro preference
  under-serves everywhere else, and out-of-stock on the local head is worse than a thin tail.
- **Delivery expectation.** The competitive promise differs by market. Importing a metro
  promise into lower density raises cost per order without buying the retention it buys in
  the metro, and the capacity trap in spine 4.2 bites hardest here.
- **Repeat behaviour.** Frequency, basket and category adoption follow different curves, so
  a payback assumption from blended national data mis-prices expansion in both directions.
- **Economics.** Density drives cost per order, and a blended figure hides that some
  geographies are structurally loss-making — the trap in spine 4.10.

**WhatsApp is the real interface.** For a large share of users, messaging is where support,
discovery and sharing actually happen, whatever your app does. Support expectation is
conversational and asynchronous, so a ticket portal with a reference number is not how users
expect to be helped. Sharing happens as a forwarded message, making the link preview or
image a product surface; sharing that only works in-app does not work. Re-engagement runs
through messaging rather than email, which is close to dead for consumer use here. And
attribution breaks: traffic from forwarded messages is poorly attributed, so word-of-mouth
is systematically under-credited against paid channels — say this when someone proposes
cutting a channel on measured ROI alone. Business messaging is a metered, rule-bound channel
rather than a free broadcast tool. *(Time-sensitive under D5.)*

**The true competitor is the informal or manual alternative** — not the funded startup in
the same category. The real incumbent is the local shop with a phone number and a credit
book, the agent who fills the form, the cash arrangement, the relative who does it for them,
the spreadsheet. It is trusted, flexible, extends informal credit, needs no onboarding and
costs nothing visible. So your comparison set is wrong if it contains only apps — name the
manual alternative in the market-structure layer of a teardown or the analysis is
incomplete. And the switching argument must beat "free, trusted and already working", which
convenience alone rarely does; something must be structurally better — price, reach,
record-keeping, reliability — and you should be able to say which.

## 5. Seasonality

The reason this section exists: **week-on-week comparison is unreliable here**, and
week-on-week is the default in most dashboards and most interview answers.

- **Salary and pay cycles.** Discretionary spend concentrates after pay dates and thins
  before them. Month-end and month-start differ for spend, for payment success where
  balances are low, and for anything credit-adjacent.
- **Festival periods.** Retail events and festival seasons dominate the commerce calendar,
  with a pull-forward before and a trough after. They follow a lunar calendar and move
  between Gregorian dates year to year — which is why naive year-on-year also breaks.
- **Exam periods**, withdrawing a student cohort and adding demand to education products.
- **Monsoon**, affecting delivery time, rider supply, cancellation and demand mix,
  regionally and on different dates in different places.
- **Regional variation.** Holidays are not national in the same way, so a national aggregate
  can sit flat while two regions move in opposite directions.

What to compare instead, in preference order: the same weekday, since weekday effects are
strong and unequal; the same point in the pay cycle rather than the same date; year-on-year
aligned to the festival rather than the calendar date, saying you have done the alignment;
and best, a holdout or control region living through the same seasonality, the only
comparison that survives all of the above.

For an RCA the first cut is always: seasonality, a shifted festival date, or a real change?
Answering that before proposing causes is a strong signal, and failing to is the commonest
way an order-volume-drop answer goes wrong. Full order in section 5 of `metric-library.md`.

## 6. Payments rails

*All of this section is time-sensitive under D5. Verify against the regulator's and the
network operator's current publications before it enters a deliverable.*

**UPI is the default rail** for person-to-merchant digital payment; a checkout designed on
card-first assumptions is designed for the wrong market. Volume and share statistics are
published monthly by the network operator — cite them from source, dated, never from memory.

**Zero-MDR and what it does to monetisation.** As currently framed, merchant discount rate
on UPI and on RuPay debit for merchant transactions is set to zero by policy. The
consequence is structural and worth saying before anyone asks: **the dominant rail earns
nothing per transaction.** So a payments business cannot be modelled on take rate on that
rail; monetisation comes from adjacency — lending, merchant services and software,
subscriptions, ads, value-added services, and float only where regulation permits. Any "we
take a small cut of every transaction" answer is wrong on the default rail, and saying so is
a fast credibility signal. Spine 4.3 makes the same point from the metrics side.

**Where interchange and MDR still exist:** card rails, and instruments and use cases outside
the zero-MDR scope. That boundary is a policy boundary and it moves. If you quote a rate at
all, quote it from a primary source with a date.

**Success rate is a first-class product metric**, not an engineering statistic — merchants
choose on it. Two disciplines: never quote a blended rate, since it hides a dragging issuer
or instrument and mix shift alone moves it with nothing changing underneath; and attribute
failure by owner — issuer or bank downtime, network timeout, your own stack, insufficient
funds, user abandonment, risk decline. Each has a different owner, fix and user-visible
message, and naming the split is the clearest signal you have worked in payments.
Insufficient-funds declines cluster against the pay cycle, so a month-end dip may be
population rather than platform.

**Settlement timing.** Merchants are settled on a cycle, not instantly, and the cycle depends
on rail, instrument, merchant category, risk profile and contract. Do not assert a
settlement period — read the contract, or say that you would. What matters for product:
settlement timing is the merchant's working capital, faster settlement is a priced product
rather than a courtesy, refunds and chargebacks run on their own timelines, and every
reconciliation exception becomes a manual queue somebody clears.

**The regulator as a design constraint.** In payments the regulator is not a compliance step
at the end; it decides what the product can be — rails, pricing, data handling,
authentication and grievance handling. Requirements arrive as deadlines, not backlog items.
Use the role-pack framing: an absent stakeholder in every design review.

## 7. Regulatory boundary

*Time-sensitive under D5. Shapes only — no section numbers, thresholds or dates.* **A
regulatory claim must be checked against a current primary source before it is used in a
deliverable.** Regulation moves quarterly, transition periods are common, and a confidently
stated stale rule is worse than saying you would check.

- **Data protection and consent.** A consent-based regime with obligations around notice in
  plain language and in Indian languages, purpose limitation, retention limits, deletion and
  correction rights, children's data, and breach notification. Design consequence: collect
  less, state purpose at collection, make consent granular and withdrawable, know where data
  sits and for how long. Staged commencement means the obligations in force at any moment
  must be checked.
- **KYC tiers.** Identity verification is tiered — lighter verification permits limited
  functionality and limits, fuller verification unlocks more. This is a design surface, not
  a gate: the tiers are what let you build the trust ladder in section 3 instead of
  demanding full identity at signup. Verify what each tier currently permits.
- **Lending and collections conduct.** Obligations cluster around money moving between
  borrower and a regulated entity without unregulated intermediaries holding it; clear
  up-front disclosure of the full cost of credit; a cooling-off period; limits on automatic
  credit-limit increases; recovery agent conduct including contact hours and harassment
  prohibitions; and data handling by lending apps. A credit answer that ignores collections
  conduct is incomplete — the collections experience is a product surface with reputational
  and regulatory cost attached.
- **Dark patterns and consent design.** Specified deceptive practices are prohibited: false
  urgency, basket sneaking, confirm-shaming, forced action, subscription traps, bait and
  switch, disguised advertisements, drip pricing and others. The design-review test: would
  the user describe this control the way we do? Pre-ticked consent, a hidden cancel path and
  a fee revealed at the last step are all in scope. This is where growth tactics imported
  from elsewhere are most likely to be illegal here rather than merely distasteful.
- **Grievance redressal.** Expect obligations to publish a contactable route, name a
  responsible officer, resolve within a defined turnaround and escalate to an external
  scheme. Design consequence: a reachable human and a status-visible complaint path are a
  legal requirement in regulated categories, not a support-cost trade-off.

Advertising, content, competition, sectoral licensing and employment law also bind specific
products and are out of scope here.

**In a room:** naming the shape and saying you would verify the current text is a strong
answer. A section number from memory is weak even when correct, because it invites a question
you cannot survive. "We cannot, it is regulated" is equally weak — name the constraint, then
say what remains possible within it.

## 8. Labour and the unpriced cost

Many models here are viable because a cost sits somewhere it was not priced. Naming it is an
ethical point and a durability point at once: an unpriced cost is usually an unhedged risk,
and it gets repriced by regulation, litigation, labour supply or attrition, generally at the
worst moment.

- **Gig and delivery workforces.** Classification determines what is owed. Incentive
  structures booked as a variable marketing line are pay design, and pay design driven purely
  by unit cost transfers volatility to the worker. Waiting time, fuel, maintenance, device
  and data cost, weather and safety exposure are borne by the worker and rarely appear in a
  CM1 stack. Attrition is where this surfaces as a business cost, which is why spines 4.2 and
  4.10 carry it as a guardrail.
- **In-store and dark-store staff.** Shift design, forecast error and exception load land on
  the store. A tool that saves the customer time by adding picker steps has moved cost, not
  removed it — the defining risk of the consumer-tech seat in `role-packs.md`.
- **Merchant float.** Settlement cycles mean the merchant finances the gap. Faster settlement
  sold as a premium is that cost made explicit and priced back to them.
- **Small-seller working capital.** Inventory held for a platform's promise, returns
  absorbed, discounts funded by the seller, payment terms set by the platform. If marketplace
  economics depend on seller-funded discounting, they depend on a subsidy that is not on your
  P&L, and seller churn is where it shows up.
- **Customers as unpaid labour.** Returns handling, failed-delivery coordination and chasing
  a payment that did not go through is work the customer does for free.

**How to name it well.** State who bears the cost, whether it is priced, what would happen if
it were, and what early signal would tell you it is being repriced. That is sharper than
either ignoring it or moralising, and it converts an ethical observation into a risk with a
monitoring plan — the form in which it survives contact with an executive.
