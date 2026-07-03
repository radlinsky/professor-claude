---
name: port-library
description: >
  Turn a real method — an R/Python/C/C++/Fortran library, a paper's methods section,
  or a GitHub repo (code-only, formulas-only, or with no runnable data) — into a
  built-up course that rebuilds the method FROM SCRATCH in base R, PROVES the rebuild
  matches the real thing via the equivalence harness, and teaches it with interactive
  in-browser WebR lessons. Use when the learner says "teach me the math behind <method
  in this library/paper/repo>", "port <library> into a course", "rebuild <algorithm>
  from scratch and show it matches", or points at source code / a paper / a repo URL
  and wants the method taught. For a course from a concept or paper with NO real
  implementation to validate against, use create-course. For changing existing material
  use update-course; for only adding problems use add-problems.
---

# port-library

You are porting a real method into a course for ONE specific learner. This skill is
**thin on purpose**: it owns only the three things that make a *port* different from an
ordinary course — reading the source, rebuilding the algorithm, and proving the rebuild
correct — and then hands the actual teaching build to `create-course`. It does not
restate the teaching contract or the course pipeline; it links to them.

**Before doing anything, read** (in this order): `TEACHING.md` (the teaching contract),
`.claude/course-authoring/learner-profile.md` (who you teach), `equivalence/README.md`
(the harness: the three validation tiers, the generate/check split, the fixture format,
`check_fixture()`), `docs/webr-decision.md` §2–3 (what WebAssembly can and cannot run —
the reason the real library is validated at authoring time, not in the browser), and
`.claude/course-authoring/interactive-webr.md` (the interactive/static split).

Work the four phases in order. Each has a GATE that must be fully true before you move
on. Phases P1–P3 are this skill's job; P4 runs the `create-course` pipeline.

---

## Phase P1 — Source intake & algorithm extraction

**Goal:** know the actual algorithm, and know what can be *run*.

1. Locate and read the SOURCE. Handle every input kind:
   - a **library** (R/Python/C/C++/Fortran): find the function that does the work and
     read its real implementation — not just its docs.
   - a **paper / methods section**: extract the equations verbatim, with their numbers.
   - a **repo** (may be code-only, formulas-only, or lack runnable data/results): read
     what is there; note what is missing.
1.5. **Check the source license FIRST**, per
   `.claude/course-authoring/source-licensing.md` — resolve the upstream license
   (`gh api repos/{owner}/{repo}/license`, CRAN `DESCRIPTION`, PyPI metadata) *before*
   you read the implementation to rebuild it. Flag anything not clearly open and get
   explicit human confirmation before continuing; note the verdict for the syllabus.
2. Write the algorithm as a **numbered list of update steps** in your own words — the
   thing the course will rebuild. Be concrete: each step is an assignment or an update
   rule, not a paragraph.
3. **Detect what is actually runnable** (this decides the validation tier in P3):
   - Can you install and RUN the real reference on simulated inputs, in any language?
     (R package → separate lib; Python → venv; C/C++/Fortran → compile a driver — recipes
     in `equivalence/README.md`.) → aim for **full** tier.
   - No runnable reference, but the paper/repo reports specific numbers/figures? →
     **partial** tier (transcribe them, with citation).
   - Neither? → **fallback** tier (a closed-form / analytic value, or a self-consistency
     invariant the method must satisfy).
4. For anything a **live `{webr}` cell** might load, confirm wasm availability the way
   `docs/webr-decision.md` §2 describes — and heed the trap there: a binary existing in
   the wasm repo does NOT mean its workflow runs. Test the workflow, not the binary. The
   from-scratch rebuild must be **base R** so it runs in the browser regardless.

**GATE P1:** ☐ Source license checked (upstream resolved before reading the code);
any flag confirmed by the human; verdict noted for the syllabus. ☐ The algorithm is
written as concrete numbered steps. ☐ You know which validation tier the source
supports, and why. ☐ You know what (if anything) the real reference needs to run, and
in which language.

---

## Phase P2 — Incremental base-R reimplementation design

**Goal:** the method rebuilt from scratch in teachable pieces a course can walk UP to.

1. Decompose the algorithm (P1) into 2–4 **teachable pieces**, each a building block the
   learner can understand and code before the next depends on it. This decomposition IS
   the target list you will hand to `create-course` Phase 2 — walking bottom-up from the
   learner's baseline (`learner-profile.md`) to the full method. Every math prerequisite
   a piece needs (a notation, an algebra/calculus move, a linear-algebra idea) is itself
   a step to teach or a foundation module — never assumed.
