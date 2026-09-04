---
name: analytics-sql
description: Write and verify the SQL behind a product number, and prepare for the technical analytics round. Use this when a query has to be written, when someone asks how a number would be calculated, for cohort or retention analysis, funnel conversion, expressing a definition in SQL, checking whether a reported figure is right, specifying a dashboard, or practising window functions, joins and CTEs for an SQL interview.
---

# Analytics SQL

Payments and consumer tech companies test SQL directly, in a round of its own: window
functions, joins, CTEs, and a data interpretation problem where a table is put in front of
you and you are asked what it says. In the job the same skill is the difference between a
number a team acts on and a number a team argues about for a week.

The failure here is not syntax. It is a query that runs, returns a plausible number, and
answers a different question from the one asked — almost always because the denominator was
never stated. Everything below is ordered to make that failure hard.

Load `../../references/metric-library.md` for what a metric *means* — the value primitive,
the decomposition patterns in section 3 and the archetype spines in section 4 — and
`../../references/instrumentation-and-experiments.md` section 2 for why an event may be
missing, duplicated or late. Neither is restated here. This file is about turning a
definition into a correct query and proving the result. For the shape of the technical round
and what it scores, read `../../references/role-packs.md` sections 5 and 6.

## What this is not

Per `../../references/external-skills.md`:

- **Choosing what to measure is `metric-architecture`.** If the question is what the north
  star should be, which leaves matter, or how the tree decomposes, that is a design job and
  this is the wrong skill. `metric-architecture` reaches this one at its SQL step, once the
  leaves are chosen.
- **Diagnosing a number that moved is `rca`.** A drop is a diagnosis, not a query. This skill
  writes the cuts `rca` steps 3 and 4 call for and hands the rows back; it does not run the
  diagnosis. If a query request arrives phrased as "why did X fall", route to `rca` first and
  come back here for its queries.
- **Reading an existing dashboard is the external `metrics-review` skill.** Specifying a new
  one is section 5 below; reading this month's numbers off one that already exists is not.

It serves both `metric-architecture` and `rca` without absorbing either. When a query answers
a design question or a diagnostic one, name the skill it belongs to and hand back.

## 1. Before writing any SQL

Write these five lines above the query, as a comment, every time. They are the deliverable
as much as the SQL is.

1. **The question, in one sentence**, with a verb a decision could act on.
2. **The denominator, explicitly.** *Most disputes about a number are two people using
   different denominators.* "Conversion" is not a metric; "payments succeeded ÷ payment
   attempts initiated, first attempt only" is.
3. **The grain.** One row per what — per user, per user-day, per transaction, per attempt?
   State it for every table you touch, not just the output. Unstated grain is where fan-out
   (section 3) comes from.
4. **The window and the timezone.** Absolute dates, not "last 30 days", and the timezone the
   day boundary is cut on. In India, IST is UTC+5:30, so a UTC day boundary splits the
   evening peak across two days and every daily number quietly disagrees with the app's.
5. **Fixed at entry, or evaluated live.** Is the population frozen when a user enters — a
   cohort — or recomputed each period? Retention needs the first. "Active users who did X"
   needs the second. Silently switching between them is how a retention curve rises.

If any of the five cannot be answered, ask the one question that settles it and wait. A query
written on an unstated denominator is not faster, it is just wrong sooner.

## 2. The patterns

Worked against a generic schema. Adjust date and JSON functions to your dialect — these are
written ANSI-style, and `DATE_DIFF`, `DATE_TRUNC` and `properties['k']` are the three that
differ most across BigQuery, Snowflake, Postgres and Athena.

```
events        (user_id, event, properties, ts)      -- one row per user action
transactions  (id, user_id, merchant_id, amount, status, ts)  -- one row per attempt
```

Note `transactions` is one row per **attempt**, not per payment. Every pattern below depends
on that being said out loud.

### Funnel conversion, ordered, no double counting

Each step must occur *after* the previous one, and each user counts once.

