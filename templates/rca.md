# RCA: <metric or incident> — <date>

**Diagnosis (answer first, two sentences):**

**Confidence:** high / medium / low, and what would raise it.

## Fact base
| | |
|---|---|
| Metric | |
| Definition and denominator | |
| Magnitude | absolute and relative |
| Window | |
| Baseline compared against | |
| Source | server or client, and why it is trustworthy here |

Clarifying question asked, and the assumption proceeded on if unanswered:

## Ruled out
| Step | Checked | Result | Evidence |
|---|---|---|---|
| Is it real | instrumentation, deploy, app version, pipeline, schema, bots, duplicates | | raw event volume before rate |
| Population or slice | new/existing, platform, version, geography, tier, channel, cohort, device, network | | the cut run first, and why |
| Mix or rate | reweighted to prior period mix | | survives / does not survive |
| Us or the world | competitor, seasonality, festival, pay cycle, counterparty outage, regulation | | natural control segment used |

## Isolated to
The single factor in the chain carrying the change, with the decomposition walked top-down.
State the share of the total move this factor accounts for.

## Mechanism
Falsifiable claim:

The one query or test that would disprove it:

## Evidence needed
| Question | Data or query | Who holds it | Turnaround |
|---|---|---|---|

## Recommendation
| | Action | Owner | By when |
|---|---|---|---|
| Do now | | | |
| Study | | | |

## Cost of delay
What a quarter of doing nothing costs, with the derivation. Urgency follows from this, not
from how alarming the chart looks.

---

## Incident section — only for a production incident

### Timeline
| Time | Event |
|---|---|
| | change deployed |
| | first impact |
| | first signal |
| | detected |
| | escalated |
| | mitigated |
| | resolved |

**Detection time:** and whether it was found by monitoring or by a customer.

### Impact
Users affected, transactions or orders lost, money, with the derivation shown.

### Trigger versus underlying condition
| | |
|---|---|
| Trigger | what changed on the day |
| Underlying condition | what made the system fragile enough for it to matter |

### Contributing factors
Not a single cause. The change, the gap in testing, the alert that did not fire, the stale
runbook. Systems and steps, never individuals.

### Corrective actions
| Action | Class | Owner | By when |
|---|---|---|---|
| | prevent / detect faster / reduce blast radius | | |
