---
name: spec-writer
description: Write a PRD, PRFAQ, one-pager or technical spec that a team could actually build from, then critique it against the gaps that get specs rejected. Use this whenever someone asks for a PRD, product requirements, a spec, a PRFAQ, working backwards, a product one-pager, an RFC or a feature document, or when a decided concept needs to be written up for handover, review or an interview assignment.
---

# Spec writer

A spec is a decision record, not a description. Every requirement must trace to a stated
user problem, and every open question must be visible rather than silently resolved.

## Choose the format

- **PRFAQ** when the audience thinks in customer outcomes, when the product is new, or when
  the reader is an Amazon-style panel. It forces you to write the outcome before the plan.
- **PRD** when the audience will build it and needs edge cases, states and dependencies.
- **One-pager** when a decision is requested rather than a build.
- **RFC or technical spec** when the contested part is the approach, not the requirement.

## PRFAQ structure

1. **Press release**, one page, dated at launch, written for the customer. Heading,
   sub-heading, summary paragraph, problem paragraph, solution paragraph, an internal quote
   that states why now, a customer quote that states the before-and-after, and a call to
   action. No adjective that cannot be measured.
2. **Customer FAQ**: the five questions a sceptical user asks, including what it costs,
   what happens when it fails, and what happens to their data.
3. **Internal FAQ**: the ten questions a sceptical panel asks. This section is where the
   document is won. Cover the economics, build versus buy versus partner, what happens at
   100x, the failure modes, the second-order effects on adjacent teams, the regulatory
   exposure, what we are deliberately not doing, and what would make us stop.
4. **Appendix**: metric tree, sizing arithmetic, mock or wireframe.

## PRD structure

Problem and evidence (with the evidence class for each claim). Goals. Explicit non-goals.
Users, segments and jobs. Success metrics with baselines, targets and the decision rule.
Requirements grouped by priority, each traced to a problem. Flows including empty, error,
offline, partial-failure and recovery states. Data and privacy: what is collected, why,
retention, and who can see it. Dependencies and their owners. Open questions in a table
with owner and due date. Rollout, monitoring and rollback. Risks with mitigations.
Accessibility and localisation requirements where relevant.

## Non-negotiables

- Non-goals present and specific. A spec without non-goals will grow until it ships late.
- Every requirement is a need, not a solution. If it names a UI control, ask what job it does.
- Unhappy paths specified. In payments, commerce and identity products, the unhappy path is
  the majority of the engineering.
- Metrics carry baselines. A target without a baseline is a wish.
- Open questions in a table, never resolved by confident prose.
- Data and consent addressed explicitly, not deferred to a legal review.

## Self-critique before delivering

Mark every claim without evidence, every metric without a baseline, every requirement that
is a solution rather than a need, and every edge case not covered. Then fix them. Report
what was fixed. Score against `../../references/rubrics.md`.

## Output

Markdown by default. Use the docx skill only if the recipient expects a Word document. Use
`../../templates/prd.md` or `../../templates/prfaq.md`.