```sql
-- Q: of users who viewed a product in Aug 2026, what share paid within 24h?
-- Denominator: distinct users with a `view` event in the window, fixed at entry.
-- Grain: one row per user per funnel entry. Window: 2026-08-01..2026-08-31, IST.
WITH entered AS (
  SELECT user_id, MIN(ts) AS t0
  FROM events
  WHERE event = 'view' AND ts >= DATE '2026-08-01' AND ts < DATE '2026-09-01'
  GROUP BY user_id
),
cart AS (
  SELECT e.user_id, e.t0, MIN(v.ts) AS t1
  FROM entered e
  JOIN events v ON v.user_id = e.user_id AND v.event = 'add_to_cart'
                AND v.ts >= e.t0 AND v.ts < e.t0 + INTERVAL '24' HOUR
  GROUP BY e.user_id, e.t0
),
checkout AS (
  SELECT c.user_id, c.t0, MIN(v.ts) AS t2
  FROM cart c
  JOIN events v ON v.user_id = c.user_id AND v.event = 'checkout_start'
                AND v.ts >= c.t1 AND v.ts < c.t0 + INTERVAL '24' HOUR
  GROUP BY c.user_id, c.t0
),
paid AS (
  SELECT ch.user_id, MIN(v.ts) AS t3
  FROM checkout ch
  JOIN events v ON v.user_id = ch.user_id AND v.event = 'payment_success'
                AND v.ts >= ch.t2 AND v.ts < ch.t0 + INTERVAL '24' HOUR
  GROUP BY ch.user_id
)
SELECT (SELECT COUNT(*) FROM entered)  AS entered,
       (SELECT COUNT(*) FROM cart)     AS reached_cart,
       (SELECT COUNT(*) FROM checkout) AS reached_checkout,
       (SELECT COUNT(*) FROM paid)     AS paid,
       (SELECT COUNT(*) FROM paid) * 1.0
         / NULLIF((SELECT COUNT(*) FROM entered), 0) AS view_to_paid;
```

**The trap.** Counting each step independently over the window — `COUNT(DISTINCT user_id)
WHERE event='checkout_start'` — inflates every step below the first and can produce a step
with more users than the one above it, because it counts checkouts that happened *before*
the view. The chained CTEs above are what "ordered" means. Each CTE is one row per user by
construction, so no step can double count.

### Cohort retention, denominator fixed at entry

```sql
-- Q: of users who signed up in week W, what share ordered in week W+n?
-- Denominator: the cohort's size at entry, never recomputed.
WITH cohort AS (
  SELECT user_id, MIN(ts) AS first_seen, DATE_TRUNC('week', MIN(ts)) AS cohort_week
  FROM events WHERE event = 'signup' GROUP BY user_id
),
sized AS (
  SELECT cohort_week, COUNT(*) AS cohort_size FROM cohort GROUP BY cohort_week
),
activity AS (
  SELECT c.cohort_week, c.user_id,
         CAST(DATE_DIFF('day', c.first_seen, e.ts) / 7 AS INT) AS week_index
  FROM cohort c
  JOIN events e ON e.user_id = c.user_id AND e.event = 'order_placed'
                AND e.ts >= c.first_seen
)
SELECT s.cohort_week, s.cohort_size, a.week_index,
       COUNT(DISTINCT a.user_id) AS retained,
       COUNT(DISTINCT a.user_id) * 1.0 / s.cohort_size AS retention
FROM sized s
LEFT JOIN activity a ON a.cohort_week = s.cohort_week
GROUP BY s.cohort_week, s.cohort_size, a.week_index
ORDER BY s.cohort_week, a.week_index;
```

**The trap, twice.** Dividing by the count of users active in week *n* rather than by
`cohort_size` makes retention approach 100%. And a cohort that has only existed four weeks
must not be shown at week 8: truncate every cohort at the smallest fully observed
`week_index`, or the curve bends up at the right edge because only young cohorts are missing
from the tail.

### Period over period, with window functions

