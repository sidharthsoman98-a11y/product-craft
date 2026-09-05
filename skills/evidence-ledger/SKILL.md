---
name: evidence-ledger
description: Keep verified facts about companies and markets in the workspace between sessions, so the next run reuses what the last one proved rather than rebuilding it differently. Use when researching a company or market, gathering facts before a teardown, case or brief, when asked what is already known about a named company, when recording or updating what a session learned, or when checking whether a stored fact is still current. It stores and retrieves facts; analysing them is the skill asked for.
---

# Evidence ledger

Every run gathers facts and throws them away. The second run on the same company pays the
same research cost again and arrives somewhere slightly different, because a different
search on a different day found a different number. **Two runs producing contradictory
figures about one company is not a memory problem, it is a credibility problem** — and it
surfaces in the room, where the person asking has both documents.

This skill is the store. It reads `knowledge/` before anything reaches for the web, and
writes back only what was verified.

Load `../../references/sources.md` before using it. Section 1 is the source hierarchy every
stored row carries, section 3 is the recording form, section 4 is staleness, and section 6
is what to do with a fact that cannot be sourced at all. This skill does not restate any of
them; it is where their output is kept.

## What this is not

- **Not `discovery-brief`'s evidence ledger.** That is a table of claims about *users*,
  classed by how they were learned — measured, observed, reported, inferred, assumed — and
  it travels with one idea into its PRD. This is a durable store of *published external
  facts* about named companies, markets and regulations, and it outlives every idea that
  reads it. Same word, different object. A discovery ledger is written once per idea; this
  file is appended to for as long as you follow the company.
- **Not analysis.** It does not decide what a fact means, whether the business works, or
  what to build. It answers "what do we already know, and how sure are we", then gets out of
  the way. If the answer requires a judgement about the fact, that is the skill that was
  asked for — `product-teardown`, `unit-economics`, `rca` — reading from here.
- **Not a research skill.** It does not run the search. It says what still needs one.

## 1. The `knowledge/` convention

**One file per company or market, in the workspace, never in the pack.** `knowledge/` sits
alongside `cases/`, `teardowns/`, `prototypes/`, `drills/` and `outputs/` in the folder where
you do product work. It is not in this repository and must not be: **the pack is shareable
and the research is yours.** That is D7 applied to facts — the public pack stays generic,
and everything company-specific lives in your workspace or the private overlay.

Name files `knowledge/<slug>.md`: `knowledge/razorpay.md`, `knowledge/quick-commerce-india.md`.
A market file holds what is true of the category; a company file holds only what is true of
that company. When a fact would sit equally well in either, it belongs in the market file,
and the company file points at it — otherwise the same number is maintained in five places
and diverges in four of them.

### File structure

```markdown
# <Company or market>

One line: what this is, and why you are following it.

## Claims

| ID | Claim | Source class | URL | Checked | Confidence |
|----|-------|--------------|-----|---------|------------|
| K1 | <the claim, stated so it can be true or false> | Tier 2, annual report | <url> | 2026-09-05 | Verified |

## Derivations

**D1 — <what the number is>.** Value, then the arithmetic, then the inputs by ID.
Every input is a K-row or a stated assumption. An assumption is labelled as one.

## Contradictions

**C1 — <the claim in dispute>.** Both readings, both dates, both sources, and which is
preferred with the reason.

## Open questions

What was wanted and could not be sourced. One line each, with what would answer it.
```

Six fields on every claim, and none of them is optional:

- **ID.** Stable, never reused. Derivations and contradictions point at rows by ID, so a row
  that is edited in place silently changes every number built on it.
- **Claim.** Written so it could be false. "Large merchant base" cannot be checked next
  quarter; a stated figure with its period and unit can.
- **Source class.** The tier from `sources.md` section 1, plus what the document was — "Tier
  2, DRHP" rather than "Tier 2". The tier carries strength, the document carries scope.
- **URL.** Where it was read. If the page will not survive — a job posting, a pricing page —
  archive it and store the archive link, per `sources.md` section 5.
- **Checked.** The date *you* read it at that URL. Not the document's date, not today's date
  by default. This field is what section 4 acts on, so a wrong date disables the flag.
- **Confidence.** Exactly three values, and they describe your reading, not the source:
  - **Verified** — you opened the cited source and read the claim there.
  - **Derived** — computed here from other rows. Requires a Derivations entry.
  - **Uncertain** — believed, not confirmed; or flagged stale and not yet re-checked. An
    Uncertain row may be used, but it must be marked uncertain wherever it is quoted.

There is no "reported" value, because source strength is already the source class. Two
scales for one property is how they drift apart.

## 2. Read before search

**Any skill that needs a fact about a named company, market or regulation opens
`knowledge/<slug>.md` first, and searches only for what is missing or stale.** Not after the
first search, not as a fallback when the search is thin. First.

The order:

1. Open the file. If none exists, say so and create it at write-back, not now.
2. List what it covers against what this run needs. Three buckets: **held** (Verified, inside
   90 days), **stale** (flagged by section 4), **missing**.
3. Search for the stale and the missing only.
4. **Say which is which in the output.** One line is enough — held from the store, re-checked
   today, newly found. A reader who cannot tell a fact read in March from one read this
   morning has to re-verify all of them, which costs more than the run saved.

