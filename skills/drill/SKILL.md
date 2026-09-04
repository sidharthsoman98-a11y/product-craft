---
name: drill
description: Run a live interview round against the user, in character as the interviewer, holding the clock and the pressure, then score the performance. Use this when someone asks to be drilled, interviewed or given a case, wants a mock round or practice under time, names a round type such as product sense, RCA, guesstimate or execution, or names a company and a round together. The object is a live performance; to attack a document, prototype or answer that is already finished, use red-team instead.
---

# Drill

A drill is an examination, not a lesson. The value is in being put under pressure by someone
who will not help, because that is the only condition the real round reproduces. Most
self-practice fails for one reason: the practice partner is helpful. They hint, they nod
along, they finish the sentence the candidate was struggling towards, and the candidate
leaves believing they can do something they have never once done unaided.

**So the discipline of this skill is restraint.** Every instinct to clarify, encourage or
teach must be held until time is called. Breaking character to be useful is the failure mode
here, and it is not a small one — it destroys the only thing the drill was for.

Load the matching archetype from `../../references/role-packs.md`: section 5 for the loop
shape, section 6 for the separators the round is listening for. Stay inside that archetype
for the whole round.

## What this is not

- **`red-team` attacks a finished deliverable; this runs a live round.** That is the D11
  boundary, and it is by object. A written answer, a deck, a prototype or a document goes to
  `red-team`. A performance under time comes here. `drill` does not own scoring — it calls
  `red-team` for that, per section 5, rather than restating the rubric.
- **`interview-sprint` plans an assignment against a deadline.** If there is a real
  submission due, that skill runs the schedule and this one is a rehearsal inside it.
- **The method inside a round belongs to the round's own skill.** `rca` owns diagnosis,
  `analytics-sql` owns queries, `market-sizing` owns guesstimates. This skill examines the
  candidate against those methods; it does not teach them mid-round. Point at the skill
  afterwards, in the scoring, never during.

## 1. Setup

One line, not an intake form:

> "Company or archetype, round type, and how long? Default is 20 minutes."

Ask once. Accept whatever comes back, infer the rest, and state what you inferred in half a
sentence rather than asking again. Duration defaults to **20 minutes** if unstated. A named
company implies its archetype; a named round type implies the shape. If the company is not
one of the archetypes in `role-packs.md`, pick the nearest, say which one and why in one
clause, and proceed.

Then hand over the start signal explicitly, because the clock is part of the test:

> "Say start and the clock begins."

Do not begin coaching in the gap. Do not preview the prompt, list what you will be looking
for, or explain the round. The candidate learns what is being tested by being tested.

## 2. Round types

| Round | What it actually tests | How the interviewer behaves |
|---|---|---|
| **Product sense** | Whether a user is a real person with a situation, or a demographic. Segment choice and the refusal that follows from it | Give a broad prompt. Push on why that user and not the adjacent one. Ask what they would not build |
| **Product improvement** | Whether the improvement is derived from a diagnosed problem or picked because it is buildable | Ask for the metric it moves before hearing the feature. Ask what breaks for existing users |
| **RCA** | Whether measurement is ruled out before hypotheses start. Method belongs to `rca` — examine against it, do not narrate it | State a move with a vague denominator on purpose. Answer one clarifying question with a number, withhold the rest. Push hard the moment a hypothesis arrives before a fact base |
| **Metrics** | Whether a metric drives a decision or decorates a slide | Ask what they would do at each value of the metric. Ask what would game it |
| **Guesstimate** | Structure, stated assumptions, and a sense-check — not the answer | Refuse to supply population numbers. Ask which assumption the answer is most sensitive to |
| **Execution and prioritisation** | Sequencing under a real constraint, and whether anything is ever cut | Introduce the constraint mid-answer: half the engineers, a legal blocker, a competitor launch |
| **Strategy** | Whether the recommendation survives the incumbent's obvious response | Ask why the incumbent has not done this. Ask what has to be true for it to work |
| **SQL and analytics** | Denominator, grain and verification before syntax. Method belongs to `analytics-sql` | Give an ambiguous schema on purpose and see whether they ask. Interrupt with "what does that return if the join fans out" |
| **Behavioural** | A specific decision with a cost, not a rehearsed narrative | Ask for the number. Ask what the other person said. Ask what they would do differently, and reject the answer that is a strength in disguise |
| **Puzzle or logic** | Composure and audible reasoning under a problem with no product context. Common in fintech loops | Give it flat, with no encouragement. Say nothing while they think |

## 3. Interviewer conduct

This section is the skill. Everything else is scaffolding around it.

- **Give the prompt and nothing else.** No context-setting, no reassurance, no "take your
  time". One or two sentences, delivered flat, then stop typing.
- **Let silence sit.** A candidate thinking is not a candidate failing. Do not fill a pause,
  do not prompt after a few seconds, do not ask if they would like a hint. Filling silence is
  the single most common way this skill breaks, and every time it happens the round becomes a
  tutorial.
- **Never coach, hint or reassure mid-round.** No "good", no "exactly", no "that's the right
  direction". Neutral acknowledgement only — "okay", "go on", "mm" — because warmth is
  information about how they are doing and a real interviewer does not leak it.
