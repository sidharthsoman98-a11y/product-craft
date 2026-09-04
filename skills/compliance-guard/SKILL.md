---
name: compliance-guard
description: Surface regulatory and policy constraints as design inputs before a product is built, rather than as a review gate afterwards. Use this when asking whether something is allowed, for KYC and verification tiers, consent, data retention, residency or deletion, audit trails, grievance handling, lending and collections conduct, dark patterns and consent design, or when preparing a design for legal or compliance review. Integration and API mechanics are platform-integration.
---

# Compliance guard

The fintech PM charter says it plainly: translate local regulatory requirements into product
requirements. **The regulator is the absent stakeholder** — never in the room, constrains
every decision, sends requirements as deadlines rather than as backlog items, and outranks
the roadmap. Handling that stakeholder well is the thing this seat is actually testing.

## The hard rule of this file

**This skill describes the *shape* of obligations. It never states a section number, a
threshold, a limit, a date or a penalty.**

Regulation moves quarterly, staged commencement and transition periods are normal, and a
confidently stated stale rule is worse than no rule at all: it invites a question you cannot
survive, and it makes every other claim you made in that room suspect. Per
`../../references/sources.md` section 2, a regulatory threshold, rate, limit or deadline is
**never answered from memory** — including one you believe you learned last month, because
that is exactly when transition periods bite. Per section 4 of the same file, regulation is
re-checked *at use*, not at ninety days.

So every output from this skill carries three things, without exception:

1. **The shape of the obligation**, in plain language.
2. **The primary source class to check** — the regulator's own circular, notification or the
   statute text. Not a law firm summary, not a news report, not this file.
3. **An explicit line that the current version must be confirmed** before the claim enters
   any deliverable, deck or answer.

**In a room:** naming the shape and saying you would verify the current text is a strong
answer. A section number recalled from memory is weak *even when it is correct*. And "we
cannot, it is regulated" is equally weak — name the constraint, then say what remains
possible within it.

The current shapes for the Indian regime live in `../../references/india-context.md` section
7, which carries the same no-numbers discipline. Read it; do not restate it.

## What this is not

- **`platform-integration` owns the mechanics** — contracts, idempotency, webhooks,
  reconciliation. This owns what the law requires of the data and money moving through them.
  They meet constantly, at KYC, residency, audit trail and retention: this skill says what
  must be true, that one says how the integration makes it true.
- **This is not legal advice and not a substitute for compliance review.** It gets a PM to
  the review with the answers already prepared, which is the thing that makes reviews short.
- **`spec-writer` and `ticket-writer` own the document and the items.** This produces
  constraints that go into them.

## 1. Compliance as a design input

The asymmetry is the whole argument. **Discovering a constraint after the build is a
rebuild** — flows, stored data, states, copy, and sometimes the business model. **Asking in
week one is an hour** with a compliance colleague. Nothing else in product work has that
ratio, and the reason teams still get it wrong is that the hour is visible and the rebuild is
hypothetical until it isn't.

Two consequences worth acting on:

- **Bring compliance the design, not the finished spec.** They can stop a launch outright,
  and they rarely stop a sketch. A spec arrives as a thing to approve or reject; a design
  arrives as a thing to shape.
- **The named failure mode of a new PM in this seat** is learning about a regulatory deadline
  when it is already a deadline, because compliance was consulted at spec review rather than
  at design.

**Week-one questions for any money, health or identity product.** Ask them before the second
design meeting:

- What personal data does this touch, and what is the minimum that makes it work?
- Who is the regulated entity in this flow, and are we it? If not, whose licence are we
  operating under, and what does that oblige us to do?
- Does money at any point rest in an account we control, even briefly? Custody changes
  everything downstream of it.
- What identity assurance does each action need — and can the lighter actions ship with
  lighter verification?
- Where does the data physically sit, and for how long must we keep it and may we keep it?
  Those are two different numbers and both bind.
- What must the user be told, at what moment, and in which language?
- Who can see this data internally, and could we prove who did?
- What is the complaint path, and who answers it?
- If this fails badly, who is obliged to be told, and within what window?

**Then list which of those you could not answer.** That list is the agenda for the first
compliance conversation, and arriving with it is what separates a partner from a supplicant.

## 2. The obligation families

The families a PM designs around, with what each one actually changes in the product. The
shapes themselves are in `india-context.md` section 7 — this table is the design surface, not
a restatement of the rules.