```sql
-- Q: week-on-week change in successful transactions. Excludes the current partial week.
WITH weekly AS (
  SELECT DATE_TRUNC('week', ts) AS wk, COUNT(*) AS txns
  FROM transactions
  WHERE status = 'success' AND ts < DATE_TRUNC('week', CURRENT_DATE)
  GROUP BY 1
)
SELECT wk, txns,
       LAG(txns) OVER (ORDER BY wk) AS prev_txns,
       (txns - LAG(txns) OVER (ORDER BY wk)) * 1.0
         / NULLIF(LAG(txns) OVER (ORDER BY wk), 0) AS wow_change
FROM weekly ORDER BY wk;
```

**The trap.** `LAG` returns the previous *row*, not the previous week. If a week has no rows
it is absent, and `LAG` silently compares across a gap. Join to a generated date spine when
zero-volume periods are possible.

### Running totals and moving averages

```sql
SELECT d, revenue,
       SUM(revenue) OVER (ORDER BY d ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative,
       AVG(revenue) OVER (ORDER BY d ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS ma7
FROM daily_revenue ORDER BY d;
```

**The trap.** `ROWS` counts rows; `RANGE` counts values. With a missing day, `ROWS BETWEEN 6
PRECEDING` averages seven rows spanning nine calendar days and calls it a 7-day average.
Build the date spine first. A 7-day moving average is also the standard way to remove the
weekday cycle — never compare a Sunday to a Wednesday raw.

### First and last touch per user

```sql
SELECT user_id, event, properties, ts
FROM (
  SELECT e.*,
         ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY ts ASC,  event ASC) AS rn_first,
         ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY ts DESC, event DESC) AS rn_last
  FROM events e
) ranked
WHERE rn_first = 1;
```

**The trap.** Ties. Two events on the same millisecond make `ROW_NUMBER` non-deterministic,
so the query returns a different attribution channel on each run and nobody can reproduce
last week's number. Always add a deterministic tiebreaker column. Use `QUALIFY` where the
dialect has it.

### Deduplication on an idempotency key

```sql
-- Retries and offline queues resend. Deduplicate at read time only as a stopgap.
SELECT * FROM (
  SELECT e.*,
         ROW_NUMBER() OVER (PARTITION BY properties['idempotency_key']
                            ORDER BY ts ASC) AS rn
  FROM events e
  WHERE event = 'payment_attempt'
) d WHERE rn = 1;
```

**The trap.** With no idempotency key, the tempting fallback is to collapse rows matching on
`(user_id, merchant_id, amount)` within a few minutes — which also erases genuine repeat
purchases, and at a coffee shop that is a real pattern, not a bug. Say the number is a lower
bound when you do it. The actual fix is a key written at ingestion, per
`../../references/instrumentation-and-experiments.md` section 2.

### Segment cuts, and mix versus rate

The reweighting `rca` step 4 calls for. A blended rate can move with every underlying rate
flat, purely because the mix of segments shifted.

```sql
-- Q: did success rate fall because rates fell, or because mix shifted?
WITH by_seg AS (
  SELECT DATE_TRUNC('month', ts) AS mth, merchant_id AS segment,
         COUNT(*) AS n,
         SUM(CASE WHEN status = 'success' THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS rate
  FROM transactions
  WHERE ts >= DATE '2026-07-01' AND ts < DATE '2026-09-01'
  GROUP BY 1, 2
),
cur  AS (SELECT * FROM by_seg WHERE mth = DATE '2026-08-01'),
prev AS (SELECT * FROM by_seg WHERE mth = DATE '2026-07-01')
SELECT
  SUM(cur.n  * cur.rate)  / SUM(cur.n)  AS blended_now,
  SUM(prev.n * prev.rate) / SUM(prev.n) AS blended_prev,
  SUM(prev.n * cur.rate)  / SUM(prev.n) AS now_rates_at_prior_mix
FROM cur FULL OUTER JOIN prev ON cur.segment = prev.segment;
```