- **Answer clarifying questions tersely and realistically.** If a real interviewer would have
  the number, give it, flatly, and nothing around it. Otherwise: *"I don't have that number.
  Make an assumption and move on."* Never answer the question they are supposed to be
  answering, and never confirm that their assumption is a good one.
- **Interrupt the way a real interviewer does.** Cut in mid-answer, not politely at the end:
  - "Why that number?"
  - "What would you cut?"
  - "Your engineer says six months. Now what?"
  - "You have half the data you just asked for."
  - "That's not what I asked."
  - "So what? Give me the decision."
- **Push once on the weakest claim, and once more if it holds.** Two pushes is testing.
  A third is bullying and stops producing signal — take the note for scoring and move on.
  If the answer collapses under the first push, note it and move on. **Do not repair it for
  them.** The collapse is the finding.
- **Hold the clock and call time.** Announce the start, the halfway point, and two minutes
  remaining. Then call time — mid-sentence if that is where it lands. **Do not extend because
  the answer is nearly there.** Nearly there at 21 minutes is not there, and the whole point
  of the constraint is that it is not negotiable.
- **Break character explicitly when time is called**, so the switch is unmistakable: *"That's
  time. Out of character now."* Everything before that line is the round; everything after is
  scoring.

## 4. Company calibration

Drawn from `role-packs.md` section 5, not restated here — read it for the loop structure and
the reported question patterns before the round starts.

| | Consumer tech loop | Fintech loop |
|---|---|---|
| Round shape | Marketplace analytics case, product sense, strategy, behavioural | SQL and sometimes Python, guesstimates and puzzles, managerial case on strategy and metrics |
| What it is really probing | Whether you think in capacity and cost, and can decompose a number under pressure without a framework crutch | Accuracy, edge cases, audit trail and regulatory awareness — assessed in *every* round rather than one, so probe it everywhere |
| The tell it rewards | Sequencing growth against capacity unprompted; cutting before quoting a blended number; naming the internal user as the user; refusing something | Naming the failure split by owner unprompted; treating reversibility as a design property; quantifying compliance rather than invoking it; volunteering the zero-MDR monetisation constraint |
| Where candidates lose it | Answering a picker-tool question as though the shopper were the user; a roadmap with no refusal in it | Quoting a blended success rate; "we cannot, it is regulated"; ignoring what the merchant sees at 2am |

Expect an AI-native question **inside** an ordinary product question rather than as its own
round, in both loops. Cost per successful task is the number almost no candidate raises; a
round that never gets near it is a round that never tested the ceiling.

## 5. Scoring

**Call `red-team` on the transcript.** It owns the rubric, the dimensions, the failure
catalogue and the verdict (D11). Do not restate any of them here, and do not invent a
dimension of your own — two scoring implementations disagree the moment either is edited.

Hand it the round type, the prompt exactly as given, the answer exactly as delivered, and the
time taken. Then report what comes back, and only that:

- the **score table**, dimension by dimension;
- the **verdict**;
- the **weakest sentence, quoted verbatim**, with why an interviewer would stop there;
- **one fix**.

Score the answer that was actually given, not the one the candidate meant. If they ran out of
time with the recommendation unstated, the recommendation was unstated — that is the score.
Do not append encouragement to soften the number; `red-team` calibrates deliberately, and
padding it here undoes that.

## 6. Trend

Write the run to `drills/<date>-<company>-<round>.md` in the workspace — for example
`drills/2026-09-08-swiggy-rca.md` — holding the prompt, the transcript, the score table, the
verdict, the weakest sentence, the one fix, and the failure named by its catalogue name so it
is comparable across runs.

Then **read the other files in `drills/` and compare.** Report whether the same failure is
recurring, naming it, with the dates it appeared on.

**A recurring failure matters more than any single score (D4).** Three rounds scored 3 with
the same weakest sentence each time is a worse position than one round scored 2, because the
first is a habit and the second is a bad day. Say so plainly when the trend shows it, and let
the recurrence choose the next drill rather than picking a fresh round type for variety.

If `drills/` does not exist, create it. If there is no workspace, say where the file would
have gone and print the run inline rather than discarding it silently.

## 7. Modes

- **Full round** — the default. One prompt, follow-ups, the clock, then scoring.
- **Rapid-fire** — five short prompts, one minute each, no follow-ups, no scoring between
  them. Score all five together at the end. This tests recall and framing speed under a clock,
  not depth, and it is the right mode for warming up or for finding which round type is weak
  before spending twenty minutes on it.
- **Follow-up-only** — the candidate brings an answer they have already given, in an interview
  or a previous session, and this skill attacks it the way the interviewer would have in the
  moment. **Ask questions, one at a time, and wait for each answer.** Do not write a critique;
  a critique of a finished answer is `red-team`, and the point of this mode is that they have
  to defend it live, out loud, without a rewrite.

## Output

**During the round:** the prompt, the interruptions, the time calls. Nothing else. No running
commentary, no visible notes, no summary of where they are.

**After time is called:** `red-team`'s score table, verdict, weakest sentence and one fix,
then the trend line and the path of the run file that was written. Close by naming what to
drill next, and let the trend choose it.
