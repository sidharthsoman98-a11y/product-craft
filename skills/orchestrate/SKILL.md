---
name: orchestrate
description: Plan and run a complete product workflow end to end, selecting which product-craft skills apply, sequencing them by dependency, enforcing quality gates and proving coverage before anything is delivered. Use this at the start of any substantial product task - a teardown, a case, an assignment, a new product concept, a strategy question or a prototype - and whenever someone asks for a full or thorough treatment, mentions a deadline, or wants to be sure nothing was skipped. Prefer this over invoking a single analysis skill directly when the request could reasonably need more than one.
---

# Orchestrate

The other skills are instruments. This one decides which play, in which order, and refuses
to deliver until coverage and quality are proved. Its purpose is to make the process
auditable rather than probabilistic.

Load `../../references/routing.md` at the start. Load
`../../references/rubrics.md` before the final gate.

## Procedure

**Step 1: classify and plan.** Quote the request back in one sentence. Classify it against
the scenario table in `routing.md`. If it matches none, say which is closest and what
differs. Then print the plan before doing any work:

```
Scenario: <n> — <name>
Deliverable: <exact format the user needs>
Audience: <who evaluates it>          Time budget: <stated or asked>
Sequence: skill → skill → skill → red-team
Skipping now: <skill> (<which applicability test failed>)
Gates: G1 ... G7
```

Ask for confirmation only when the classification is genuinely ambiguous or the deliverable
is unclear. Otherwise state the reading and proceed; a plan that arrives with the work is
better than a plan that arrives instead of it.

**Step 2: run the sequence.** Invoke each skill in dependency order. Never run a skill whose
prerequisites have not produced output; if a prerequisite is missing, insert it and say so.
Carry outputs forward explicitly: the segment chosen in one step is the segment named in the
next, by name. Drift between steps is the most common way a multi-skill answer becomes
internally inconsistent.

**Step 3: stop at every gate.** At each gate print one line: gate, pass or fail, and the
evidence. A failed gate is fixed immediately. Do not note a failure and carry on, and do not
soften a gate because time is short; cut scope instead, in the order given by
`interview-sprint`.

**Step 4: checkpoint with the user** at G2 (arc), G3 (decision) and G5 (build). Two lines
each: what is done, what is next, what is at risk. These three are where a wrong turn is
cheap to correct and expensive to discover later.

**Step 5: red team.** Always. Run `red-team` on the assembled deliverable, fix what it
finds, and report the score before and after.

**Step 6: coverage ledger.** Print the coverage ledger from `routing.md` immediately before
the deliverable, one row per candidate skill for this mode. Every skill is APPLIED, CONSIDERED-SKIPPED with the failed test
named, or DEFERRED with the blocker named. "Not relevant" is not a permitted reason.
Repeat every DEFERRED row in a closing "what I would do next" line.

**Step 7: deliver**, answer first.

## Rules

- The ledger is not optional and is not a summary. If the ledger cannot be completed
  honestly, the work is not finished.
- Sequence beats speed. A fast answer that skipped the decision gate is the failure this
  skill exists to prevent.
- Never let a prototype substitute for a decision. If code appears before G3, stop.
- If the user asks for a single skill directly, honour that, but note in one line which
  skills the routing table would have added and offer them. Do not run them unasked.
- If new information invalidates an earlier gate, reopen it explicitly rather than patching
  downstream. Say which gate reopened and why.
- Where parallel execution is available, parallelise research only. Deciding is one thread
  and it belongs to the user.

## Degraded modes

- **Under 30 minutes**: run the mandatory skills only, mark the rest DEFERRED rather than
  skipped, and say in one line what the compression cost.
- **No web access**: mark every external fact as recalled with a range, and add a row to the
  assumptions table stating which conclusions depend on unverified figures.
- **User pushes back on the process**: shorten the visible scaffolding, not the gates. The
  ledger can be three lines instead of a table, but it still prints.
