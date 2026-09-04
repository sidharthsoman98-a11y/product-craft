---
name: launch-plan
description: Take a built feature to real users safely and deliberately - readiness gates, staged rollout, feature flags and kill switches, day-one monitoring, comms and enablement, and the post-launch decision. Use this for a launch or rollout plan, a phased or staged release, go-to-market sequencing, a launch checklist, briefing support, launch communications, or deciding what happens on day one. Deploying a prototype to a public URL is ship-it.
---

# Launch plan

A launch is the moment a decision meets people who attended none of the meetings. Everything
before it was reversible in private. From here, failures are public, and they cost trust
rather than time.

**The boundary against `ship-it` is the object.** `ship-it` is deployment mechanics for a
prototype: repository, host, environment variables, a working URL. **This skill is product
rollout to real users:** readiness gates, stages, flags, monitoring, comms and the decision
at the end. A prototype going live for one reviewer is `ship-it`. A feature reaching
customers is this, and the two do not overlap even though both end with something being
"live".

Load `../../references/india-context.md` sections 1, 2 and 5 before fixing any date or
staging plan, and `../../references/external-skills.md` section 5 for the announcement and
roadmap handoffs.

## What this is not

- **`ship-it` ends at a working URL.** This begins at a built feature and ends at a decision.
- **`experiment-readout` reads a test with a control.** A staged rollout is not an
  experiment — it is risk management with monitoring, and calling it a test invites causal
  claims it cannot support. If you need causality, design one: `metric-architecture`.
- **The announcement itself is `product-management:stakeholder-update`**, and roadmap
  sequencing is `roadmap-update`. Hand those the decided content rather than the brief.

## 1. Readiness, before any date

Six gates. Each is a yes or no with a name against it, and **a gate that is "in progress" is
a gate that has failed** — launches slip on the item everyone assumed was done.

- **Instrumentation live and verified.** Not "instrumented": events firing in production and
  checked against a known action. **A launch date agreed before instrumentation works is a
  date for a launch you cannot measure**, and you find that out on day two when someone asks
  how it is going and the honest answer is that nobody can tell.
- **Guardrails defined with thresholds.** The numbers that mean stop, written down before
  launch rather than argued about during one.
- **Rollback tested rather than assumed.** See section 3.
- **Support briefed with the three questions they will actually get** — not with the feature
  description. Usually: what is this, why did it change, and how do I get back. If you cannot
  predict three questions, you do not yet understand the change you are making.
- **Unhappy paths handled.** The edge-case walk from `ticket-writer` section 4, closed out
  rather than logged.
- **The stop authority named.** See section 4.

## 2. Staged rollout

Stages exist to catch *different classes* of failure. So **the gate between two stages is a
question answered, not a date reached.**

| Stage | What it is for | Gate to the next stage |
|---|---|---|
| **Internal** | Catastrophic breakage, a wrong mental model, missing copy | The team uses it for its real purpose without a workaround |
| **One unit, or 1–5%** | Failures that only exist in production: scale, data variety, integrations | Guardrails clean across one full operating cycle, not one good day |
| **A segment or geography** | Contact with a real population: support load, operational fit, the users you did not picture | Support volume per user inside threshold, and ops able to absorb it |
| **General availability** | Everything, at once | The decision in section 7 |

Three rules that make stages real rather than ceremonial:

- **A stage that catches nothing new should be dropped.** Stages cost time and, more
  importantly, credibility — a ritual stage teaches the organisation that the gates are
  theatre, and then a real gate gets waved through.
- **Never advance two stages in one day.** The mechanism is elapsed time under load; skipping
  it means the stage happened on paper.
- **Advance on evidence, not on the absence of complaints.** Nobody complaining at 1% is
  exactly what 1% looks like whether the feature works or not.

## 3. Feature flags and kill switches

Four questions, answered in writing before launch:

- **Who can turn it off?** By name and by role, including outside working hours.
- **How fast?** A config change or a deploy. **If disabling it requires a deploy, it is not a
  kill switch, it is a fix** — and it will take the time a fix takes, during an incident.
- **Has anyone actually run it?** **A rollback nobody has run is a hypothesis.** Throw the
  switch in production deliberately, before you need it, while everyone is calm.
- **What happens to work in flight?** The hard part, and the one that is skipped. A payment
  mid-flow, a job on a queue, a row written by new code that old code cannot read. **Turning
  a flag off does not un-write data.**

Two more, both cheap and both usually missing:

- **Flag hygiene.** Every flag has an owner and a removal date. A codebase full of permanent
  flags is one where nobody can say what is currently on.
- **Name the irreversible parts before launch.** A migration, a public API, a price change,
  anything users must re-learn. Those are one-way doors: they need more evidence beforehand,
  because no switch reverses them afterwards.

## 4. Day one

- **The dashboard exists before the launch, not after it** — guardrails, adoption, support
  volume, error rate, on one screen.
- **Someone is watching it, by name, for a stated number of hours.** "The team is watching"
  means nobody is watching.
- **A pre-registered number triggers a stop.** A threshold invented during an incident is set
  by whoever is most confident in the room, which is not the same as whoever is right.
- **The person who can stop the launch is identified by name before it starts** — a person
  and their named backup, both of whom know they hold it. Not a role, not a rota. In an
  incident, the expensive minutes are spent working out who is allowed to decide.
