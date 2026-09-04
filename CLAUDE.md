# Build contract — product-craft

Read this at the start of every session in this repository. It exists because the same
mistake class has now occurred twice: an instruction cited repo content that did not exist,
and the work was built on it anyway.

## Verify before citing

**Any instruction that references a file, a section, a claim or a decision is a claim about
this repository, not a fact.** Check it before building on it — open the file, find the
section, read the decision. This applies to instructions from the repository owner exactly as
it applies to anything else. An instruction is a description of the repo written from memory,
and memory is what this rule exists to guard against.

## On a false premise, stop and report

When a cited file, section, claim or decision does not exist, or does not say what the
instruction says it says:

- **Stop.** Do not write around it.
- **Do not substitute a plausible equivalent.** The nearest true thing is not what was asked
  for, and silently swapping it hides the error rather than surfacing it.
- **Do not proceed with the rest while quietly leaving the wrong part out.** A step delivered
  with a hole in it reads as complete.
- **Report:** what was asserted, what is actually there, and then wait.

## Never introduce an unsourced claim to satisfy an instruction

`references/sources.md` treats an unsourced factual claim as a blocking error, not as
something to tidy up later. **That standard applies to work done here.** If satisfying an
instruction would require inventing a citation, a source or an attribution, that is a false
premise — stop and report it, per the rule above.

## One commit per step

One step, one commit. **Run `scripts/validate.sh` after each**, and fix any failure before
starting the next step. **A step without a commit did not happen** — uncommitted work does
not count, and neither does a tick in `BUILD-LOG.md` written ahead of the commit it describes.

## Every new skill registers itself

**A new skill's applicability row in `references/routing.md` section 3 lands in the same
commit that creates the skill.** A skill the router does not know about still appears to work,
which is what makes it the most likely silent failure in the pack. `scripts/validate.sh`
enforces this.

## No invented numbers, anywhere

Including in examples, worked calculations and illustrative figures. **Derive it, or label it
as an assumption.** A number invented to make an example read well becomes a number someone
quotes, and the pack's own rubric treats an unowned number as a failure.

## Report what you did beyond the literal instruction

If you extended the scope, corrected a premise, fixed something adjacent, or made a judgement
call the instruction did not cover, **say so and say why**. Work that quietly exceeds its
brief is as hard to review as work that quietly falls short of it.
