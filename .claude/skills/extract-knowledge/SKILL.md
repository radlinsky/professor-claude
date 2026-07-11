---
name: extract-knowledge
description: >
  Extract a textbook or paper PDF from source-papers/ into the repo's citable
  knowledge base (knowledge/): definitions, notation, derivations, terminology,
  misconceptions, teaching insights, and prerequisite structure, every claim cited.
  Use when the user says "extract knowledge from <pdf>", "ingest this textbook/paper",
  "add <source> to the knowledge base", or "resume extraction of <source>" (big books
  are extracted chapter by chapter across sessions — the source record's chapter
  table is the resume state). Extraction is driven by the source record the
  survey-source skill creates (license verdict + user-chosen extraction goal); when
  no record exists this skill runs survey-source first. Tie-breaker: extraction ONLY
  populates knowledge/ — building or changing courses is create-course /
  port-library / update-course, and a course build may follow an extraction but is
  never part of one. To audit existing courses against the knowledge base
  afterwards, use knowledge-gap-check; to only triage a PDF without extracting,
  use survey-source directly.
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

Work through the 4 phases below **in order**. Each phase has a GATE — a checklist
that must be fully true before you move on. The per-chapter loop in Phase 2 is
interruption-safe by design: keep it that way by updating the state table the moment
a chapter (or, for long chapters, a page slice) is finished, never in a batch at
the end.

---

## Phase 1 — Intake (the record is the contract)

**Goal:** an extraction goal and license verdict you can act on, from the source
record.

1. Locate `knowledge/sources/<slug>.md` for the requested source.
   - **Record exists with a license verdict AND an `**Extraction goal:**` that is
     not `undecided`** → read its chapter table and extraction log and proceed to
     Phase 2. This is also the resume path — chapters already `done`/`skipped`
     are never redone.
   - **Record missing, or goal `undecided — survey only`** → invoke the
     **survey-source skill now** (via the Skill tool — its steps and GATEs,
     including the blocking goal decision, run in full), then return here. (The autonomous `knowledge-extractor`
     agent cannot ask: it stops before the decision and delivers the proposal —
     see its definition.)
2. **License re-gate rule:** follow `source-licensing.md` §Recorded verdicts are
   not re-gated — a properly recorded verdict proceeds without re-prompting. A
   MALFORMED verdict line (a FLAG-class license without the confirmation token,
   or an "OK" naming a license on the FLAG lists) blocks: re-run the license
   check per `source-licensing.md` and correct the record's `**Source license:**`
   line in place (human confirmation where the check demands it) — do NOT route
   through survey-source, which never redoes an existing record.
3. From the record, order the `pending` chapters for extraction **by dependency,
   not page order**: foundational chapters first (if chapter 8 builds on chapter
   3, extract 3 first — its concept pages become merge targets for 8's material,
   not duplicates). The TOC/preface notes from the survey say what builds on
   what; when unstated, page order is the fallback. Note the chosen order in the
   extraction log.

**GATE 1:** ☐ Record carries license verdict, big ideas, full chapter map,
relevance proposal, and a decided goal (all owned by survey-source). ☐ Resume
state read — nothing done twice. ☐ Extraction order noted, foundational-first.

---

## Phase 2 — Per-chapter extraction (the resumable loop)

**Goal:** the source's knowledge, merged into `knowledge/`, chapter by chapter.

For each `pending` **or `in progress`** chapter, in the Phase-1 order — an
`in progress (pp. X–Y done)` row is an interrupted chapter: resume it FIRST,
starting from the page after Y (never re-extract the done range):

1. Set its state row to `in progress`.
2. Read the chapter's pages in ≤20-page Read slices. **Long chapters (> ~30
   pages):** after each slice, update the state row to
   `in progress (pp. X–Y done)` — sub-chapter resume granularity, so a session
   that dies mid-chapter loses one slice, not the chapter.
3. For each unit of knowledge, apply the **two-tier granularity heuristic**
   (`knowledge-base.md`):
   - Atomic term → a row in `knowledge/glossary.md` (create the file from the
     skeleton in `knowledge-base.md` if it doesn't exist; keep rows alphabetized).
     If the term exists from another source: augment the row; on a genuine
     disagreement, promote to a concept page.
   - Lesson-anchoring concept → a page in `knowledge/concepts/`. Check
     `knowledge/README.md` and the directory for an existing slug FIRST (prefer an
     existing `foundations/<slug>` name on a 1:1 match). **Create** from
     `kb-concept-template.md`, or **merge** into the existing page per the
     protocol in `knowledge-base.md` — add, never overwrite; conflicts go to
     "Source disagreements" with both sides cited.
   - The extraction goal steers depth: concepts the goal's courses/foundations
     need get full pages; incidental material gets glossary rows or nothing.
4. Every claim gets a `[@key, pinpoint]` citation per `citations.md` — the tightest
   pinpoint you actually verified.
5. **Math fidelity rule:** PDF text extraction garbles dense equations. Transcribe
   an equation only if you can read it cleanly on the page; otherwise record the
   claim WITHOUT the formula and log the page in "Open questions & low-confidence
   extractions". **Never reconstruct an equation from memory** — a plausible-looking
   wrong formula is the worst artifact this skill can produce.
6. **Unreadable pages (scanned/no OCR):** log the page range in "Open questions &
   low-confidence extractions", extract what the readable pages give, and mark the
   chapter `done (partial — pp. X–Y unreadable)`. A wholly unreadable chapter →
   `skipped (unreadable — needs OCR'd copy)`, and tell the user which chapters
   need a better copy. Never guess at unreadable content.
7. **The commit point:** the moment the chapter is done, update its state row
   (`done`, or `done (partial — …)`) with the concepts/glossary entries extracted
   and any confidence note, and append a dated line to the extraction log —
   BEFORE starting the next chapter. If the session ends mid-book, the record is
   the resume state.

**GATE 2 (per chapter, before starting the next):** ☐ State row updated (incl.
slice updates for long chapters). ☐ Every new claim cited with a verified
pinpoint. ☐ Garbled/unreadable material logged, not guessed.

---

## Phase 3 — BibTeX & registration

**Goal:** the KB indexes, bibliography, and site all reflect the new content.

1. Verify the source's entry exists in `knowledge/references.bib` (survey-source
   added it; add it only if somehow missing — key = the filename transform per
   `citations.md`, details verified against the title page, never memory).
