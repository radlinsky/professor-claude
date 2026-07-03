---
name: create-course
description: >
  Design and build a complete applied math/stats course for this repo's learner.
  Use when the user asks to create a course, learn a method or concept, understand
  the statistical methods of an academic paper, or says things like "teach me X",
  "I want to understand this formula", "make a course for the methods section of
  this paper", "create a course from source-materials/<x>/COURSE-REQUEST.md", or
  drops a paper in source-papers/ or a course request in source-materials/ and asks
  about it. For changing EXISTING material use update-course; for only adding
  problems use add-problems.
---

# create-course

You are building a course for ONE specific learner. **Before doing anything else,
read, in this order:** `TEACHING.md` (repo root — the teaching contract every file
you write must satisfy), `.claude/course-authoring/learner-profile.md` (who you are
teaching), and `.claude/course-authoring/course-structure.md` (exact layouts). Read
the other course-authoring files at the phase that uses them (each phase says which).

Work through the 8 phases below **in order**. Each phase has a GATE — a checklist
that must be fully true before you move on. Do not skip phases, do not merge phases,
do not "come back to it later".

---

## Phase 1 — Intake

**Goal:** know exactly what the course must teach.

1. Identify the target. It is one of:
   - a paper in `source-papers/` (read it; if PDF reading fails, ask the user to
     paste the methods section),
   - a pasted excerpt or URL,
   - a named concept ("Kalman filter", "mixed effects models", a formula),
   - a **course request** — a `source-materials/<x>/COURSE-REQUEST.md`. Read it
     fully: it gives the goal, extra learner notes, the target list, seed materials
     to mine, applied-practice pointers, and candidate resources. Honor its
     constraints (scope, stable slugs, "don't duplicate the external repo").
2. If the request names **seed materials** (prior notebooks, curricula in
   `source-materials/`): mine them for toy examples, build-up order, pronunciation
   tables, and exercise ideas — they show "what stuck the first time". Seeds are
   *inputs*, never course content: they may be in other languages and may not run
   here; anything project- or game-flavored gets re-toyed into neutral examples
   before it can enter `foundations/` (genericity rule).
3. Write down (in your working notes, not a file yet) the **target list**: every
   mathematical object the learner must understand at the end. Be exhaustive and
   concrete. Examples of "objects": an estimator and its formula, a model equation,
   a distribution and its parameters, a matrix operation, an optimization step, a
   test statistic, an algorithm's update rule.
4. For a paper: quote each formula/equation you intend to cover, verbatim, with its
   equation number or section.
5. If the paper contains several distinct methods, or the request is ambiguous, ask
   the user which one(s) to target before continuing. Otherwise do not ask.
6. **Check the source license** per `.claude/course-authoring/source-licensing.md`
   before quoting any formula or mining any seed. Flag anything not clearly open and
   get explicit human confirmation before continuing; note the verdict for the
   syllabus (`**Source license:**` line).

