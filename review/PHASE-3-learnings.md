# Phase 3 — build learnings

How the Phase-3 fix batch (issues #74–#80, the Quarto/WebR/CI/rendering review) was
actually executed, and what to reuse next time. The issue list is in `PHASE-3-issues.md`;
this file is the *process* record (cf. `PHASE-2-learnings.md`).

## What shipped

Two PRs against `develop`, then one release PR `develop → main`:

- **#82** (`phase-3/ci-scripts-webr`): #77 (pin equivalence R 4.5.2 + license-check on
  develop), #76 (harden index scripts), #78 (post-render renv.lock drift gate), #75
  (native-R autorun `{webr}` execution check), #80 (vendored quarto-live update procedure).
- **#81** (`phase-3/guide-docs`): #74 (README `renv::restore` + version pins), #79
  (CLAUDE.md registration split: course = hand-register, foundation = meta.dcf + generator).
- **#83**: release roll-up of all of `develop` (25 commits) into `main`.

Two Phase-2 deferrals got closed here: #76 renumbered `check-indexes.R`'s check labels to
execution order and added the `gen-indexes.R` partial-scaffold guard (both listed as
"deferred" at the end of `PHASE-2-learnings.md`).

## Orchestration that worked

- **Group PRs by file overlap, not by theme.** The 7 issues clustered by *which files they
  touch*: `render.yml` (#75, #76, #78) and `interactive-webr.md` (#75, #80) forced those
  five into one PR; #74/#79 touch only README/CLAUDE.md, disjoint from everything, so they
  went in a second PR. Result: **two PRs with zero shared files → fully parallel, no
  stacking, no `rebase --onto`.** Cheaper than one-PR-per-issue (7× the bot/CI overhead and
  render.yml conflicts) and cleaner than theme grouping (which would have split #75 across
  PRs and conflicted on the shared files).
- **`Workflow` fan-out, one agent per PR**, each creating its own **persistent** worktree
  (`git worktree add ../pc-wt-<name> -b <branch> origin/develop`) — not the Workflow's
  ephemeral `isolation: worktree`, because the worktree has to survive for bot-feedback
  follow-ups. Both agents returned a structured result (PR URL, per-issue verification list).
- **Don't trust the agent self-report — independently diff every PR before it's "done".**
  The agents reported all-green, but reading the actual diff caught a real semantic bug the
  agent's own scratch test missed (Check 7 below). Self-reported "passed" ≠ correct.

## Verification posture (lazy but honest)

- **No full `quarto render` in a worktree** (worktrees lack `renv/library`; a whole-site
  render is ~8–11 min). Instead: run the base-R scripts directly (`Rscript scripts/*.R` —
  they need no renv), `python3 -c 'yaml.safe_load(...)'` on every edited workflow, and prove
  render-dependent logic with lightweight simulations (e.g. `setdiff(c(lock,'praise'), lock)`
  for the #78 drift check) rather than actually rendering. CI is the final gate for the
  render steps.
- **Scratch trials stay out of the commit.** Break-an-autorun-cell (#75), unregistered-page
  and partial-scaffold (#76) trials were run then reverted; `git status --porcelain` checked
  before every commit.

## The one real bug independent review caught — Check 7 regex

#76 added a local R twin of render.yml's "every page registered" CI bash guard. render.yml
extracts render-list paths with `grep -oP '(?<=- )(foundations|courses)/\S+\.(qmd|md)'`.
Two wrong iterations before the right one:

1. Agent's first cut matched the path **anywhere on a line**, so sidebar `href:` lines
   counted as "registered" → a page in the sidebar but missing from `project: render:` would
   pass the R twin yet fail CI. (qodo flagged this too, same finding.)
2. My first fix over-corrected with a `$`-anchor (`^\s*-\s+...\.(qmd|md)\s*$`), which then
   **rejected a render-list line with a trailing YAML comment** — the opposite divergence.
   CodeRabbit caught that.
3. Correct fix = **render.yml's exact PCRE**, `regexpr("(?<=- )(foundations|courses)/\S+\.(qmd|md)", lines, perl = TRUE)`.
   The lookbehind excludes `href:` lines; `\S+` stops at whitespace so trailing comments are
   tolerated. Now byte-identical semantics to CI. Lesson: to "keep in sync" with a grep, port
   the *exact* regex (perl=TRUE for PCRE lookbehind), don't paraphrase it.

## Release PR (`develop → main`) hit add/add conflicts — recurring hazard

`#83` came up `CONFLICTING` on `scripts/check-indexes.R` and `gen-indexes.R` with **add/add**
conflicts. Cause: the squash-merge + develop-recreation flow. `main` got those scripts from
an earlier `Develop (#72)` squash-merge whose commit is **not an ancestor of the current
develop**, and the merge base (`#32`) predates the scripts — so git sees the same file as
independently added on both sides. Any file both `main` and `develop` touched since the last
release will do this on the release PR.

Resolution recipe (verify, then take develop):
1. `git merge-base origin/main origin/develop` and confirm the file is absent there (→ add/add).
2. Diff the two versions: `diff <(git show origin/develop:F) <(git show origin/main:F) | grep '^>'`
   — main-unique lines should be only *stale* content develop deliberately changed (here, the
   old out-of-order check labels), never real new work.
3. `git merge origin/main` on develop, `git checkout --ours F...`, verify scripts still pass,
   commit the merge, push. Then the release PR is `MERGEABLE`.

## Bot triage (four bots, release-PR twist)

- **Fixed (real):** Check 7 regex (both iterations above); autorun detector missing a trailing
  YAML comment; no timeout on the webr subprocess (a hung cell would stall CI until the job
  timeout — added `system2(..., timeout = 120)`).
- **Declined false positive:** LlamaPReview "`system2(stdout=TRUE, stderr=TRUE)` returns a
  list, CELL_ERROR extraction is dead code" — **verified empirically it returns a character
  vector**; `grep` works. Always test the claim before believing a confident bot.
- **Declined (deliberate / issue-prescribed):** `renv::paths$library()` "internal API"
  (it's exported+documented, and the suggested `libpaths()` would break the check by scanning
  system libs); jsonlite left floating (#77, documented); render.yml bash guard "removable"
  (kept on purpose — fails fast before R installs); check renumbering "breaks external refs"
  (nothing references numbers); Quarto "≥ 1.9 (CI uses 1.9.38)" wording (exactly #74's spec).
- **Release-PR twist:** a `develop → main` PR makes all four bots re-review the *entire*
  `main..develop` diff, re-surfacing findings on code already fixed and merged via the
  component PRs. The "Check 7 too broad" re-flag on #83 was **stale** — the current blob
  already had the perl-lookbehind fix. Check `original_commit_id` and grep the *current* file
  before acting on any release-PR comment.

## Reusable artifact

- **`scripts/check-webr-cells.R`** — the interactive `{webr}` cells were the only code in the
  repo with zero automated verification. This runs every `#| autorun: true` cell in a fresh
  `Rscript` per document (base-R + self-contained per the contract, so native ≈ in-browser),
  wired into render.yml after the render step. It does **not** replace the manual in-browser
  spot-check (documented in `interactive-webr.md` §Verifying) — wasm quirks aren't covered.
