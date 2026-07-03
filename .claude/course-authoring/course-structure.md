# Course structure specification

Exact layouts, file formats, and naming rules. Copy these; do not improvise.

## Naming

- Course slugs: kebab-case, descriptive, no dates — `simple-linear-regression`,
  `kalman-filter-basics`, `mixed-effects-models`.
- Course modules: numbered in learning order, zero-padded —
  `modules/01-least-squares-idea/`, `modules/02-deriving-the-ols-formulas/`.
- Foundation modules: kebab-case, **not numbered** (the library is a pool, not a
  sequence) — `foundations/mean-variance-covariance/`.

## Folder layouts

### A course

```
courses/<course-slug>/
├── syllabus.md          # format below
├── 00-roadmap.qmd        # format below
├── modules/
│   ├── NN-<module-slug>/
│   │   ├── lesson.qmd   # from .claude/course-authoring/lesson-template.qmd
│   │   └── practice.qmd # from .claude/course-authoring/practice-template.qmd
│   └── NN-capstone-<slug>/  # REQUIRED last module — see §Capstone below
└── resources.md         # one section per module; verified links only
```

### A foundation module

```
foundations/<module-slug>/
├── lesson.qmd           # same template; must be paper-agnostic
├── practice.qmd
└── resources.md         # verified links for just this module
```

New foundation modules must also be registered in the root `_quarto.yml` (see below)
and added to the `foundations/README.md` index table.

## Registering a course in the root `_quarto.yml`

The whole repo is **one** Quarto project — there is a single `/_quarto.yml` at the
repo root, and no per-course or per-foundation `_quarto.yml`. This keeps renv (rooted
at the repo top) active during every render. When you add a course or foundation
module, edit `/_quarto.yml` and add each new `.qmd`/`.md` in two places, using paths
**relative to the repo root**:

1. `project: render:` — the flat list of files to render.
2. `website: sidebar: contents:` — under a `section:` for the course (or the
   `"Foundations"` section for a new foundation module), in learning order.

Example — adding a course with two modules:

```yaml
# in project.render:
    - courses/<course-slug>/syllabus.md
    - courses/<course-slug>/00-roadmap.qmd
    - courses/<course-slug>/modules/01-<slug>/lesson.qmd
    - courses/<course-slug>/modules/01-<slug>/practice.qmd
    - courses/<course-slug>/modules/02-<slug>/lesson.qmd
    - courses/<course-slug>/modules/02-<slug>/practice.qmd

# in website.sidebar.contents:
      - section: "<Course Title>"
        contents:
          - courses/<course-slug>/syllabus.md
          - courses/<course-slug>/00-roadmap.qmd
          - courses/<course-slug>/modules/01-<slug>/lesson.qmd
          - courses/<course-slug>/modules/01-<slug>/practice.qmd
          - courses/<course-slug>/modules/02-<slug>/lesson.qmd
          - courses/<course-slug>/modules/02-<slug>/practice.qmd
```

Do not create a `_quarto.yml` inside a course or foundation folder — a nested one
makes Quarto run R from that subfolder, where renv is not active, and rendering fails
with "no package called 'rmarkdown'".

The root `_quarto.yml` sets `format: live-html` for the **whole** project so lessons
can carry runnable in-browser WebR chunks under one shared theme. Consequences for new
pages: do NOT give a lesson/practice/syllabus/roadmap its own `format:` block (it would
drop that page out of the shared theme). A page inherits the project format; a page that
wants live `{webr}` cells adds `engine: knitr` + the `_knitr.qmd` include instead. Full
rules: `.claude/course-authoring/interactive-webr.md`.

## `syllabus.md` format

```markdown
# <Course Title> — Syllabus

**Goal:** <the one-sentence Gate-1 goal: what the learner can do afterwards>

**Source:** <paper filename + section, "concept: <name>", or the COURSE-REQUEST path>

**Source license:** <SPDX id / short description — OK | flagged, confirmed by human YYYY-MM-DD | n/a — no external source; see `.claude/course-authoring/source-licensing.md`>

## How to take this course

- **One module per sitting.** Lesson first, then its practice — don't split them.
- **Space it out.** Start the next sitting (ideally the next day) with the new
  lesson's Warm-up — it deliberately re-tests what you did last time. Don't binge
  the course in a day; the forgetting between sittings is what makes the warm-ups
  work.
- **The mastery rule:** move on only when every "What you can now do" bullet feels
  solid. Shaky bullet → redo that section or its practice problems first.
- **Answers are hidden for a reason.** Commit to an answer (or a prediction) before
  you click — that's the part that makes it stick.

## Prerequisites from the foundations library

Take these first, in this order. Already done one (check its Status in
[foundations/README.md](../../foundations/README.md))? Skim its pronunciation
table as a refresher instead.

| Module | Why this course needs it |
|---|---|
| [<name>](../../foundations/<slug>/lesson.qmd) | <one line> |

## Course modules

### 1. <Module title> (`modules/01-<slug>/`)

**Why you need this:** <one or two lines connecting it to the goal>
**You'll learn:** <comma-separated concepts>
**Time:** ~<X> min lesson + ~<X> min practice
```