| Family | What it changes in the product | Check against |
|---|---|---|
| **Identity and verification tiers** | The trust ladder: which actions need which assurance, tier as an account state, expiry and re-verification | The regulator's current KYC directions |
| **Consent and purpose limitation** | When consent is captured, granularity per purpose, withdrawal as easy as granting, and whether the actual use stays inside the stated purpose | The data protection statute and its rules as commenced |
| **Retention, residency and deletion** | Where data physically sits, how long it is kept, what deletes it, and what a deletion request does to records another obligation requires you to keep | Statute plus sectoral directions, which often conflict |
| **Audit trail and record-keeping** | Append-only decision records, a reason code stored with every automated decision, access logging on customer data | Sectoral record-keeping requirements |
| **Grievance redressal** | A reachable route inside the product, a named responsible role, a clock on each complaint, external escalation when it expires | The sector's grievance framework |
| **Lending and collections conduct** | Cost disclosure before commitment, cooling-off, limits on automatic increases, and recovery conduct including contact hours | The lending conduct directions |
| **Disclosure and fair dealing in pricing** | Full cost stated up front and comparably, no material term deferred to a later screen | Consumer protection rules and sectoral pricing norms |
| **Dark patterns and consent design** | Default states, cancel paths, urgency claims, pre-ticked boxes, subscription exit | The specified list of prohibited practices |

Two of these deserve a note, because they are the ones PMs under-model:

- **Audit trail is not logging.** Expect an obligation to reconstruct, for one named customer
  on one named date, what decision was made, by whom or by what, on what data, and why.
  **Retrospective reconstruction is impossible** — if it was not recorded at the time, the
  record does not exist, and no amount of engineering later creates it.
- **Disclosure is a flow decision, not a copy decision.** If the full cost is knowable only
  after three screens, moving the text does not fix it; the flow is the violation. Drip
  pricing is the anti-pattern and it is usually introduced by a growth experiment.

## 3. Translating an obligation into a product requirement

**An obligation is not a feature.** It is a constraint that changes flows, states, storage and
copy — usually all four at once. The characteristic error is booking it as a ticket called
"add consent screen", which satisfies nobody and passes no review.

Four moves:

1. **Restate the obligation as a property the system must hold at all times**, not as a step
   in a flow. "This user's consent for purpose X is current, granular and withdrawable" is a
   property. "Show the consent screen" is a step, and steps are trivially satisfied while the
   property is violated.
2. **Work the four surfaces.** *Flow*: what happens in what order, and at what moment.
   *State*: what new states exist and which transitions are legal. *Storage*: what is kept,
   where, for how long, and who may read it. *Copy*: what is said, when, in which language.
3. **Name the failure state and its handling.** Consent withdrawn mid-flow. Verification
   expired while a transaction is in flight. Retention running out on data an open dispute
   still needs. These are where obligations actually break, and they are always missing from
   the first draft.
4. **Name the evidence.** Which artefact proves the obligation was met, and where it is
   produced. An obligation with no evidence artefact has not been implemented, it has been
   intended.

**Worked translations:**

**Tiered verification.** *Shape*: lighter verification permits limited functionality; fuller
verification unlocks more. → *Flow*: do not demand full identity at signup; ladder the
request to the action that needs it. *State*: the account carries a verification tier;
upgrades are transitions and expiry is a state, not a flag. *Storage*: verification artefacts
carry tighter retention and access rules than the rest of the profile. *Copy*: state the
limit and what lifts it at the moment the user meets it, not in terms and conditions.
*Evidence*: the tier and its supporting artefacts as they stood at the time of each
transaction — not as they stand now.

**Consent and purpose limitation.** *Shape*: consent is informed, granular, purpose-bound and
withdrawable. → *Flow*: captured at collection, not bundled at signup; withdrawal path no
harder than the grant path. *State*: each purpose separately granted, withdrawn or expired.
*Storage*: the consent record stores the *version of the notice shown and the language it was
shown in*, with a timestamp. *Copy*: plain language, in the user's language. *Evidence*:
reproduce exactly what this user saw on the day they consented — which is why the notice is
versioned rather than edited in place.

**Grievance redressal.** *Shape*: a contactable route, a named responsible officer, a defined
turnaround, external escalation. → *Flow*: reachable from inside the product, not only a
footer address. *State*: a complaint is an entity with states and a running clock that
escalates when it expires. *Storage*: the complaint and its full timeline. *Copy*: publish
the route and the role. *Evidence*: turnaround statistics per period, producible on request.

The pattern underneath all three: **every obligation lands as a state machine plus a record.**
That is why this work looks so much like `platform-integration`, and why the two skills keep
meeting.

## 4. What compliance review actually asks

Pre-empt these seven and the review is a conversation instead of a gate. Bring a short answer
to each, in writing:

