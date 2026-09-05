---
name: platform-integration
description: Design and review the integration surface between a platform and a partner - API contracts, webhooks, idempotency, retries, state machines, reconciliation, settlement, merchant onboarding and going live. Use this when specifying or reviewing an API, when deciding what a partner must send, when an integration is breaking, or when tickets are asked for on an integration change, where this runs first and hands ticket-writer the design. The regulatory obligation itself is compliance-guard.
---

# Platform integration

The fintech platform charter owns settlement, reconciliation, risk decisions and the APIs
other teams and billions of transactions depend on. Three things follow, and they should be
visible in every answer in this domain:

- **Your users are other builders.** Internal teams and merchant engineers build against what
  you ship, so a breaking change is an incident, not a release note.
- **Correctness outranks speed.** In settlement and reconciliation, approximately right is
  the same as wrong. Money that does not reconcile becomes a support ticket, then a merchant
  escalation, then a regulatory question.
- **Every integration is a distributed system with money inside it.** Two systems, an
  unreliable network, and a transfer of value that must happen exactly once while every
  component in the path is entitled to retry. Almost every rule below is a consequence of
  that sentence.

Load `../../references/role-packs.md` archetype 2, sections 1 and 2, for the charter and the
metric ownership tiers. Payments metrics are spine 4.3 in
`../../references/metric-library.md` and the API surface is spine 4.9; use them rather than
inventing metrics, and do not restate them here. Anything financial is a server-side event
for the reasons in `../../references/instrumentation-and-experiments.md` section 1 — also not
restated.

## What this is not

- **`ticket-writer` decomposes a decided design into buildable items.** This skill produces
  the contract; that one produces the stories underneath it. Hand over rather than writing
  acceptance criteria here.
- **`compliance-guard` owns the regulatory obligation** — what the rule requires and what
  evidence proves it. This skill owns the mechanism. They meet constantly, at KYC, data
  residency, audit trail and retention: compliance says what must be true, this says how the
  integration makes it true. Route the obligation there rather than ruling on it.
- **`spec-writer` owns the document.** This owns the integration content that goes in it.
- **A live integration that has already broken is `rca`.** Bring the diagnosis back here for
  the fix.

## 1. The contract before the code

An integration is a contract first. Write it before anyone builds against it, because the
cost of changing it rises with every partner who has integrated.

- **What the partner sends.** Every field: name, type, required or optional, constraints,
  and a worked example. Optionality is a promise — **an optional field that later becomes
  required is a breaking change**, and partners will discover it in production.
- **What they get back.** The synchronous response and its status codes, plus what continues
  asynchronously. If the real answer arrives later, say so in the contract rather than
  letting the partner infer it.
- **What every field means, in the partner's language.** A `status` field with six
  undocumented values is not a contract. Enumerate the values, define each one, and say which
  are terminal.
- **Versioning and deprecation, stated up front:** how versions are named, how long an old
  version is supported, how a partner is notified, and what the migration path is. A
  deprecation policy invented at deprecation time is not a policy.

**Define what counts as a breaking change** and publish it: adding a required field, removing
a field, changing a type, narrowing the values you accept, and *widening the values you
return*, since consumers switch on those. The last one surprises people and causes incidents.

### The error taxonomy

**An error a partner cannot act on is a support ticket by design.** Decline messaging is not
a copy task; it is the taxonomy that determines support load. Every error carries a stable
machine-readable code, a human-readable message, a retryable flag, and the action the partner
should take.

| Error class | Retryable | What the partner does |
|---|---|---|
| Validation | No | Fix the payload and resend. Never retry — it will fail identically |
| Authentication | No | Check credentials; rotate if leaked |
| Rate limit | Yes | Back off per the documented schedule, honour `Retry-After` |
| Timeout or unknown | **Yes, with the same idempotency key** | Retry, then query the status endpoint. Never treat as failure |
| Business decline (insufficient funds, limit) | No | Tell the end user, specifically. Offer the alternative rail |
| Risk decline | No | Do not retry, do not tell the user why in detail, route to the named support path |
| Platform error (5xx) | Yes | Retry with backoff and the same key; alert if it persists |

