# Problem-authoring contract

The single source of truth for how to write practice problems and "check yourself"
questions for this repo's learner. Both the `create-course` skill (Phase 5) and the
`add-problems` skill/`problem-creator` agent follow this file — do not restate these
rules elsewhere, link here.

Read root `TEACHING.md`, `learner-profile.md`, and `notation-style.md` alongside
this file. Problems inherit the teaching contract; nothing below overrides it —
this file adds the problem-specific mechanics.

## Where problems live

- **Practice set:** `<module>/practice.qmd` — 4–7 problems on the fading ramp.
- **Check yourself:** the quick questions inside a lesson's "Check yourself"
  section (answerable in under a minute each, straight from that lesson).

## The fading ramp (practice sets)

The set walks from imitation to transfer (worked-example fading — reading solutions
and solving cold are different skills; the ramp bridges them):

- **Problem 1 — confidence rep. ALWAYS** "redo the lesson's toy example with fresh,
  equally small numbers".
- **Problem 2 — faded worked example.** Show a worked solution with 1–2 steps
  blanked out (`<your step here>`); the learner supplies ONLY the missing steps.
  Blank the step that carries the lesson's core move, not bookkeeping.
- **Problems 3–4 — full problems**, by hand then in R (bigger data is fine in R);
  same skill from a new angle. Include ONE **spot-the-error**: a short, plausible
  wrong computation (built from one of the lesson's Common traps) that the learner
  must debug — say explicitly that it contains exactly one mistake.
- **Problem 5 — interleaved.** Explicitly mixes an earlier module's skill with this
  one, labeled so the learner knows to reach back (e.g. "*(uses Module 1's SSE)*").
  Skip only if the module has no earlier module or foundation to draw on.
- **Last problem — transfer / cliffhanger.** A genuinely new context, or a labeled
  preview ("you can't fully solve this yet — the next lesson gives you the tool").

Mix by-hand and in-R problems. Reuse the lesson's exact symbols and pronunciations;
introduce NO new notation in a problem set.

At least one problem (or one "check yourself" question) should test *interpretation*,
not just computation: "is this covariance large — and what would make it bigger?",
"predict whether the variance goes up or down if we add 100 to every value", "read
this number back as a sentence about the data". This exercises the intuition the
"Getting a feel for it" section built. In-R problems keep the predict-then-run
habit: ask for the learner's prediction before the chunk that reveals the answer.

**Capstone modules** (a course's final module) replace the ramp with a cumulative
set: every course module represented, mixed order, no labels saying which module
each problem comes from — retrieval is the point. Format in `course-structure.md`
§Capstone.

## Copy-able data (non-negotiable)

Any question that hands the learner specific data to compute with — a vector, a
function, a data frame, anything they'd otherwise retype — MUST open with a small
live `{webr}` starter chunk (`#| autorun: false`) that defines exactly that data,
placed **right after the problem statement and BEFORE the answer callout**.

This applies to **by-hand problems too**: the learner should be able to copy the
starter to check their pencil work in R without transcribing numbers. Stating data
only in prose or math (e.g. "$x = (3, 1, 4, 2)$") with no copy-able chunk is a defect.

Engine choice (live starter, baked answer) is owned by `interactive-webr.md` — see it for wiring.

The starter defines data only — never the solution:

````markdown
```{webr}
#| autorun: false
# p2-starter — copy this to begin
x <- c(3, 1, 4, 2)
```
````

Chunk-label convention: `{webr}` starters take no label — name them in a leading
comment (`# pN-starter` in practice sets, `# checkN-starter` in lesson "Check
yourself" questions). Comment names must be unique within the file.

**Exempt from the starter chunk:** problems that use a built-in dataset (e.g.
`mtcars`) — nothing to retype — and prompts stated entirely with scalars already in
the prose (e.g. "slope 2, $\bar{x} = 10$; find the intercept").

## Hidden, fully-worked answers

Every answer goes in a collapsed callout, this exact pattern:

```markdown
::: {.callout-note collapse="true" title="Answer"}
Full worked reasoning — every algebraic/R step explained, not just the final number.
:::
```

For an in-R answer, include the completed R with comments explaining the MATH each
line performs. For a by-hand answer, show the arithmetic step by step, then (when
useful) the same result via an R one-liner so the learner can check.

## Self-check before you're done

Re-read every new problem against `content-review-checklist.md`. In particular:
notation matches the lesson, every symbol used is already decoded in that lesson,
hand-arithmetic matches any R output, and every data-bearing question ships a
copy-able starter chunk.