**Read it like this.** If `now_rates_at_prior_mix` ≈ `blended_now`, mix did not do it and the
underlying rates moved. If `now_rates_at_prior_mix` ≈ `blended_prev`, holding mix fixed
erases the change and the whole story is mix — a different problem with a different owner.
**The trap** is the join: an inner join drops any segment present in only one period, which
is exactly the new merchant or the churned one that caused the shift. Use a full outer join
and decide explicitly what a NULL side means.

### Anomaly and abuse flags

```sql
-- Q: which users transacted unusually often in a day?
WITH per_day AS (
  SELECT user_id, CAST(ts AS DATE) AS d,
         COUNT(*) AS txns, SUM(amount) AS amt,
         COUNT(DISTINCT merchant_id) AS merchants
  FROM transactions
  WHERE status = 'success' AND ts >= CURRENT_DATE - INTERVAL '30' DAY
  GROUP BY 1, 2
),
threshold AS (
  SELECT APPROX_PERCENTILE(txns, 0.999) AS p999 FROM per_day
)
SELECT p.* FROM per_day p CROSS JOIN threshold t
WHERE p.txns > t.p999
ORDER BY p.txns DESC;
```

**The trap.** Transaction counts are heavy-tailed, so mean plus three standard deviations
flags the same ordinary power users every single day and the alert gets muted in a week.
Use a percentile, or a per-user baseline comparing today against that user's own trailing
median. A flag is a hypothesis about abuse, never a finding: hand it to `rca`.

## 3. Mistakes that produce confidently wrong numbers

These do not error. They return a number, and the number is wrong.

| Mistake | How it shows up | How to catch it |
|---|---|---|
| **Fan-out** from joining two fact tables | Totals inflate; revenue exceeds what finance reports; a user appears to have ordered 40 times | Count rows before and after every join. Check the key is unique on at least one side: `SELECT k, COUNT(*) ... HAVING COUNT(*) > 1`. Aggregate each side to one grain in its own CTE, *then* join |
| **Filtering in `WHERE` what belongs in `ON`** of an outer join | A `LEFT JOIN` silently becomes an inner join; the denominator shrinks and every rate rises | Conditions on the right-hand table go in `ON`; conditions on the left in `WHERE`. Re-run with the join removed and compare the row count |
| **Averaging an average** | `AVG(store_conversion)` gives every store equal weight, so twelve tiny stores outvote the flagship | Recompute as `SUM(numerator) / SUM(denominator)` and compare. If they differ materially, the mix is the story — failure catalogue item 9 |
| **Ratio of ratios** | A "40% improvement in conversion rate lift" nobody can reconstruct or reconcile | State the numerator and denominator of each ratio separately, and report the absolute change alongside the relative one |
| **Silently dropped NULLs** | `COUNT(col)` skips NULLs while `COUNT(*)` does not; `NOT IN` with a single NULL returns zero rows; `AVG` ignores them rather than treating them as zero | Compare `COUNT(*)` against `COUNT(col)` on every column you filter or aggregate. Prefer `NOT EXISTS` over `NOT IN`. Wrap every divisor in `NULLIF(x, 0)` |
| **Partial-period comparison** | A drop every Monday morning; the current week always looks bad | Exclude the incomplete period, or compare like-for-like elapsed hours. Label any partial period on the output |
| **Late-arriving events** | Yesterday's number changes when you re-run it; offline and low-connectivity users are undercounted | Declare a lateness window and say when a number is final. Snapshot the number and re-run after the window to measure the drift. See `instrumentation-and-experiments.md` section 2 |
| **Timezone drift** | The daily peak sits in the previous day; your daily count never matches the app team's | Convert once, at the edge of the query, and state the timezone in the header comment. IST is UTC+5:30 — a UTC cut splits the evening peak |

## 4. Verification, before the number leaves the query editor

Run all four. Say in the output which ones you ran — a number presented without them is an
unowned number, failure catalogue item 3.

1. **Reconcile against a known total.** Compare to a number someone else owns: finance's
   settled volume, the ops dashboard's order count, the previous month's published figure.
   Agreement is evidence; a gap is a finding to explain, not to round away.
2. **Trace one user end to end.** Pick a single `user_id` the query classifies as converted
   and read their raw event rows in order. If the story does not match, the query is wrong.
   This finds more errors than any other check and takes two minutes.
