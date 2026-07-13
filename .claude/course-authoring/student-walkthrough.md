# Student walkthrough (persona review)

A second review MODE that runs alongside the numbered rubric
(`content-review-checklist.md`): read the material **as the learner in
`learner-profile.md`** and let that persona's real-time reactions surface defects
no checklist item can enumerate in advance. The rubric asks "does the file satisfy
rule N?"; the walkthrough asks "did the story just break for this reader?" — the
two passes catch different escapes.

Why this pass exists: PR #128 shipped five auditor-passed modules, and a student
walkthrough still found a toy dataset silently swapped mid-lesson, a placeholder
code comment, and a false claim about a built-in dataset. Each became checklist
check 24, 25, and 26 — but the *method* that found them is this document.

**Who runs it:** the `course-auditor` agent (mandatory, folded into its first
end-to-end read), any skill's self-review step when no agent is available, or on
demand ("walk through <module> as the student"). Like every review in this repo it
is **report-only** — log defects with file:line and the exact quote; never edit.

## Become the learner

Read `learner-profile.md` first and hold the persona for the whole read. For this
repo's shipped example learner that means: fluent professional R, rusty AP-Calc
mechanics, one long-ago stats course, cannot read dense notation cold, follows
worked examples with a pencil. Two consequences drive everything below: **they
verify with a pencil and with R**, and **they cannot fill gaps the text leaves** —
what a mathematically fluent author auto-repairs while reading, this reader
experiences as a wall.

## The method

Read each lesson start to finish, in order, no skipping — the learner can't skip,
so neither can you. While reading, hold these five disciplines:

1. **The pencil rule.** When the lesson works a number, work it yourself BEFORE
   reading the lesson's result, then compare (this is checklist check 3 done
   in-flow rather than as a separate sweep). When a formula is derived, plug the
   toy numbers in — if the lesson never does, that is the TEACHING.md
   "sanity-check it numerically in front of the reader" rule failing.
2. **The R-programmer rule.** Run what this learner would run. They will
   `cor(iris[,1:4])` the moment a lesson claims something about iris; they will
   re-run a quoted seed to see if the draw reproduces; they read every comment
   the displayed chunk shows them as teaching text (`#|` chunk options are
   stripped at render and don't count), because to them the chunks ARE the
   lesson. Verify
   with `Rscript -e` as you go (check 26 owns dataset claims; check 25 owns
   comments).
3. **The "do I know this yet?" register.** At every symbol, term, and algebraic
   move, ask whether the persona has been taught it — by this lesson, a linked
   prerequisite, or the stated baseline. If the answer is "a mathematician would
   know", it's a defect (checks 2, 4, and 14's
   "actually taught there" clause). Seed escape: a MAP lesson leaned on Beta(a, b)
   mechanics when the linked priors module mentioned Beta only inside a code
   comment.
4. **The "is this still the same example?" register.** The toy dataset is a
   character in the story; the persona is tracking its values on paper. If a later
   chunk or sentence quietly uses different values while still saying "our data",
   the story broke and trust goes with it (check 24).
5. **The "was that thread resolved?" register.** Note every question a section
   opens with ("which species is the new fish?") and every tool it builds, and
   confirm each gets a numeric payoff on the running example before the lesson
   moves on. A rule derived but never applied — the reader left wondering what it
   would have said — is a defect under TEACHING.md §Building equations even though
   no arithmetic is wrong.

Practice files get the same treatment: attempt each problem before opening the
answer callout, exactly as the timing note tells the learner to — running its
starter chunk first when the problem provides one (not every problem does; see
`problem-authoring.md` §Copy-able data for the exemptions).

## Logging what you find

A reaction is only useful once it's a findable defect. For each one record:
file:line, the exact quote, what the persona experienced ("I hand-computed bass
covariance = +0.5 from the toy table; the chunk says (6, 4, 6)"), and the minimal
fix. Map it to a numbered check where one exists (24 toy-data continuity, 25
learner-visible comments, 26 empirical dataset claims, or any other); otherwise
cite the TEACHING.md rule it violates. Feed the log into the same severity-ordered
defect table as the rubric findings — one report, two methods.

## What this pass is NOT

- Not a replacement for the numbered rubric — run both; the rubric still catches
  structural gaps (missing ramp stages, quiz form) the persona won't notice.
- Not a critique of difficulty or taste. "This felt hard" is not a defect;
  "this used a move nothing has taught" is.
- Not editing. Report only; fixes route through the update-course skill.
