---
title: "<Firstauthor (Year) — Short title>"
---

<!-- Copy of .claude/course-authoring/kb-source-template.md. Rules:
     knowledge-base.md + citations.md + source-licensing.md.
     The chapter table IS the resume mechanism for extract-knowledge —
     update a row to `done` the moment its chapter is finished, before
     starting the next one. -->

**File:** source-papers/<YYYY-firstauthor-shortname>.pdf
**Bib key:** <firstauthoryearshortname>
**Source license:** <SPDX id or short description> — <OK | flagged, confirmed by human YYYY-MM-DD | n/a — no external source>
**Extraction scope:** <full book | chapters relevant to: <stated goal>>

## Bibliographic record

Full reference as it appears in `knowledge/references.bib`, plus anything useful
that doesn't fit BibTeX (edition notes, companion website, errata page).

## Big ideas (backward design)

What this source wants a reader to be able to DO after working through it — 3–7
bullets, capability-phrased ("compute…", "decide when…", "read a paper that…"),
not chapter titles. [@key]

## Chapter coverage map & extraction state

| Chapter | Pages | Status | Concepts extracted | Confidence notes |
|---|---|---|---|---|
| 1 — <title> | pp. 1–24 | pending | — | — |

Status is exactly one of: `pending` · `in progress` · `done` · `skipped (<reason>)`.
Concepts extracted: comma-separated `knowledge/concepts/` slugs and/or
`glossary: <term>` entries. Confidence notes: anything extracted with doubt
(garbled equations, ambiguous claims) — details go in Open questions below.

## Extraction log

- YYYY-MM-DD — <chapters completed this session; issues hit; decisions made>

## Open questions & low-confidence extractions

- <p. 0> — <what couldn't be read or verified, and what was done instead
  (skipped, partially transcribed, flagged)>
