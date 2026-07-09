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

Why this artifact exists: retrieving an answer with feedback strengthens retention far
more than re-reading (test-enhanced learning — Roediger & Karpicke), and the wait-a-day
rule is what makes the retrieval effortful enough to count (spacing — Rawson & Dunlosky's
successive-relearning work). The grader supplies the feedback half of that loop:
per-item right/wrong plus the correct answer revealed on a miss, immediately.

What a miss triggers — diagnose, **fresh reps** (a new parallel problem round via the
add-problems skill, per `problem-authoring.md` §Fresh-rep rounds), retake in a later
session — is TEACHING.md §Module check's relearning loop; don't restate it here. If
after several retakes the learner can recite the quiz *answers* from memory rather than
re-derive them, replacing items is an **update-course** job: the replacement tests the
same concept on different numbers, and since the answer's meaning changes it gets a
**new qid** (the stable-qid rule below).

| | Check yourself | Practice set | **Module check** | Capstone |
|---|---|---|---|---|
| Role | formative | formative | **summative-lite** | cumulative final |
| Answers | free-response | free-response | **closed (MC/numeric), machine-graded** | free-response |
| Timing | mid-lesson | after lesson | **after practice, ideally next session** | end of course |
| Recorded | no | no | **yes (localStorage)** | no |
| Pass rule | none | none | **≥4/5 = objective mastery trigger** | none |

The grader is `includes/quiz.html` (injected site-wide via `include-after-body` in
`_quarto.yml`). It converts the rendered markup into radios/inputs, grades on the page,
and persists each module's `best` plus its **full attempt history** (a chronological
`attempts` array) under the localStorage key `professor-claude.quiz.v1`; "Download my
results" exports the whole blob. Without JavaScript the quiz stays a readable list — the
answers live only in `data-*` attributes, never in visible prose.

## Syntax

Container: `.module-check` with `module=` (the repo-relative module dir) and `pass=`
(integer, default 4). Question: `.quiz-q` with `qid=`, `qtype="mc"|"numeric"`,
`answer=`, and — numeric only — optional `tolerance=` (default 0).

**Never use `id=` or `type=`.** Pandoc treats those as native HTML attributes; only
`qid`/`qtype` survive as `data-qid`/`data-qtype`.

MC options are a plain lettered markdown list (`a) …`, **max 4**); `answer` is the
letter. The rendered `<ol type="a">` becomes radios; without JS it stays a list.

The whole thing is wrapped in a **collapsed `.callout-tip`** whose title tells the
learner to wait at least a day — the spacing is the point (testing while the lesson is
fresh only measures short-term fluency), so the quiz reads as a deferred checkpoint,
not more practice. Use `::::`
for the callout so it nests unambiguously around the `:::` quiz divs.

Copy-able example:

````markdown
## Module check

:::: {.callout-tip collapse="true" title="⏳ Wait at least a day before taking this quiz"}

This is a checkpoint, not more practice — come back to it **at least a day from now**,
once the material isn't fresh. A pass then is real evidence you've retained it. Five
questions, graded on the page; 4/5 or better means this module is solid. Score under
4? Revisit what the missed questions point at, then retake in a **later session** —
passing after another gap is the evidence that counts. Results are saved in this
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

::::
````

## Rules

- **Exactly 5 items.** 3–4 test this module; **1–2 are interleaved** from earlier
  modules of the course (or the foundation's `Builds on` modules), each interleaved
  item labeled in its question text (mirrors the practice-ramp labeling). **Entry
  modules** — nothing earlier — are exempt: all 5 items module-local. **Capstone
  modules** are the opposite: all 5 items are cumulative and, like the capstone
  practice set, left **unlabeled** — recalling which module applies is the point.
- **Distractors** come from the lesson's **Common traps**; **numeric answers** use the
  lesson's own toy numbers, so every answer is verifiable against the lesson. Full
  distractor and stem rules: §Writing the five items, below.
- **Stable qid rule:** `<module-initials>-<concept-slug>`, kebab-case (e.g.
  `rmn-hat-meaning`). A qid names the *concept tested*, not a position — never renumber
  on reorder, never reuse a deleted qid, keep the qid across wording tweaks, mint a new
  one only if the answer's meaning changes. Unique within the module.
- **No `{webr}` / code cells inside a quiz** — closed-answer only.
- **Lint:** quiz prose is checked by `scripts/check-teaching-lint.R`, which bans the
  standalone words `simply`, `clearly`, `obviously`, `it follows that`, `it is trivial`.
  Avoid them in questions and options; if a line genuinely needs one, its escape hatch
  is a trailing `<!-- lint-ok -->` comment.

## Writing the five items

These rules come from the validated item-writing taxonomy of Haladyna, Downing &
Rodriguez, Rodriguez's 2005 meta-analysis on option counts, and Little & Bjork's work
on competitive distractors. Each one exists because breaking it lets the learner score
a point without knowing the material — which quietly corrupts the ≥4/5 mastery signal.

**Coverage & level**

- **One idea per item.** Each item tests a single concept, and the five together cover
  *different* can-do bullets from the lesson's Recap — not five angles on one bullet.
- **Application over recognition.** Never lift a sentence from the lesson into a stem
  or key — that rewards remembering prose, not the idea. Where the concept allows it,
  make the learner *apply* it to numbers ("For x = …, what is …?") instead of
  completing a definition.

**Stems**

- **The stem is a complete question on its own.** The learner should be able to answer
  before reading the options; the substance lives in the stem, the options stay short.
- **Positive phrasing only.** No "which is NOT…", no "all are true EXCEPT…" — a
  negative stem tests sentence-parsing, not the concept.

**Options**

- **3 or 4 options — one per real misconception.** Three options measure as well as
  four (Rodriguez 2005); write a fourth only when a fourth genuine wrong path exists.
  Never pad with a throwaway distractor nobody would choose.
- **Every distractor is the end of a wrong road.** Before keeping one, name the exact
  mistake that produces it: a Common trap first, otherwise a predictable slip (n for
  n−1, the minimum for the arg-min, a dropped square). For numeric options, compute
  each distractor by running the wrong method on the same toy numbers. A plausible,
  competitive distractor is what makes MC retrieval productive (Little & Bjork).
- **One defensibly correct key.** Every distractor must be flatly wrong, not "less
  right". If a knowledgeable reader could argue for two options, rewrite the item.
- **Homogeneous options.** Same grammatical shape, same content category, similar
  length. The key must never be the longest or most carefully qualified option — that
  makes the item answerable by test-wiseness alone.
- **Banned option types:** "all of the above", "none of the above", combined options
  ("both a and c"), and absolute qualifiers ("always", "never") inside distractors.

**Across the set**

- **No clueing.** All five items render on one page: no stem or option may contain,
  restate, or eliminate another item's answer.
- **Vary the key letter.** Spread correct letters across the set; never let one letter
  carry most of the five.

**Numeric items**

- Answers come from the lesson's own toy numbers (see Rules), but prefer asking for a
  quantity the lesson did **not** print for those numbers — same data, one step the
  learner must compute rather than remember.
- `tolerance=` stays 0 for integer answers. For decimal answers, set it to absorb
  honest rounding (e.g. `answer="0.667" tolerance="0.001"`) and tell the learner in
  the stem how many decimals to enter.

## Self-check before you're done

Re-read every item against `content-review-checklist.md` #20: exactly 5 `.quiz-q` divs,
qids unique + stable-format, every `answer=` independently verified against the lesson,
≥1 interleaved item unless this is an entry module, `qid`/`qtype` (never `id`/`type`),
no code cells.
