# Phase 3 — Quarto, WebR, rendering & CI: filed issues

Fable deep-dive review, Phase 3 of 5 (see `docs/fable-review-phase-3.md`). Filed 2026-07-04.

**Method:** 3 Opus sub-agents (CI workflows + .coderabbit.yaml; _quarto.yml/renv/index-script
machinery; WebR contract + fork friction). Fable spot-checked every load-bearing claim against the
real files (render.yml read in full, README Requirements, script code, both auxiliary workflows,
CLAUDE.md and interactive-webr.md excerpts) before drafting. One sub-agent finding was REJECTED in
verification (deploy race — see not-issues #1) and one was SHARPENED (renv drift — see #78's design
note: the setup chunk's auto-install defeats the assumed render backstop).

**Dedup vs Phases 1-2:** checked both prior issue files. No overlap. #76 extends the check-indexes.R
built by Phase-2 #51 (additive new check + the two generator nits Phase-2's learnings explicitly
deferred); #79 touches a CLAUDE.md bullet untouched by Phase-1 #14. No prior issues reopened.

**Labels:** `phase-3`, `mission:new-learner-course`, `mission:forkability`.

| # | Title | Core defect |
|---|---|---|
| [#74](https://github.com/radlinsky/professor-claude/issues/74) | Fix README setup: restore, not init/snapshot; pin versions | README:101-103 tells a forker `renv::init(bare=TRUE)`+`snapshot()` — OVERWRITES the committed 26-package renv.lock with a 2-package one; CI restores instead. No R/Quarto version pins in README (CI: R 4.5.2, Quarto 1.9.38) |
| [#75](https://github.com/radlinsky/professor-claude/issues/75) | Native-R execution check for autorun {webr} cells + real manual procedure | Nothing executes {webr} cells anywhere; the docs' "manual/CI check" (interactive-webr.md:114-116, Playwright job) does not exist. Fix: base-R proxy script running `autorun: true` cells (contract makes native R faithful — cells must be base-R + self-contained) + written spot-check steps |
| [#76](https://github.com/radlinsky/professor-claude/issues/76) | Harden index scripts: local registration check, renumber, scaffold guard | Registration guard lives only in CI bash (render.yml:30-38) — local render silently skips unregistered pages; check labels execute 0,1,4,5,3,6,2; gen-indexes emits practice/resources lines for partial scaffolds (both deferred #72 nits confirmed in code) |
| [#77](https://github.com/radlinsky/professor-claude/issues/77) | Pin equivalence R; license-check develop pushes | equivalence.yml:29 `r-version: 'release'` + unpinned jsonlite vs render's pinned 4.5.2; license-check push trigger main-only |
| [#78](https://github.com/radlinsky/professor-claude/issues/78) | Gate renv.lock drift post-render | No workflow checks the lock; worse, the template setup chunk AUTO-INSTALLS missing packages at render time (RSPM on in CI) so a forgotten `renv::snapshot()` still renders GREEN while the lock rots. Fix: post-render library-vs-lockfile diff (renv::status() is the wrong tool — the `needed <- c(...)` pattern is invisible to renv's static scanner) |
| [#79](https://github.com/radlinsky/professor-claude/issues/79) | CLAUDE.md registration bullet: generated-foundations exception | CLAUDE.md:101-103 blanket "every page goes into _quarto.yml" — hand-editing the foundation sentinel block trips `gen-indexes.R --check` in CI; the meta.dcf/generator path is unmentioned |
| [#80](https://github.com/radlinsky/professor-claude/issues/80) | Document vendored quarto-live update procedure | True pin (v0.2.0) recorded only in prose; `_extension.yml` reads misleading `0.1.3-dev`; no update procedure exists |

## Findings NOT turned into issues

1. **Pages deploy "race" — REJECTED.** A sub-agent claimed queued deploys could publish an older
   artifact after a newer one. GitHub concurrency semantics (group `pages`, `cancel-in-progress:
   false`) keep at most one running + one pending run per group, and a newer pending SUPERSEDES the
   older pending — runs start in arrival order, so the final deployed artifact is always the newest
   commit. render.yml:86-90's design (serialize, never cancel an in-flight publish) is correct as-is.
2. **The registration CI guard already exists and covers courses** (render.yml:30-38) — the phase
   brief's candidate issue "a CI/lint step that flags unregistered pages" was already implemented;
   #76 only adds the local/R twin and hardening.
3. **Render gating is exemplary:** whole-site render on every PR and every push to main/develop with
   NO path filter; pinned R 4.5.2 + Quarto 1.9.38; deploy `needs: render`, main-only; offline lychee
   link check; broken baked `{r}` chunks fail the build (no `error: true`, no freeze).
4. **The {webr}/{r} contract is clean post-Phase-1:** role→engine table unambiguous, matches the
   template exactly, package-limits doc (webr-decision §2-3) transitively linked from CLAUDE.md, the
   skill, the template, and the contract. No contract issue — only the execution gap (#75).
5. **`warning: false` in _quarto.yml execute settings** swallows chunk warnings at build — a
   deliberate noise-reduction choice; flagging for owner awareness, not filing.
6. **Extending gen-indexes.R to course pages** (courses are still hand-typed twice in _quarto.yml) —
   deliberate deferral: the merge-conflict pressure that motivated the generator was the 15-module
   foundation fan-out; course PRs land less often in parallel. Revisit if a course batch is planned.
7. **No content/pedagogy gate in CI** (teaching contract enforced only by the authoring-time auditor
   loop + advisory CodeRabbit) — Phase 4's territory (audit deep-dive); not filed here.
8. **license-check `courses/*/syllabus.md` single-level glob** — courses are structurally single-level
   per course-structure.md; nested-course syllabi don't exist. Non-issue by construction.
9. **webr-decision.md §2's grep one-liner has a `$`-anchored placeholder** needing literal
   substitution — usability nit, not a decision ambiguity; skipped.
10. **jsonlite left floating in equivalence.yml** — intentional (stable API; the check itself
    exercises it); #77 documents the choice in a comment rather than pinning.

## Prior issues touched

None reopened or modified. #76 extends Phase-2 #51's script additively and implements the two
generator nits Phase-2's learnings recorded as deferred.
