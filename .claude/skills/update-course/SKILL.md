---
name: update-course
description: >
  Safely modify or extend EXISTING teaching material in this repo: fix an error,
  improve an explanation or intuition section, rewrite a section, add a section or
  a whole module to an existing course, retrofit new template sections into old
  lessons, or update links. Use when the user says "improve/fix/revise/extend
  <lesson|module|course>" or "add a module to <course>". For building a whole NEW
  course use create-course; for ONLY adding practice problems use add-problems.
---

# update-course

You are changing material a learner may already be partway through. The danger is
never the edit itself — it is the web of things the edit silently touches: verified
numbers quoted in three places, anchors other lessons reuse, slugs external repos
reference, prose that disagrees with the chunk below it. This procedure exists to
make those breakages impossible to miss.

**Read first:** `TEACHING.md` (repo root) — especially §Revising existing material
and §Self-check — and `.claude/course-authoring/learner-profile.md`. Read other
course-authoring files at the step that uses them.

Work the 6 steps in order. Each has a GATE.

---

## Step 1 — Scope

1. Identify exactly which files change. If the user's request is ambiguous about
   which module/course, ask; otherwise don't.
2. Read every target file fully before deciding anything.
3. Classify the change (this decides which later rules bite):
   - **fact fix** — a number, formula, or claim is wrong;
   - **explanation improvement** — same facts, better teaching (incl. improving a
     "Getting a feel for it" section or retrofitting newer template sections —
     warm-up, traps, recap — into an older lesson);
   - **new section** within an existing file;
   - **new module** in an existing course (or a new foundation module);
   - **restructure** — renames, renumbering, moving content between files.
4. For a **fact fix**: verify the fact is actually wrong by recomputing it (run the
   R) before changing anything. If your rewrite of an *explanation* surfaces a fact
   that looks wrong, STOP and flag it to the user — never silently "fix" facts
   during a teaching rewrite (TEACHING.md revision rule).

**GATE 1:** ☐ File list explicit. ☐ Change classified. ☐ Any "wrong fact" verified
wrong by recomputation, or flagged to the user instead.

---

## Step 2 — Impact scan (before touching anything)

Grep the repo for everything the edit could silently break, and list what must
change together:

1. **Slugs & paths** — if renaming/renumbering: `grep -rn "<old-slug>"` across
   `courses/`, `foundations/`, `_quarto.yml`, both README indexes. Slugs are
   referenced by external repos (see COURSE-REQUEST constraints) — prefer keeping
   them; renames need the user's OK.
2. **Numbers** — any toy-example value, verified result, or quoted output you are
   changing: grep for it; the same number often appears in the lesson prose, its R
   chunk comments, the practice answers, and later modules' warm-ups or interleaved
   problems.
3. **Anchors & pronunciations** — if the edit touches an analogy or a symbol
   reading, check `notation-style.md` and other lessons that reuse it (anchors are
   deliberately shared repo-wide).
4. **Cross-references** — links from syllabus, roadmap, other modules' "Builds on"/
   "Where this goes next", and README index rows that describe the content.

**GATE 2:** ☐ A written list of every file that must change together, with why.
☐ No planned slug change without user approval.

---

## Step 3 — Apply, under the revision rules

- Follow `TEACHING.md` for anything you write — new sections/modules use the
  current templates in `.claude/course-authoring/` (a **new module** additionally
  follows the create-course skill's Phase 4–6 rules: lesson + practice + resources,
  genericity classification, paper-agnostic if it lands in `foundations/`).
- If the edit adds runnable code, or retrofits interactivity into an older lesson,
  follow `.claude/course-authoring/interactive-webr.md`: tweak/solve cells become live
  `{webr}` (and the file gains `engine: knitr` + the `_knitr.qmd` include if it lacks
  them); baked listings, worked answers, and non-WebR-runnable code stay `{r}`. Never
  add a per-file `format:` — the project renders every page as live-html.
- If the edited lesson is part of a PORTED course (it self-checks a from-scratch
  reimplementation against a frozen `equivalence/fixtures/*.json`): keep the
  reimplementation's signature and the fixture in sync — if you change what the function
  takes or returns, regenerate the fixture (`equivalence/generate/regenerate-all.sh`)
  and re-run `Rscript equivalence/check.R`, and update the reference numbers embedded in
  the lesson's `{webr}` self-check. A mismatch silently breaks the check.
- A teaching rewrite changes the *explanation*, never the *facts*. Preserve
  verified numbers unless Step 1 proved them wrong and you recomputed replacements.
- Keep pronunciations consistent with `notation-style.md`; keep established anchors
  unless the improvement IS the anchor (then update every reuse found in Step 2).
- Mark any added beyond-the-need depth **Optional**.
- Never modify the learner-owned *Status* columns in the README indexes.
- Update every file on the Step-2 must-change-together list in the same pass.

**GATE 3:** ☐ Every Step-2 list item addressed. ☐ No fact changed without
recomputation. ☐ New content follows the current templates.

---

## Step 4 — Re-register

Only when files were added/renamed/removed:

- Root `_quarto.yml`: add/fix each page in BOTH the render list and the sidebar
  (paths relative to repo root; no per-course `_quarto.yml` — see
  `course-structure.md`).
- `courses/README.md` / `foundations/README.md`: update rows (never Status);
  new foundation modules get a row; new course modules may change the course row's
  "Teaches" summary.
- Syllabus and `00-roadmap.qmd` of the affected course: new/renamed modules appear
  in both, with the Mermaid diagram updated.

**GATE 4:** ☐ `_quarto.yml`, both READMEs, syllabus, and roadmap all agree with the
new file reality (skip-checked even for edits that "shouldn't" need it).

---

## Step 5 — Verify

1. `quarto render` from the **repo root** until green — every baked `{r}` chunk
   executes (live `{webr}` cells are emitted for the browser, not run at build; their
   in-browser execution is a manual/CI check — `interactive-webr.md`). (No quarto/R
   available? Run the changed R via `Rscript` and say plainly in your report that a
   full render was not possible.)
2. If you added/changed any URL: WebFetch-verify it now
   (`resource-curation.md` rules — never write an unverified URL).
3. If a setup chunk gained a package: `Rscript -e 'renv::snapshot()'`.
4. Re-check one rendered page's answer callouts are still collapsed if you touched
   callouts.

**GATE 5:** ☐ Render green (or honestly reported). ☐ Touched URLs verified.
☐ renv.lock snapshotted if packages changed.

---

## Step 6 — Review & report

**Preferred:** dispatch the `course-auditor` agent on every changed file; fix
confirmed defects, re-verify (back through Step 5), re-dispatch until clean.
Fallback (no agent tool): self-review against
`.claude/course-authoring/content-review-checklist.md` with fresh eyes and disclose
that the review was self-performed.

Report to the user: what changed and why, the classification from Step 1, every
file touched, render status, and the review verdict. If the change altered what a
module teaches, say whether the learner should redo it (and update nothing in the
Status column yourself).

**GATE 6 (definition of done):** ☐ Auditor (or disclosed self-review) clean.
☐ Report delivered.
