---
name: idea-forge
description: Run a structured ideation and brainstorming session that moves an idea from a vague notion to a decided, buildable concept through staged questions, generative lenses and forced trade-offs. Use this whenever someone wants to brainstorm, ideate, explore a problem space, has a rough product idea they want to develop, asks what they should build, needs to think through an opportunity before specifying it, or is starting a product assignment, hackathon or case with only a theme to work from.
---

# Idea forge

The failure mode of ideation is a list. The output here is a decided concept: one segment,
one job, one loop, one metric, one riskiest assumption, and a written record of what was
rejected and why. That record is what makes the eventual prototype defensible.

Load `../../references/decision-lenses.md` for the lenses and the staged nudge bank.

## How to run the session

Work in stages. At each stage, ask two or three questions from the nudge bank, wait for
answers, and record the decision before moving on. Never dump the whole bank. Never
proceed with an unanswered stage-1 question by inventing an answer; ask.

**Stage 0: frame.** Establish what is fixed and what is open: theme, constraints, time
budget, audience, and whether this must end in a prototype. If the user has a solution
already, park it visibly and return to it at stage 3, then test whether the problem work
still supports it.

**Stage 1: problem.** Who, how often, what it costs them, what they do today, why it is
unsolved, what changed to make it solvable now. Do not permit solution talk here. If the
user keeps proposing solutions, note them in a parking list and redirect once, politely.

**Stage 2: user and job.** Force a single segment. Ask which segment, if delighted, would
carry the product to the next one. Get the trigger moment, the current workaround, and the
switching cost. The workaround is the benchmark.

**Stage 3: divergence.** Now generate. Run at least five lenses from the reference,
including inversion, constraint addition, the non-consumer, job substitution and
distribution-first. Produce eight to twelve options, tagged with the lens that produced
them. Include at least two that the user will initially dislike; those are often where the
non-obvious answer is.

**Stage 4: convergence.** Fix criteria and weights before scoring, and drop any criterion
on which all options score alike. Score, rank, and state the one assumption that, if wrong,
reorders the ranking. Choose one concept. Write down the rejected concepts and the reason
each lost, because interviewers ask what else was considered and the answer is a
differentiator.

**Stage 5: shape.** The one screen it cannot exist without. The manual version you could
run for ten users this week. What is deliberately excluded from version one. What data
must exist on day one and where it comes from. What happens when the clever part is wrong.

**Stage 6: viability and risk.** Who pays and when, cost to serve, what has to be true to
be contribution-positive, cheapest distribution channel. Then misuse, unpriced costs to
workers or merchants or bystanders, what breaks at 100x, and the regulatory exposure.

**Stage 7: proof.** The single riskiest assumption, the two-week test that would kill the
idea cheapest, and the signal that would justify doubling down.

## Facilitation rules

- One question at a time when the user is thinking; batches of three when they are moving.
- Push back on the first plausible answer once per stage. "What would have to be true for
  that to be wrong?" is the highest-yield follow-up in this entire skill.
- When the user is stuck, offer three concrete options rather than asking an open question
  again. Stuck people need a menu, not another prompt.
- Keep a visible decision log. Every stage ends with a line: decided X, rejected Y because Z.
- Do not let the session become a feature list. If more than five features are named before
  stage 5, stop and re-anchor on the job.

## Output

A concept brief: problem, segment and job, the decided concept, what it explicitly is not,
core loop, riskiest assumption and its test, success metric, rejected options with reasons,
and open questions in a table. Hand off to `discovery-brief` for validation, `spec-writer`
for the PRD or PRFAQ, or `prototype-build` to make it real.
