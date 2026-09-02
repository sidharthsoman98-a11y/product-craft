# Decision lenses and the nudge bank

Two things live here: strategic lenses that generate non-obvious options, and the
question bank used to interrogate an idea until it becomes a buildable spec.

## Contents
1. Generative lenses
2. Strategic frames
3. The nudge bank (staged questions)
4. Counterfactual reasoning method
5. Option scoring

---

## 1. Generative lenses

Run at least five when generating options. Record which lens produced which idea, because
that provenance tells you what assumption each idea rests on.

- **Inversion.** How would you make this product fail as fast as possible? Reverse the list.
- **Constraint removal.** If capital, regulation or supply were free, what would you build?
  Then ask which of those is achievable with a partnership rather than money.
- **Constraint addition.** You have one screen, no login, no budget, and two weeks. What
  survives? This produces the sharpest wedge products.
- **The non-consumer.** Who has this problem and is not served at all? Why. What would
  make them serviceable at a tenth of the cost.
- **Job substitution.** What are people hiring today instead: a phone call, a WhatsApp
  group, a spreadsheet, a local agent, cash. Beat the workaround, not the app.
- **Unbundling.** Which single feature of an incumbent, done ten times better, is worth
  its own product? What distribution would it need to survive alone?
- **Rebundling.** Which five things does a user currently stitch together manually?
  What does owning the seam give you that owning the parts does not?
- **Workflow to system of record.** Can a tool that helps with a task become the place
  where the data lives? That transition is where durable value is created.
- **Distribution-first.** Start from an existing channel with attention or trust, and ask
  what product that channel can carry at near-zero acquisition cost.
- **10x versus 10%.** If the improvement is not an order of magnitude on the dimension the
  user cares about, switching costs will eat it.
- **Trust ladder.** For money, health and identity products, sequence features by how much
  trust each requires, and never ask for more trust than you have earned.
- **Latency and effort budget.** Cut the steps or seconds to value in half. Often the whole
  product idea.
- **Distributional lens.** Who is worse off if this succeeds? Workers, small merchants,
  low-income users, moderators. If the model depends on someone bearing an unpriced cost,
  the design is unfinished. Name the cost and price it in.

## 2. Strategic frames

- **Cold start.** Identify the atomic network: the smallest unit where the product is
  useful with no one else present. Growth is the repetition of that unit, not a national
  launch.
- **Hard side first.** In two-sided products, one side is scarce. Everything the easy side
  wants is worthless until the scarce side is served.
- **Counter-positioning.** What can you do that the incumbent cannot copy without damaging
  its existing business? That is the only durable wedge against a larger player.
- **Aggregation.** Who owns the demand relationship, and does your product deepen it or
  rent it? Renting distribution is a business until the landlord raises the rent.
- **Bundling economics.** A bundle wins when marginal cost is near zero and willingness to
  pay is heterogeneous across components.
- **Sequencing.** Almost every product strategy question is really about order, not choice.
  Ask what must be true before step two, and you will usually find the real answer.
- **Regulatory boundary.** In fintech, health and mobility, the boundary is the strategy.
  Products that respect it early and design for audit outlast products that ask forgiveness.

## 3. The nudge bank

Use in stages. Ask two or three at a time, wait for answers, then go deeper. Do not dump
the list. The point is to force a decision at each stage and record it, so the eventual
prototype is the visible consequence of a chain of choices.

**Stage 1: problem (before any solution talk)**
- Who exactly has this problem, and how often does it occur for them?
- What do they do today, step by step, including the parts they hate?
- What does the problem cost them in money, time or risk? What have they already tried?
- Why has nobody solved it? Is the reason technical, economic, regulatory or cultural?
- What has changed recently that makes it solvable now?

**Stage 2: user and job**
- Which single segment, if delighted, would carry the product to the next one?
- What is the trigger moment, and where is the user physically and mentally at that moment?
- What is the smallest promise you can make that would make them try it once?
- What would make them tell someone else, unprompted?

**Stage 3: solution shape**
- What is the one screen the product cannot exist without?
- What is the manual version you could run for ten users this week?
- What is deliberately excluded from version one, and how do you say no gracefully in the UI?
- What data must exist for this to work, and where does it come from on day one?
- What is the fallback when the intelligent part is wrong?

**Stage 4: economics and viability**
- Who pays, how much, and when in the journey?
- What does one unit cost to serve, all in?
- What has to be true for this to be contribution-positive within a year?
- What is the cheapest distribution channel available to you, and does the product fit it?

**Stage 5: risk and ethics**
- What is the worst way this is misused, and by whom?
- Who bears a cost they did not consent to: workers, merchants, bystanders, the user's data?
- What breaks at 100 times the volume?
- What is the regulatory exposure and what would a regulator ask first?
- What is the failure mode that damages trust irreversibly, and what protects against it?

**Stage 6: proof**
- What is the single riskiest assumption?
- What two-week test would kill the idea cheapest?
- What would you need to see to double down?

## 4. Counterfactual reasoning method

Used to answer "why did they build it this way" and "what if they had chosen differently".
Speculation is fine; unlabelled speculation is not. Mark every inference as observed,
inferred or assumed.

1. **Observe.** What is actually shipped, in detail. Include what is conspicuously absent.
2. **Infer the objective.** What metric would this choice maximise? Work backwards from the
   design to the incentive.
3. **Infer the constraint.** Which constraint makes the obvious alternative unavailable:
   legacy architecture, regulation, a partner contract, an org boundary, unit economics,
   a data gap, a platform policy, or simple sequencing.
4. **Reconstruct the alternatives** the team plausibly considered, and the trade each one
   loses on. There are usually three: the fast one, the correct one, and the one that
   another team would have had to build.
5. **Distinguishing evidence.** What observable would tell the alternatives apart? Release
   timing, job postings, API surface, changelog, pricing changes, support documentation,
   which surface the feature appears on first.
6. **Simulate the counterfactual.** If they had chosen the alternative: which metric moves,
   in which direction, by roughly how much, over what horizon, and what second-order effect
   follows in the next quarter. Second-order effects are where the interesting answer is.
7. **Judge.** Given the objective and constraint, was the choice reasonable at the time,
   with the information they had? Separate that from whether it was right in hindsight.
8. **Transfer.** State the rule you now hold: "in situations of type T, prefer X because Y."

## 5. Option scoring

Score options only after criteria are fixed and weighted, and pick criteria that
discriminate. If every option scores the same on a criterion, delete the criterion.

Default criteria, to be adapted rather than copied:
- Expected impact on the primary metric (magnitude x confidence)
- Strategic fit with the stated objective and constraint
- Effort and dependency risk
- Time to signal (how fast you learn, which matters more than how fast you ship)
- Reversibility (one-way doors need a higher bar)
- Downside and externality (who is harmed if it works)

Present as a table with the weights visible, then state the one assumption that, if wrong,
reorders the ranking. That sentence is worth more than the table.
