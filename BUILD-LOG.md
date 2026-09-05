# Build log — v2.0.0
Rule: tick a box only after that step's commit lands. Uncommitted work does not count.
Second rule, for acceptance steps: the installed plugin is pinned at v1.1.0 until 4.6, so
any test run through the router before the merge is measuring the old build. Acceptance
steps that need the router are marked for Sunday and cannot be ticked early.

## Day 1 — foundations
- [x] 1.1 branch, plan, log
- [x] 1.2 validate.sh extended with four checks
- [x] 1.3 DECISIONS.md
- [x] 1.4 references/role-packs.md
- [x] 1.5 references/india-context.md
- [x] 1.6 references/sources.md + external-skills.md

## Day 2 — interview-critical four
- [x] 2.1 skills/rca + diagnosis section removed from metric-architecture
- [x] 2.2 skills/analytics-sql
- [x] 2.3 skills/marketplace-ops
- [x] 2.4 skills/drill
- [x] 2.5a acceptance, content: read skills/drill/SKILL.md directly and run a drill by it
- [ ] 2.5b acceptance, routing: after 4.6 installs, ask for a drill in plain language from
      ~/pm-work and confirm the router reaches it unprompted

## Day 3 — job-side five
- [x] 3.1 platform-integration
- [x] 3.2 compliance-guard
- [x] 3.3 ticket-writer
- [x] 3.4 experiment-readout
- [x] 3.5 launch-plan

## Between Day 3 and Day 4 — unnumbered
- [x] 9e6ce06 build contract (CLAUDE.md) and the section-pointer check in validate.sh.
      Not a step in the plan: it came out of the second instance of an instruction citing
      repo content that did not exist. Logged so the log matches the branch.

## Day 4 — wiring and release
- [x] 4.1 evidence-ledger
- [x] 4.2 role-lens
- [ ] 4.3 routing.md rewrite + orchestrate update
- [ ] 4.4 deletions, run to craft rename, templates, rubric gates
- [ ] 4.4a delegation rewrites (plan section 2, items 3 and 4): prototype-build hands UI
      mechanics to frontend-design; artefact-forge hands deck mechanics to frontend-slides
      and theme-factory; artefact-recipes.md aligns. external-skills.md already promises
      these handoffs in its "Called by" column, so until this lands the map claims a
      delegation neither skill performs
- [ ] 4.5 plugin hygiene
- [ ] 4.6 evals, v2.0.0, merge to main
