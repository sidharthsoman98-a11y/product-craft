# Sources and the verification protocol

`references/role-packs.md` and `references/india-context.md` both defer their verification
rules to this file. It carries the hard constraint, and it is short on purpose so that
there is no excuse for not having read it.

The constraint, stated once: **a factual claim about a company, a market or a regulation
carries a source class, a URL where one exists, and the date it was checked. A claim
without a source class is an error, not a stylistic lapse.** It is an error because the
reader cannot tell the difference between something verified last week and something
remembered wrongly, and in a room the person asking usually knows which it is.

## 1. Source hierarchy

Strongest first. Where two sources disagree, the higher tier wins and the disagreement is
worth saying out loud.

**Tier 1 — primary regulatory and network publications.** RBI circulars, master directions
and bulletins; NPCI monthly statistics and circulars; SEBI filings and regulations; TRAI
reports and releases. These are the only acceptable source for a regulatory threshold, a
rate, a deadline, or a national transaction statistic. They are authoritative, dated and
citable, and they supersede any reporting about them.

**Tier 2 — company primary material.** Annual reports, DRHPs and prospectuses, MCA filings,
investor presentations and earnings materials, engineering and product blogs, official
documentation and public pricing pages. Authoritative about the company, but it is the
company speaking: filings are audited and conservative, blogs and investor decks are
selective. Note which kind you are quoting. A published job description sits here.

**Tier 3 — credible secondary reporting.** Established business and technology press
working from filings, regulatory releases or named sourcing. Useful for context, chronology
and for pointing you at the primary document. Never the final source for a number when a
tier 1 or tier 2 original exists — find the original and cite that instead.

**Tier 4 — interview and JD aggregators.** Aggregated interview reports and job-listing
sites. Genuinely useful for loop structure, round sequence and recurring question patterns,
which are otherwise unpublished. Self-selected, unverifiable, often stale, and skewed
towards people who did not get the offer. Treat as evidence about *process*, describe it as
reported, and never as evidence about the company's numbers or strategy.

**Tier 5 — community forums.** Reddit, Discord, Blind, comment threads. Signal about
process, sentiment and what it is like to work somewhere. Not fact. Never cite for a
number, a policy or a claim about a named person. Useful mainly for generating a question
to verify elsewhere.

## 2. Never from memory

Look these up every time, without exception, however confident you feel. Confidence is not
correlated with accuracy on any of them, because all of them change and none of them
announce that they have changed.

- **Any regulatory threshold, rate, limit or deadline.** Including anything you believe you
  learned recently. Transition periods and staged commencement make "I read it last month"
  actively dangerous.
- **Market share, of anything.**
- **Transaction volumes and revenue figures**, for a company or a rail.
- **Pricing**, whether a company's own or a competitor's. Pricing pages change silently and
  are frequently geography-specific.
- **Anything about a person's current role.** People move, titles change, and being wrong
  about this in a room is both an accuracy failure and a discourtesy.
- **The current state of a company's product.** What is shipped, what is in beta, what has
  been withdrawn, what the flow looks like. Product surface is the fastest-decaying claim
  class there is; if the answer matters, open the product.

The general test: if the claim could have changed since you last saw it and you would not
have been told, it must be looked up.

## 3. The verification protocol

**What to check.** For each claim: does a tier 1 or tier 2 original exist, and are you
citing it rather than a report about it? Is the figure the one you think it is — same
period, same unit, same scope, same definition? Consolidated or standalone, gross or net,
calendar or financial year, and which year convention? Has it been superseded by a later
circular, a later filing or a later version of the page?

**How to record it.** Inline, in the file where the claim lives, in this form:

```
[source class, publisher, date checked YYYY-MM-DD, URL]
```

Compress to the source class alone in prose where a full citation would break the line, and
keep the full entry in the file's citation table. Both `role-packs.md` and
`india-context.md` use the compressed form in the body; section 5 below is where the full
entries live for `role-packs.md`.

**The convention, restated because it is the point of this file:** every factual claim about
a company carries a source class, a URL where one exists, and the date checked. A claim
without a source class is an error. Treat an unsourced claim in a review the way you would
treat a failing test — not as something to tidy later, but as a thing that blocks.

**What is exempt.** Structural and analytical claims that are not about a specific company:
how a funnel decomposes, why blended rates mislead, what a trust ladder is. These are the
pack's own reasoning and need no citation. The line is whether a named party could dispute
the claim as a matter of fact.

## 4. Staleness, per D5

Facts carry a date. **Flag anything over 90 days old at read time**, and re-verify before it
enters a deliverable rather than after someone questions it.

Decay rates differ by claim type, fastest first:

