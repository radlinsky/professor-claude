# Course structure specification

Exact layouts, file formats, and naming rules. Copy these; do not improvise.

## Naming

- Course slugs: kebab-case, descriptive, no dates — `simple-linear-regression`,
  `kalman-filter-basics`, `mixed-effects-models`.
- Course modules: numbered in learning order, zero-padded —
  `modules/01-least-squares-idea/`, `modules/02-deriving-the-ols-formulas/`.
- Foundation modules: kebab-case, **not numbered** (a pool with declared prerequisite
  edges, not a numbered sequence) — `foundations/mean-variance-covariance/`. The edges
  live in the `Builds on` column of `foundations/README.md` (see §Index tables).

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

A new foundation module is **generated** into the two shared index files, not
hand-registered: add `foundations/<slug>/meta.dcf` (`ShortName`, `Concepts`,
`BuildsOn`, `UsedBy` — see below) and run `Rscript scripts/gen-indexes.R`. The
generator rewrites the foundation render list + sidebar in the root `_quarto.yml` and
the table body in `foundations/README.md`, sorted by slug, between `# >>> generated` /
`<!-- >>> generated -->` sentinel markers. **Never hand-edit between those markers** —
CI (`Rscript scripts/gen-indexes.R --check`) fails on drift. The learner-owned
**Status** cell is preserved across regeneration (a brand-new module defaults to `not
started`). Courses are NOT generated — register a course by hand as described below.

## Registering a course in the root `_quarto.yml`

The whole repo is **one** Quarto project — there is a single `/_quarto.yml` at the
repo root, and no per-course or per-foundation `_quarto.yml`. This keeps renv (rooted
at the repo top) active during every render. When you add a course or foundation
module, edit `/_quarto.yml` and add each new `.qmd`/`.md` in two places, using paths
**relative to the repo root**. This includes `resources.md` — lessons and roadmaps
link to it, and an unregistered page is never rendered, so the link 404s on the live
site. CI's "Check every page is registered" step fails on any page left out; the only
files intentionally excluded are the GitHub-facing `README.md` indexes. Run
`Rscript scripts/check-indexes.R` locally to catch a forgotten registration before
pushing.

1. `project: render:` — the flat list of files to render (no nesting; independent
   of the sidebar).
2. `website: sidebar: contents:` — under a `section:` for the course (or the
   `"Foundations"` section for a new foundation module), in learning order. Insert a
   new course's `section:` AFTER the existing course sections but BEFORE the
   `# >>> generated: knowledge sidebar` markers at the bottom of `contents:` — that
   region (the "Knowledge base" section) is machine-owned by
   `Rscript scripts/gen-kb-index.R`, same rule as the foundation markers. **Each
   module is its own nested `section:`** that groups the module's lesson and
   practice one level below it, so practice reads as part of its module rather than
   a peer of the whole course. The lesson/practice are `text:`/`href:` entries
   labelled just **Lesson** / **Practice** (the module's `section:` label carries
   the descriptive name). Module labels: courses use `N · Short name` (number in
   learning order); foundation modules use the short name with **no** number.
   The module's `resources.md` also gets a `text: "Resources"` / `href:` entry so
   it is a visible nav page, not just an inline link — for a **course** it is the
   last entry of the course section (a peer of the module `section:`s); for a
   **foundation** module it sits inside that module's `section:`, after Practice.

The site's landing page is `/index.qmd` (the repo-root `index.qmd`, Quarto's
homepage). It is hand-registered once — first in `project: render:` and as the
first `website: sidebar: contents:` entry (a `text: "Welcome"` link, above the
`"Foundations"` section) — and is not part of the generated sentinel blocks, so
`gen-indexes.R` leaves it alone. It links to sections generically, not to
specific modules, so adding or removing a course never touches it.

Example — adding a course with two modules:

