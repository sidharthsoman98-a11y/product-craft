# Build decisions — v2.0.0

Ten decisions that shape the pack. Each one closed off an alternative that a future
contributor might otherwise reopen, so the rationale column is the point of this file.
Amend a row rather than silently reversing it.

| ID | Decision | Choice | Rationale | Date |
|---|---|---|---|---|
| D1 | Role pack content | Public sources only — written from published job descriptions and interview reports, not personal experience | Keeps the pack shareable and unblocked; personal depth belongs in the private overlay plugin (D7) | 2026-09-03 |
| D2 | Coverage ledger scope | Scoped to the mode's candidate skills, not all 24 every time | An exhaustive ledger stops being read, and a ledger nobody reads cannot audit anything | 2026-09-03 |
| D3 | rca | Split into its own skill; the diagnosis section is removed from metric-architecture entirely | One home for the method. Both skills read the diagnostic playbook in `references/metric-library.md` | 2026-09-03 |
| D4 | Drill scoring | Score plus trend across stored runs in the workspace | Recurring failures matter more than any single score | 2026-09-03 |
| D5 | Knowledge staleness | Facts in `knowledge/` carry a date; anything over 90 days is flagged at read time | Payments regulation moves quarterly | 2026-09-03 |
| D6 | Ambiguous mode | Ask once, in one line, then proceed | — | 2026-09-03 |
| D7 | Public and personal | Public pack stays generic; personal story bank, employer domain knowledge and company notes live in a separate private overlay plugin that installs alongside | The shareability constraint in D1 — personal material cannot ship in a public pack | 2026-09-03 |
| D8 | Command prefix | Keep `/product-craft:` | Collisions are worse than typing | 2026-09-03 |
| D9 | Slippage | If a day slips, cut job-side skills | Protect the interview-side skills | 2026-09-03 |
| D10 | Monday acceptance | The three prompts in `V2-BUILD-PLAN.md` section 6 | All three must pass in a fresh session | 2026-09-03 |