| Claim type | Decays | Notes |
|---|---|---|
| Regulation | Fastest | Circulars, transition deadlines, staged commencement. Quarterly movement is normal. Re-check every time, regardless of the 90-day flag |
| Market share | Fast | Also redefined as often as it is restated. Check the definition, not only the number |
| Pricing | Fast | Changes silently, no announcement, often geography-specific |
| Org structure | Fast | Reorganisations, role changes, team ownership. Anything about a named person is in this row |
| Product surface | Fast | What is shipped, in beta, or withdrawn. Open the product rather than citing a page about it |
| Company strategy statements | Medium | Direction is announced then quietly revised |
| Job description content | Medium | Postings are reused, so a charter is durable, but the posting itself may be withdrawn — archive it when you cite it |
| Interview loop structure | Medium | Changes with hiring cycles and volume |
| Market structure and behaviour | Slow | Devices, language, trust, seasonality, informal alternatives |

The 90-day flag is a floor, not a licence. Regulation is re-checked at use, not at 90 days.

## 5. Live citations for role-packs.md

Every company claim currently asserted in `references/role-packs.md`, with its source class.
**URLs are outstanding — the TODO markers are the work.** Compiled September 2026; each row
needs its own date-checked stamp when the URL is filled, replacing the compilation date.

| # | Claim as asserted | Where | Source class | URL | Date checked |
|---|---|---|---|---|---|
| 1 | Swiggy PM I supply-chain charter: dark store workforce management, gig picker and in-store staff tooling, compliance flows, order fulfilment, packaging workflows, inventory systems; judged on picker productivity, fulfilment SLAs and unit economics | Consumer §1, §2 | Published JD (tier 2) | TODO | Compiled 2026-09 |
| 2 | Flipkart PM charter: strategy and roadmap across use cases and internal businesses, balancing short-term commercial goals against long-term platform development | Consumer §1, §6 | Published JD (tier 2) | TODO | Compiled 2026-09 |
| 3 | Razorpay platform charter: settlement, reconciliation, risk decisions and APIs other teams and billions of transactions depend on | Fintech §1 | Published JD (tier 2) | TODO | Compiled 2026-09 |
| 4 | Razorpay merchant onboarding and KYC automation as a separate charter | Fintech §1 | Published JD (tier 2) | TODO | Compiled 2026-09 |
| 5 | Razorpay regional charter: translating local regulatory requirements and merchant pain points into product requirements | Fintech §1 | Published JD (tier 2) | TODO | Compiled 2026-09 |
| 6 | Consumer loop structure and question patterns: screen, marketplace analytics problem-solving round, onsite of product sense / analytics / strategy / behavioural, leadership round; RCA on order-volume drop, RCA on delivery time against promise, three-sided trade-offs | Consumer §5 | Interview process page and aggregated interview reports (tier 4) | TODO | Compiled 2026-09 |
| 7 | Fintech loop structure: SQL and sometimes Python rounds covering window functions, joins and CTEs; guesstimates and logic puzzles; managerial case rounds; accuracy, edge cases, audit trails and regulatory awareness assessed throughout | Fintech §5 | Interview process page and aggregated interview reports (tier 4) | TODO | Compiled 2026-09 |
| 8 | Swiggy and Razorpay restructuring around AI in product and operating models | Shared close | Company statements and press coverage (tier 2 / tier 3), marked **Uncertain** in role-packs | TODO | Compiled 2026-09 |

Three things to fix while filling these in, not after:

- **Rows 1 to 5 are tier 2 and archivable.** A job posting disappears when the role closes,
  so archive the page at the moment you cite it and record the archive URL alongside.
- **Rows 6 and 7 are tier 4** and must stay described as reported. Row 7's loop evidence was
  compiled from Paytm process material while the fintech archetype is written Razorpay-shaped.
  **Resolved:** `role-packs.md` now qualifies the fintech loop section as drawn from published
  process material across comparable Indian payments companies rather than any single
  employer, with specifics varying by company and charter, so it no longer reads as
  Razorpay's. Keep that qualifier if the row's URL is later filled with a single-company
  source, or narrow both together.
- **Row 8 is the weakest row in the pack.** It is marked Uncertain in `role-packs.md` and
  should stay marked until a tier 2 original — an investor presentation, an annual report or
  a company blog — replaces the press coverage.

## 6. When you cannot source a claim

You will sometimes need a number that is not published: an internal conversion rate, a cost
line, a COD share. The answer is never to assert it and never to drop the analysis. Do all
three of the following:

1. **State the uncertainty in the same breath as the claim.** "This is not published, so I
   am estimating" costs one sentence and buys the room's trust for everything else you say.
2. **Give the derivation or the range.** Either build the number from things that *are*
   sourceable and show the arithmetic, or give a plausible range with the reasoning for both
   ends. A range with a stated method beats a point estimate with none. Say which assumption
   the answer is most sensitive to, and what you would do differently at each end of the
   range — that is usually the more useful answer anyway.
3. **Never let an unsourced number carry a recommendation alone.** If the recommendation
   changes when the estimate moves within its own range, the recommendation is not ready.
   Say what you would need to see, and how you would get it, before committing.

Naming the number you would ask for first is a strong answer. Inventing it is disqualifying,
and it is disqualifying in exactly the rooms you most want to be in, because those are the
rooms where somebody has the real figure.