- **Define what "stop" means**, because it is three different actions with three different
  costs: pause the rollout, flip the flag back, or fully revert. Decide the ladder now and
  say who can authorise each rung.
- **Walk the actual user journey in production in the first hour.** A dashboard only shows
  what you instrumented; the thing you forgot to instrument is the thing that will hurt.

## 5. Comms and enablement

- **Users.** What changes, when they see it, and whether they must do anything. Say it in the
  product at the moment of change rather than only in an email nobody opens — and if nothing
  is required of them, say that explicitly, because silence reads as a task.
- **Support, before launch rather than at it.** The three questions, the workaround for each,
  the escalation path, and **how to tell whether a given user is in the new experience or the
  old one** — which is the question that actually strands support during a staged rollout.
- **Sales and account teams**, where relevant: what to promise, what not to promise, and what
  is still gated behind a stage.
- **Documentation** updated at the stage where external users first meet the change, not at
  general availability.
- **The internal note for when it breaks:** who to page, what the flag is called, where the
  dashboard is, and the known failure modes. One page, linked from the launch ticket. This is
  the artefact people actually open at 2am, and it is the one most often written afterwards.

The external announcement goes to `product-management:stakeholder-update` and the roadmap
change to `roadmap-update`, per `external-skills.md` section 5.

## 6. Commercial launches

For anything with money attached, the feature being live is not the launch. Sequence:

- **Pricing and packaging live in the systems that charge**, not merely decided. Billing,
  invoicing, tax handling and the plan the customer sees have to agree with each other before
  the first transaction, not after the first complaint.
- **Sales enabled:** what it costs, who it is for, **what it does not do**, the competitive
  answer, and a demo that works on a bad connection.
- **Partner and merchant communication sequenced.** Decide who hears it first and why.
  Existing customers learning about a change from a public announcement is a trust cost you
  pay later. For anything that changes an integration, lead time must be proportional to the
  work you are asking of them — see `platform-integration` for what a breaking change costs
  the people on the other side.
- **The first customer conversation planned:** who, when, and what you will ask. The first
  five real conversations are worth more than the first month of aggregate data, and they
  only happen if somebody puts them in a calendar before launch.

**A note on ownership.** In the fintech platform seat, intent volume and merchant coverage
sit with sales and growth rather than with the PM (`role-packs.md` archetype 2, section 2).
So this section is about *sequencing and readiness*, which the PM owns, rather than about
carrying a commercial number that belongs to someone else. In the consumer seat the published
charter names the balance between short-term commercial goals and long-term platform work as
the PM's to arbitrate (archetype 1, section 1), which makes the sequencing decision yours to
make rather than to receive.

## 7. Post-launch

- **Declare it done rather than drifting into it.** Done means: at general availability,
  guardrails stable for a stated period, the flag removed or its removal scheduled, support
  volume back to baseline, and the decision below actually taken.
- **The decision is keep, iterate or roll back**, with the number that supports it. **A launch
  without a decision point is an announcement rather than a launch.** Features that shipped
  and were never revisited are the most common form of accumulated cost in a product, because
  each one keeps charging maintenance against a benefit nobody ever confirmed.
- **The retro asks five things:** what did we learn at this stage that we could have learned
  one stage earlier — the cheapest process improvement available; which gate nearly slipped;
  what did support get asked that we failed to predict; what would we have to see to reverse
  this; and did the metric we predicted actually move. If it did not, the result is
  unexplained rather than proven, per `experiment-readout` section 3.

## 8. Emerging-market considerations

Per `india-context.md`, and each of these has cost a real launch:

- **Stage by city or pincode rather than by percentage wherever operations are involved.** A
  5% random sample spread across every city gives you 5% of the load everywhere and a real
  signal nowhere, while supply, ops and support are organised geographically. One city at
  full volume tests the actual system; 5% everywhere disrupts everywhere and tests nothing.
- **Vernacular readiness before general availability**, per section 2: strings translated,
  then checked for truncation and layout in the *longest* language rather than merely present.
  An English-only general availability has launched to a fraction of the market, and reads as
  a bug to everyone else.
- **Low-end device verification before general availability**, per section 1: the real device
  tier on a real network, not an emulator on office wifi. Client-side failure correlates with
  device tier and network, which means the users most likely to break are the least likely to
  be in your beta population.
- **Check seasonality before fixing a date**, per section 5. Launching into a festival peak
  measures your guardrails against an abnormal baseline and leaves ops with no slack to
  absorb a problem — the two things you most need on day one.

## Output

A launch plan carries: the six readiness gates with a name against each; the stages with the
question each answers and the gate between them; the flag, the kill switch, who holds it and
when it was last actually tested; the day-one dashboard, its watcher, the stop threshold and
the named stop authority; the comms set including the internal break-glass note; the
commercial sequence where money is involved; and a dated post-launch decision.

Hand the announcement to `stakeholder-update`, roadmap sequencing to `roadmap-update`,
prototype deployment to `ship-it`, and anything needing a causal claim to
`metric-architecture` and `experiment-readout`.

Score against `../../references/rubrics.md`. The failures this work produces are missing the
unhappy path, and metric without a decision — which here takes the specific form of a launch
nobody ever went back to.
