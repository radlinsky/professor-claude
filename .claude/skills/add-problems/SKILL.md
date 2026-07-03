---
name: add-problems
description: >
  Add practice problems (or lesson "check yourself" questions) to an EXISTING course
  or foundation module, without rebuilding the course. Use when the user says "add
  problems to <module>", "more practice on X", "write a few exercises for this
  lesson", or wants extra reps for a concept that already has a lesson. For building
  a whole new course from scratch, use create-course instead.
---

# add-problems

You are authoring problems for ONE specific learner into a module that already
exists. The full authoring contract — difficulty ramp, the copy-able-data rule,
hidden worked answers, notation reuse — lives in one place; do not reinvent it.

## Read first (shared with create-course, single source of truth)

1. `TEACHING.md` (repo root) — the teaching contract problems inherit.
2. `.claude/course-authoring/learner-profile.md` — who the learner is.
3. `.claude/course-authoring/problem-authoring.md` — HOW to write a problem
   (the fading ramp, copy-able data, spot-the-error, interleaving).
4. `.claude/course-authoring/notation-style.md` — symbol pronunciations to reuse.
5. `.claude/course-authoring/interactive-webr.md` — the interactive/static split: a
   problem's solve-it **starter** is a live `{webr}` cell; its worked **answer** stays
   baked `{r}`.

## Procedure

1. **Locate the target.** Find the module the user means (a
   `courses/<slug>/modules/NN-*/` or `foundations/<slug>/` folder). If ambiguous,
   ask which module. Confirm whether they want problems added to `practice.qmd`, new
   "Check yourself" questions in `lesson.qmd`, or both.

2. **Lock the context.** Read that module's `lesson.qmd` to pin down its toy example,
   its exact symbols and pronunciations, and what it teaches. New problems must reuse
   that notation and stay within what the lesson (plus its prerequisites) has taught.
   Read the existing `practice.qmd` so new problems continue the difficulty ramp and
   don't collide with existing chunk labels.

3. **Draft the problems** following `problem-authoring.md` to the letter — especially:
   every data-bearing question opens with a copy-able starter chunk, and every answer
   is a fully-worked collapsed callout. Per `interactive-webr.md`, write each starter
   as a live `{webr}` cell (`#| autorun: false`) and keep the answer chunk baked `{r}`.
   If the module is part of a PORTED course (it validates a from-scratch reimplementation
   against a frozen equivalence fixture), a new solve-it problem may re-run that function
   against the lesson's already-embedded frozen reference numbers — reuse them, don't
   invent new reference values.

4. **Insert them.** Add practice problems as new numbered `## Problem N` sections
   (keep any cliffhanger problem last). Add "Check yourself" questions inside the
   lesson's existing section. `{r}` answer chunks need unique labels; `{webr}` starters
   take no label (name them in a leading comment). **If the target file has no live
   cells yet** (no `engine: knitr` + `_knitr.qmd` include in its header), add both when
   you introduce the first `{webr}` cell — see `interactive-webr.md`.

5. **Verify.** Run `quarto render` from the repo root until green. A baked `{r}` answer
   executes at build; a `{webr}` starter is emitted for the browser and is NOT run at
   build (its in-browser execution is a manual/CI check). Then re-check the new content
   against `.claude/course-authoring/content-review-checklist.md` — notation, symbol
   coverage, arithmetic-matches-R, copy-able starters, and the check-12 interactive
   wiring.

Do NOT touch the syllabus, roadmap, or README indexes — you are adding problems to an
existing module, not restructuring the course.