The retryable column is the one that matters most: it is what stops a partner turning a
transient failure into an outage, or a permanent failure into an infinite retry loop.

## 2. Idempotency

This section prevents money bugs. It is the most common source of them, and the reasoning is
short enough that there is no excuse for getting it wrong.

**The network gives you at-least-once delivery, never exactly-once.** A client whose request
times out does not know whether it landed. It cannot know. So it will retry, and it *should*
retry — which means **every payment endpoint must be safe to call twice.** Not "should be":
must.

- **The idempotency key** is generated by the client, unique per logical operation, sent as a
  header, and stored by the platform alongside the response. A repeat of the same key returns
  the stored response and **does not re-execute the operation**.
- **The key scopes to the intent, not to the attempt.** Same key means "this is the same
  payment I already told you about". A genuine second payment gets a new key. A client that
  reuses one key for two different payments has a bug, and so does a client that generates a
  new key for each retry of one payment.
- **Store the request fingerprint with the key.** Same key with a different body is a client
  bug and must be rejected loudly with a distinct error, never silently served the first
  response — silently serving it hides the bug until it is a reconciliation break.
- **State the retention window** — 24 hours is common — and what happens to a key after it
  expires. An expired key that silently re-executes is the same bug with a delay on it.
- **Concurrency.** Two simultaneous requests with one key: one proceeds, the other waits for
  it or receives a conflict. Say which, in the contract. "Undefined" means partners will find
  out during a traffic spike.

**The distinction that matters: a duplicate request is not a duplicate payment.** Duplicate
requests are expected, routine and harmless against an idempotent endpoint. A duplicate
payment is money that left twice and now requires a reversal, a merchant conversation and a
reconciliation entry. The platform's entire job here is to absorb the first without ever
producing the second.

**A timeout is not a failure.** It is an unknown, and the difference is expensive. The client
retries with the same key, and if the answer is still unknown it queries the status endpoint,
which must exist for exactly this reason. A client that books a timeout as a failure and
tells the user the payment did not go through will be wrong some of the time, and the
customer will see the debit.

## 3. Webhooks and asynchronous state

**The webhook is a hint. The API is the truth.** Every rule here follows from that sentence,
and any design that treats a webhook as authoritative will eventually lose money.

- **Delivery is at-least-once,** so the consumer must be idempotent. Say so in the
  documentation and give them a stable event id to deduplicate on. A consumer that credits an
  order on every `payment.succeeded` it receives will double-credit.
- **Ordering is not guaranteed.** `payment.succeeded` can arrive after `payment.refunded`.
  Consumers must reconcile against state, not against arrival order, which means every event
  carries a sequence number or a version and a server timestamp so a stale event can be
  discarded rather than applied.
- **Signature verification** on every event: signed payload, shared secret, a timestamp
  inside the signed material so a captured event cannot be replayed later, and a documented
  key rotation path that does not require downtime. The consumer verifies before acting, not
  after.
- **Retries and dead letters.** Publish the retry schedule and the backoff, the number of
  attempts before an event is parked, and how a partner requests a replay or a backfill for a
  window they missed. Backfill is not optional — partners have outages.
- **A polling fallback must exist.** A status endpoint is mandatory, because webhooks are
  blocked by firewalls, dropped during deploys and lost in partner incidents. If the only way
  to learn that a payment succeeded is an event you pushed once, a partner's bad afternoon
  becomes your reconciliation break.

State the consumer's responsibilities in the contract, because they are half the design:
acknowledge fast with a 2xx and process asynchronously, be idempotent on event id, verify the
signature, tolerate unknown event types, and tolerate new fields appearing.

## 4. State machines

Model the entity's states explicitly and put the diagram in the spec. **Most integration
defects are illegal transitions nobody enumerated.**

States for a payment: `initiated`, `pending`, `succeeded`, `failed`, `reversed`, `disputed`,
`settled`. Then specify which transitions are legal, who triggers each, and what evidence
accompanies it. Everything not enumerated is illegal, and an illegal transition must be
rejected and alerted rather than quietly applied.

