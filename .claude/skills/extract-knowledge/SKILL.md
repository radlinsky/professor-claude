---
name: extract-knowledge
description: >
  Extract a textbook or paper PDF from source-papers/ into the repo's citable
  knowledge base (knowledge/): definitions, notation, derivations, terminology,
  misconceptions, teaching insights, and prerequisite structure, every claim cited.
  Use when the user says "extract knowledge from <pdf>", "ingest this textbook/paper",
  "add <source> to the knowledge base", or "resume extraction of <source>" (big books
  are extracted chapter by chapter across sessions — the source record's chapter
  table is the resume state). Tie-breaker: extraction ONLY populates knowledge/ —
  building or changing courses is create-course / port-library / update-course, and
  a course build may follow an extraction but is never part of one. To audit existing
  courses against the knowledge base afterwards, use knowledge-gap-check.
---

# extract-knowledge

You are populating a knowledge base for ONE specific repo and, downstream, ONE
specific learner. **Before doing anything else, read, in this order:**
`.claude/course-authoring/knowledge-base.md` (what a concept is, the two tiers, the
merge protocol), `.claude/course-authoring/citations.md` (the citation contract),
`.claude/course-authoring/source-licensing.md` (the license gate), and
`.claude/course-authoring/learner-profile.md` (misconception/trap capture is
calibrated to this learner; definitions record what the field says at the field's
level).

Work through the 5 phases below **in order**. Each phase has a GATE — a checklist
that must be fully true before you move on. The per-chapter loop in Phase 3 is
interruption-safe by design: keep it that way by updating the state table the moment
a chapter finishes, never in a batch at the end.

---

## Phase 1 — Intake & license

**Goal:** know what you are extracting, whether you may, and where you left off.

1. Locate the PDF in `source-papers/` and check its name against the
   `YYYY-firstauthor-shortname.pdf` convention — if it doesn't match, rename it (or
   ask, if the right name is ambiguous) before anything else; the source-record slug
   and BibTeX key both derive from it.
2. **Check the source license FIRST** per `source-licensing.md` (first + last pages,
   footers, stated terms). Any FLAG blocks: present the warning and wait for
   explicit human confirmation. Extraction paraphrases into `knowledge/` — a
   published site — so this gate is not skippable.
3. **Resume check.** If `knowledge/sources/<slug>.md` already exists, this is a
   resume: read its chapter table and extraction log, then jump to Phase 3 (skip
   Phase 2 — the survey is already done). Otherwise create the record now from
   `.claude/course-authoring/kb-source-template.md` and write the
   `**Source license:**` verdict line immediately (CI greps for it).
4. **Scope.** Ask the user (or read from their request): extract the **full book**
   or only **chapters relevant to a stated goal**? Default for a textbook is
   goal-relevant chapters — full-book is a multi-session commitment. A paper is
   always full-paper. Record the decision in the record's `**Extraction scope:**`
   line.

**GATE 1:** ☐ License verdict recorded in the source record (FLAG → human confirmed).
☐ Scope recorded. ☐ If resuming: state table read and this phase's other steps
skipped, not redone.

---

## Phase 2 — Survey pass

**Goal:** a map of the whole source before extracting any of it.

1. Read the table of contents, preface, and (for a textbook) the index — in Read
   slices of ≤20 pages. Do not read body chapters yet.
2. Fill in **Big ideas (backward design)**: 3–7 bullets on what the source wants a
   reader to be able to DO — capabilities, not chapter titles.
3. Fill in the **chapter coverage map**: one row per chapter with its page range and
   status `pending`, or `skipped (<reason>)` for chapters outside the Phase-1 scope.
   For a paper, "chapters" are its sections; a short paper may be one row.
4. While surveying, note in the record any chapters the preface/TOC flags as
   pivotal or notoriously hard — those are where threshold concepts and
   misconceptions concentrate; you'll extract them with extra care.

