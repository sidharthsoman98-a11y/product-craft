---
name: ticket-writer
description: Turn a decided feature into the sprint-level items an engineering team can build from - stories, acceptance criteria, edge cases, slicing and definition of done. Use this when writing tickets, user stories or backlog items, breaking a feature into tasks, defining acceptance criteria or what counts as done, or working out what engineering needs before it can start. The document above the tickets is spec-writer; an API contract is platform-integration.
---

# Ticket writer

Tickets broken out of a spec, with acceptance criteria the person doing the job would
recognise, are weekly work in both archetypes. This is the least glamorous skill in the pack
and the one whose absence is most visible: a team can survive a mediocre strategy for a
quarter, and it cannot survive a week of ambiguous tickets.

**The boundary is the artefact, per D12.** `spec-writer` owns the document — the problem, the
why, the non-goals, the open questions. This skill owns the items underneath it. Same family,
different object, so it consumes that document rather than restating it.

Most bad tickets are not badly written. They are **undecided work wearing the costume of a
decision**, and no amount of formatting fixes that.

## What this is not

- **`spec-writer` owns the document above these items.** If the spec does not exist, the
  tickets will silently encode assumptions nobody agreed to. Say so and go get the decision
  rather than writing tickets that quietly make it.
- **`platform-integration` owns the contract** — field definitions, idempotency semantics,
  webhook behaviour, reconciliation. A ticket *references* it. Restating a contract inside a
  ticket guarantees the two drift.
- **`compliance-guard` owns the obligation.** A ticket carries the constraint it imposes, not
  a ruling on what the rule says.
- **Sprint scoping, capacity and carryover are the external `product-management:sprint-planning`
  skill**, per `../../references/external-skills.md`. This writes the items; that plans the
  sprint they go into.

## 1. What a ticket is for

Three properties. If any one fails, it is not a ticket yet:

- **Small enough to finish inside a sprint.** Work that spans two sprints is a project
  wearing a ticket's name, and it will be reported as 80% done for three weeks.
- **Independent enough to ship or drop.** If dropping it strands three other tickets, the
  slicing is wrong — see section 5.
- **Specified well enough that nobody has to guess.** The working test: **if a ticket needs a
  meeting to be understood, it is not written yet.** Write the meeting into the ticket.

The audience is one specific engineer picking this up on a Tuesday morning with you
unavailable. Write for them, not for the grooming session where you will be present to
explain it.

The counter-rule, so this does not curdle into bureaucracy: **a ticket is a device for
removing ambiguity, not for assigning blame later.** If the team repeatedly discovers the
requirement was wrong, that is a spec failure, not a ticket-writing failure, and writing
stricter tickets will not fix it.

## 2. The story: a need, not a solution

> As a **[specific user in a specific situation]**, I need **[capability]**, so that
> **[the job gets done]**.

**The "so that" is the load-bearing clause.** A ticket that names a UI control without saying
which job it does cannot be challenged or improved by the engineer building it — they can
only implement it exactly, including its mistakes. That is how a team ends up building
precisely what was asked for and nothing better, which is a failure that looks like success
in every status report.

- *Weak:* "Add a dropdown to the store settings page."
- *Strong:* "As a store manager whose inbound shipment is running late, I need to change the
  store's cut-off time myself, so that one delayed truck doesn't breach the promise on every
  order that evening."

The second version can be argued with. An engineer can say "a dropdown is wrong, this should
be a one-tap toggle with an auto-revert", and they will often be right, because they know
things about the system that you do not.

**Every ticket traces back** to a spec section and a problem statement. If nothing traces,
that is a question about whether the ticket should exist, not a formatting gap.

**Write in the language of the person doing the job.** For an operations seat, acceptance
criteria should be recognisable to an ops lead reading them cold — a picker, a store manager,
a city lead — not phrased in the vocabulary of the system that serves them.

## 3. Acceptance criteria that can actually be tested

Given / when / then, or a plain checklist. The form matters less than consistency; what
matters absolutely is this: **every line must be verifiable by someone who did not write it.**
Could QA, or the engineer, or you in three months, decide pass or fail without asking anyone
a question?

**A criterion nobody can test is a wish.**

- *Wish:* "The page should be fast." *Criterion:* "The order list renders within two seconds
  on a 3G connection on the store's shared Android device."
- *Wish:* "Handle errors gracefully." *Criterion:* "If the cut-off update fails, the previous
  cut-off remains in force, the manager sees the failure reason, and the retry does not create
  a second update."

Three rules that catch most of the rest:

- **Specify the negative.** Most criteria describe only success. What must *not* happen is
  usually the more important half, and it is the half that turns into an incident.
- **Name the observable.** What the user sees, and what the system records. If nothing is
  recorded, section 6's instrumentation requirement has nowhere to land.
- **Every threshold comes from somewhere** — the spec, the metric tree, a contract, a
  constraint. A number invented while writing the ticket is an unowned number that will be
  treated as a commitment forever.

## 4. Edge cases: where the PM work actually shows

The happy path is the part everyone writes. **For every ticket, walk this list and either
specify the behaviour or state explicitly that the case cannot arise and why:**

- **Empty state** — first use, zero rows, the last item deleted.
- **Error state** — what the user sees, and what they can do next.
- **Partial failure** — half the operation succeeded. What is the system's state now?
- **Retry** — safe or unsafe, and what the user is told while it happens.
- **Timeout** — an unknown, not a failure. They are different and the difference is expensive.
- **Permission denied** — and whether the user should have been shown the control at all.
- **Offline and poor network** — for Indian consumer products this is the ordinary case, not
  the exception; see `../../references/india-context.md` section 1.
- **Concurrent action** — two people at once, or one person who tapped twice.

