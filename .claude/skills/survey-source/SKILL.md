---
name: survey-source
description: >
  Lightweight triage of a PDF in source-papers/ BEFORE any extraction: check the
  license, read only the front/back matter (title page, abstract/preface, table of
  contents, index), map the source's chapters against the existing courses and
  foundations, and PROPOSE what the source is relevant to — existing material or
  new-course/foundation opportunities — so the user can pick an extraction goal
  from an informed menu. Applies identically to papers and textbooks. Use when the
  user says "survey <pdf>", "what's in this source", "which courses would <pdf>
  help", "triage source-papers/…", or "propose what to extract from <pdf>".
  Tie-breaker: this skill NEVER reads body chapters and writes ONLY the source
  record + bibliography entry — full extraction is extract-knowledge (which runs
  this skill automatically when no record exists); building a course is
  create-course/port-library.
---

# survey-source

You are answering one question cheaply: **what is this source good for, for THIS
repo and THIS learner?** The output is a `knowledge/sources/<slug>.md` record whose
Relevance proposal lets the user decide the extraction goal — the record is the
handoff artifact the extraction skills resume from. **Before doing anything else,
read, in this order:** `.claude/course-authoring/knowledge-base.md` (what the
record is for), `.claude/course-authoring/citations.md` (bib key convention),
`.claude/course-authoring/source-licensing.md` (the license gate), and
`.claude/course-authoring/learner-profile.md` (relevance is judged for this
learner, not in the abstract).

Stay cheap: front/back matter only, in ≤20-page Read slices. If you find yourself
reading a body chapter, you have drifted into extract-knowledge's job — stop.

Work the 7 steps in order; each has a GATE.

---

## Step 1 — Locate & license

1. Locate the PDF in `source-papers/` and enforce the
   `YYYY-firstauthor-shortname.pdf` naming convention — rename if needed (ask only
   if the right name is ambiguous); the record slug and BibTeX key derive from it.
2. **Check the source license FIRST** per `source-licensing.md` (first + last
   pages, footers, stated terms). Any FLAG blocks: present the warning and wait
   for explicit human confirmation. This applies to every source — paper or
   textbook, no exceptions.
3. If `knowledge/sources/<slug>.md` already exists, the survey was already done —
   never redo it. Two cases:
   - goal still `undecided — survey only` → jump straight to Step 5 (the
     proposal already exists; only the decision is missing);
   - goal decided → report the record's proposal, goal, and state, and stop
     (changing a decided goal is editing the Decision line + skipped rows —
     offer it, don't assume it).

**GATE 1:** ☐ Filename convention holds. ☐ License verdict determined (FLAG →
human confirmed). ☐ Existing record detected and reported instead of re-surveyed.

---

## Step 2 — Lightweight read

Read, in ≤20-page slices: the title page, the abstract (paper) or preface
(textbook), the full table of contents, and — textbooks — a skim of the index for
recurring terms. **No body chapters.** Note anything the preface/TOC flags as
pivotal or notoriously difficult — that is where threshold concepts and
misconceptions concentrate, and it belongs in the record for extraction to use.

**GATE 2:** ☐ You can say in two sentences what the source covers and who it's
written for. ☐ You have every chapter/section title with its page range. ☐ No body
chapter was read.

---

## Step 3 — Record scaffold

Create `knowledge/sources/<slug>.md` from
`.claude/course-authoring/kb-source-template.md`:

- `**Source license:**` verdict line NOW (CI greps for it).
- `**Extraction goal:**` set to `undecided — survey only` (Step 5 replaces it).
- **Big ideas (backward design):** 3–7 bullets on what the source wants a reader
  able to DO — capabilities, not chapter titles.
- **Chapter coverage map:** one row per chapter with page ranges, all `pending`
  for now (Step 5 sets the skipped rows). For a paper, "chapters" are its
  sections; a short paper may be one row.
- Pivotal/hard-chapter notes from Step 2.

**GATE 3:** ☐ Record exists with license line, big ideas, and a complete chapter
map. ☐ Nothing invented — every big idea traces to the preface/TOC/abstract you
actually read.

---

## Step 4 — Relevance proposal

The heart of the survey. Read `courses/README.md` and `foundations/README.md`
(module lists and Concepts columns), then fill the record's `## Relevance
proposal` table: for each chapter/section, which EXISTING course or foundation it
could feed (link it, one line on why), and/or which NEW course or foundation the
material suggests — phrased as a capability for this learner ("could anchor a
course on reading mixed-model papers"), not a topic noun. `no clear match` is an
honest and useful entry; do not force relevance.

**GATE 4:** ☐ Every chapter row has a proposal entry (match, opportunity, or "no
clear match"). ☐ Existing-material links resolve. ☐ Opportunities are
capability-phrased and learner-appropriate.

---

## Step 5 — Decision point

Present the proposal to the user as a menu and ask which goal this extraction
serves. Valid answers: one or more existing courses/foundations; a planned new
course; "full encyclopedic extraction" (explicit choice, never a default); or
"survey only — decide later". Then:

- Write the choice into `**Extraction goal:**` and the proposal's
  `**Decision (YYYY-MM-DD):**` line.
- Set out-of-scope chapters to `skipped (out of scope for <goal>)`; in-scope
  chapters stay `pending`. For "survey only", leave everything `pending` and the
  goal `undecided — survey only`.

This ask is BLOCKING in interactive use. (The `knowledge-extractor` agent cannot
ask — it delivers the proposal as its report and stops; see the agent definition.)

**GATE 5:** ☐ Goal recorded (or explicitly `undecided — survey only`). ☐ Skipped
rows name the goal. ☐ No scope was silently chosen for the user.

---

## Step 6 — Bib entry & register

1. Add the source's entry to `knowledge/references.bib` (key = the filename
   transform per `citations.md`; verify bibliographic details against the title
   page you read — never memory). This is not optional for a survey-only record:
   CI (check-indexes.R check 8) requires the record's declared `**Bib key:**` to
   resolve.
2. Run `Rscript scripts/gen-kb-index.R`, then `--check` (exit 0), then
   `Rscript scripts/check-indexes.R`. A full `quarto render` is NOT required here
   (one new plain page; the site picks it up on its next build) — say so in the
   report rather than claiming a render.
3. **Batch note:** when this skill runs as Phase A of a batch (see
   extract-knowledge §Batch extraction), steps 6.1–6.2 still run per source —
   surveys are sequential in the parent session, so there is no race.

**GATE 6:** ☐ Bib entry present, key matches the filename transform.
☐ gen-kb-index `--check` exits 0. ☐ check-indexes green.

---

## Step 7 — Report

Tell the user: the record path; the two-sentence what-this-source-is; the
proposal summary (matches, opportunities, no-clear-match count); the recorded
goal; and the follow-up — "extract knowledge from <slug>" starts extraction from
this record (or, for an undecided record, "tell me the goal and I'll update the
record, then extract").

**GATE 7 (definition of done):** ☐ Record complete and internally consistent
(goal line ↔ Decision line ↔ skipped rows). ☐ Report delivered with the follow-up
command. ☐ Nothing outside `knowledge/sources/<slug>.md`, `knowledge/references.bib`,
and the generated index blocks was touched.
