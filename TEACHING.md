# TEACHING.md — the teaching contract

**The single source of truth for HOW to teach in this repo.** Every file whose job
is to teach — lessons, practice sets, syllabi, teaching-oriented comments — follows
these rules. Other files (CLAUDE.md, skills, templates, checklists) point here; they
must not restate these rules, so this file can evolve without drift.

WHO you are teaching lives in `.claude/course-authoring/learner-profile.md` (strong
R programmer; rusty AP-Calc + one long-ago intro stats course; cannot read dense
notation cold). Repo mechanics (folders, Quarto, renv) live in
`.claude/course-authoring/course-structure.md`. This file is deliberately close to
project-agnostic: to reuse it elsewhere, copy it to another repo's root and add one
line to that repo's CLAUDE.md.

Most rules here implement two findings that dominate the learning-science
literature: **retrieval beats re-reading** (practicing recall is what builds
memory), and **explanations stick only when anchored to something concrete the
learner already has**. When you face a judgment call the rules don't cover, decide
in favor of those two.

---

## The golden order (non-negotiable)

Every lesson runs this spine, in this order. Within it, every new CONCEPT gets
steps 2–7 in order. Steps 1 and 8–11 appear **once per lesson**; steps 2–7 form a sub-spine repeated **for each new concept** the lesson introduces. A formula may never appear before its toy example and its
pronunciation-table row.

1. **Warm-up retrieval** — 2–3 quick recall questions on the prerequisites THIS
   lesson stands on (earlier modules, or baseline knowledge for entry modules),
   answers in collapsed callouts with a link back to where each was taught. The
   learner must *retrieve*, not re-read: questions ask them to produce a value, a
   pronunciation, or a one-line explanation — never "did you read X?".
2. **Tiny worked example first** — small hand-checkable numbers (n ≤ 6, integers
   when possible), every arithmetic step shown in prose AND reproduced in a
   commented R chunk. No formal notation yet.
3. **Getting a feel for it (intuition, before notation)** — three beats, still no
   formulas:
   (a) an **analogy or mental picture** tying the concept to something the learner
   already has a feel for;
   (b) **why THIS construction** — why square, why multiply, why divide by *this*:
   the design reason, in plain words, tied to the toy numbers;
   (c) **what the number feels like** — is the toy result big or small, what change
   makes it move, and a picture when one exists.
   Anti-filler rule: restating the formula in words is NOT intuition; this section
   is a defect without a genuine analogy AND a why-it's-built-this-way reason.
4. **Notation in plain English** — narrate what the upcoming formula will say,
   referring to the toy numbers, before any symbols.
5. **Pronunciation & meaning table** — every symbol used anywhere in the lesson
   gets a row: `Symbol | How to say it | What it means | Value in our toy example`.
6. **The formal version** — only now show the formula; map each part back to the
   toy numbers; give both the symbol-by-symbol reading and an everyday-words
   reading.
7. **Explore it interactively** — runnable, tweakable chunks; compute the concept
   from the raw formula AND with the built-in function, showing they match.
8. **Common traps** — name 1–2 misconceptions and refute them *with numbers*.
9. **Check yourself** — quick retrieval questions on this lesson, including one
   say-it-in-your-own-words prompt; answers collapsed.
10. **Recap: what you can now do** — 3–5 can-do bullets and the mastery rule.
11. **Where this goes next** — forward link, practice pointer, applied-practice
    pointer when the course has one.

Practice problems (separate file) and verified external resources complete every
module. Structurally: **fundamentals before the target** — prerequisites are
always taught before the concept that needs them, including notation itself and
every algebra/calculus trick a derivation uses.

## Symbols & notation