**For anything touching money or identity, add idempotency and reconciliation** — and hand
the detail to `platform-integration` rather than restating it. The ticket says "must be
idempotent on the key defined in the payments contract"; the contract says what that means.

This list is not ceremony. **An unwritten edge case is not absent from the product** — it is
decided by whoever writes that line of code, at the moment they write it, usually at 6pm,
without the context needed to decide it well. You are not choosing whether it gets decided,
only whether you are in the room.

## 5. Slicing a feature

**The vertical-slice rule: every slice cuts through all the layers and delivers something a
user can actually do.** Thin, but complete.

**Splitting by layer produces a stack of tickets that ship nothing until the last one lands.**
"Build the data model", "build the API", "build the UI" — three tickets, no user value until
all three are done, no integration risk discovered until the schedule is already spent, and
no ticket that can be dropped, which removes the only real scope lever you have. It also
produces the most demoralising status report in software: three of four tickets closed, zero
users helped.

Ways to cut a genuine slice:

- **By user or segment** — one store, one merchant tier, one city first.
- **By journey step** — create before edit before delete.
- **By variation** — one payment method, then the others.
- **By rule complexity** — the ordinary case first, the exceptions after.
- **By quality attribute** — works, then works quickly, then works at volume; but only where
  the first version is genuinely usable rather than a demo.

The test for each: **could this ship on its own, and would shipping it be worth doing?** If
not, it is not a slice, it is a stage with a slice's name.

**When the answer is genuinely unknown, write a spike** — time-boxed, with a decision as its
deliverable rather than code. Say which decision, and say what happens when the box expires,
because a spike with no end condition is just unmanaged work.

## 6. Definition of done

**"The code works" is not done.** Done is:

- **Instrumentation in place** — the events that will let you tell whether this worked,
  shipping *with* the feature rather than after it. This is the item that gets dropped under
  pressure, and it is the one whose absence is invisible until the readout, when it is too
  late to recover the data.
- **Error states handled** — every branch from section 4 implemented or explicitly ruled out.
- **Rollback possible** — the change can be turned off, and someone has said what happens to
  work that is in flight when it is.
- **Documentation or support notes updated** — what support says when a customer calls about
  this. A feature that generates tickets nobody was briefed on is not finished.
- **The metric it moves is observable** — if you cannot see the metric, you cannot tell
  whether it worked, and it will never be revisited.

Plus whatever the team's own standards are: tests, review, accessibility, performance budget.
**The definition of done is a team agreement, written once with the team and then applied** —
not a PM's list negotiated afresh on each ticket. And a definition of done that is never
enforced is decoration; the honest move is to enforce it or to change it.

## 7. Estimation and dependency hygiene

**Estimation is not a PM activity.** The team estimates. The PM's job is to remove the
ambiguity that makes estimation impossible, and what you owe them *before* anyone points
anything:

- the problem and the why, not only the what;
- acceptance criteria already written, not "we'll work it out in the ticket";
- the edge-case walk from section 4, done;
- known constraints named — compliance, a partner contract, a fixed date;
- the priority relative to everything else, decided rather than implied;
- answers to the open questions, or each open question flagged and owned by name.

Without these the estimate is fiction, and everyone in the room knows it is fiction, which is
corrosive in a way that a wrong estimate is not.

**On dependencies: a dependency named without an owner is a risk you have documented rather
than managed.** "Blocked on the platform team" is a shrug. Each dependency carries what is
needed, from whom *by name*, by when, what happens if it slips, and who is chasing it.

**Sequence so the riskiest unknown resolves first**, not last. Cheap certainty early is worth
more than a tidy plan, and the plan was going to change anyway.

## 8. What to hand over versus what to decide

**The PM specifies the need, the constraint and the observable outcome. The engineer
specifies the implementation.** That line is not etiquette; both sides of it are load-bearing.

- **Yours:** what problem, for whom, what must be true when it is done, what must not happen,
  what it costs to be wrong, and which trade-off you would take under time pressure.
- **Theirs:** data model, architecture, libraries, algorithms, how the code is organised, and
  how long it will take.
- **Contested, and worth naming explicitly:** anything where an implementation choice carries
  a product consequence — latency budgets, failure behaviour, data retention, degradation on
  a weak network. **State the consequence you need; do not name the mechanism.** Sections 4
  and 6 exist so these arrive as requirements rather than as architecture.

**Crossing the line produces worse systems**, because you have strictly less information than
the person building it, and specifying the mechanism removes their ability to find a better
one — while quietly transferring responsibility for a decision you are not equipped to
evaluate.

**It also produces worse relationships**, and that cost is larger and slower. An engineer who
is handed solutions stops bringing you problems, and problems arriving early is the single
most valuable thing that relationship produces.

**If you notice you have crossed it, say what you were actually worried about.** "I asked for
a cache because I'm worried about the two-second load on the shared device in the store" hands
back the constraint and lets them solve it properly — often in a way you would not have
thought of.

## Output

**Per ticket:** a title stating the user-visible outcome; the story with its "so that"; the
trace back to the spec; acceptance criteria a stranger could test; the section 4 walk with
each case specified or ruled out; dependencies with named owners and dates; and the definition
of done applied rather than assumed.

**Per feature:** the slice list in shipping order, the first slice being the thinnest thing
that is genuinely usable, with the riskiest unknown resolved first.

Hand contract detail to `platform-integration`, regulatory obligations to `compliance-guard`,
the document above to `spec-writer`, and sprint scoping to the external sprint-planning skill.

Score against `../../references/rubrics.md`. The failures this work produces are missing the
unhappy path — failure, retry and recovery left to whoever writes the code — and scope
inflation, which in ticket form is a stage dressed as a slice.
