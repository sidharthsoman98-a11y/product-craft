#!/usr/bin/env bash
# Scaffold a one-day prototype: Next.js + Tailwind, mock-data module, metrics stub.
# Usage: bash scaffold-prototype.sh <app-name>
set -euo pipefail
NAME="${1:?usage: scaffold-prototype.sh <app-name>}"

npx --yes create-next-app@latest "$NAME" --ts --tailwind --app --eslint --src-dir \
  --use-npm --import-alias "@/*" --no-turbopack --skip-install
cd "$NAME"
npm install

mkdir -p src/lib src/components

cat > src/lib/mock-data.ts <<'TS'
// All fake data lives here. Typed, plausible, and changed in one place.
export type Persona = { id: string; name: string; segment: string; context: string };
export type Item = { id: string; title: string; price: number; meta?: string };

export const personas: Persona[] = [
  { id: "p1", name: "Persona one", segment: "Primary segment", context: "Where they are when the trigger fires" },
  { id: "p2", name: "Persona two", segment: "Secondary segment", context: "A different circumstance" },
];

export const items: Item[] = [
  { id: "i1", title: "Replace with plausible data", price: 149, meta: "for the actual market" },
];
TS

cat > src/lib/metrics.ts <<'TS'
// Metrics stub. Open the console during a demo and show the events firing.
type Props = Record<string, string | number | boolean | null>;

export function track(event: string, props: Props = {}) {
  const payload = { event, ts: new Date().toISOString(), ...props };
  // Replace with a real sink later. Server-side for anything financial.
  console.log("[track]", payload);
}
TS

cat > src/lib/state.ts <<'TS'
"use client";
import { useState } from "react";
// One store. In-memory, resets on refresh. Say so in the demo.
export function useDemoState() {
  const [personaId, setPersonaId] = useState("p1");
  const [step, setStep] = useState(0);
  return { personaId, setPersonaId, step, setStep };
}
TS

cat > DEMO.md <<'MD'
# Demo script (target: under 3 minutes)
1. The user and the moment, one sentence.
2. The problem and the number that makes it worth solving.
3. Walk the loop, narrating decisions not clicks.
4. Show one unhappy path.
5. Open the console, show the events, name the north star and the guardrail.
6. What is fake, what is real, what I would build next with two engineers.
MD

echo "Scaffolded $NAME. Next: build the loop end to end before styling anything."
