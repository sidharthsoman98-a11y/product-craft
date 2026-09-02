# Artefact recipes

Which artefact, which tool, how long, and what makes it good. Choose the cheapest artefact
that carries the argument.

| Artefact | Tool | Time | Good when |
|---|---|---|---|
| Flow or state diagram | Mermaid in markdown | 10 min | Sequence or state machine is the point |
| Metric tree | Mermaid graph, or a nested markdown list | 10 min | Showing decomposition and ownership |
| Journey map | Markdown table: stage, action, thought, pain, opportunity, metric | 20 min | Locating where in the journey the problem lives |
| Competitive matrix | Markdown table, features as rows, players as columns | 20 min | Positioning; must include a "what nobody does" row |
| Wireframe | Single HTML file with Tailwind, or SVG | 45 min | Structure of one screen, before building |
| Clickable prototype | Next.js on Vercel (see prototype-stack.md) | 3-5 h | Demonstrating the loop |
| Sizing model | Spreadsheet via the xlsx skill | 30 min | Numbers must be inspected or changed live |
| Unit economics model | Spreadsheet, one tab of assumptions, one of outputs | 45 min | Sensitivity is part of the argument |
| PRD or PRFAQ | Markdown, or Word via the docx skill if the recipient expects it | 1-2 h | Handing over to build |
| Deck | pptx skill, or an HTML deck if it will be presented from a browser | 1-2 h | Panel presentation with a fixed time limit |
| One-pager | Markdown | 30 min | Executive decision requested |

## Rules

- **Assumption tables belong in every artefact that contains a number.** Three columns:
  value, basis (measured, benchmarked, assumed), and impact if wrong.
- **Open questions stay in a table**, never resolved by assertion in the prose. An artefact
  that hides its uncertainty is worse than one that admits it.
- **Every diagram needs a one-line caption** stating what the reader should conclude.
  If you cannot write the caption, the diagram is decoration.
- **Decks**: one message per slide, stated in the title as a sentence, not a label.
  Evidence in the body. Fifteen slides maximum for a thirty-minute slot, plus an appendix
  that answers the four questions you expect.
- **Spreadsheets**: assumptions on their own tab, colour-coded inputs, no hardcoded numbers
  inside formulas, and one output tab that a reader can understand without you present.

## Mermaid patterns worth memorising

Core loop:
```
graph LR
  T[Trigger] --> A[Action] --> R[Reward] --> I[Investment] --> T
```

Metric tree:
```
graph TD
  NS[North star] --> A[Input A] --> A1[Sub-input]
  NS --> B[Input B]
  NS --> C[Input C]
```

Funnel with drop-off annotated:
```
graph TD
  S1[Visit 100%] --> S2[Search 62%] --> S3[Detail 41%] --> S4[Cart 12%] --> S5[Paid 8%]
```

State machine for an unhappy path:
```
stateDiagram-v2
  [*] --> Attempted
  Attempted --> Succeeded
  Attempted --> Failed
  Failed --> Retried
  Retried --> Succeeded
  Failed --> Refunded
```
