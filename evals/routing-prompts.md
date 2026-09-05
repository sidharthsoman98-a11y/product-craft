# Routing eval set

Twenty prompts for checking that a plain-language request reaches the right skill without
the skill being named. **This is the input to a routing test, not a routing test.**

## Why this is a file and not a harness

`claude plugin eval` would run this: it takes cases under an eval dir, supports a
`tool_used: Skill` grader that records whether a skill fired, and accepts a path target, so
it could test the working tree rather than the installed copy. **It is gated.**
`claude plugin eval init --bare` exits 1 with "`plugin eval` is currently in early access"
and writes nothing, on this account as of 2026-09-05. `skill-creator`, which the build plan
named for this step, is not installed either.

So there is no harness, and none was invented. The set is recorded here so that:

- the live check can be run by hand, a prompt at a time, in a fresh session;
- it is repeatable by a contributor who wants to know they have not broken routing, which
  is what plan section 8 item 4 asks for;
- it is ready to become eval cases the day the command opens up.

**A static check against `references/routing.md` and the skill descriptions is not a
substitute.** It can find a collision in the wording; it cannot tell you what the router
actually does. Anything below marked as a concern is a hypothesis until a live run confirms
it, and the live run cannot happen before the merge, because the installed plugin is pinned
at v1.1.0 and a pre-merge session loads that cache regardless of the working tree.

**Durations in these prompts are the stimulus, not data.** "20 minutes" is the signal being
tested — a time budget attached to a question is what should push a request toward interview
prep — and carries no claim about the world.

## The set

| # | Prompt | Mode | Archetype | Should reach |
|---|---|---|---|---|
| 1 | Orders per dark store dropped last week in Bangalore. What happened? | Employee | Consumer | `rca` |
| 2 | Our UPI success rate fell after Tuesday's release. Walk me through the diagnosis. | Employee | Fintech | `rca` |
| 3 | Settlement volumes are down against last month and nobody knows why. | Employee | Fintech | `rca` |
| 4 | Drill me on an RCA round for a quick-commerce company, 20 minutes. | Interview prep | Consumer | `drill` |
| 5 | Run me a mock product sense round, Flipkart style, 30 minutes. | Interview prep | Consumer | `drill` |
| 6 | Give me a live 25-minute guesstimate round and score me at the end. | Interview prep | Either | `drill` |
| 7 | Write the tickets for adding retry-with-backoff to a webhook consumer. | Employee | Fintech | `platform-integration` **and** `ticket-writer` |
| 8 | A partner is going live next month. What do we need to agree on the API contract? | Employee | Fintech | `platform-integration` |
| 9 | Our reconciliation breaks are piling up between our ledger and the PSP's. How should this work? | Employee | Fintech | `platform-integration` |
| 10 | What's the difference between a git rebase and a merge? | — | — | **No pack skill** |
| 11 | Summarise this CSV of my expenses by month. | — | — | **No pack skill** |
| 12 | I have a take-home from a payments company due tomorrow, here is the brief. | Assignment | Fintech | `orchestrate` → `interview-sprint` |
| 13 | I've been given a take-home teardown of Swiggy Instamart, due Sunday. Where do I start? | Assignment | Consumer | `orchestrate` → `interview-sprint` → `product-teardown` |
| 14 | How would you measure whether our new merchant onboarding flow worked? | Employee | Fintech | `metric-architecture` |
| 15 | Is charging a convenience fee on UPI allowed? | Employee | Fintech | `compliance-guard` |
| 16 | How many UPI transactions happen in India in a day? | Interview prep | Fintech | `market-sizing` |
| 17 | Write the SQL for weekly retained buyers by city. | Employee | Consumer | `analytics-sql` |
| 18 | Riders are idle in the mornings and short in the evenings in this zone. | Employee | Consumer | `marketplace-ops` |
| 19 | The pricing test came back flat. Do we ship it? | Employee | Either | `experiment-readout` |
| 20 | We're rolling out the new checkout to a small percentage next week. What's the plan for day one? | Employee | Either | `launch-plan` |

Coverage: eleven employee, five interview prep, two assignment, two that should reach
nothing. Six consumer, nine fintech, three either. Three each for `rca`, `drill` and
`platform-integration`, which are the skills whose boundaries are most contested.

## Static check, 2026-09-05

Read against each skill's description and its applicability test in `routing.md` section 3.
Sixteen of the twenty have a decisive trigger with no competing skill. Four do not.

**Prompt 7 — the known two-skill failure.** `V2-BUILD-PLAN.md` section 6 names this exact
prompt and requires both skills to fire. The wording works against it: `platform-integration`
ends "Decomposing the work into user stories is ticket-writer", and the prompt asks for
tickets, so the description points the router away from the skill that owns retries and
idempotency. Scenario 15 routes sprint items to `ticket-writer` with no integration step, and
scenario 13 routes integrations to `platform-integration` with `ticket-writer` conditional —
neither covers tickets *for* an integration change. **Fixed**: see the commit for prompt 7.

**Prompt 6 — `drill` against `market-sizing` on "guesstimate".** Both descriptions claim the
word. `drill` should win on "live", "round" and "score me at the end", and its skip test
distinguishes a live performance from a finished artefact. Left unchanged: the collision is
real but the prompt carries three signals to one, and editing `market-sizing` on a hypothesis
risks breaking routing that works. **Watch on the live run.**

**Prompt 11 — false positive risk on `analytics-sql`.** "Summarise by month" is aggregation,
and the skill fires on "how a number would be calculated". No SQL, no product metric and no
warehouse are in the prompt, and its skip test — the number already exists and is trusted —
does not obviously catch this. **Watch on the live run.** If it fires, the fix is a skip test
naming a file the user brought, not a metric the product owns.

**Prompt 3 — `rca` against `platform-integration` on "settlement".** `platform-integration`
lists settlement among its triggers; `rca` owns a number that has moved. Both firing is
defensible here and is not a failure. **Watch that `rca` leads**, since the fact base has to
be pinned before anyone theorises about the rail.
