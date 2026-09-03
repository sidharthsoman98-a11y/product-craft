---
name: decision-forensics
description: Reverse-engineer why a product team made a specific decision, reconstruct the alternatives they weighed, and simulate what would have happened had they chosen differently, including second-order effects. Use this whenever someone asks why a company built something a certain way, why a feature works like that, what would have happened if they had done X instead, whether a decision was right, or asks a counterfactual or hindsight question about a shipped product or a strategic choice.
---

# Decision forensics

The purpose is to convert an observation into a transferable rule. Speculation is
permitted; unlabelled speculation is not. Tag every claim as observed, inferred or assumed,
and keep the tags visible in the output.

Load `../../references/decision-lenses.md`, section 4, for the method. Load
`../../references/metric-library.md` when simulating metric consequences and
`../../references/economics-library.md` when the counterfactual touches margin or pricing.

## Procedure

1. **Observe precisely.** What shipped, in detail, including what is conspicuously absent,
   what is defaulted on, what is buried, and what the copy is careful not to say. Absences
   are evidence.
2. **Infer the objective.** Which metric does this choice maximise? Work backwards from the
   design to the incentive, and consider that the maximised metric may belong to a team
   rather than to the company.
3. **Infer the constraint.** Which of these made the obvious alternative unavailable:
   legacy architecture, a partner or platform contract, regulation, an org boundary,
   unit economics, missing data, capital, talent, or simple sequencing. Name the most
   likely one and the evidence for it.
4. **Reconstruct the option set.** Usually three: the fast one, the correct one, and the
   one requiring another team's cooperation. State what each loses on.
5. **Find distinguishing evidence.** What observable would separate these explanations:
   release order, which platform got it first, pricing changes, job postings, API surface,
   changelog language, support documentation, the shape of the error messages.
6. **Simulate the counterfactual.** For the chosen alternative: which metric moves, in
   which direction, by roughly what magnitude, over what horizon. Then the second-order
   effect in the following quarter, which is where the interesting answer lives: what the
   competitor does, what the team stops being able to build, what the cost structure
   becomes, what the users learn to expect.
7. **Judge twice.** Was it reasonable given the information and constraint at the time?
   Separately, was it right in hindsight? Conflating these is the most common error, and
   distinguishing them is what makes the analysis credible.
8. **Extract the rule.** "In situations of type T, prefer X because Y." Then state the
   condition under which the rule inverts.

## Quality bar

- Give the charitable reading before the critique, always. Competent teams make locally
  rational choices under constraints you cannot see.
- Prefer one deeply traced decision to five shallow observations.
- Quantify at least one counterfactual, even roughly, with the arithmetic shown.
- Name the thing you would need to know that you cannot know, and how you would find a
  proxy for it.

## Output

Markdown: Observation, Objective, Constraint, Options, Distinguishing evidence,
Counterfactual with second-order effects, Verdict (at the time, in hindsight), Rule.
Tag every line. Close with the one question you would ask the team if you had ten minutes
with them.
