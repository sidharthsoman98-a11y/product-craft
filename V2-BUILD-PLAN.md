# product-craft v2.0.0 — build plan

Place this file at the repo root. Claude Code reads it as the spec for the build.
Target: complete by end of Sunday, in use from Monday.

---

## 1. How v2 fits the existing pack

v2 is additive. Nothing in v1 is discarded. Fourteen skills become twenty-four, and the
existing pieces gain the layer they were missing: v1 analyses and builds, v2 operates and
remembers.

### Complementary, no conflict
| New | Extends |
|---|---|
| `analytics-sql` | `metric-architecture` defines the metric; this queries it |
| `ticket-writer` | `spec-writer` writes the document; this writes the sprint items under it |
| `experiment-readout` | `instrumentation-and-experiments.md` designs the test; this reads the result |
| `launch-plan` | `ship-it` deploys the artefact; this launches the product |
| `marketplace-ops` | `product-teardown` layer 5; supply and capacity as a working domain |
| `platform-integration` | `spec-writer` at API level, where fintech PM work actually lives |
| `compliance-guard` | Feeds `idea-forge` stage 5 and `product-teardown` layer 3 as a constraint input |
| `evidence-ledger` | Serves every skill that touches a fact |
| `role-lens` | Runs before everything; changes what all downstream skills optimise for |

### Overlaps to resolve, with the decision
| Overlap | Resolution |
|---|---|
| `rca` versus the diagnosis section of `metric-architecture` | **Delete** the diagnosis section from `metric-architecture`; replace with one line pointing to `rca`. The diagnostic playbook stays in `metric-library.md`, which both read |
| `drill` versus `red-team` | Scope by object: `drill` runs a live round and scores the performance; `red-team` attacks a finished artefact. `drill` calls `red-team` for its scoring step rather than restating the rubric |
| `launch-plan` versus `ship-it` | Scope by object: `ship-it` is deployment mechanics for a prototype; `launch-plan` is product rollout. Cross-reference both ways |

### External plugin overlaps
| Action | Skill |
|---|---|
| Disable | `product-management:brainstorm`, `product-brainstorming`, `write-spec`, `synthesize-research` — superseded by `idea-forge`, `spec-writer`, `discovery-brief` |
| Disable entirely | `common-room` plugin — sales prospecting, no relevance, seven skills of context cost |
| Keep and delegate to | `stakeholder-update`, `sprint-planning`, `roadmap-update` (job-side, not rebuilt here); `frontend-design`, `web-artifacts-builder` (prototype UI); `frontend-slides`, `theme-factory` (decks); `docx`/`pptx`/`xlsx`/`pdf` (claude.ai only); `skill-creator` (evals); `productivity:task-management` (working backlog) |
| Scope, do not disable | `metrics-review` reads an existing dashboard; `metric-architecture` designs a new system. Record the boundary in `external-skills.md` |

---

## 2. Structural changes to v1 files

Each is small, and each must be verified by `validate.sh` before the next begins.

1. `references/routing.md` — rewrite. Three modes (employee, interview prep, assignment),
   twenty-four applicability tests, new dependency edges, ledger scoped by mode.
2. `skills/metric-architecture/SKILL.md` — remove the diagnosis section.
3. `skills/prototype-build/SKILL.md` — replace UI guidance with delegation to `frontend-design`.
4. `skills/artefact-forge/SKILL.md` — delegate deck mechanics to `frontend-slides` and `theme-factory`.
5. `skills/orchestrate/SKILL.md` — add mode selection, `role-lens` as step zero, `evidence-ledger` as step one.
6. `references/rubrics.md` — add gates for the six new artefact types.
7. `commands/run.md` → `commands/craft.md` — kill the collision with the bundled `run` skill.
8. `scripts/validate.sh` — extend, per section 4.
9. `templates/` — add `rca.md`, `ticket.md`, `experiment-readout.md`, `launch-plan.md`, `api-review.md`.
10. `README.md` and `plugin.json` — version 2.0.0, new tables.

---

## 3. Your decision points

Nothing below is decided by the build. Each is asked, answered, and recorded in
`DECISIONS.md` so future-you knows why the pack is shaped this way.