The transitions that catch teams out, all of them legal and all of them missed:

- `succeeded` → `pending` is **illegal**, and it is what a late or out-of-order webhook will
  try to do. This is the concrete reason section 3 insists on sequence numbers.
- `failed` → `succeeded` is **legal** on some rails, where a bank confirms late. A design that
  treats `failed` as terminal will lose that money silently.
- `settled` → `disputed` → `reversed` is **legal**, expensive, and arrives months later. Money
  already paid out to a merchant can be clawed back, which is a product problem and a balance
  problem, not an edge case.
- `pending` → nothing, forever, is the state where money actually hides. **Every non-terminal
  state needs a timeout, an owner and a resolution path.** The stuck-in-pending queue is a
  product with a user, and if nobody has designed it, ops will run it in a spreadsheet.

Treat **reversibility as a design property**: for any change, say what happens to a
transaction that is in flight when it ships, and how the change is halted mid-flight. That is
one of the clearest payments-versus-generalist tells there is.

## 5. Reconciliation

Reconciliation proves that what your system believes happened, what the partner believes
happened, and what the money actually did are the same thing. **A system without a
reconciliation design is incomplete regardless of how well the happy path works** — and
shipping a change that is correct in the happy path while leaving settlement ops a manual
queue nobody staffed is a named failure mode of a new PM in this seat.

- **Three-way match: platform records, partner records, and the bank or settlement file.**
  Two-way is not enough. Two systems can agree with each other and both be wrong about what
  the bank moved, and that gap is precisely where losses live.
- **State the mechanics:** the cadence, the cut-off time, the timezone the cut-off is in, the
  file format, and the reference identifier that joins their records to yours. Most
  reconciliation projects fail on the join key, not on the logic.
- **Classify every break before escalating it.**

| Break type | Usually means | Owner | Resolution |
|---|---|---|---|
| **Timing difference** | Present on one side, will appear on the other next cycle | Nobody yet | Age it. It is not a break until it survives the stated window |
| Amount mismatch | Fee, FX or rounding applied on one side only | Finance with platform | Recompute against the fee schedule; fix the derivation, not the row |
| Missing on one side | A request that timed out and was never reconciled, or a dropped event | Platform | Query by idempotency key; this is what the key exists for |
| Status mismatch | Late transition, or an event applied out of order | Platform | Re-derive from the API, per "the webhook is a hint" |
| Duplicate | An idempotency failure | Platform, urgently | Reverse, then find the bug. A duplicate is never only a data problem |

**Timing differences versus real breaks is the distinction that keeps the queue usable.**
Treating every unmatched row as an incident trains everyone to ignore the queue by Wednesday.
The ratio of timing to real is itself a health metric.

Every break class gets a **named owner and an SLA**, and the exception queue is designed as a
product whose user is an ops analyst. Track break rate, ageing of open breaks, value at risk
in the queue, and auto-resolution rate. The settlement guardrails in spine 4.3 cover the rest.

## 6. Onboarding and go-live

- **Sandbox parity is the whole game.** The sandbox must reproduce the production state
  machine *including its failures* — declines by reason code, timeouts, late webhooks,
  refunds, disputes. A sandbox that only does the happy path guarantees the partner meets the
  unhappy path for the first time in production, with real money.
- **Certification before a production key.** A short, mandatory list the partner demonstrates:
  one success, one decline handled by reason code, one timeout retried with the same
  idempotency key, one webhook signature verified, one refund or reversal, and one settlement
  file parsed. Six tests, and they eliminate most go-live incidents.
- **Credentials are the partner's responsibility, and the contract says so:** keys are
  secrets, never shipped in client code, separate per environment, rotatable without downtime,
  and revocable on suspicion. Provide the rotation and revocation paths, or the policy is
  decoration.
- **Stage the rollout by volume, not by date.** One percent, ten, fifty, a hundred — or a cap
  on transaction value per hour — with a defined observation window and a metric to watch at
  each step. A date-based rollout ships on the date whatever the numbers say.