- **First use of ANY symbol** gives: the symbol, its spelled-out name, **how to
  pronounce it**, and what it stands for here ("ρ, rho, pronounced 'ROW' — the
  correlation"). The pronunciation glossary in
  `.claude/course-authoring/notation-style.md` keeps these identical across modules.
- Every formula gets a **plain-English restatement** immediately beside it — a full
  sentence a non-mathematician could read aloud.
- Decode sub/superscripts on first use ("$x_t$ means 'the value of x at time-step
  t'"). Pair symbols with words ("the average of the x values, $\bar{x}$") until
  the pattern is established in that lesson.
- Prefer words over symbols when compression buys nothing; if the symbol form is
  needed later, show both.

## Terminology

- Define every technical term (math, statistics, economics, CS) **at first use,
  inline, in one plain sentence**. Assume zero field vocabulary.
- One consistent name per concept across the whole repo. If the literature has
  synonyms, mention them once ("also called …") and stick to the chosen one.
- Never write "it is trivial", "obviously", "simply", "clearly", or "it follows
  that". Either show the step, link the exact place that teaches it, or mark the
  material **Optional** and give the punchline in words.

## Anchors & analogies

- Ground each abstraction in an everyday anchor before formalizing (a balance
  point for the mean, a bathtub for stocks & flows, a lottery for sampling
  variation). **Reuse the same anchors repo-wide** so they compound across courses.
- Analogies must be honest: say where the analogy breaks.

## Building equations & derivations

- Assemble multi-term equations **one term at a time** — why each term exists and
  what breaks without it — then show the finished equation.
- Derivations: one algebraic step per line, each line annotated with the named
  trick it uses ("expand the square", "a sum splits into two sums"), and every
  trick taught earlier (its own module or an earlier section).
- After deriving anything, **sanity-check it numerically in front of the reader**:
  plug the toy example back in; the numbers must agree with the earlier hand
  computation.

## Retrieval, spacing & interleaving (what makes it stick)

- **Warm-up retrieval** opens every lesson (golden-order step 1). Reach back to at
  least two different earlier points when the course has them — the older the
  memory, the more the retrieval strengthens it.
- **Practice sets interleave:** at least one problem per set explicitly mixes an
  earlier module's skill with the current one (labeled, e.g. "…uses Module 1's
  SSE"). Blocked-only practice feels better and teaches worse.
- **Every course ends in a capstone module** — part 1: return to the source
  (decode the actual paper excerpt / target artifact, line by line — the course
  goal made into an exercise); part 2: a cumulative problem set drawing on ALL
  modules in mixed order. Format spec in `course-structure.md`.
- **The syllabus schedules spacing:** one module per sitting; start the next
  sitting with the new lesson's warm-up (which re-tests yesterday's material);
  don't binge the whole course in one day.

## Predict-then-run & self-explanation

- Explore-chunks and in-R problems carry **predict-then-run prompts**: "PREDICT:
  write down what you expect X to be — now run it." 2–3 per lesson. Committing to
  a prediction is what makes the observed result teach.
- Each lesson's Check-yourself includes one **own-words prompt** ("explain to a
  colleague, in two sentences, what X measures and why it's built the way it is"),
  with a collapsed model answer.
- At least one practice question tests **interpretation**, not computation ("is
  this covariance big? what would make it bigger?").

## Worked-example fading (practice ramp)

Practice sets ramp from imitation to transfer:

1. **Confidence rep** — redo the lesson's toy example with fresh, equally small
   numbers.
2. **Faded worked example** — a worked solution with 1–2 steps blanked out; the
   learner supplies ONLY the missing steps (the bridge between reading solutions
   and solving cold).
3. **Full problems** — by hand then in R, same skill from new angles; include one
   **spot-the-error** ("here is a plausible wrong computation — find the mistake"),
   built from a Common-traps misconception.
4. **Interleaved problem** — mixes an earlier module's skill (labeled).
5. **Transfer / cliffhanger** — a new context, or a clearly-labeled preview the
   learner can't fully solve yet ("the next lesson gives you the tool").

Full mechanics (starter chunks, answer format, chunk labels) live in
`.claude/course-authoring/problem-authoring.md`.

This ramp is for **first encoding**. Relearning sets added after a Module-check miss
(or once the original set is memorized) drop the scaffolds and use the abbreviated
**fresh-rep round** format instead — `problem-authoring.md` §Fresh-rep rounds.

## Module check

Each module's `practice.qmd` ends with a **Module check**: five closed-answer
(multiple-choice / numeric) questions, graded on the page and recorded in the
learner's browser. It is *summative-lite* — it sits after the free-response practice
set, presented as a **collapsed callout that tells the learner to wait at least a day**
because the spacing is the point (taking it while the lesson is fresh only measures
short-term fluency). It gives
the mastery rule the one thing self-report can't: an objective signal. **≥4/5 = the module is solid**,
and that pass is the learner's evidence for flipping their Status column to `done`.

**The timing protocol** (why each thing sits where it does): the practice set runs in
the **same sitting** as its lesson — feedback lands while the attempt is fresh, which
is what formative practice is for. The Module check waits **at least a day** — the
forgetting in the gap is what makes the retrieval effortful enough to strengthen
memory, and a same-day score only measures short-term fluency. The capstone re-tests
everything **weeks later**. The sequence deliberately expands: useful gaps scale with
how long you want to remember (roughly 10–20% of the retention interval), so
same-day → next-day → end-of-course is the cheap approximation of that curve.

**A miss is a prescription, not a verdict.** The relearning loop:

1. **Diagnose** from the missed items — re-open the lesson section each one points
   at, but only to find *what* went wrong. Re-reading is diagnosis, not treatment.
2. **Fresh reps, not re-grinding.** Practice the missed skills on a **fresh-rep
   round**: new parallel problems — same constructions, different numbers and
   contexts (format: `.claude/course-authoring/problem-authoring.md` §Fresh-rep
   rounds; the add-problems skill writes them). Re-solving the original set proves
   little once its answers are remembered — recalling an answer is not retrieving
   the procedure, and it is *varied* retrieval that transfers.
3. **Retake in a later session** — passing after another gap is the durable evidence.

Optional but research-backed: even after a pass, one more retake about a week later
buys disproportionate durability (successive relearning) — worth it for material a
later course leans on.

- **Cumulative:** 3–4 items test this module; 1–2 are interleaved from earlier modules
  of the course (or a foundation's `Builds on` modules), each labeled in its question
  text. **Entry modules** (nothing earlier) are exempt — all five items module-local.
  **Capstone modules** are the mirror image: all five items are cumulative and left
  unlabeled, matching the capstone practice set's unlabeled retrieval.
- **This is NOT a final exam.** The capstone is already the cumulative, unlabeled final
  (see `course-structure.md` §Capstone) and is unchanged; do not add a separate exam.
  The capstone module gets a Module check like any other (all-cumulative, unlabeled).

Syntax, the stable-qid rule, and the item-design rules live in
`.claude/course-authoring/quiz-authoring.md`.

## Misconceptions (Common traps)

- Each lesson names 1–2 predictable wrong beliefs **explicitly**, states why each
  is tempting, and refutes it **with the lesson's own numbers** (e.g.
  "$\left(\sum x_i\right)^2$ vs $\sum x_i^2$: 144 vs 56 — parentheses change the
  order of operations"). Naming the trap inoculates; hiding it leaves it live.
- Practice sets turn one trap into a spot-the-error problem.

## Depth control

- Everything beyond what the course goal actually needs is clearly marked
  **Optional** (in a heading or bold prefix) with one sentence on what the extra
  depth buys. The reader must always be able to skip Optional material without
  losing the thread.
- These are applied courses, not surveys: teach the minimum path to genuine
  understanding of the target, not the whole field.

## Pictures (dual coding)

- When a concept has a geometric or visual picture (slope, area, spread, a valley
  with a bottom), draw it with a simple R plot — words alone are half the encoding.
- In Quarto, give every figure chunk a `fig-alt`.

## Recap boxes

- End each lesson with **What you can now do**: 3–5 concrete can-do bullets
  ("compute a covariance by hand from paired deviations"), phrased as abilities,
  not topics.
- Attach the **mastery rule**: "If any bullet feels shaky, revisit <section/module>
  before continuing — the next module assumes all of these."

## Layering (don't re-teach)

- Fundamentals are taught **once** (usually in `foundations/`). Applied material
  *links* to the module that teaches a prerequisite; a one-line reminder of the
  punchline is fine, a re-derivation is not.
- Every teaching artifact states its prerequisites at the top ("Builds on: …") and
  links forward ("you'll use this in …") so the material forms a chain.

## Revising existing material

- Preserve verified numbers, established anchors, slugs, and section titles other
  files reference — grep before renaming or renumbering anything.
- A teaching rewrite changes the *explanation*, never the *facts*. If a fact looks
  wrong mid-rewrite, stop and flag it to the user instead of silently "fixing" it.
- Recompute any quoted number you touch; never let prose and code chunks disagree.

## Self-check before calling any teaching artifact done

- [ ] Could the learner-profile reader follow every step with a pencil?
- [ ] Golden order respected for every concept — no formula before its toy example
      and table row?
- [ ] Warm-up retrieval present and reaching back (not re-reading prompts)?
- [ ] "Getting a feel for it" contains a genuine analogy AND a
      why-it's-built-this-way reason (not a reworded formula)?
- [ ] Every symbol pronounced and plain-Englished; every term defined at first use?
- [ ] Derivation steps annotated with already-taught tricks; results sanity-checked
      numerically?
- [ ] Predict-then-run prompts present; own-words prompt present?
- [ ] Common traps present and refuted with numbers?
- [ ] Recap can-dos present, with the mastery rule?
- [ ] Practice ramp complete (confidence rep → faded → full/spot-the-error →
      interleaved → transfer)?
- [ ] Module check present: 5 closed-answer items, ≥1 interleaved (unless entry
      module), stable qids, answers verified?
- [ ] Everything beyond the applied need marked **Optional**?
- [ ] Quoted numbers re-verified against the code they came from?

The machine-checkable defect classes (with worked examples of each) live in
`.claude/course-authoring/content-review-checklist.md` — run that after every build
or revision.
