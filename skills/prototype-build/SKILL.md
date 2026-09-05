---
name: prototype-build
description: Build a working, demonstrable product prototype from a concept - choosing fidelity, scaffolding a Next.js or single-file app, generating plausible mock data, covering unhappy paths and writing the demo script. Use this whenever someone wants to build, make, mock up, prototype or demo a product or feature, needs something clickable for an interview assignment, hackathon or review, or has a decided concept and asks what to build next.
---

# Prototype build

The prototype exists to make a decision visible, not to look finished. A complete ugly loop
beats two beautiful screens and a dead end.

Load `../../references/prototype-stack.md` for the fidelity table, the default stack, the
file layout and the speed rules.

## Before writing code

Confirm four things in one short exchange, and state assumptions rather than asking a long
list of questions:

1. **What decision does the prototype settle?** If the answer is "it shows the idea", push
   for the specific thing a viewer should conclude.
2. **The core loop**, as three to five screens. If it cannot be drawn in five screens, the
   concept is not yet decided; go back to `idea-forge`.
3. **Fidelity level** from the table, chosen against the time budget.
4. **Deployment**: does this need a public link. If yes, `ship-it` runs at the end, and the
   build must be deployed by the halfway mark rather than at the deadline.

## Build order

1. Scaffold and get an empty app running.
2. Write `lib/mock-data.ts` first, fully typed, with plausible names, prices and volumes for
   the actual market. Implausible data loses an audience faster than an ugly interface.
3. Build the loop end to end with unstyled components. Verify a person can complete it.
4. Add the metrics stub: a `track()` function that logs event name and properties to the
   console. Wire it to the four or five decision-bearing actions. Being able to open the
   console during a demo and show the events firing is disproportionately persuasive.
5. Add one unhappy path in full: a payment failure, a rejection, an empty state, a retry.
6. Only now, style — and **hand the mechanics to `frontend-design`**. This skill decides
   what the prototype must show and at what fidelity; how it looks is that skill's job, and
   reimplementing it here produces a thinner version of work that already exists. Hand over
   the decided loop, the fidelity level from step 3 and the constraints that are product
   decisions rather than taste: mobile-first at 390px, one accent colour, visible focus
   states, and touch targets of at least 44px because the demo is driven on a phone. Take
   back the styled components. If `frontend-design` is unavailable, say so and style it
   here to those constraints rather than silently producing something thinner.
7. Deploy via `ship-it`.
8. Write the demo script from `../../references/prototype-stack.md`, under three minutes,
   narrating decisions rather than clicks.

## Constraints that keep it shippable

- No authentication, no database, no third-party credentials. Use a persona switcher.
- All fake data in one file. All state in one store. No persistence unless the demo needs it.
- Keep dependencies minimal. Every added package is a build failure waiting for hour 23.
- If a build error appears, fix the root cause rather than adding a workaround; workarounds
  compound and the second one usually costs an hour.
- Time-box styling to twenty per cent of the budget, including the round trip to
  `frontend-design`. The budget is the constraint, not who does the work.

## What to fake and what to build

Fake authentication, payments, external APIs, ranking, notifications. Build the state
transitions of the loop, the decision points, and the empty and error states. Never fake a
claim about latency, cost or accuracy: measure it or label it an assumption.

## Output

A running app, a deployed link if requested, `README.md` with run instructions, the demo
script, and an honest limitations list stating what is real and what is simulated.