- **The rollback path is about in-flight transactions, not the switch.** Anyone can disable an
  integration; the design question is how transactions already in `pending` are drained,
  reconciled and settled after it is off. Say that explicitly.
- **The metric is activation, not signup.** Spine 4.9's trap is counting signups and sandbox
  keys, which are free and meaningless. What counts is time to first successful production
  transaction, and the number of integrations past a production volume threshold. A merchant
  who has signed up, taken a sandbox key and never transacted is not a customer, and a
  funnel that celebrates them is measuring the wrong thing.

## 7. Failure and the unhappy path

- **Partner downtime.** Circuit-break rather than queueing indefinitely into a dead
  dependency, fail over to an alternative rail if one exists, and decide deliberately whether
  you fail fast or hold the transaction. Say what the customer sees during it, because "spin
  forever" is a decision someone will make by default.
- **Partial failure.** One leg moved and the other did not. The fix is a **compensating
  transaction — a reversal — never a delete**, because the ledger is append-only and the
  original event happened. Design the compensating path at the same time as the forward path,
  not after the first incident.
- **What the user sees**, drawn from the error taxonomy: a specific reason and a next action.
  What the merchant sees, in which dashboard, with which reference. Vague failure messaging is
  how one bug becomes a thousand support contacts.
- **"Where is my money?"** Support must answer this with a single lookup that returns the
  transaction, its current state, its full timeline, the partner reference, and the expected
  settlement date. **Design that lookup as part of the integration.** If answering it requires
  an engineer with database access at 2am, the design is not finished — and what support does
  at 2am is the honest test of every integration in this section.

## 8. What to ask a partner on the first call

The checklist that makes this skill useful immediately. Work down it; the gaps are the
project plan.

**Contract.** Where are the docs? How is the API versioned, and what is the deprecation
notice period? Is there a sandbox, and does it simulate failures? What are the rate limits?
Do you support idempotency keys — on which endpoints, and what is the retention window?

**Asynchronous.** Webhooks, polling, or both? What is the delivery guarantee? Is ordering
guaranteed? How are events signed, and how are signing keys rotated? Can we request a replay
or a backfill for a missed window? What happens after your final retry?

**States.** Give me the complete list of statuses and the legal transitions. Which are
terminal? What is your timeout on a pending transaction? Can a settled transaction reverse,
and how long afterwards?

**Money.** Settlement cadence, cut-off time, and in which timezone? What file, in what
format, delivered how? Who bears fees, FX and rounding? **Which reference identifier joins
your records to ours** — and is it present on every record, including failures?

**Reconciliation.** What does your break report look like? Who do we contact, and what is the
SLA? Have you had a reconciliation incident in the last year, and what caused it?

**Failure.** What is your uptime, and where is it published? How are incidents communicated,
and to which channel? What are support hours, and what is the escalation path with a name and
a number outside them?

**Change.** How will you tell us about a breaking change, and with how much notice? Is there
a changelog we can subscribe to?

Data residency, KYC obligations, retention periods and audit evidence come up on this call
too. **Take them to `compliance-guard` rather than ruling on them here.**

## Output

An integration design is complete when it carries: the field-level contract with optionality
and versioning; the error taxonomy with retryability and the partner's action; the idempotency
rule and the key's full lifecycle; the webhook contract, the hint-versus-truth rule and the
polling fallback; the state machine with legal transitions, timeouts and owners; the
reconciliation design with break classes, owners and SLAs; the go-live gates and the in-flight
rollback path; and the unhappy path including the support lookup.

Write into `../../templates/api-review.md`, which carries the contract, idempotency,
webhook, state-machine, reconciliation and go-live sections as tables to be completed.

Hand the document to `spec-writer`, the sprint items to `ticket-writer`, the regulatory
obligations to `compliance-guard`, and any diagram of the state machine or the exception flow
to `artefact-forge`.

Score against `../../references/rubrics.md`. The failure this domain produces most is missing
the unhappy path — failure, refund, dispute and recovery ignored — followed closely by an
answer that is correct on the happy path and silently creates a manual queue for someone else.
