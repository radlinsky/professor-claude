# Module-check authoring contract

The single source of truth for the **Module check** — the short, machine-graded quiz
that ends a module's `practice.qmd`. Both the `create-course` skill (Phase 5) and the
`update-course` skill (retrofits) follow this file — do not restate these rules
elsewhere, link here.

Read root `TEACHING.md` (§Module check), `learner-profile.md`, and `notation-style.md`
alongside this file. The Module check inherits the teaching contract; nothing below
overrides it.

## What it is (and where it sits)

A Module check is a **5-question, closed-answer (multiple-choice / numeric),
machine-graded, locally-recorded** quiz appended as the LAST section of an existing
`practice.qmd`. It is *summative-lite*: it sits between the formative practice set and
the cumulative capstone.

| | Check yourself | Practice set | **Module check** | Capstone |
|---|---|---|---|---|
| Role | formative | formative | **summative-lite** | cumulative final |
| Answers | free-response | free-response | **closed (MC/numeric), machine-graded** | free-response |
| Timing | mid-lesson | after lesson | **after practice, ideally next session** | end of course |
| Recorded | no | no | **yes (localStorage)** | no |
| Pass rule | none | none | **≥4/5 = objective mastery trigger** | none |

The grader is `includes/quiz.html` (injected site-wide via `include-after-body` in
`_quarto.yml`). It converts the rendered markup into radios/inputs, grades on the page,
and persists **best + last per module** under the localStorage key
`professor-claude.quiz.v1`. Without JavaScript the quiz stays a readable list — the
answers live only in `data-*` attributes, never in visible prose.

## Syntax

Container: `.module-check` with `module=` (the repo-relative module dir) and `pass=`
(integer, default 4). Question: `.quiz-q` with `qid=`, `qtype="mc"|"numeric"`,
`answer=`, and — numeric only — optional `tolerance=` (default 0).

**Never use `id=` or `type=`.** Pandoc treats those as native HTML attributes; only
`qid`/`qtype` survive as `data-qid`/`data-qtype`.

MC options are a plain lettered markdown list (`a) …`, **max 4**); `answer` is the
letter. The rendered `<ol type="a">` becomes radios; without JS it stays a list.

Copy-able example:

````markdown
## Module check

Five quick questions, graded on the page. Take it in your next session, after the
practice set. 4/5 or better means this module is solid; results are saved in this
browser only.

::: {.module-check module="foundations/reading-math-notation" pass="4"}

::: {.quiz-q qid="rmn-hat-meaning" qtype="mc" answer="b"}
In $\hat{\beta}$, what does the hat mean?

a) The true parameter value we can never observe
b) An estimate computed from a sample
c) The largest value $\beta$ can take
d) A vector rather than a single number
:::

::: {.quiz-q qid="rmn-sum-toy" qtype="numeric" answer="14" tolerance="0"}
For $x = (3, 5, 6)$: what is $\sum_{i=1}^{n} x_i$?
:::

:::
````

## Rules

- **Exactly 5 items.** 3–4 test this module; **1–2 are interleaved** from earlier
  modules of the course (or the foundation's `Builds on` modules), each interleaved
  item labeled in its question text (mirrors the practice-ramp labeling). **Entry
  modules** — nothing earlier — are exempt: all 5 items module-local.
- **Distractors** come from the lesson's **Common traps**; **numeric answers** use the
  lesson's own toy numbers, so every answer is verifiable against the lesson.
- **Stable qid rule:** `<module-initials>-<concept-slug>`, kebab-case (e.g.
  `rmn-hat-meaning`). A qid names the *concept tested*, not a position — never renumber
  on reorder, never reuse a deleted qid, keep the qid across wording tweaks, mint a new
  one only if the answer's meaning changes. Unique within the module.
- **No `{webr}` / code cells inside a quiz** — closed-answer only.
- **Lint:** quiz prose is checked by `scripts/check-teaching-lint.R`, which bans the
  standalone words `simply`, `clearly`, `obviously`, `it follows that`, `it is trivial`.
  Avoid them in questions and options; if a line genuinely needs one, its escape hatch
  is a trailing `<!-- lint-ok -->` comment.

## Self-check before you're done

Re-read every item against `content-review-checklist.md` #20: exactly 5 `.quiz-q` divs,
qids unique + stable-format, every `answer=` independently verified against the lesson,
≥1 interleaved item unless this is an entry module, `qid`/`qtype` (never `id`/`type`),
no code cells.
