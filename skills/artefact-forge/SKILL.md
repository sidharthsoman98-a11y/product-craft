---
name: artefact-forge
description: Produce the supporting artefacts a product argument needs - flow and state diagrams, metric trees, journey maps, competitive matrices, wireframes, sizing and unit economics spreadsheets, decks and one-pagers - choosing the cheapest artefact that carries the argument. Use this whenever someone asks for a diagram, flowchart, user journey, wireframe, competitive analysis, model, spreadsheet, slide deck or visual for a product case, review or assignment.
---

# Artefact forge

Choose the cheapest artefact that carries the argument. Anything more elaborate consumes
the time the analysis needed.

Load `../../references/artefact-recipes.md` for the selection table, the rules and the
Mermaid patterns.

## Procedure

1. **State the argument the artefact must carry**, in one sentence. This becomes the
   caption. If the caption cannot be written, the artefact is decoration and should be cut.
2. **Pick the artefact and the tool** from the recipes table, against the time budget.
3. **Build it**, following the rules for that type.
4. **Caption it**: one line stating what the reader should conclude, not what it shows.
5. **Attach the assumptions table** if it contains any number: value, basis, impact if wrong.

## Standing rules

- Diagrams: Mermaid inside the markdown document by default. Only produce an image when the
  destination cannot render Mermaid.
- Spreadsheets: use the xlsx skill. Assumptions on their own tab, inputs colour-coded, no
  hardcoded numbers inside formulas, one output tab a reader can follow unaided.
- Decks: use the pptx skill when a file is required, or an HTML deck when it will be
  presented from a browser. One message per slide, stated as a sentence in the title.
  Fifteen slides maximum for thirty minutes, plus an appendix answering the four questions
  you expect to be asked.
- Documents: markdown by default, docx only when the recipient expects Word.
- Wireframes: a single HTML file with Tailwind from a CDN, no build step. Faster to produce
  and to change than a design tool, and it can be deployed as a link.
- Competitive matrices must include a row for what nobody currently does. That row is
  usually the reason the matrix exists.
- Journey maps must include a metric column. A pain point with no metric attached will not
  survive prioritisation.

## Output

The artefact, its caption, and a note on what was deliberately left out of it.
