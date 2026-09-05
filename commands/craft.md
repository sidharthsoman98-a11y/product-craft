---
description: Run a full product workflow with routing, gates and a coverage ledger
---
Use the `orchestrate` skill for: $ARGUMENTS

Run `role-lens` then `evidence-ledger` first, fix the mode, then classify the scenario
against references/routing.md within that mode. Print the plan and the sequence before doing
any work, stop at every gate, checkpoint at G2, G3 and — where there is a build — G5, run
red-team last, and print the coverage ledger — one row per candidate skill for this mode —
immediately before the deliverable.
