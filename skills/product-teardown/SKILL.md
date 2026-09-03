---
name: product-teardown
description: Run a rigorous nine-layer teardown of a product in the market, covering objective function, unit economics, market structure, segments, core loop, experience walkthrough, opportunities, refusals and measurement. Use this whenever someone names a shipped product or feature and asks to break it down, analyse it or say what they would change, mentions a teardown or case, or needs one for an interview or assignment. The object is a product in the market; to attack a deliverable, use red-team.
---

# Product teardown

A teardown is an argument, not an inventory. Layer 1 constrains layer 9. If the
recommendations could have been written without the analysis, the work has failed.

Load `../../references/teardown-layers.md` before starting; it holds the nine layers,
the arc rule, the consistency checks and the depth ladder. Load
`../../references/metric-library.md` for layer 9 and `../../references/economics-library.md`
for layer 2.

## Before writing

Establish and state three things. Ask the user only if they cannot be inferred; do not
interrogate when a reasonable reading is available, state the reading and proceed.

1. Which product, which market, which surface.
2. Who the audience is: an interviewer, a hiring panel, a team, or the user's own learning.
   This changes depth and format, not rigour.
3. Time budget. Under 30 minutes means layers 1, 2, 4, 5, 7, 8 only, and say what was cut.

Then fix the arc: objective, binding constraint, and the product's current job. Everything
downstream must trace to these.

## Procedure

1. **Research before opinion.** If web access is available, gather: recent product changes,
   pricing, public financials or funding, competitor moves, regulatory events, and any
   published metrics. Mark each fact as sourced. Where a number cannot be sourced, derive
   it and label it derived. Never present an invented number as a fact.
2. **Walk the layers in order.** Do not skip ahead to opportunities. If an idea arrives
   early, park it in a list and return to it at layer 7, then check whether the analysis
   actually supports it. Ideas that do not survive that check are the most instructive
   thing in the teardown; note two of them as rejected.
3. **Layer 6 requires evidence of use.** If the user has used the product, ask for their
   observations and use them. If not, say the walkthrough is reconstructed from public
   material, and reduce the confidence of claims that depend on it.
4. **Three opportunities, no more.** Each with hypothesis, segment, metric, magnitude with
   arithmetic, effort, risk, and door type.
5. **Refusals are mandatory.** At least one attractive idea rejected on economics, focus or
   sequencing grounds, with the reasoning.
6. **Run the eight consistency checks.** Fix contradictions rather than hiding them.
7. **Compress.** Produce a 120-second spoken version, answer first. If it cannot be
   compressed, the argument is not yet clear.

## Depth requirements

An adequate teardown reaches rung 4 of the depth ladder on most claims and rung 7 on the
top recommendation. Push past the first plausible explanation at least once per layer by
asking what the alternative was and why it lost.

Specific depth moves that separate strong work:
- Name the constraint that explains a weakness, rather than calling it an oversight.
- Show where two of the company's own metrics are in tension and which one is winning.
- Identify a decision that looks wrong but is correct given the constraint, and say so.
- Quantify one thing everyone else describes qualitatively.
- Say who bears an unpriced cost: workers, merchants, low-income or low-trust users. Price
  it in rather than noting it as a caveat.

## Output

Markdown file using `../../templates/teardown.md`. End with a self-score against
`../../references/rubrics.md`, the verdict, and the single highest-leverage fix. Then offer,
without doing it unasked: a metric tree via `metric-architecture`, a counterfactual analysis
via `decision-forensics`, or a prototype of the top recommendation via `prototype-build`.
