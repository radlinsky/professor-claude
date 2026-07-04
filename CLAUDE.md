# Professor Claude

This repo generates **applied math/stats courses** tailored to one specific learner.
Every course teaches the fundamentals needed to understand a statistical method or
math concept (often from an academic paper), working UP from building blocks to the
real thing.

## The two documents that govern everything

- **`TEACHING.md` (repo root)** — the teaching contract: the golden order — the
  11-step lesson spine defined in TEACHING.md — plus the rules for notation,
  anchors, derivations, retrieval/interleaving, practice ramps, misconceptions,
  depth control, revision, and the self-check. **ALL teaching material follows
  TEACHING.md.** Do not restate its rules elsewhere — link to it.
- **`.claude/course-authoring/learner-profile.md`** — WHO you are teaching: a
  strong R programmer whose math stops at rusty AP Calculus A/B + one long-ago
  intro stats course, who cannot comfortably read formal notation. Never assume
  knowledge beyond that baseline; when in doubt, teach the building block.
  (This profile ships as an **example** — forkers edit it to describe their own
  learner; see the README's *Make it yours* section.)

## Repo map

```
professor_claude/
├── TEACHING.md                # THE teaching contract (see above)
├── CLAUDE.md                  # this file
├── README.md                  # human-facing overview
├── _quarto.yml                # SINGLE Quarto project for the whole repo (renders
│                              #   every course + foundation; new pages register here)
├── renv/, renv.lock, .Rprofile # project-local R library; root .Rprofile activates it
├── .claude/
│   ├── agents/
│   │   ├── course-creator.md          # subagent: builds a whole course end-to-end
│   │   ├── problem-creator.md         # subagent: adds problems to an existing module
│   │   └── course-auditor.md          # subagent: READ-ONLY quality review of material
│   ├── course-authoring/              # SHARED authoring assets (learner profile,
│   │                                  #   templates, notation/style, problem-authoring
│   │                                  #   contract, review checklist, resource-curation,
│   │                                  #   source-licensing, and more — see the directory)
│   │                                  #   — used by ALL skills/agents; no skill owns it
│   └── skills/
│       ├── create-course/SKILL.md     # whole-course generation procedure (8 phases)
│       ├── update-course/SKILL.md     # safely modify/extend EXISTING material
│       ├── add-problems/SKILL.md      # add problems to an EXISTING module
│       └── port-library/SKILL.md      # rebuild a real library/paper into a course
├── equivalence/               # fixture harness proving port-library rebuilds match the
│                              #   original (fixtures/, generate/, reimplementations/,
│                              #   harness.R, check.R) — see equivalence/README.md
├── .github/workflows/         # CI: equivalence.yml, license-check.yml, render.yml
├── docs/                      # decision records (e.g., webr-decision.md)
├── foundations/               # SHARED, recyclable prerequisite modules
│   ├── README.md              # index: module, concepts, used-by, learner status
│   └── <module-slug>/{lesson.qmd, practice.qmd, resources.md}
├── courses/
│   ├── README.md              # index of all courses
│   └── <course-slug>/         # one folder per course (registered in root _quarto.yml)
│       ├── syllabus.md
│       ├── 00-roadmap.qmd      # Mermaid dependency map incl. foundation links
│       ├── modules/NN-<slug>/{lesson.qmd, practice.qmd}   # last module = capstone
│       └── resources.md
├── source-papers/             # learner drops papers here (YYYY-firstauthor-shortname.pdf)
└── source-materials/          # non-paper course inputs: prior notebooks, curricula, and
                               # COURSE-REQUEST.md files a course build mines (seed material,
                               # not course content — may be in other languages, may not run here)
```

## Which skill / agent to use

| You want to… | Use |
|---|---|
| Build a whole new course (from a paper, concept, or a `source-materials/*/COURSE-REQUEST.md`) | **`create-course` skill**; or the **`course-creator` agent** for a one-shot build (agent = autonomous one-shot; skill = interactive build) |
| Rebuild a real method (an R/Python/C/C++/Fortran library, a paper's methods, or a repo) from scratch into a course AND prove the rebuild matches the original | **`port-library` skill** — does source analysis + equivalence fixtures, then runs create-course phases 3–8 (if ANY validation reference exists — runnable code, reported numbers, or a closed form — port-library applies; only a bare concept with nothing to validate against goes to create-course) |
| Change ANYTHING in existing material (fix, improve, extend, add a module/section) | **`update-course` skill** — never edit course content ad hoc |
| Only add practice problems / check-yourself questions to an existing module | **`add-problems` skill**, or the **`problem-creator` agent** (ADDING new problems; CHANGING existing problems is update-course) |
| Grade material against the contract (after a build/update, or on demand) | **`course-auditor` agent** (read-only) |

Everything the skills need (templates, notation glossary, problem-authoring
contract, structure spec, review checklist) lives in `.claude/course-authoring/`.
Use those files; do not improvise structure.

## Foundations library (module recycling)

A module belongs in `foundations/` if it would appear essentially unchanged in a
course about a *different* paper or method (full genericity rule + borderline calls:
`.claude/course-authoring/course-structure.md`). **Check `foundations/README.md`
before writing any prerequisite module** — if it exists, link to it; never copy.
Foundation modules stay paper-agnostic. When a course uses one, update its *Used by*
column. The **Status** columns in both README indexes belong to the learner — never
overwrite them.

## Always-on conventions

- **Slugs:** kebab-case; course modules zero-padded in learning order
  (`modules/01-least-squares-idea/`); foundation modules NOT numbered. Keep slugs
  stable once created — external repos may reference them.
- **Registration:** every new `.qmd`/`.md` page goes into the root `_quarto.yml`
  (render list + sidebar) — no per-course `_quarto.yml`. New courses/modules get
  rows in `courses/README.md` / `foundations/README.md`.
- **R packages:** the setup chunk in each template auto-installs into renv. If you
  added a package, run `Rscript -e 'renv::snapshot()'` before finishing so
  `renv.lock` stays true.
- **Runnable lessons:** the whole site renders as `live-html` so lessons can host
  in-browser WebR chunks. Cells the learner tweaks or solves are live `{webr}`;
  hidden setup, listings, worked answers, and code needing a non-WebR package stay
  baked `{r}`. Never give a page its own `format:`. Contract:
  `.claude/course-authoring/interactive-webr.md`; viability + package limits:
  `docs/webr-decision.md`.
- Exact file formats, the setup chunk, and the hidden-answer callout pattern live
  in the templates and specs under `.claude/course-authoring/` — copy from there.

## Commands

```bash
quarto render                                            # render the whole repo (one project)
quarto preview courses/<slug>/modules/NN-<slug>/lesson.qmd  # live-preview one lesson
Rscript -e 'renv::snapshot()'                            # after adding any R package
```

Run these from the **repo root** — it is a single Quarto project, and only the root
`.Rprofile` activates renv (which holds the `knitr`/`rmarkdown` render engine).
A course is not done until `quarto render` succeeds with every baked `{r}` chunk
executing (live `{webr}` cells run in the browser, not at build — see
`.claude/course-authoring/interactive-webr.md`) AND the content-accuracy review
(`.claude/course-authoring/content-review-checklist.md`) finds nothing.
