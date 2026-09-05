# <Feature> — ticket set

Traces to: `<spec or integration design, and the section within it>`
Decision this implements: <one line, from the written decision>

## Slices, in shipping order

| # | Slice | Genuinely usable on its own? | Riskiest unknown it resolves |
|---|---|---|---|
| 1 | | the first slice must be yes | |

A slice that is not usable on its own is a stage, not a slice. Say so and merge it.

---

## Ticket <n>: <user-visible outcome as the title>

**Story.** As a <specific role, not "user">, I want <need, not solution>, so that
<the outcome that makes it worth building>.

**Traces to:** <the stated user problem or contract clause in the spec>

**Acceptance criteria** — each one testable by a stranger with no context:

| # | Given | When | Then |
|---|---|---|---|
| 1 | | | |

**Edge cases.** Every row is specified or explicitly ruled out with a reason. An empty
cell is an unanswered question, not an omission.

| Case | Behaviour | Ruled out because |
|---|---|---|
| Failure | | |
| Retry | | |
| Reconciliation | | |
| Empty state | | |
| Permission or eligibility denied | | |
| Concurrent or duplicate action | | |
| Partial success | | |

**Dependencies**

| On | Owner | Needed by | Blocking? |
|---|---|---|---|

**Definition of done.** Applied, not assumed — tick each or say why it does not apply:
instrumented and verified firing; unhappy paths handled; support able to answer the
predictable question; rollback available; documented where the next person will look.

**Not in this ticket:** <what a reader would reasonably assume is included and is not>

---

## Handoffs

Contract detail to `platform-integration`. Regulatory obligations to `compliance-guard`.
The document above these tickets to `spec-writer`. Sprint scoping and capacity to the
external `product-management:sprint-planning` skill.
