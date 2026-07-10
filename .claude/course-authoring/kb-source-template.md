---
title: "<Firstauthor (Year) — Short title>"
---

<!-- Copy of .claude/course-authoring/kb-source-template.md. Rules:
     knowledge-base.md + citations.md + source-licensing.md.
     The record is created by the survey-source skill (license, big ideas,
     chapter map, relevance proposal, goal) and then driven by extract-knowledge:
     the chapter table IS the resume mechanism — update a row the moment its
     chapter (or, for long chapters, its page slice) is finished, before
     starting the next one. -->

**File:** source-papers/<YYYY-firstauthor-shortname>.pdf
**Bib key:** <firstauthoryearshortname>
**Source license:** <SPDX id or short description> — <OK | flagged, confirmed by human YYYY-MM-DD | n/a — no external source>
**Extraction goal:** <which courses/foundations this extraction serves — from the
Relevance proposal decision; or "encyclopedic — user explicitly chose full source";
or "undecided — survey only" while no goal has been picked>

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

Status starts with exactly one of `pending` · `in progress` · `done` ·
`skipped (<reason>)`, with an optional parenthesized qualifier after the base word:
`in progress (pp. X–Y done)` (sub-chapter resume point for long chapters) and
`done (partial — pp. X–Y unreadable)` (gaps logged in Open questions) are the two
defined qualifiers. Concepts extracted: comma-separated `knowledge/concepts/` slugs
and/or `glossary: <term>` entries. Confidence notes: anything extracted with doubt
(garbled equations, ambiguous claims) — details go in Open questions below.

## Relevance proposal

Filled by the survey-source skill from `courses/README.md` + `foundations/README.md`:
what each part of the source could feed, so the user can pick the extraction goal
from an informed menu. "No clear match" is an honest entry.

| Chapter/section | Relevant to (existing) | New opportunity |
|---|---|---|
| 1 — <title> | [<course-or-foundation>](../../<path>) — <why, one line> | <new course/foundation the source suggests, capability-phrased — or —> |

**Decision (YYYY-MM-DD):** <the user's chosen goal, verbatim — mirrored in the
`**Extraction goal:**` line above>

## Extraction log

- YYYY-MM-DD — <chapters completed this session; issues hit; decisions made>

## Open questions & low-confidence extractions

- <p. 0> — <what couldn't be read or verified, and what was done instead
  (skipped, partially transcribed, flagged)>
