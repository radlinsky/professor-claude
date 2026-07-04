# Phase 2 — build learnings

How the Phase-2 batch (issues #33–#51) was actually executed, and what to reuse next
time. The issue list itself is in `PHASE-2-issues.md`; this file is the *process* record.

## What shipped

- **15 foundation modules** (#33–#47): matrices-and-linear-transforms (pilot),
  linear-combinations-and-data-matrices, variance-structure-and-standardization,
  distance-similarity-and-geometry, loss-functions-and-optimization,
  randomness-samples-and-sampling-distributions, likelihood-and-log-likelihood,
  distributions-and-densities, algebra-moves-for-derivations, paper-and-proof-conventions,
  partial-derivatives-and-the-gradient, hypothesis-tests-p-values-and-confidence-intervals,
  model-fit-error-and-validation, priors-posteriors-and-updating,
  resampling-bootstrap-and-permutation.
- **4 infra issues** (#48 Builds-on column + roadmap F→F edges + create-course sort rules;
  #49 reading-math-notation standing-first prerequisite wiring; #50 Status-preservation
  gate checkboxes; #51 index-check CI).
- **2 supporting infra PRs surfaced by the work**: #59 (`.coderabbit.yaml` note) and #63
  (the `meta.dcf` index generator).

## Orchestration that worked

- **Pilot first.** Build the infra + one root module (#33) end-to-end, get the format
  signed off, *then* fan out. Caught format issues once instead of 15×.
- **Dependency tiers, not one big bang.** Tier 1 = modules whose Builds-on are already
  merged; Tier 2/3 = modules that depend on a Tier-1/2 module. A module can't be authored
  until its Builds-on targets are **merged** (its lesson links them; the index-check fails
  on a dangling link otherwise).
- **Author via a `Workflow` fan-out, one agent per module** (author → register → render →
  push), piped into an independent **`course-auditor`** pass. Then a human-in-the-loop
  triage of the auditor + the four review bots before each merge.
- **The course-auditor gate earns its keep.** It recomputes every number and caught real
  defects a green render hides: a false `dist()` correlation-distance claim, an inverted
  CI↔p-value check, a wrong permutation p-value in a "numeric proof", paper-agnostic slips
  ("ridge/Gaussian" in a foundation), and — by far the most common — missing
  pronunciation-table rows for symbols used in `$...$` blocks.

## Git / CI gotchas (see also the `pr-flow-develop` memory)

- **`develop` is squash-merged into `main` and then deleted.** To start a batch, recreate
  it: `git push origin origin/main:refs/heads/develop`. Because merges are *squash*, a
  merged PR's commit is not an ancestor of branches stacked on it — rebase stacked
  branches with `git rebase --onto origin/develop <old-base>`, never a plain rebase.
- **Rendering inside a git worktree**: worktrees have no `renv/library`, so
  `RENV_PATHS_LIBRARY=<repo>/renv/library quarto render <file>` (one file at a time).
- **`Closes #N` does not auto-close** on develop-targeted PRs (default branch is `main`);
  close issues manually.

## The merge-conflict fix (#63) — the biggest lever

Every module PR appended to the same two files (`_quarto.yml` render list + sidebar,
`foundations/README.md` table), so parallel PRs serially conflicted and each needed a
rebase. The fix: **generate those blocks** from a per-module `foundations/<slug>/meta.dcf`
(`ShortName`, `Concepts`, `BuildsOn`, `UsedBy`) via `scripts/gen-indexes.R`, **sorted by
slug** between sentinel markers, preserving learner-owned Status. Because entries are
sorted (not appended), different modules touch non-adjacent lines and git auto-merges —
only two modules landing in the *same* alphabetical gap still collide (a trivial re-run of
the generator resolves it). `gen --check` in CI blocks drift. This also serves
`mission:forkability`: a forker adding many foundations never hits the churn.
Tradeoff accepted: the Foundations **sidebar is now alphabetical** (a pool, not a
sequence — dependency order lives in the Builds-on column + roadmaps, not nav position).

## Triaging four review bots (CodeRabbit, Greptile, LlamaPReview, qodo)

Fix the real, decline the rest *with a reason on the PR*:

- **Fix**: wrong numbers/logic, border violations (a foundation re-teaching or crossing
  into course-level material), broken links, genuine missing symbol rows, leftover
  template placeholders, orphaned `fig-alt`.
- **Decline (recurring false positives)**: `edit: true` "missing" on `{webr}` starters
  (it's the r-wasm default — #59 documents this so CodeRabbit stops); "Status column
  edited" when *adding a new row* (allowed; #50 protects *existing* rows); prose Builds-on
  line "not canonical slugs" (the repo convention; index-check Check 6 validates the
  slugs); "module before its prerequisite" in the alphabetical sidebar (by design);
  verbatim helper redefinition across `{webr}` cells (intentional — cells are
  self-contained). When bots re-review after a fix, GitHub re-anchors *old* threads to the
  new commit — check `original_commit_id` to tell stale from new.

## Deferred (not done in Phase 2 — owner's call on timing)

- **Course retrofit**: slim `simple-linear-regression/02–04`, `logistic-regression/03–04`,
  `gradient-descent/02–03` to *link* the new foundations instead of teaching those
  fundamentals inline (they still do; the foundations now exist to link to). One
  `update-course` run per course.
- **Minor generator hardening** (Greptile nits on #72, non-blocking): renumber
  `check-indexes.R` check labels to execution order; add an existence guard in
  `gen-indexes.R` for partial scaffolds (only `lesson.qmd`, no practice/resources yet).