```yaml
# in project.render (flat — order here doesn't drive the sidebar):
    - courses/<course-slug>/syllabus.md
    - courses/<course-slug>/00-roadmap.qmd
    - courses/<course-slug>/modules/01-<slug>/lesson.qmd
    - courses/<course-slug>/modules/01-<slug>/practice.qmd
    - courses/<course-slug>/modules/02-<slug>/lesson.qmd
    - courses/<course-slug>/modules/02-<slug>/practice.qmd
    - courses/<course-slug>/resources.md

# in website.sidebar.contents:
      - section: "<Course Title>"
        contents:
          - courses/<course-slug>/syllabus.md
          - courses/<course-slug>/00-roadmap.qmd
          - section: "1 · <Short module name>"
            contents:
              - text: "Lesson"
                href: courses/<course-slug>/modules/01-<slug>/lesson.qmd
              - text: "Practice"
                href: courses/<course-slug>/modules/01-<slug>/practice.qmd
          - section: "2 · <Short module name>"
            contents:
              - text: "Lesson"
                href: courses/<course-slug>/modules/02-<slug>/lesson.qmd
              - text: "Practice"
                href: courses/<course-slug>/modules/02-<slug>/practice.qmd
          - text: "Resources"                       # peer of the modules, last entry
            href: courses/<course-slug>/resources.md
```

A new **foundation** module gets the same nested shape — its own `section:`
(short name, no number) under the `"Foundations"` section — but you do **not** type
it by hand. The block below is what `Rscript scripts/gen-indexes.R` emits from the
module's `meta.dcf` `ShortName` (the render-list entries and the `foundations/README.md`
table row are generated the same way). Edit `meta.dcf` and re-run the generator; the
region between the `# >>> generated: foundation sidebar` markers is machine-owned:

```yaml
      - section: "Foundations"
        contents:
          # >>> generated: foundation sidebar (scripts/gen-indexes.R) — do not edit by hand
          - section: "<ShortName from meta.dcf>"
            contents:
              - text: "Lesson"
                href: foundations/<module-slug>/lesson.qmd
              - text: "Practice"
                href: foundations/<module-slug>/practice.qmd
              - text: "Resources"                   # inside the module section
                href: foundations/<module-slug>/resources.md
          # <<< generated: foundation sidebar
```

The per-module metadata file is `read.dcf` format — one leading space indents any
continuation line of a long `Concepts:` value:

```text
ShortName: Matrices & linear transforms
Concepts: A matrix as a grid/stack of rows, matrix × vector as one dot product per
 row, the transpose and why it appears, and the inverse as "undo"
BuildsOn: [vectors-and-summation](vectors-and-summation/lesson.qmd)
UsedBy: —
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
- **Missed the Module check?** Don't re-grind the same problems — you remember
  their *answers* by now, not the skill. Ask for a fresh round ("add problems to
  <module>"), work it, then retake the check in a later session. Passing after
  another gap is the evidence that counts.
- **Answers are hidden for a reason.** Commit to an answer (or a prediction) before
  you click — that's the part that makes it stick.

## Before you start: course(s) this one builds on   <!-- OMIT this whole section if none -->

This course reuses the anchors of course(s) you should have met already instead
of re-teaching them:

- [**<Course Title>**](../<course-slug>/syllabus.md) — <the anchor it reuses, and
  the one-line contrast with this course>.

## Prerequisites from the foundations library

Take these first, in this order. Already done one (check its Status in
[foundations/README.md](../../foundations/README.md))? Skim its pronunciation
table as a refresher instead.

| Module | Why this course needs it |
|---|---|
| [reading-math-notation](../../foundations/reading-math-notation/lesson.qmd) | The standing first prerequisite — it decodes the accents, Greek letters, subscripts, and operators every other formula uses. New? take it fully; done before? skim its symbol table. |
| [<name>](../../foundations/<slug>/lesson.qmd) | <one line> |

## Course modules

### 1. <Module title> (`modules/01-<slug>/`)

**Why you need this:** <one or two lines connecting it to the goal>
**You'll learn:** <comma-separated concepts>
**Time:** ~<X> min lesson + ~<X> min practice
```