**GATE 2:** ☐ Every chapter has a state row with a page range. ☐ Big ideas written.
☐ Scope decision visible as `skipped` rows, not silence.

---

## Phase 3 — Per-chapter extraction (the resumable loop)

**Goal:** the source's knowledge, merged into `knowledge/`, chapter by chapter.

For each `pending` chapter, in order:

1. Set its state row to `in progress`.
2. Read the chapter's pages in ≤20-page Read slices.
3. For each unit of knowledge, apply the **two-tier granularity heuristic**
   (`knowledge-base.md`):
   - Atomic term → a row in `knowledge/glossary.md` (create the file from the
     format in `knowledge-base.md` if it doesn't exist; keep rows alphabetized).
     If the term exists from another source: augment the row; on a genuine
     disagreement, promote to a concept page.
   - Lesson-anchoring concept → a page in `knowledge/concepts/`. Check
     `knowledge/README.md` and the directory for an existing slug FIRST (prefer an
     existing `foundations/<slug>` name on a 1:1 match). **Create** from
     `kb-concept-template.md`, or **merge** into the existing page per the
     protocol in `knowledge-base.md` — add, never overwrite; conflicts go to
     "Source disagreements" with both sides cited.
4. Every claim gets a `[@key, pinpoint]` citation per `citations.md` — the tightest
   pinpoint you actually verified.
5. **Math fidelity rule:** PDF text extraction garbles dense equations. Transcribe
   an equation only if you can read it cleanly on the page; otherwise record the
   claim WITHOUT the formula and log the page in "Open questions & low-confidence
   extractions". **Never reconstruct an equation from memory** — a plausible-looking
   wrong formula is the worst artifact this skill can produce.
6. **The commit point:** the moment the chapter is done, update its state row to
   `done` with the concepts/glossary entries extracted and any confidence note, and
   append a dated line to the extraction log — BEFORE starting the next chapter.
   If the session ends mid-book, the record is the resume state.

**GATE 3 (per chapter, before starting the next):** ☐ State row updated. ☐ Every
new claim cited with a verified pinpoint. ☐ Garbled/uncertain material logged, not
guessed.

---

## Phase 4 — BibTeX & registration

**Goal:** the KB indexes, bibliography, and site all reflect the new content.

1. Add the source's entry to `knowledge/references.bib` (skip if resuming and it's
   already there). Key = the filename transform per `citations.md`; verify
   bibliographic details against the work's own title page or DOI, never memory.
2. Run `Rscript scripts/gen-kb-index.R`, then `Rscript scripts/gen-kb-index.R
   --check` (must exit 0).
3. Run `quarto render` from the repo root. Fix and re-render until green. (No
   quarto/R available? Say so explicitly in your final report — never claim it
   rendered.)
4. Run `Rscript scripts/check-indexes.R` — checks 7–10 cover KB registration,
   citation resolution, concept links, and the cited-page floor.

**GATE 4:** ☐ Bib entry present; key matches the filename transform. ☐ gen-kb-index
`--check` exits 0. ☐ Render green (or honestly reported). ☐ check-indexes green.

---

## Phase 5 — Self-check & report

**Goal:** the KB is trustworthy, and the user knows what changed.

1. Sweep the source record: every chapter row is `done` or `skipped (<reason>)` —
   or, for a deliberately partial session, remaining rows are `pending` and the
   extraction log's last line says so.
2. Sweep every concept page touched this session: every claim cited; prose
   paper-agnostic; Prerequisites links resolve to real concept pages;
   disagreements double-cited.
3. Suggest — do not run — a follow-up: "run knowledge-gap-check to see whether
   existing courses/foundations should be updated against the new knowledge."
4. Report: source record path; chapters done/skipped/still pending; concept pages
   created and augmented (with slugs); glossary terms added; low-confidence count
   (with record pointer); render + check status.

**GATE 5 (definition of done):** ☐ Record state consistent with reality. ☐ Sweep
clean. ☐ Report delivered with the gap-check suggestion.
