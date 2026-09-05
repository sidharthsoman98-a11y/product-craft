# <Feature> — launch plan

**The decision this launch implements:** <one line>
**What we will do at the end:** <the post-launch decision, and its date>

## 1. Readiness

Six gates. Each is a yes or no with a name against it. **"In progress" is a gate that has
failed** — launches slip on the item everyone assumed was done.

| Gate | Yes / no | Name against it | Evidence |
|---|---|---|---|
| Instrumentation live and verified in production | | | the known action checked against |
| Guardrails defined with thresholds | | | the numbers that mean stop |
| Rollback tested, not assumed | | | when it was last actually run |
| Support briefed with the three questions they will get | | | what is this, why did it change, how do I get back |
| Unhappy paths handled | | | the edge-case walk, closed out |
| Stop authority named | | | including outside working hours |

## 2. Stages

The gate between two stages is **a question answered, not a date reached**. A stage that
catches nothing new should be dropped rather than run as ceremony.

| Stage | What it is for | Gate to the next stage | Earliest date |
|---|---|---|---|
| Internal | | the team uses it for its real purpose without a workaround | |
| One unit, or a small percentage | | guardrails clean across one full operating cycle | |
| A segment or geography | | support volume per user inside threshold | |
| General availability | | the decision in section 7 | |

Never advance two stages in one day. Advance on evidence, not on the absence of complaints.

## 3. Flag and kill switch

| | |
|---|---|
| Who can turn it off, by name and role | |
| How fast — config change or deploy | **a switch needing a deploy is a fix, not a kill switch** |
| When it was last actually run | a rollback nobody has run is a hypothesis |
| What happens to in-flight work when it flips | |

## 4. Day one

| | |
|---|---|
| Dashboard | |
| Watcher, by name | |
| Stop threshold | |
| Stop authority | |
| Escalation path out of hours | |

## 5. Comms and enablement

| Audience | Message | Channel | Owner | When |
|---|---|---|---|---|

Include the **internal break-glass note**: what someone on support says when it is broken
and the fix is not ready.

## 6. Commercial sequence

Only where money is involved. Pricing, billing, contracts, partner readiness, and what
happens to customers mid-cycle.

## 7. Post-launch decision

**Dated, with an owner.** A launch nobody went back to is a metric with no decision
attached to it.

| | |
|---|---|
| Decision date | |
| Owner | |
| What we will be looking at | |
| What would make us roll it back after GA | |

---

Announcement copy goes to `product-management:stakeholder-update`, roadmap sequencing to
`roadmap-update`, prototype deployment to `ship-it`. **A staged rollout is not an
experiment** — if a causal claim is needed, design a test with `metric-architecture` and
read it with `experiment-readout`.
