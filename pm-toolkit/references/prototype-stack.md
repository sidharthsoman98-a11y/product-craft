# Prototype stack

How to get from a decided concept to a link someone else can open, in hours rather than days.

## 1. Choose fidelity deliberately

| Fidelity | Use when | Build time | Stack |
|---|---|---|---|
| Flow sketch | The argument is about sequence, not surface | 15 min | Mermaid diagram in the doc |
| Clickable wireframe | Reviewing structure and information hierarchy | 1-2 h | Single HTML file, Tailwind via CDN, no build |
| Interactive prototype | Demonstrating the core loop with realistic state | 3-5 h | Next.js + Tailwind, mock data module, deployed |
| Working slice | Proving a technical claim (an API, a model, latency) | 1 day | Next.js + one real integration, everything else mocked |

Rule: fidelity should be the minimum that makes the decision. Anything more is theatre
and consumes the time you needed for the analysis.

## 2. Default stack and why

Next.js with the App Router, TypeScript, Tailwind, deployed on Vercel. Reasons that matter
under time pressure: zero-configuration deployment from a Git push, previews per branch,
no server to manage, and a single command from empty directory to public URL.

```bash
npx create-next-app@latest <name> --ts --tailwind --app --eslint --src-dir --use-npm --no-turbopack
```

Keep the dependency list short. Every package added is a build failure waiting to happen
at hour twenty-three.

Optional, only if needed: `recharts` for charts, `lucide-react` for icons, `zustand` for
state beyond `useState`, `date-fns` for dates. Nothing else without a reason.

## 3. Architecture for a one-day prototype

```
src/
  app/page.tsx           landing and entry to the loop
  app/<flow>/page.tsx    one route per screen in the core loop
  components/            presentational only
  lib/mock-data.ts       ALL fake data in one file, typed
  lib/state.ts           one store, no persistence unless the demo needs it
  lib/metrics.ts         event logging stub that prints to console
```

Principles:
- One file for all mock data. When the demo needs to change, you change one file.
- Type the mock data. Types are documentation you cannot forget to update.
- Include the metrics stub even in a prototype. Being able to open the console during a
  demo and show which events fire is disproportionately persuasive in a PM interview.
- Build the unhappy path for at least one screen: an error, an empty state, a rejection.
  Every candidate demos the happy path; the unhappy path is what shows product judgement.

## 4. Speed rules

1. Build the core loop end to end before making any screen look good. A complete ugly loop
   beats two beautiful screens and a dead end.
2. Hardcode aggressively, then centralise the hardcoding into `mock-data.ts`.
3. No authentication. If the demo needs a user, put a segment switcher in the corner. It
   also lets you demo two personas in one session, which is a better demo anyway.
4. No database. State in memory, reset on refresh, and say so up front.
5. Mobile-first layout at 390px width. Most of these products are phone products, and a
   desktop-only prototype signals that you did not think about the real user.
6. Ship something deployed by the halfway mark, then improve. A prototype that is not
   deployed by the deadline does not exist.
7. Seed the fake data with plausible names, prices and volumes for the market in question.
   Implausible data is the fastest way to lose an audience's attention.

## 5. Demo script

Write it before you polish anything, and keep it under three minutes.

1. The user and the moment, in one sentence.
2. The single problem, with the number that makes it worth solving.
3. Walk the loop, narrating decisions rather than clicks: "notice we ask for this after
   the value is shown, not before, because..."
4. Show one unhappy path.
5. Show the metrics stub and name the north star and the guardrail.
6. State what is fake, what is real, and what you would build next with two engineers.

The most common demo failure is narrating the interface. Narrate the decisions.

## 6. Accessibility and quality floor

Even in a prototype: semantic elements, labels on inputs, contrast that survives a
projector, keyboard focus visible, touch targets at least 44px, and no text below 14px.
These take minutes and are noticed by design-literate interviewers.

## 7. What to fake and what to build

- **Fake**: authentication, payments, third-party APIs, search ranking, notifications,
  anything requiring credentials.
- **Build**: the state transitions of the core loop, the decision points, the empty and
  error states, and anything your argument depends on being real.
- **Never fake**: a claim about latency, cost or accuracy. If you assert it, measure it or
  label it as an assumption on the slide.
