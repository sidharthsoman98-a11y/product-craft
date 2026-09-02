# Teardown layers

The nine layers of a product teardown, in order. The order is the argument: each layer
constrains the next, and the value of a teardown comes from that chain holding together.
An analysis where layer 7 could have been written without layers 1-6 is a list of opinions.

## The arc rule

Before writing anything, fix these three sentences. Everything downstream must be
traceable to them.

1. **The company is optimising for X this year** (growth, margin, defensibility, category
   expansion, regulatory survival, an exit).
2. **The binding constraint is Y** (supply, capacity, trust, distribution, unit economics,
   regulation, talent, capital).
3. **Therefore the product's job right now is Z.**

If your recommendations at layer 7 do not serve Z under constraint Y, the teardown is
internally inconsistent, and a good interviewer will find it in one question.

---

## Layer 1: Context and objective function
- Who owns this product, in which market, at what stage of maturity.
- What the company has publicly committed to, and what its incentives suggest instead.
- Which of the five postures it is in: land grab, monetisation, defence, expansion, retreat.
- What "winning" means at this stage, in one measurable sentence.
- What has changed in the last twelve months that makes this question live now.

## Layer 2: Business model and economics
- Revenue lines, ranked. Which is real today and which is a story for later.
- The contribution stack (see economics-library.md). Where money leaks per unit.
- Who subsidises whom: across sides, across categories, across cohorts, across geographies.
- Capital intensity and the shape of fixed cost. Does scale help or just multiply losses.
- The one number that decides viability, and its break-even value.

## Layer 3: Market structure and competition
- Where value pools sit in the chain and who currently captures them.
- Substitutes, including the informal or manual alternative, which is usually the real
  competitor in emerging markets.
- Switching costs in both directions. Multi-homing behaviour on each side.
- Which moat is actually operating: scale economies, network effects, switching costs,
  brand, cornered resource, process. Name it and say how you would test whether it holds.
- Where regulation sets the boundary of what is buildable.

## Layer 4: Users, segments and jobs
- Two or three segments defined by behaviour and job, never by demographics alone.
- For each: the job to be done, the trigger, the current workaround, and what they give up
  to switch. The workaround is the benchmark you must beat, not the competitor's app.
- Forces of progress: push away from the status quo, pull of the new, habit inertia,
  anxiety about the new. Most adoption failures are anxiety and habit, not features.
- The non-consumer: who should use this and does not, and what blocks them. This is where
  most growth headroom actually sits.

## Layer 5: The core loop and the growth engine
- Write the loop as text: trigger, action, reward, investment, and what makes the next
  turn more likely than the last.
- Identify the compounding term. If nothing compounds, growth is bought, not earned, and
  the economics must carry it forever.
- The growth engine: viral, paid, content, sales-led, embedded, or distribution-partnered.
  Name which one is actually running, not which one the company talks about.
- The rate-limiting step in the loop, with the evidence that points to it.
- Cold-start status: which side is hard, what the atomic network is, and whether the
  product has escaped its cold start in each new market or restarts it every time.

## Layer 6: Experience walkthrough
- Walk the primary flow end to end, screen by screen, on the device tier and network the
  real user has, not on a flagship phone on office wifi.
- For each friction point record: what it costs the user, which metric it moves, and the
  charitable explanation for why a competent team shipped it. Give the charitable reading
  first. Assuming incompetence is the fastest way to sound junior.
- Note the deliberate friction: confirmation steps, KYC, risk checks. Friction that
  protects trust or satisfies regulation is not a bug.
- Cover the unhappy paths: failure, retry, refund, dispute, support, account recovery.
  In payments and commerce, the unhappy path is the product.
- Cover the first-run experience separately. Onboarding is a different product.
- Note what the interface reveals about internal structure: which team owns which surface,
  where the seams are, what is bolted on.

## Layer 7: Opportunities
Three, no more. For each:
- Hypothesis, in falsifiable form: "if we do A, B will change because C".
- Which segment and which loop step it touches.
- The metric it moves, its baseline, and an expected magnitude with the arithmetic shown.
- Effort in engineering weeks and the dependency that could stall it.
- The risk it creates, including the guardrail it might breach.
- Whether it is a one-way or two-way door.

## Layer 8: Prioritisation and the refusals
- Explicit criteria with weights, chosen for this situation and defended.
- The ranking, and one sentence on what would reorder it.
- **What you would not build, and why.** Mandatory. Include at least one attractive,
  popular idea that you are rejecting on economics, focus or sequencing grounds. This
  section is where the analysis stops being a feature wishlist.
- Sequencing: what must be true before the second item can start.

## Layer 9: Measurement and the pre-mortem
- The metric tree for the top recommendation, with a guardrail and a decision rule
  written before the data arrives.
- Pre-mortem: it is twelve months later and this failed. Name the three most likely causes
  and the earliest observable signal for each.
- The cheapest test that would kill the idea in two weeks.

---

## Internal consistency checks

Run these before presenting. Each is a real interviewer follow-up.

1. Do the recommendations serve the objective named in layer 1, under the constraint in
   layer 1? If retention is the diagnosis, acquisition features are inconsistent.
2. Does the segment in layer 7 match a segment defined in layer 4, by name?
3. Does the metric in layer 9 appear in the decomposition, and does the claimed magnitude
   fit the size of that segment? A 40% lift on a 2% segment is a rounding error.
4. Does the economics in layer 2 permit the recommendation? A margin-negative business
   cannot afford a discount-driven fix.
5. Does the recommendation respect the binding constraint, or does it assume the constraint
   away? Assuming away capacity, supply or regulation is the most common fatal error.
6. Is the moat claim in layer 3 consistent with the loop in layer 5? If you claim network
   effects, the loop must contain a term that improves with users.
7. Have you priced the trade-off? Every recommendation costs something. If nothing is
   sacrificed, you have not made a decision.
8. Could a competitor copy this in a quarter? If yes, say so and explain why it is still
   worth doing, or drop it.

## Depth ladder

Use to push past a surface answer. Each rung is a question an interviewer asks when the
previous answer was adequate but shallow.

1. What is happening? (observation)
2. Why is it happening? (mechanism)
3. Why did they choose that mechanism over the obvious alternative? (constraint)
4. What would have to be true for that choice to be right? (assumption)
5. How would you test whether it is true? (evidence)
6. What breaks if it is false? (risk)
7. What would you do differently, and what does that cost? (decision)
8. How would you know within a month that you were wrong? (feedback)

Aim to reach rung 7 on your top recommendation and rung 4 on everything else. Reaching
rung 8 on the top recommendation is what a strong hire sounds like.