**The cost of skipping this is not the wasted search.** It is that two runs on the same
company produce different numbers, and neither cites the other, so there is no way to tell
which one is wrong without redoing both. The store exists so that the second run either
agrees with the first or records a contradiction on purpose — and the second of those is a
finding, per section 5.

## 3. Write after verify

**Only verified facts are stored.** A number that survived one search and no source check is
not a fact yet; it is an open question, and it goes in Open questions where the next run will
see it and finish the job. **Storing an unchecked claim is worse than not storing it**,
because the store's whole value is that reading from it can be trusted without re-reading the
source — an unverified row spends that trust on something that never earned it.

Write back at the *end* of a run, not as you go: mid-run facts are still provisional, and a
claim you abandon in step 4 should never have been written in step 2.

Rules:

- **Source class from `sources.md` section 1, on every row.** A row without one is the same
  blocking error there as anywhere else in the pack, and here it is worse, because the store
  is read later by someone — you — who no longer remembers where it came from.
- **A derived number is stored with its derivation, not just its value.** The arithmetic, the
  input IDs, and every assumption labelled as an assumption. A value alone cannot be
  re-checked when one of its inputs changes; with the derivation, it can be recomputed in a
  minute. This is the same rule `sources.md` section 6 applies to unsourceable numbers, kept
  after the run rather than only inside it.
- **Never store a fact you could not open.** If the tier 3 article is all you have and the
  tier 1 original was not reachable, the row is Uncertain and the Open questions entry names
  the original you still need.
- **Store the negative results too.** "Checked the pricing page on this date, no published
  figure for this tier" saves the next run the same failed search, and it is a fact.

## 4. Staleness, per D5

**Flag any row over 90 days old at read time.** Per D5, facts carry a date so that the reader
sees age without asking for it. The flag is raised when the file is read, not on a schedule —
nothing runs in the background, and a fact only matters when something is about to use it.

Fastest-decaying claim types, which is the order to re-check them in: **regulation, market
share, pricing, org structure, product surface.** `sources.md` section 4 holds the full decay
table with the reason for each, and this list is a pointer to it rather than a second copy.
Two of them override the 90-day floor:

- **Regulation is re-checked at use, every time, whatever its date says.** Circulars,
  transition deadlines and staged commencement move faster than the flag.
- **Product surface is checked by opening the product**, not by re-reading the page you cited
  about it.

**A flagged fact is never deleted.** Deleting it loses the fact that it was once true, which
is what section 5 is built on. Do one of two things:

- **Re-verify.** Open the source again, update the Checked date, and — if the value moved —
  record a contradiction rather than overwriting.
- **Mark it Uncertain**, and say so wherever it is quoted. A stale fact used knowingly and
  labelled is honest work. A stale fact used silently is the failure this whole file exists
  to prevent.

## 5. Conflict handling

When a new source contradicts a stored row: **record both, with both dates. Do not
overwrite.**

The Contradictions entry carries both readings, both sources with their classes, both dates
checked, and one line saying which is preferred and why. The preference rule is already in
`sources.md` section 1 — the higher tier wins, and the disagreement is worth saying out loud.
Where both are the same tier, the later date wins, and that is a *change over time*, not a
correction. Say which of the two you are looking at:

| What happened | What it means | What to write |
|---|---|---|
| Higher tier disagrees with lower | The lower one was wrong | Prefer the higher; keep the lower with its date so the next run does not re-find it and re-believe it |
| Same tier, later date, different value | The number moved | Both rows stand. The movement is the finding |
| Same tier, same period, different value | Definitions differ | Neither is preferred until you find the definitions. Usually consolidated versus standalone, gross versus net, or a different year convention |

**The history of a changing number is often the finding.** A take rate that fell across three
filings says more about the business than the current one does, and it is invisible to anyone
who overwrote the first two. This is the single strongest argument for the store existing at
all: a run that only ever holds today's number cannot see a trend, and trends are where the
interesting questions are.

## 6. What never goes in `knowledge/`

Three exclusions, and they are absolute:

- **Nothing confidential from an assignment brief.** A take-home contains the company's data
  and usually says so. It stays in `cases/<assignment>/`, where it is obviously scoped to the
  thing it came with, and it never becomes a durable fact about the company.
- **Nothing from an employer.** Internal figures, roadmaps, incidents, conversations. Not
  paraphrased, not "the rough shape of it", not as an unattributed number. Per D7, employer
  domain knowledge lives in the private overlay, and even there it is not published research.
- **Nothing that would make the file unshareable.** This is the test that catches what the
  first two miss, so apply it to the file as a whole: **if you handed `knowledge/<slug>.md`
  to the company it is about, is every row something they could already have read?** If any
  row is not, it does not belong here.

The exclusions are strict because the store's value depends on being able to reuse it without
re-auditing it. A file you have to check for confidential material before every use is a file
you will eventually forget to check.

## Output

When this skill runs on its own — "what do we know about X" — the output is the three
buckets: held, stale, missing, with the stale rows named and their ages. Not the file dumped
back.

When it runs inside another skill, the output is one line before the work starts saying what
came from the store, and one write-back after the work ends saying what was added. Everything
between those two lines belongs to the skill that was asked for.
