# Knowledge base

A paper-agnostic, citable encyclopedia of what this repo's sources teach:
definitions, notation, derivations, terminology, misconceptions, teaching
insights, and prerequisite structure. Every claim carries a bracketed citation
into [`references.bib`](references.bib).

- **How entries get here:** the `extract-knowledge` skill (or the
  `knowledge-extractor` agent for a one-shot run) ingests a PDF from
  `source-papers/` — resumable chapter by chapter for big textbooks.
- **How they're used:** `create-course` consults the KB at intake,
  `knowledge-gap-check` audits existing material against it (report-only), and
  the `course-auditor` cross-checks lessons against it (checks 22–23).
- **Two tiers:** lesson-anchoring concepts get a page in
  [`concepts/`](concepts/); atomic vocabulary gets a row in
  [`glossary.md`](glossary.md). Rules: `.claude/course-authoring/knowledge-base.md`;
  citation convention: `.claude/course-authoring/citations.md`.

The table bodies below are **generated** by `Rscript scripts/gen-kb-index.R` —
never edit inside the markers (CI runs `gen-kb-index.R --check`). Unlike the
foundations index, there is no learner Status column: the knowledge base is
fully machine-owned.

## Concepts

| Concept | Topic | Sources | Referenced by |
|---|---|---|---|
<!-- >>> generated: knowledge concepts table (scripts/gen-kb-index.R) — do not edit by hand -->
<!-- <<< generated: knowledge concepts table -->

## Sources

| Source | Bib key | License | Extraction state |
|---|---|---|---|
<!-- >>> generated: knowledge sources table (scripts/gen-kb-index.R) — do not edit by hand -->
<!-- <<< generated: knowledge sources table -->
