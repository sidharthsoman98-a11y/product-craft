# <Integration> — API and integration review

**Partner or counterparty:** <who>
**What crosses the boundary:** <money, identity, state, or all three>

## 1. Contract

| Field | Type | Optional? | Versioning behaviour |
|---|---|---|---|

**Error taxonomy** — every error a caller can receive, what it means, and what they do:

| Code | Meaning | Retryable? | Partner's action |
|---|---|---|---|

## 2. Idempotency

| | |
|---|---|
| Idempotency key | what it is derived from |
| Scope | per what, over what window |
| Lifetime | when it expires, and what happens after |
| Replay behaviour | same response, or a stated difference |
| Collision behaviour | same key, different payload |

## 3. Webhooks and asynchronous state

| | |
|---|---|
| Events emitted | |
| Delivery guarantee | at least once, at most once, ordering |
| **Hint versus truth** | the webhook is a hint; the authoritative read is |
| Polling fallback | and how often |
| Signature and replay protection | |

## 4. State machine

| From | To | Trigger | Timeout | Owner of the transition |
|---|---|---|---|---|

Illegal transitions are stated, not left implicit. Every state with a timeout has a stated
destination when it expires.

## 5. Reconciliation

| Break class | How detected | Owner | SLA to resolve |
|---|---|---|---|

Cadence, source of truth, and what happens to a break nobody resolves inside the SLA.

## 6. Go-live

| Gate | Met? | Evidence |
|---|---|---|
| Sandbox parity with production | | |
| Partner has tested the unhappy path | | |
| Rollback path for in-flight transactions | | |
| Support lookup: given an ID, who can see what | | |

## 7. Unhappy path

Failure, retry, duplicate, partial success, dispute, refund and recovery — each with the
behaviour and the human who ends up holding it. **An answer that is correct on the happy
path and silently creates a manual queue for someone else has not passed this section.**

---

The document above this goes to `spec-writer`, the sprint items to `ticket-writer`,
regulatory obligations to `compliance-guard`, and the state-machine or exception-flow
diagram to `artefact-forge`.