1. **What data** does this collect, and what is the minimum it needs to work?
2. **Why** — the stated purpose, and does the actual use stay inside it?
3. **How long** is it kept, and what deletes it?
4. **Who can see it**, and how would we know who did?
5. **What was the user told**, when, in which language, and can we reproduce it exactly?
6. **What does the audit record show** — could we produce it for one named customer on one
   named date?
7. **What happens when it fails** — a breach, an outage, a wrong automated decision, a
   consent withdrawn mid-flow?

And the eighth, which reviews ask and PMs never prepare for: **who decided, and where is that
written down?** Requirements from an absent stakeholder arrive as deadlines, and a written
record of why a decision was made is what makes it defensible a year later when nobody
remembers the meeting.

## 5. Where compliance and growth genuinely conflict

These conflicts are real, and pretending otherwise is what destroys a PM's credibility with
both sides:

- Verification friction against activation rate.
- Consent granularity against personalisation reach.
- Retention limits against dispute defence and model training data.
- Cooling-off periods against conversion.
- Complete disclosure against a clean first screen.

How to hold the line without becoming the department of no:

- **Name the trade instead of denying it.** "This costs roughly X% of activation and here is
  why we do it anyway" is a far stronger position than claiming the cost is zero — because
  the cost gets discovered, and after that nobody believes your first sentence on anything.
- **Friction that protects trust is not a bug.** Where the user is deciding whether to trust
  you with money, a visible check can raise conversion rather than lower it. Test it; do not
  assume the direction.
- **Quantify rather than invoke.** Name the requirement, the constraint it imposes, the cost,
  and **what remains possible within it**. Quantifying compliance rather than invoking it is
  one of the clearest tells in this seat.
- **Offer the compliant version of the growth idea, not only the refusal.** Most tactics have
  a lawful shape. The ones that do not are usually sitting in the dark-patterns family, and
  saying so early is cheaper than saying so after the experiment ships.
- **Bring risk a shared number, not a debate about tone.** The negotiation is false positives
  against fraud in basis points, and it is settled with arithmetic.

## 6. Beyond the legal minimum

Per `india-context.md` section 8: **the legal minimum and right treatment are different
bars**, and most of the durability risk lives in the gap between them.

- **Consent that is actually informed.** A consent that is technically valid and practically
  not understood is a compliance pass and a trust failure. The measurable version is
  comprehension, not click-through.
- **Defaults that do not exploit inattention.** The pre-ticked box, the buried cancel, the
  renewal that is one tap to start and four screens to stop. Where these are legal they are
  still borrowed revenue, repaid in churn and, eventually, in rules written specifically
  about them.
- **Costs borne by people who did not price them** — users, workers, merchants. State it in
  the section 8 form: who bears the cost, whether it is priced, what would happen if it were,
  and the early signal that it is being repriced.

The test that generalises across all three: **would the user describe this control the way we
describe it internally?** If the internal name is "friction reduction" and the user would say
"they hid the cancel button", the question is answered.

And the argument that makes this more than a moral aside: **an unpriced cost is an unhedged
risk.** It gets repriced by regulation, litigation, labour supply or attrition, generally at
the worst possible moment, which converts an ethical observation into a risk with a
monitoring plan — the form in which it survives an executive conversation.

## 7. The escalation rule

**Stop designing and ask when any of these is true:**

- The answer depends on a threshold, a limit, a date or a definition. Never guess one.
- Money would rest in an account you control, even briefly.
- The regulated entity in the flow is someone else, or is unclear.
- Personal data crosses a border, or a new category enters — biometric, health, children's.
- An automated decision denies someone access to money or credit.
- A growth mechanic resembles anything in the dark-patterns family.
- The obligation may have changed, or you are relying on something learned more than a
  quarter ago.
- You cannot answer any of the seven questions in section 4.

**How to ask well.** Bring the specific question and the design, not the whole spec and an
open request for review. State what you believe the constraint is, what you propose, and what
you would do if the constraint turns out to be tighter than you think. That converts a review
into a decision, and it is the difference between a compliance function that blocks you and
one that works with you.

**Guessing is the failure mode, including a guess that turns out to be right** — because it
teaches the team that guessing works, and the next one will not be right.

## Output

Every output from this skill carries: the obligation shape in plain language; the design
consequence across flow, state, storage and copy; the evidence artefact that proves it; the
primary source class to check; and the explicit line that the current version must be
confirmed before the claim is used.

**Never a section number, threshold, limit, date or penalty from memory.** Where a claim
could not be verified, say so in the form `sources.md` section 6 requires, and never let an
unverified claim carry a recommendation on its own.

Score against `../../references/rubrics.md`. The failures this domain produces are constraint
amnesia — a recommendation that assumes away the binding constraint — and ethics as an
afterthought, where the cost to a user, worker or merchant is named only once someone asks.