2. Run `Rscript scripts/gen-kb-index.R`, then `Rscript scripts/gen-kb-index.R
   --check` (must exit 0).
3. Run `quarto render` from the repo root. Fix and re-render until green. (No
   quarto/R available? Say so explicitly in your final report — never claim it
   rendered.)
4. Run `Rscript scripts/check-indexes.R` — checks 7–10 cover KB registration,
   citation resolution, concept links, and the cited-page floor.

**BATCH MODE variant:** if your invoking prompt says `BATCH MODE`, do step 1 only
(shared-file discipline: `.claude/agents/knowledge-extractor.md` §Parallel/batch
operation) and SKIP steps 2–4 entirely — the invoking session runs gen-kb-index.R,
quarto render, and check-indexes.R once after ALL extractors finish.
(check-indexes cannot pass mid-batch: its check 7 fails on pages not yet
registered until the parent runs the generator.) Declare the skipped steps in
your report.

**GATE 3:** ☐ Bib entry present; key matches the filename transform. ☐ Interactive:
gen-kb-index `--check` exits 0, render green (or honestly reported), check-indexes
green. ☐ Batch: steps 2–4 skipped and declared, nothing half-run.

---

## Phase 4 — Self-check & report

**Goal:** the KB is trustworthy, and the user knows what changed.

1. Sweep the source record: every chapter row is `done`, `done (partial — …)`
   with its gaps logged in Open questions, or `skipped (<reason>)` — or, for a
   deliberately partial session, remaining rows are `pending` (or
   `in progress (pp. X–Y done)`) and the extraction log's last line says so.
2. Sweep every concept page touched this session: every claim cited; prose
   paper-agnostic; Prerequisites links resolve to real concept pages;
   disagreements double-cited.
3. Suggest — do not run — a follow-up: "run knowledge-gap-check to see whether
   existing courses/foundations should be updated against the new knowledge."
4. Report: source record path; extraction goal; chapters done/partial/skipped/
   still pending; concept pages created and augmented (with slugs); glossary
   terms added; low-confidence count (with record pointer); render + check status
   (or "deferred to parent — batch mode").

**GATE 4 (definition of done):** ☐ Record state consistent with reality. ☐ Sweep
clean. ☐ Report delivered with the gap-check suggestion.

---

## Batch extraction (multiple sources)

The protocol for "extract all N of these PDFs", run by the interactive parent
session (the `knowledge-extractor` agent's §Parallel/batch rules are the
per-agent side of this):

**Phase A — survey everything, decide once.**

1. Run the survey-source skill on EACH PDF (its license gate runs here, with the
   user), but hold the extraction-goal decision: collect all N relevance proposals first, then present
   ONE combined decision menu and let the user assign each source its extraction
   goal (or "skip for now"). Write every decision into its record. Surveys are
   sequential in the parent session — records and bib entries all exist before
   any agent launches, so agents never race on `references.bib` creation.
2. Sanity-check the commitment with the user before launching: per source, the
   sum of `pending` chapter page counts. A scoped batch of textbooks is still a
   large job — the user should see the number.

**Phase B — extract with overlap-aware parallelism.**

3. Launch one `knowledge-extractor` agent per source (background), each prompt
   naming the source slug + `BATCH MODE`. Each agent hits the Phase-1 resume path;
   there is nothing left to ask it.
4. **Parallel only across sources with disjoint topics.** Sources feeding the
   SAME concepts (e.g. three stats textbooks) run sequentially or in waves — the
   later agent then merges into the earlier one's concept pages instead of racing
   it. The Phase-A relevance proposals tell you which sources overlap.
5. An agent that dies mid-book leaves an honest state table — re-launch it with
   "resume extraction of <slug>".

**Phase C — finalize once.**

6. Reconciliation checklist over the batch's diff: near-duplicate concept slugs
   (two agents minting `variance` vs `variance-basics` → merge per
   `knowledge-base.md`), duplicate glossary terms and broken alphabetization,
   duplicate `references.bib` keys. Fix what you find.
7. Run once: `Rscript scripts/gen-kb-index.R` (+ `--check`), `quarto render`,
   `Rscript scripts/check-indexes.R` — all green.
8. Combined report (per source: goal, chapters done/partial/pending, concepts,
   low-confidence counts) and suggest a `knowledge-gap-check` run.

(Worktree-per-agent isolation is deliberately not used: it trades occasional
clobbers for N-way semantic merge conflicts and heavy machinery. Check-before-
create + overlap-aware sequencing + the Phase-C checklist cover this repo's
single-operator reality; revisit only if clobbering is actually observed.)
