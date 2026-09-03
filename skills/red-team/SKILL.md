---
name: red-team
description: Attack a product answer, document, prototype or presentation the way a hostile interviewer or a sceptical executive would, then score it and name the single highest-leverage fix. Use this whenever someone asks for feedback, a critique, a review, a sanity check, wants to know what is wrong with their answer, asks how an interviewer would attack it, or has just finished any deliverable that will be evaluated by someone else.
---

# Red team

The job is to find the failure before the evaluator does. Be direct and specific. Vague
encouragement is a disservice; so is contempt. Attack the work, respect the person.

Load `../../references/rubrics.md` for the scoring dimensions, the artefact gates and the
failure catalogue.

## Procedure

1. **Restate what the work is claiming**, in one sentence. If that sentence is hard to
   write, the work has no thesis and that is the finding.
2. **Run the failure catalogue** by name. Report which of the fifteen failures are present,
   with the specific sentence or screen that triggers each.
3. **Attack in four passes:**
   - *Structural*: does the argument hold together, does each section constrain the next,
     is anything asserted that the analysis did not earn.
   - *Evidential*: every number, where it came from, what its error bar is, whether the
     conclusion survives the pessimistic end of the range.
   - *Adversarial*: the six questions an interviewer asks when they want to fail someone.
     Why that segment. Why not the obvious alternative. What does it cost. What if the main
     assumption is wrong. Why has the incumbent not done this. What would you cut if you had
     half the resources.
   - *Consequential*: who is worse off if this works, what breaks at scale, what is the
     regulatory or trust exposure, what happens on the unhappy path.
4. **Quote the weakest sentence verbatim** and explain precisely why an evaluator would stop
   there. This is more useful than any general comment.
5. **Score** every rubric dimension with a one-line justification. Give the verdict.
6. **One fix.** Name the single highest-leverage change and say which score it moves. More
   than one fix and none of them get done.

## Calibration

- Do not soften a 2 into a 3 because effort is visible. The evaluator will not.
- Do not manufacture problems in strong work. If it is genuinely strong, say what makes it
  strong specifically, then find the one thing that would move it from hire to strong hire.
- Distinguish fatal from cosmetic. A missing trade-off is fatal. A slide layout is not.
- If the work answers a different question than the one asked, say that first and stop.
  Nothing else matters until it is fixed.

## Output

Thesis restatement, failures present, four passes, weakest sentence, score table, verdict,
one fix. Offer a rerun after revision, and compare against the previous score so the user
can see whether the same failure keeps recurring. Recurring failures matter more than scores.

Where the workspace has a `drills/` folder, previous scores live there, one file per run.
Read it for the trend rather than asking the user what they scored last time. When `drill`
calls this skill for its scoring step (D11), the score written back belongs in that run's
file.
