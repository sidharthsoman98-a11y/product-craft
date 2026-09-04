---
name: metric-architecture
description: Design a complete metric system for a product or feature - value primitive, north star with selection tests, input tree, guardrails, event instrumentation, SQL, experiment design and pre-registered decision rules. Use this whenever someone asks how to measure something, what metrics to track, how a metric is defined or calculated, how to tell if a feature worked, how to design an A/B test, or what the north star should be, and use it as a matter of course for any product analysis that will need a measurement section.
---

# Metric architecture

Most metric answers fail because they list metrics. A metric system is a chain: value
primitive, north star, decomposition, instrumentation, decision rule. Each link must
survive the question "and then what would you do".

Load `../../references/metric-library.md` first. Load
`../../references/instrumentation-and-experiments.md` before writing any event schema or
test design. Load `../../references/economics-library.md` when the metric touches money.

## Procedure

1. **Name the value primitive.** The smallest event where the user gets something they
   would miss and the business captures something. State the time to value and the value
   recognition lag.
2. **Propose the north star and test it out loud** against all six tests in the library:
   value fidelity, revenue causality, sensitivity, influenceability, gaming resistance,
   segment stability. Name the test it passes least well. Reject one plausible alternative
   and say why. This step is where the interview is won.
3. **Choose the decomposition pattern** that matches the physics of the business:
   multiplicative, funnel, cohort, marketplace liquidity, capacity and utilisation,
   reliability-weighted, or portfolio and risk. Say why that pattern and not another.
4. **Build the tree to three levels.** Every leaf must be something a team could move in a
   quarter, and the arithmetic must be consistent: the leaves must actually compose into
   the parent.
5. **Guardrails and counter-metric.** Enumerate the three cheapest ways to game the north
   star, then set guardrails that close the two that are cheap and invisible.
6. **Instrumentation.** For the two most important leaves: event name, properties, client
   or server and why, identity handling, and the specific failure mode that would corrupt
   it. Anything financial is server-side; say so and say why.
7. **The query for those two leaves.** State what each query has to return, define the
   denominator explicitly, and fix the window. Denominator ambiguity is where most metric
   conversations break, and settling it is part of designing the metric. **Do not write the
   SQL here.** Writing and verifying it is `analytics-sql` (D12): hand over the purpose, the
   denominator and the window, and take back the query and the checks that confirm it.
8. **Experiment design.** Unit of randomisation, primary metric, MDE argued from the
   business, duration covering a full cycle, guardrails, and what makes a simple A/B
   invalid here (interference, small N, long horizon, rare events).
9. **Pre-registered decision rules.** Ship if, kill if, extend if, with thresholds. Include
   the one-way versus two-way door judgement and the cost of a month of delay.
10. **Counterfactual.** State what this metric system would have made the team do
    differently over the last year, and what choosing the runner-up north star would have
    cost. A metric that would not have changed a decision is not worth collecting.

## Diagnosis

A metric that has already moved is `rca`, not this skill. Hand over (D3).

## Output

Markdown, with the tree as a Mermaid graph. Include an assumptions table with basis and
impact-if-wrong. Score against `../../references/rubrics.md`. Then quiz the user on three
numbers in the output until they can defend each without reading.