| # | Decision | Options | Recommendation |
|---|---|---|---|
| D1 | Role pack content | Written from public JDs / enriched with your payments experience | Enriched. Twenty minutes of your input makes `platform-integration` and `compliance-guard` genuinely yours |
| D2 | Coverage ledger size | Always 24 rows / scoped to the mode's candidate set | Scoped. Twenty-four rows every time becomes noise, and noise gets skimmed |
| D3 | `rca` split | Split from `metric-architecture` / keep as a mode | Split. It is a named interview round and a weekly job task |
| D4 | Drill scoring | Score only / score plus trend across stored runs | Trend. Recurring failures matter more than any single score |
| D5 | Knowledge staleness | No expiry / flag facts older than 90 days | Flag. Payments regulation moves quarterly |
| D6 | Default mode when ambiguous | Ask / assume interview prep | Ask, once, in one line |
| D7 | Public and personal boundary | Everything public / personal overlay plugin | Overlay. Your story bank and ES domain knowledge stay private and never block sharing |
| D8 | Command prefix | `/product-craft:craft` / short aliases | Keep the prefix. Collisions are worse than typing |
| D9 | Sequence if a day slips | Cut job-side / cut interview-side | Cut job-side. Interviews come first, job skills can land the following week |
| D10 | Monday acceptance | Define what "ready" means | Section 6 |

---

## 4. Nothing-breaks protocol

Follow exactly. Every step is reversible.

```bash
cd ~/product-craft
git tag v1.2.0                      # rollback point
git checkout -b v2
```

Rules:
- One commit per skill or per file change. Never batch.
- **A new skill's applicability row in `references/routing.md` section 3 lands in the same
  commit that creates the skill.** A skill the router does not know about still appears to
  work, which is why it is the most likely silent failure. Step 4.3 rewrites the table
  wholesale; this rule keeps it non-empty and current until then.
- `bash scripts/validate.sh` after every commit. A failure is fixed before the next step.
- The plugin stays installed from `main` while you build on `v2`. Nothing you do can break
  a working setup mid-week.
- Merge to `main` only after the Sunday acceptance test passes.
- Rollback at any point: `git checkout main` and the installed plugin is untouched.

Extend `validate.sh` with four new checks before writing any skill:
1. Every skill directory appears in `routing.md`'s applicability table. Catches a skill the
   router does not know about, which is the most likely silent failure. **Enforced — this
   check fails the build**, because an advisory version of it does not enforce the
   registration rule above, and a rule nothing enforces is a preference.
2. Every skill named in `routing.md` exists on disk. Catches the reverse. Advisory: routing
   legitimately names skills the schedule has not reached yet.
3. No two skill descriptions share a distinctive trigger phrase. Crude, but it catches the
   `drill` versus `red-team` class of collision.
4. Description length under 500 characters and frontmatter name matches the directory.

---

## 5. Four-day schedule

### Day 1, Thursday — foundations (2.5 h)
| Block | Work |
|---|---|
| 20 min | Tag, branch, extend `validate.sh`, commit |
| 30 min | Answer D1 to D10. Write `DECISIONS.md`. Commit |
| 40 min | `references/role-packs.md`: consumer tech PM and fintech PM. Charter, owned metrics, stakeholders, weekly artefacts, interview loop shape, failure modes of a new PM in that seat |
| 30 min | `references/india-context.md`: device and network tiers, vernacular, COD and returns, pay-cycle seasonality, UPI rails and zero-MDR reality, RBI and DPDP boundary, trust behaviour |
| 20 min | `references/sources.md`: NPCI statistics, RBI circulars, DRHP and annual reports, MCA, TRAI, company engineering blogs. Plus the verification protocol and what may never be recalled from memory |
| 10 min | `references/external-skills.md`: the delegation map from section 1 |

**Acceptance**: `validate.sh` passes, five files committed, decisions recorded.

### Day 2, Friday — interview-critical four (3 h)
| Block | Work |
|---|---|
| 45 min | `rca`, and remove the diagnosis section from `metric-architecture`. Two commits |
| 45 min | `analytics-sql` |
| 45 min | `marketplace-ops` |
| 45 min | `drill`, delegating its scoring to `red-team` |

**Acceptance**: run one live RCA drill on a Swiggy-style prompt. It must give the prompt,
hold the clock, refuse to coach mid-round, then score. If it explains instead of examining,
the description is wrong, and that is the fix before Saturday.