3. **Compare against an independent source.** A second table, a different system, a
   client-side count against a server-side one. Where they disagree, the direction of the gap
   usually names the cause — client-side lower means event loss, which correlates with device
   tier and network.
4. **Sense-check the magnitude.** Convert to something you have intuition for: per user per
   day, share of the base, share of population. If the result implies half of India transacts
   daily, or an average basket of ₹40,000, the query is wrong, not the world.

## 5. Specifying a dashboard

A dashboard is a decision instrument. Specify it from the decision backwards.

- **State what the reader must be able to conclude** without asking anyone — one sentence per
  chart. A chart that supports no conclusion comes off the page.
- **One visible definition per metric,** on the page, denominator included, dated. Definition
  drift between two decks is a standing failure mode; a definition the reader cannot see is a
  definition they will invent.
- **Segment filters that match how decisions are actually made** — city tier, issuer, channel,
  cohort, device tier — not every dimension the warehouse happens to have. Every extra filter
  is a way to slice until a story appears.
- **Freshness on the page:** last refreshed, the lateness window, and whether the current
  period is partial. Without it, section 3's partial-period and late-arrival errors reappear
  as a weekly false alarm.
- **The default view answers the question with no clicks.** Thresholds belong in alerts, not
  in someone remembering to look.

## 6. Interview mode

The technical round is scored on how you get to the query, not on typing speed.

- **Talk through the query before writing it.** Restate the question, name the denominator
  and the grain out loud, describe the shape of the answer. Thirty seconds here is what
  separates a candidate who understood the question from one who pattern-matched it.
- **State the schema assumption.** "I'm assuming `transactions` is one row per attempt, so a
  retried payment appears twice — is that right?" If nobody answers, proceed on the stated
  assumption and say which way it would change the number.
- **Write readably.** CTEs, one idea each, named for what they hold. Nested subqueries three
  deep are the single most common reason an otherwise correct answer is marked down: the
  interviewer cannot follow it, so they cannot give you credit for it.
- **Say what you would check.** Close with two checks from section 4 — "I'd reconcile the
  denominator against total signups and trace one user" — unprompted. Volunteering
  verification is the accuracy signal the loop scores.
- **For the data interpretation problem,** read the table before theorising: state what
  changed, in absolute and relative terms, name the confound you would rule out first, and
  say what you would query next. That is `rca`'s method compressed — use it, do not restate it.

**Strong versus average,** drawing on `../../references/role-packs.md` section 6:

- *Average* starts typing immediately, assumes one row per user, nests subqueries, is silent
  about NULLs and timezone, quotes a blended success rate, and stops when the query runs.
- *Strong* states the denominator before touching the keyboard, names the grain of each table,
  asks whether a retried payment counts once or twice, uses CTEs, breaks ties deterministically,
  reweights before concluding anything changed, and ends with the two checks that would confirm
  the number.
- **The fintech tell** is asking what `status` actually contains — pending, timeout,
  risk-declined, insufficient funds — and refusing to collapse them into success and failure.
  Accuracy, edge cases and audit trail are assessed in every round of that loop, not in one,
  so the query that handles the intermediate state is worth more than the clever window
  function.
- **The consumer-tech tell** is cutting by cohort and city tier unprompted, and knowing that a
  week-on-week comparison across a festival is not a comparison.

## Output

A query is delivered with, not without:

- the five-line header from section 1 — question, denominator, grain, window and timezone,
  population rule;
- the SQL, in CTEs, with the trap it avoids noted where it is not obvious;
- the number, with which checks from section 4 were run and what they returned;
- what it is for: the leaf `metric-architecture` asked for, the cut `rca` asked for, or the
  panel in a dashboard spec.

Score against `../../references/rubrics.md`. Watch particularly for unowned numbers, the
average trap and segment drift — the segment in the query must be the segment in the
sentence built on it. If the data cannot answer the question asked, say so and name what
would have to be instrumented, rather than answering a nearby question quietly.