**reading-math-notation is the standing first prerequisite of *every* course.** It is
always row 1 of the prerequisites table above, with the wording shown (identical across
courses), regardless of what else the course needs. It does NOT get a Mermaid node in
the roadmap (avoid clutter), but each roadmap's intro prose links it once. In
`courses/README.md`, list it first in the course's foundation-prerequisites cell.

## `00-roadmap.qmd` format

Must be `.qmd` (not `.md`): Mermaid cells only execute in `.qmd` files.

```markdown
---
title: "Roadmap"
---

How every module depends on the others. Foundation modules are reusable
building blocks shared across courses.

<!-- Add this sentence ONLY if the course has prerequisite courses: -->
This course also **builds on** [<Course Title>](../<course-slug>/syllabus.md)
(<the anchor>) and reuses its anchors rather than re-teaching them; if rusty,
skim its syllabus first.

​```{mermaid}
flowchart TD
    classDef foundation fill:#e8f0fe,stroke:#4285f4
    classDef priorcourse fill:#e6f4ea,stroke:#34a853
    F1["vectors-and-summation"]:::foundation
    C1["course: gradient-descent<br/>(step along the slope)"]:::priorcourse
    M1["01 · least-squares idea"]
    F1 --> M1
    C1 --> M1
​```

## Suggested order

1. Foundation: [<name>](../../foundations/<slug>/lesson.qmd) — new / review
2. ...
```

(Use `{mermaid}` executable cells; arrows mean "needed for". Foundation nodes are
blue `:::foundation`; prerequisite-COURSE nodes are green `:::priorcourse` and
prefix the label with `course:` — see the genericity rule for when a building
block is a prerequisite course rather than a foundation.)

**Foundation-to-foundation edges:** when a roadmap shows two foundation modules and one
**Builds on** the other (per the `Builds on` column of `foundations/README.md`), draw
that edge too — e.g. `F1 --> F2` for exponentials-and-logs → probability-and-odds — not
just the foundation→module edges. Otherwise the diagram shows them as independent
siblings when one actually depends on the other, and a learner may take them out of
order.

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

### …or a prerequisite course (the third option)

Before classifying a building block as foundation vs. course module, check whether
an **existing course** already teaches it as its own subject — not a generic
Khan-Academy concept, but a whole method (e.g. "fitting a line", "gradient
descent"). If one does, the block is neither: declare that course a **prerequisite
course**, reuse its anchors, and do NOT re-teach it or promote it to foundations.
Surface it in the syllabus's *Before you start* section and as a green
`:::priorcourse` node in the roadmap. (Example: `logistic-regression` builds on
`simple-linear-regression` and `gradient-descent`.)

## Index tables

- `courses/README.md` columns: `Course | Teaches | Source | Prerequisite courses | Foundation prerequisites | Status` (`Prerequisite courses` = `—` when none)
- `foundations/README.md` columns: `Module | Concepts covered | Builds on | Used by | Status`
  - The table **body is generated** — `Concepts covered`, `Builds on`, and `Used by`
    come from each module's `foundations/<slug>/meta.dcf` (`Concepts`, `BuildsOn`,
    `UsedBy`), and `Status` is preserved from the current table. Edit `meta.dcf` and run
    `Rscript scripts/gen-indexes.R`; never hand-edit rows between the `<!-- >>> generated -->`
    markers. `Status` stays learner-owned and is not stored in `meta.dcf`.
  - `Builds on` = kebab-slug link(s) to the foundation module(s) this one leans on, `—`
    for a root. **Sync rule:** a module's `Builds on` cell (i.e. its `meta.dcf` `BuildsOn`)
    must always match the **Builds on:** line inside its own `lesson.qmd` — edit both
    together, never one alone.
- Status values (learner-owned; initialize to `not started`, never overwrite later):
  `not started` / `in progress` / `done`.

## Module count

3–8 modules total per course (reused foundations + new foundations + course modules,
**including** the required capstone). Under 3: probably not worth a course — offer a
single lesson. Over 8: the target is too big; propose splitting into two courses and
ask the user.
