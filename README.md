# Professor Claude 🧮

A personal, Claude-powered **applied math & statistics school**. Give it an academic
paper (or just name a method/concept), and Claude designs a complete course that
teaches you the fundamentals first, then works up to the real thing — with toy
numerical examples, plain-English notation decoding, symbol pronunciation tables,
interactive Quarto R notebooks, practice problems with hidden answers, and verified
links to external videos and posts.

**▶️ [Browse the live site](https://radlinsky.github.io/professor-claude/)** — every
example course, rendered with runnable in-browser R (WebR) cells. No install needed.

<!-- Demo GIF: record a ~10s clip of a lesson's {webr} cell running (edit code → Run →
     see output), save it as docs/assets/demo.gif, then uncomment the line below:
![Professor Claude in action](docs/assets/demo.gif)
-->

## Make it yours

This repo ships tailored to **one example learner** — a strong R programmer whose math
stops at rusty AP-Calculus-level algebra and calculus — described in
[`.claude/course-authoring/learner-profile.md`](.claude/course-authoring/learner-profile.md).
Every course is written *for that profile*, so before you use it for yourself or someone else:

1. **Edit `.claude/course-authoring/learner-profile.md`** to describe the real learner: their
   programming background, math level, what they already know, what trips them up, and how they
   like to learn. This one file retargets the whole system.
2. *(Optional)* tune
   [`notation-style.md`](.claude/course-authoring/notation-style.md) (bridge every symbol to
   *their* fluent language) and
   [`resource-curation.md`](.claude/course-authoring/resource-curation.md) (their preferred
   videos and sites).

Everything else — the [`TEACHING.md`](TEACHING.md) contract, the skills, the templates, and the
example courses — is learner-agnostic and works as-is. Click **Use this template** (or fork) to
start your own. To keep a course you build private, git-ignore its `courses/<slug>/` folder and
its rows in `_quarto.yml`.

The three courses under `courses/` double as worked examples of the three ways to seed a build:
a concept from scratch (`simple-linear-regression`), a ported library (`gradient-descent`), and
a written request (`logistic-regression`, from
`source-materials/logistic-regression/COURSE-REQUEST.md`).

## Quickstart

1. (Optional) Drop a paper into `source-papers/` (see its README for naming).
2. Ask Claude, in this repo:

   > Create a course for the methods section of `source-papers/2024-smith-mixedmodels.pdf`

   or

   > Create a course that teaches me what a Kalman filter is

3. Claude runs the `create-course` skill: it maps out every prerequisite you'll need
   (down to your actual math baseline), reuses building-block modules from
   `foundations/` where they already exist, writes the new ones, and builds the
   course under `courses/<slug>/`.

## Taking a course

- **Interactively (recommended):** open the **repo root** in RStudio/Positron (not a
  single course folder) — that's what activates renv, so the Preview button and
  chunk-running find `knitr`/`rmarkdown`. Then open a `lesson.qmd` and run it
  chunk-by-chunk, in the order given by `syllabus.md`. Tweak numbers, rerun chunks,
  break things — that's the point.
- **As a rendered site:** the courses are published at
  **<https://radlinsky.github.io/professor-claude/>** (auto-deployed from `main`).
  To build locally instead — the whole repo is one Quarto project, so render from
  the root:

  ```bash
  quarto render        # builds everything into _site/ — open _site/index.html
  ```

- Start every course from its `syllabus.md` and `00-roadmap.qmd` — they tell you which
  `foundations/` modules to take (or skim, if you've done them before) first.

## Layout

| Path | What it is |
|---|---|
| `foundations/` | Shared, reusable building-block modules (learn once, reuse across courses) |
| `courses/` | One folder per generated course (each ends in a cumulative capstone module) |
| `source-papers/` | Where you drop papers to build courses from |
| `source-materials/` | Non-paper course inputs (seed notebooks, written course requests) |
| `TEACHING.md` | The teaching contract every lesson/practice file follows |
| `.claude/skills/` | Procedures: `create-course`, `update-course`, `add-problems` |
| `.claude/agents/` | Agents: `course-creator`, `problem-creator`, `course-auditor` |
| `.claude/course-authoring/` | Shared templates, notation glossary, review checklist |
| `CLAUDE.md` | Repo rules every Claude session follows |

## Requirements

- R 4.5.2 (the version pinned in `renv.lock` and CI; nearby versions usually work)
  and [Quarto](https://quarto.org) ≥ 1.9 (CI uses 1.9.38).
- **One-time setup ([renv](https://rstudio.github.io/renv/)):** dependencies are
  managed in a project-local library so every course renders reproducibly. Quarto's
  R engine needs `knitr` and `rmarkdown` to run any `.qmd` (a "no package called
  'rmarkdown'" error means setup was skipped). The committed `renv.lock` records
  `knitr`, `rmarkdown`, and everything else, so restore it — don't re-init. From the
  repo root, run once:

  ```bash
  Rscript -e 'install.packages("renv", repos="https://cloud.r-project.org")'   # if you don't have renv
  Rscript -e 'renv::restore()'
  ```

  After this, opening the repo root in Positron/RStudio auto-activates the renv
  library via `.Rprofile`, so the preview button just works.

- Individual lessons auto-install any *other* R packages they need in their first
  chunk. With renv active those installs land in the project library; run
  `renv::snapshot()` to record them in `renv.lock` if you want them pinned.

## License

[MIT](LICENSE). Fork it, adapt it, teach with it — attribution appreciated.