**GATE 1:** ☐ You can state, in one sentence, what the learner will be able to do
after the course (e.g., "read section 3.2 of the paper and explain every symbol in
equations 4–7"). ☐ You have the explicit target list. ☐ If a COURSE-REQUEST exists,
its constraints and seeds are captured in your notes. ☐ Source license checked; any
flag confirmed by the human; verdict noted for the syllabus.

---

## Phase 2 — Prerequisite decomposition

**Goal:** a dependency-ordered module list reaching from the learner's actual
baseline up to the target.

1. Re-read the baseline in `.claude/course-authoring/learner-profile.md` ("What the learner
   knows" / "What the learner does NOT know"). That baseline is the floor you build
   from — nothing below it needs teaching, nothing above it may be assumed.
2. For EACH item on the target list, walk backwards, asking: *"What must you already
   understand to get this?"* Recurse until every chain bottoms out at the baseline.
   - Formal notation itself counts as a prerequisite (e.g., Σ notation, subscripts,
     conditional-probability notation, matrix notation).
   - Every algebra/calculus manipulation used by a derivation is its own explicit
     prerequisite item (e.g., "expand a squared sum", "take a derivative and set it
     to 0", "log of a product = sum of logs"). Never treat a trick as an aside.
3. Merge duplicates across chains. Group the remaining items into **modules** of
   1–3 tightly related concepts each. Aim for 3–8 modules total (foundation +
   course-specific combined); if you need more, the course target is too big — tell
   the user and propose splitting into two courses.
4. **The final course module is always the capstone** — "return to the source" plus
   a cumulative problem set (format: `course-structure.md` §Capstone). It counts in
   the 3–8; plan it now, not as an afterthought.
5. Classify each module with the **genericity rule** (`.claude/course-authoring/course-structure.md`
   §Genericity): would it appear essentially unchanged in a course about a different
   paper?
   - Generic → it is a **foundation module**. Open `foundations/README.md`:
     - Already exists there? → REUSE: it becomes a link; you will not write it.
     - Doesn't exist? → you will author it into `foundations/<slug>/`.
   - Not generic → **course module**, authored into `courses/<slug>/modules/`.
   (The capstone is always a course module.)
6. Topologically sort: every module comes after all modules it depends on. Foundation
   modules always come before the course modules that need them.

**GATE 2:** ☐ Every target-list item is covered by exactly one module. ☐ Every module
either sits at the baseline or has all its prerequisites in earlier modules. ☐ Each
module is labeled `reuse-foundation` / `new-foundation` / `course`. ☐ The last module
is the capstone. ☐ Total module count is 3–8.

---

## Phase 3 — Syllabus & roadmap

**Goal:** the two orientation files the learner reads first.

Follow the exact file formats in `.claude/course-authoring/course-structure.md`. Create:

1. `courses/<course-slug>/syllabus.md` — course goal (your Gate-1 sentence), a
   **How to take this course** box (the spacing/mastery schedule — format in
   `course-structure.md`), then a **Prerequisites from the foundations library**
   section (one row per foundation module: relative link to its `lesson.qmd`, one
   line on *why this course needs it*, and "already done it? skim its pronunciation
   table as a refresher"), then one section per course module: title, "why you need
   this", concepts covered, rough time estimate.
2. `courses/<course-slug>/00-roadmap.qmd` — a Mermaid `flowchart TD` where each node is
   a module (foundation nodes visually distinct, e.g. different class/style), each
   edge means "needed for", and below the diagram a numbered "suggested order" list
   with the same relative links as the syllabus.
3. Scaffold the folders now: `courses/<course-slug>/` with empty `modules/NN-<slug>/`
   directories; `foundations/<slug>/` directories for any `new-foundation` modules.
   Then register every page you are about to create in the **root `/_quarto.yml`**
   (render list + a sidebar section) — see `.claude/course-authoring/course-structure.md`. Do NOT
   create a per-course `_quarto.yml`.

**GATE 3:** ☐ Both files exist and every module from Phase 2 appears in both. ☐ The
syllabus has the How-to-take box. ☐ All foundation links are relative paths that
resolve (check with `ls`). ☐ The root `/_quarto.yml` lists every chapter/file you
are about to create.

---

## Phase 4 — Lessons

**Goal:** one `lesson.qmd` per NEW module (both `new-foundation` and `course`).

Read `.claude/course-authoring/notation-style.md` and
`.claude/course-authoring/interactive-webr.md` now (the latter is the interactive/
static contract: the lesson's "Explore it" cells and any solve-it starters are live
`{webr}` cells; hidden setup, read-only listings, and code needing a non-WebR package
stay baked `{r}`). For each module, **copy
`.claude/course-authoring/lesson-template.qmd` and fill in every section, keeping
the section order and headings**. The template implements `TEACHING.md`'s golden
order — its HTML comments carry the per-section rules; the contract itself (what
counts as real intuition, honest anchors, annotated derivation steps, predict-then-
run, traps refuted with numbers, can-do recaps) lives in `TEACHING.md`. When a
template comment and TEACHING.md seem to disagree, TEACHING.md wins — and tell the
user.

Location rules:

- Foundation lessons must be paper-agnostic: neutral examples, no mention of the
  course, paper, or external project that prompted them.
- Write into `foundations/<slug>/lesson.qmd` or
  `courses/<course-slug>/modules/NN-<slug>/lesson.qmd`. New foundation modules also
  get registered in the root `/_quarto.yml`.
- The capstone lesson follows `course-structure.md` §Capstone instead of the
  standard template (it decodes the source; it does not introduce new concepts).
- If a COURSE-REQUEST provided applied-practice pointers, end the matching modules'
  "Where this goes next" with the **Applied practice** line (format in
  `course-structure.md`).
- For a PORTED course (you arrived here from the `port-library` skill, which already
  built the from-scratch reimplementation + frozen equivalence fixture): the module
  that completes the reimplementation adds a live `{webr}` cell that re-runs it against
  the fixture's FROZEN reference numbers (embedded inline — a browser session has no
  path to `equivalence/fixtures/`) and states which validation tier proved the match;
  the real reference library is shown static under the "runs on your machine" callout.
  See `equivalence/README.md` and the `port-library` skill; do not re-derive them here.

**GATE 4 (check per lesson before starting the next)** — the lesson-relevant items
of `TEACHING.md` §Self-check, i.e.: ☐ All template sections present, in order.
☐ Warm-up retrieves (not re-reads) from ≥2 earlier points where they exist.
☐ Every formula preceded by its toy example; every symbol has a table row.
☐ "Getting a feel for it" has a genuine analogy + why-this-construction (not a
reworded formula). ☐ No unexplained derivation step; derived results sanity-checked
numerically. ☐ Predict-then-run prompts present. ☐ Common traps refuted with the
lesson's numbers. ☐ Recap can-dos + mastery rule present. ☐ Setup chunk present
with `set.seed(42)`.

---

## Phase 5 — Practice problems

**Goal:** one `practice.qmd` per new module, next to its `lesson.qmd`.

Read `.claude/course-authoring/problem-authoring.md` — the full contract for writing problems
(the fading ramp, the copy-able-data rule, hidden worked answers, interleaving,
spot-the-error, notation reuse). It is shared with the `add-problems` skill, so it
is the single source of truth; do not re-derive the rules here.

Copy `.claude/course-authoring/practice-template.qmd` and fill it accordingly: 4–7
problems on the ramp (confidence rep → faded worked example → full/spot-the-error →
interleaved → transfer/cliffhanger), every data-bearing problem opening with a
copy-able starter chunk, and every answer a fully-worked `collapse="true"` callout.
Per `.claude/course-authoring/interactive-webr.md`, each **starter** is a live
`{webr}` cell (`#| autorun: false`) so the learner solves in-browser on a phone; the
worked **answer** chunk inside the callout stays baked `{r}`. The capstone's
cumulative set follows `course-structure.md` §Capstone.

**GATE 5:** ☐ Every new module has `practice.qmd`. ☐ The ramp is complete
(P1 confidence rep, a faded problem, a spot-the-error, an interleaved problem where
an earlier module exists, a transfer/cliffhanger last). ☐ Every answer is inside a
`collapse="true"` callout with worked steps. ☐ Every problem with specific data
opens with a copy-able starter chunk (built-in datasets / scalar-only prompts exempt).

---

## Phase 6 — Resource curation

**Goal:** verified external links, so the learner can watch/read other explanations.

Read and follow `.claude/course-authoring/resource-curation.md` exactly. Summary of its
non-negotiables:

- WebSearch per module (videos first: StatQuest, 3Blue1Brown, Khan Academy; then
  posts/interactive demos).
- **WebFetch every candidate URL** and confirm (a) it resolves, (b) it is actually
  about the module's topic. No exceptions — including candidate links inherited
  from a COURSE-REQUEST (they were verified when written, not now).
- Only verified links go into `resources.md` (course-level file with one section per
  module; new foundation modules get their own `foundations/<slug>/resources.md`).
  Each link is annotated: what it covers, format/length if known, and why it suits
  THIS learner.
- If search/fetch tools are unavailable, write `TODO: resources pending — search
  tools unavailable` in the section. **Never** write a URL you did not verify this
  session.

**GATE 6:** ☐ Every module has either 2–4 verified annotated links (minimum 2) or an
explicit TODO. ☐ Zero unverified URLs anywhere.

---

## Phase 7 — Verify & register

**Goal:** everything renders, everything is indexed, the learner knows where to start.

1. Run `quarto render` from the **repo root** (one project renders everything). Every
   baked `{r}` chunk must execute; live `{webr}` cells are emitted for the browser and
   are NOT run at build (their in-browser execution is a manual/CI check — see
   `.claude/course-authoring/interactive-webr.md`). Fix errors and re-render until
   green. (No quarto/R available? Say so explicitly in your final report — never claim
   it rendered.)
2. Open the rendered HTML of one lesson and confirm the answer callouts are
   collapsed by default.
3. If any lesson added an R package (a non-empty `needed` vector), run
   `Rscript -e 'renv::snapshot()'` so `renv.lock` records it.
4. Register:
   - Add the course row to `courses/README.md` (link, teaches, source, foundation
     prerequisites, status `not started`).
   - In `foundations/README.md`: add rows for new foundation modules (Status
     `not started`); append this course to the *Used by* column of every foundation
     module the course links to. Never modify existing *Status* values.

(The final report to the user happens in Phase 8, after the content review.)

**GATE 7:** ☐ Render green (or inability honestly reported). ☐ Callouts collapsed.
☐ `renv.lock` snapshotted if packages were added. ☐ Both README indexes updated.

---

## Phase 8 — Content-accuracy review

**Goal:** catch the math/notation defects that render perfectly green. A course that
compiles is not a course that is correct — this gate is the difference.

**Preferred: dispatch the `course-auditor` agent** (`.claude/agents/course-auditor.md`)
on every new lesson/practice file — it re-derives nothing, reads with genuinely
fresh eyes, and reports defects with evidence. Fix every confirmed defect, re-render
(back through Phase 7), and re-dispatch until it reports clean.

Fallback (no Task/Agent tool available): read
`.claude/course-authoring/content-review-checklist.md` and run it yourself against
every new file, re-reading as if you had never written it — and say in your report
that the review was self-performed.

Then report to the user: course path, suggested learning order (foundation modules
first, with "new" vs "review" flags from the Status column), module list, render
status, resource counts, and the content-review result.

**GATE 8 (definition of done):** ☐ Every new lesson/practice file reviewed
(auditor, or self + disclosed). ☐ All defect classes clear. ☐ Any fixes re-rendered
green. ☐ Final report delivered.
