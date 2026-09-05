# Findings register

## Why this file exists

The F-series was raised in repo audits whose output lived only in chat. Nothing in the
repository held it, so the numbers were cited in commit messages and in instructions while
being unreadable to anyone — including a later session — who had only the repo.

That failed on 2026-09-05. An instruction said work would close **F4**; F4 appears in no
tracked file and in no commit message on any branch, so it could not be checked and the
step stopped. The text below was then supplied by the repository owner from the original
audit. This file exists so that cannot recur.

## What this register is, and is not

**Reconstructed after the fact.** Every entry below except F4 was recovered from the body of
the commit that raised or fixed it. That is the only durable record that existed.

**Therefore incomplete, and knowably so.** A finding that was raised in an audit but never
mentioned in a commit message left no trace and is not here. The numbering has gaps —
F9, F11, F13, F14, F16, F17, F20, F21 — and **a gap is a finding whose text was not
recovered, not a finding that was closed.** Do not read an absent number as resolved.

**Not a substitute for the audit.** Where a commit summarised a finding rather than quoting
it, the entry below is that summary. It is faithful to the commit and may be narrower than
what was originally raised.

## The rule, from here

**Any new finding is recorded in this file before it is cited in an instruction, a commit
message or a plan.** A finding that exists only in a conversation cannot be verified by the
session that is asked to act on it, and per `CLAUDE.md` that session is required to stop —
which is the correct behaviour and an expensive way to discover that the register was
missing. Recording it here first costs one line.

Add the number, the text as raised, the severity if one was given, the owning step if one is
known, and the status. Update the status in the commit that closes it.

## Register

Status is **Closed** only where a commit shows the fix. "Fixed in" names that commit.
Owning step is recorded only where a commit or the build plan names one.

| # | Finding, as recorded | Severity | Owning step | Status | Fixed in |
|---|---|---|---|---|---|
| F1 | `skills/rca` shipped with "Score against `references/rubrics.md`" while the artefact-specific gates covered only Teardown, Metric answer, Case, PRD/PRFAQ and Prototype demo. The path resolved; the material it pointed at did not exist, so an RCA could be scored against nothing in particular | — | — | Closed | `0717fe5` |
| F2 | `rca` pointed at "section 2 when step 2 turns up a measurement candidate" without saying whose numbering. `rca`'s step 2 is the diagnostic playbook's step 1, because the playbook assumes the number has already been pinned down and `rca`'s step 1 is the pinning down | — | — | Closed | `5e9ae4c` |
| F3 | `external-skills.md`'s "Called by" column promised delegations that no skill performed — `prototype-build` to `frontend-design`, `artefact-forge` to `frontend-slides` and `theme-factory` — while all three files still carried those mechanics in-house. Had no owning step until one was created. **The commit treats F3 and F18 as one item and does not say which number covers which delegation** | — | 4.4a | Open | — |
| F4 | "`role-packs.md` and `india-context.md` open 'Loaded by role-lens'. No such skill exists." | Low | 4.2 | Closed | `v2: add role-lens skill` |
| F5 | `routing.md` said "Thirteen rows, always thirteen" while D2 scopes the ledger to the mode's candidate skills rather than the whole pack. The number had been copied into G6, `orchestrate` step 6 and `commands/run.md`, so a fifteen-skill pack was still told to print thirteen rows, and `rca` had nowhere to appear | — | — | Closed | `2ad2dc3` |
| F6 | `routing.md` scenario 3 routed to `rca` while section 3's applicability table had no `rca` row, so the ledger could never record it as applied or skipped, and the dependency graph had no `rca` node | — | — | Closed | `6557862` |
| F7 | Check 1 of `validate.sh` was advisory pending a `# routing-v2-complete` marker that does not exist, so F6 warned and the build still exited PASS. The check built to catch exactly that failure did not catch it | — | — | Closed | `6557862` |
| F8 | Day 2 required a live RCA drill on Friday, while the plan's own release sequence states the installed copy is pinned at v1.1.0 (`8cc7d95`) and that any use of the pack before the merge tests that build. Step 2.5 as written would have measured v1.1.0 and reported a result meaning nothing either way | — | 2.5 | Closed | `a71d9af` |
| F10 | D3 said the diagnosis section was "removed from `metric-architecture` entirely" while the plan said replace it with a one-line handover, which is what was built | — | — | Closed | `5e9ae4c` |
| F12 | `README.md` said fourteen skills (fifteen existed), eight reference libraries (fourteen existed) and six decomposition patterns (`metric-library` defines seven), and had no `rca` row | — | — | Closed | `5e9ae4c` |
| F15 | `decision-forensics` claimed "post-mortem" in its description, which belongs to `rca` per D3 and routing scenario 3 | — | — | Closed | `f73d621` |
| F18 | See F3. The two are recorded together in `5e3a1b1` and are not individually distinguished there | — | 4.4a | Open | — |
| F19 | D4 decides scoring is "score plus trend across stored runs in the workspace", but the workspace template defined no store, and `red-team` already promised to compare against the previous score with nowhere to read one from | — | — | Closed | `cfbdbe8` |
| F22 | The `drill` versus `red-team` boundary was decided in the build plan and never recorded as a decision, so 2.4 had nothing durable to build against | — | — | Closed | `cfbdbe8` |

## Notes on individual entries

- **F12 has drifted again.** It was closed against a fifteen-skill pack. `README.md` now
  reads "Sixteen skills, fourteen reference libraries" against twenty-four skills on disk.
  This is expected — plan section 2 item 10 gives the README update to step 4.6 — but the
  counts are wrong in the meantime, and anyone reading `README.md` before that step should
  know it. Not reopened, because the owning step already exists.
- **F19's naming convention was amended after it closed.** `cfbdbe8` specified
  `<date>-<company>-<round>.md`; `77f5671` added a run index because two rounds on the same
  day, company and round type collided and the second overwrote the first. That fix carried
  no finding number.
- **Severity was recorded only for F4**, because it is the only entry whose original audit
  text was recovered rather than reconstructed from a commit summary. The blank column for
  every other row means the severity was not preserved, not that it was low.