## `00-roadmap.qmd` format

Must be `.qmd` (not `.md`): Mermaid cells only execute in `.qmd` files.

```markdown
---
title: "Roadmap"
format: html
---

How every module depends on the others. Foundation modules are reusable
building blocks shared across courses.

​```{mermaid}
flowchart TD
    classDef foundation fill:#e8f0fe,stroke:#4285f4
    F1["vectors-and-summation"]:::foundation
    F2["mean-variance-covariance"]:::foundation
    M1["01 · least-squares idea"]
    F1 --> F2 --> M1
​```

## Suggested order

1. Foundation: [<name>](../../foundations/<slug>/lesson.qmd) — new / review
2. ...
```

(Use `{mermaid}` executable cells; arrows mean "needed for".)

## Capstone (required last module of every course)

The final course module is `modules/NN-capstone-<short-slug>/` and exists to prove
the course goal was reached and to force cumulative retrieval. It introduces **no
new concepts**.

**`lesson.qmd` — "Return to the source":** walk the actual target artifact — the
paper's methods excerpt / equations, or for concept courses a real-world artifact
(a real `summary()` output, a textbook passage, a Wikipedia equation, the
COURSE-REQUEST's target list) — and decode it line by line, symbol by symbol,
linking each piece back to the module that taught it ("$s_{xy}/s_x^2$ — Module 2").
Structure: brief orientation → the artifact, quoted → the decode (one passage at a
time: read it aloud, plain-English it, backlink it) → a short, honest "what you
still can't read" section pointing at natural next courses. The Warm-up, Common
traps, and "What you can now do" sections still apply (the recap's can-dos ARE the
course goal); "Getting a feel for it" / "The formal version" don't — nothing new is
introduced.

**`practice.qmd` — cumulative set:** 5–8 problems drawing on EVERY course module,
in mixed order, **without** labels saying which module each problem uses (recalling
*which tool applies* is part of the test — the one exception to the interleaving
label rule in `problem-authoring.md`). Ramp lightly (easy rep first); include at
least one spot-the-error and one interpretation problem; last problem = decode a
fresh passage/output not covered in the lesson. Same starter-chunk and
hidden-answer rules as everywhere.

## Applied-practice line (courses built from a COURSE-REQUEST)

When the course request maps modules to hands-on material in an external repo, the
matching module's "Where this goes next" ends with:

```markdown
**Applied practice (<repo or project name>):** open `<path/from/the/request>` —
<one line: what to do there and what it exercises>.
```

Use the paths exactly as the request gives them; do not import or copy the external
content into this repo.

## Genericity rule (foundation vs. course module)

> A module belongs in `foundations/` if it would appear essentially unchanged in a
> course about a **different** paper or method.

Worked borderline calls:

| Module idea | Verdict | Why |
|---|---|---|
| Summation (Σ) notation | foundation | Identical in any stats course |
| Variance & covariance | foundation | Identical anywhere |
| The chain rule | foundation | Identical anywhere |
| Maximum likelihood: the idea | foundation | The *idea* recurs everywhere |
| The likelihood OF THIS PAPER'S model | course | Only meaningful for this method |
| "Deriving the OLS formulas" | course | The derivation is the method itself |
| Reading `lm()` output | course | Tied to the regression course target |
| Matrix multiplication | foundation | Identical anywhere |
| The design matrix X for regression | course* | *Unless written generically as "matrices as data tables" — prefer making the generic part a foundation module and keeping the regression-specific framing in the course |

Rules of thumb: if you must mention the paper/method to motivate every example, it's
a course module. If the concept has a Khan Academy page, it's probably a foundation
module.

## Index tables

- `courses/README.md` columns: `Course | Teaches | Source | Foundation prerequisites | Status`
- `foundations/README.md` columns: `Module | Concepts covered | Used by | Status`
- Status values (learner-owned; initialize to `not started`, never overwrite later):
  `not started` / `in progress` / `done`.

## Module count

3–8 modules total per course (reused foundations + new foundations + course modules,
**including** the required capstone). Under 3: probably not worth a course — offer a
single lesson. Over 8: the target is too big; propose splitting into two courses and
ask the user.
