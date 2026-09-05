# Artefact recipes

Which artefact, which tool, how long, and what makes it good. Choose the cheapest artefact
that carries the argument.

Markdown, HTML and Mermaid are the defaults; reach for a binary format only when the brief
demands that format. The tool column names two generators for those cases because
availability differs by environment — the xlsx, docx and pptx skills exist in claude.ai but
**not** in Claude Code, where generation goes through `openpyxl`, `python-pptx`,
`python-docx` or `pandoc`. See `tooling.md` before promising a file.

| Artefact | Tool | Time | Good when |
|---|---|---|---|
| Flow or state diagram | Mermaid in markdown | 10 min | Sequence or state machine is the point |
| Metric tree | Mermaid graph, or a nested markdown list | 10 min | Showing decomposition and ownership |
| Journey map | Markdown table: stage, action, thought, pain, opportunity, metric | 20 min | Locating where in the journey the problem lives |
| Competitive matrix | Markdown table, features as rows, players as columns | 20 min | Positioning; must include a "what nobody does" row |
| Wireframe | Single HTML file with Tailwind, or SVG; `frontend-design` where it must look real | 45 min | Structure of one screen, before building |
| Clickable prototype | Next.js on Vercel (see prototype-stack.md) | 3-5 h | Demonstrating the loop |
| Sizing model | Spreadsheet: `openpyxl`, or the xlsx skill in claude.ai | 30 min | Numbers must be inspected or changed live |
| Unit economics model | Spreadsheet, one tab of assumptions, one of outputs | 45 min | Sensitivity is part of the argument |
| PRD or PRFAQ | Markdown; Word or PDF via `python-docx` / `pandoc`, or the docx skill in claude.ai | 1-2 h | Handing over to build |
| Deck | Structure decided here, built by `frontend-slides` and themed by `theme-factory`; HTML by default, `.pptx` via `python-pptx` or the pptx skill in claude.ai | 1-2 h | Panel presentation with a fixed time limit |
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
  that answers the four questions you expect. **All of that is the argument and stays here.**
  Slide mechanics go to `frontend-slides` and theming to `theme-factory`, per
  `external-skills.md` section 2 — hand over the decided structure, not the brief.
- **Spreadsheets**: assumptions on their own tab, colour-coded inputs, no hardcoded numbers
  inside formulas, and one output tab that a reader can understand without you present.
  Write live formulas rather than computed values; a model with hardcoded results is a table.
- **Binary formats are a cost.** They are slower to produce, harder to diff and cannot be
  deployed as a link. Produce one when the brief asks for that format — "submit a PDF" makes
  the format part of the evaluation — and markdown or HTML otherwise. `tooling.md` has the
  per-environment generator.

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