2. Write the from-scratch reimplementation in **base R only** (so it runs unchanged in a
   `{webr}` cell). Keep it in the shape the harness expects: a function taking the
   fixture's `inputs` and returning outputs whose names match the fixture's `reference`
   keys (see `equivalence/reimplementations/*.R` for the pattern). Write it the way the
   course will build it — plain, no clever vectorization the learner hasn't been taught.
3. Design **simulation data** the method runs on — small, seeded, and (where it aids
   teaching) rounded to numbers the lesson can show and the learner can eyeball.

**GATE P2:** ☐ The reimplementation is base R and returns the reference's output shape.
☐ It is split into teachable pieces mapped to prospective modules. ☐ You have seeded
simulation data.

---

## Phase P3 — Equivalence fixtures (the proof)

**Goal:** a frozen, checked-in proof that the rebuild matches the reference within
tolerance — the thing a `{webr}` lesson later lets the learner re-run. Follow
`equivalence/README.md` §"Add a new target".

1. Write `equivalence/reimplementations/<slug>.R` (the P2 function).
2. Write a generator `equivalence/generate/<slug>_<tier>_<ref>.{R,py,c,…}` at the
   **strongest tier P1 supports**, emitting `equivalence/fixtures/<slug>.json` with
   `meta` (record `tier` and `source`+version), `inputs`, `reference`. Reference libs
   install into the gitignored `equivalence/env/` — never renv.lock (`.renvignore`
   guards this).
3. Wire it into `equivalence/check.R` (a `source(...)` line + one `targets` entry) and
   into `equivalence/generate/regenerate-all.sh`.
4. Regenerate, then run `Rscript equivalence/check.R` — it must report the new target
   PASS. Tune the fixture `tolerance` (and the reimplementation's own hyperparameters,
   e.g. an iteration count) so the check passes **honestly** — set the knob explicitly,
   never tighten blindly. If a full reference cannot be made to run, DROP a tier and say
   so in `meta` and in your report — **never let a missing reference block the course.**

**GATE P3:** ☐ `Rscript equivalence/check.R` is green including the new target. ☐ The
fixture records the tier actually used and the reference source+version. ☐ Nothing under
`equivalence/env/` is staged, and `renv.lock` is unchanged.

---

## Phase P4 — Build the course (delegate to create-course)

**Goal:** the taught course, using everything above.

Run **`create-course` phases 3–8** (syllabus & roadmap → lessons → practice → resources
→ verify & register → content review) with the P2 decomposition as the module list. Do
not re-derive the pipeline or the teaching contract — follow `create-course`. Apply these
**port-specific deltas**, which are the whole point of a ported course:

- **The from-scratch build is interactive.** The lessons that rebuild the method are
  live `{webr}` cells the learner edits and runs (`interactive-webr.md`) — the "Explore
  it" tweak-a-parameter cells and the practice starters especially.
- **Each rebuilt piece self-checks against its frozen reference.** In the module that
  completes a piece, add a live `{webr}` cell that runs the learner's from-scratch
  function on the fixture's inputs and compares to the frozen `reference` numbers (embed
  the small reference values inline — a browser `{webr}` session has no file path to
  `equivalence/fixtures/`; the file-based `check_fixture()` gate stays in native
  `check.R`/CI). The learner watches their rebuild land on the real optimizer's answer.
- **The real library is static.** Where the reference exists but can't run in the browser
  (compiled / non-wasm — `docs/webr-decision.md` §3), show it as a baked `{r}` chunk
  under the "runs on your machine, not here" callout (`interactive-webr.md`).
- **The capstone decodes the real source.** "Return to the source" (per
  `course-structure.md` §Capstone) decodes the actual library signature / paper equations
  the port started from, backlinking each term to the module that rebuilt it.
- **Record the tier in the course.** State, in the module that validates, which tier
  proved the match and why (full / partial / fallback) — the learner should know whether
  they matched a running library, a paper's reported numbers, or a closed form.

**GATE P4 = create-course GATES 3–8** (render green, indexes updated, `course-auditor`
clean), plus: ☐ the validating module's `{webr}` self-check reproduces the frozen
reference, ☐ the real-library comparison is static and labeled, ☐ the tier is stated in
the course.

---

## Report

Tell the learner: the course path and suggested order (create-course Phase 8), **which
validation tier proved the port and why**, where the interactive self-check lives, and
what (if anything) about the source could not be run — honestly.