### Day 3, Saturday — job-side five (3 h)
| Block | Work |
|---|---|
| 45 min | `platform-integration` — the highest-value skill in the pack for fintech interviews |
| 40 min | `compliance-guard` |
| 35 min | `ticket-writer` |
| 30 min | `experiment-readout` |
| 30 min | `launch-plan` |

**Acceptance**: give it a one-line feature idea and ask for the ticket set. Acceptance
criteria must be testable, and edge cases must include failure, retry and reconciliation.

### Day 4, Sunday — wiring, hygiene, release (3 h)
| Block | Work |
|---|---|
| 30 min | `evidence-ledger` and `knowledge/` convention |
| 30 min | `role-lens` |
| 45 min | Rewrite `routing.md` for three modes and 24 skills. Update `orchestrate` |
| 20 min | Deletions, `run` to `craft` rename, templates, rubric gates |
| 20 min | Plugin hygiene: disable the four PM-plugin overlaps and common-room |
| 35 min | Evals with `skill-creator` against twenty realistic prompts. Fix the misfires |
| 20 min | Version 2.0.0, README, merge to `main`, push |
| 10 min | Install and verify the built plugin, per the release sequence below |

**Release sequence.** A merge does not update the installed plugin — the cache is a pinned
copy at a commit, so the pack keeps running the old build until it is updated and reloaded.
In order:

1. Merge `v2` into `main` and push.
2. `claude plugin update product-craft`
3. **Restart the session.** Plugin skills load at session start, so an updated cache is not
   live in the session that updated it.
4. **Verify before testing anything.** The installed version must read 2.0.0, and the cached
   copy must contain `skills/rca` and `skills/drill`. If either check fails, the acceptance
   test below is measuring the old build and its result means nothing.

   ```bash
   cat ~/.claude/plugins/installed_plugins.json
   ls ~/.claude/plugins/cache/product-craft/product-craft/2.0.0/skills
   ```

5. Only then run the three acceptance prompts in section 6.

> **The installed copy is currently pinned at v1.1.0, commit `8cc7d95`.** Any use of the
> pack before the merge is testing that build, not the working tree: no v2 work, and none of
> v1.2.0 either — including the document-generation routing by environment, so a pre-merge
> session will still promise document skills that do not exist in Claude Code.

**Acceptance**: section 6, after step 4 above has passed.

---

## 6. Monday acceptance test

Three prompts, cold, in a fresh session. All three must pass or Sunday is not finished.

1. **Interview prep**: "drill me on an RCA round for a quick-commerce company, 20 minutes."
   Expect: prompt given, clock held, no coaching mid-round, score with trend afterwards.
2. **Assignment**: "I have a take-home from a payments company due tomorrow, here is the
   brief." Expect: deliverable quoted back, time-boxed plan, gates, decision gate handed to
   you, coverage ledger before delivery.
3. **Employee**: "write the tickets for adding retry-with-backoff to a webhook consumer."
   Expect: `platform-integration` and `ticket-writer` both fire, idempotency and
   reconciliation appear without prompting.

Failure mode to watch: the router picking one skill where two are needed. That is a
`routing.md` fix, not a skill fix.

---

## 7. From Monday, the daily workflow

```
cd ~/pm-work && claude
/product-craft:craft <task>
   → role-lens: which archetype, which mode
   → evidence-ledger: read knowledge/<company>.md before the web
   → gates G1, G2 → YOUR DECISION at G3 → execution
   → artefacts → red-team → scoped ledger → deliverable
   → evidence-ledger writes back what was learned
```

Weekly, fifteen minutes: read the drill trend, note the recurring failure, and let that
choose the next week's drills.

---

## 8. Shipping to friends, week two

Do not ship before a week of daily use. Then:
1. Confirm the personal overlay holds everything private, and the public repo has no
   company-confidential material from any assignment.
2. Write a quickstart: install, workspace setup, first command, in under twenty lines.
3. Tag v2.1.0 after the week's fixes. Add an issue template asking for the prompt, the
   expected skill and the skill that actually fired, since that is the only bug report
   that is useful for a skill pack.
4. Record the eval set in the repo so a contributor can check they have not broken routing.
