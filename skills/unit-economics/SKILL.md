---
name: unit-economics
description: Build and stress-test the economics of a product - contribution margin stack, cohort payback, break-even, pricing and sensitivity - and answer whether a business or feature is viable. Use this whenever a question involves margin, profitability, pricing, take rate, cost to serve, CAC or LTV, whether something is a good business, whether to spend more on growth, or what would have to be true for an idea to work, and use it inside any teardown, case or strategy answer that makes a claim about money.
---

# Unit economics

The job is to turn a business question into an equation, find the two variables that
decide the answer, and state the threshold at which the decision flips.

Load `../../references/economics-library.md`. Load `../../references/metric-library.md`
for the archetype spine so the cost drivers match the actual physics of the business.

## Procedure

1. **Define the unit.** One order, one transaction, one seat, one loan, one active user
   month, one dark store. Ambiguity here invalidates everything downstream.
2. **Build the stack in layers**, naming each: gross value, net revenue, CM1, CM2, CM3.
   Do not present a single "margin" number. Include the lines candidates forget: support
   contacts per unit, reverse logistics, payment cost, discount and cashback, risk losses,
   and inference or compute cost where relevant.
3. **Label every input** as measured, benchmarked or assumed, in an assumptions table with
   the impact if wrong. Derive rather than recall. If a benchmark is quoted, say it is a
   benchmark and give its plausible range, never a false precision.
4. **Model the step function.** Semi-fixed costs jump at capacity thresholds. Model the
   step and identify which side of it the business is on, because that usually is the
   answer to "should we grow faster".
5. **Cohort view.** Contribution per cohort over time, cumulative, against acquisition
   cost. State the payback period and whether the cohort crosses into positive contribution
   before the relationship typically ends.
6. **Sensitivity.** Swing each input by plus and minus twenty per cent. Identify the two
   variables that dominate. Present only those as decision drivers and cut the rest.
7. **Break-even and the inversion.** Solve for the value of the dominant variable at which
   the decision flips, then judge whether that value is plausible given what is known.
   Present this as the answer: "this works if X exceeds N; comparable situations run at
   roughly M, so it needs a mechanism that makes it different, and here is the mechanism
   and the two-week test."
8. **Distributional check.** State who bears the cost that does not appear in the model:
   delivery workers absorbing waiting time, small merchants absorbing float, users
   absorbing risk, or a subsidy that ends. If the margin depends on an unpriced cost, say
   so plainly; it is both an ethical point and a durability risk.

## When to build a spreadsheet

If the numbers need to be inspected, changed or handed over, build one: one tab of
assumptions with colour-coded inputs, one tab of calculation, one tab of outputs and
sensitivity. Write real formulas, never hardcoded numbers, so a reader can change an input
and watch the model respond. Generate with `openpyxl` in Claude Code, or the xlsx skill in
claude.ai; `../../references/tooling.md` says which applies where.

Otherwise keep it in a markdown table, which is faster to read in an interview and is the
right default. A spreadsheet is for numbers someone will change, not for numbers someone
will read.

## Output

The equation, the assumptions table, the base case, the two sensitivity drivers, the
break-even threshold, the verdict, and the one measurement that would most reduce
uncertainty. Never a point estimate presented as fact.
