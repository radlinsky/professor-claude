# WebR viability decision (Stage 1)

**Date:** 2026-07-02
**Question:** Is WebR the right way to make lesson code runnable in the rendered page —
in-browser, no server, usable on a phone?
**Verdict: ADOPT WebR, via the official `r-wasm/quarto-live` extension**, scoped to
first-principles/base-R teaching code, with a static "runs on your machine, not here"
fallback for anything WebAssembly cannot run.

This document records the evidence, the limits, the extension choice, and the
recommended shape for Stages 2–4. No course or template changes ship with this PR.

---

## 1. What WebR is, and its current state

WebR is R compiled to WebAssembly (via Emscripten); it executes entirely client-side in
the browser, so a rendered Quarto page needs only static hosting — no Shiny/Jupyter
server ([webR docs](https://docs.r-wasm.org/webr/latest/), accessed 2026-07-02).

- Current release: **webR v0.6.0, published 2026-05-19**
  ([r-wasm/webr releases](https://github.com/r-wasm/webr/releases), checked 2026-07-02).
  Ships R 4.5.x on Wasm. Actively developed by Posit (George Stagg et al.); regular
  release cadence (0.5.4 → 0.6.0 within a year;
  [tidyverse blog, 2025-07](https://tidyverse.org/blog/2025/07/webr-0-5-4/)).
- This repo runs R 4.5.2 natively — same minor version as webR's R build, so teaching
  code behaves identically in both (modulo the package caveats below).

## 2. Package availability at repo.r-wasm.org

WebR loads only packages **pre-compiled to WebAssembly**, served from a CRAN-like CDN
repository at <https://repo.r-wasm.org/>
([Installing R Packages, webR docs](https://docs.r-wasm.org/webr/latest/packages.html),
accessed 2026-07-02).

**Checked 2026-07-02** against the R 4.5 binary index
(`https://repo.r-wasm.org/bin/emscripten/contrib/4.5/PACKAGES`): **23,559 packages** are
available. Spot checks relevant to this repo:

| Available | Missing (never expected) |
|---|---|
| MASS, mvtnorm, Matrix, ggplot2, dplyr, data.table, glmnet, lme4, survival, boot, broom, forecast, zoo, xts, palmerpenguins, Rcpp | **rstan, rstanarm, cmdstanr, rjags, INLA** |

**How to check availability** (any of):

1. Programmatic — grep the binary index:
   `curl -s https://repo.r-wasm.org/bin/emscripten/contrib/4.5/PACKAGES | grep -c '^Package: <name>$'`
2. In a running webR session (e.g. the [webR REPL demo](https://webr.r-wasm.org/latest/)):
   `webr::install("<name>")` — errors if unavailable.
3. The search interface at <https://repo.r-wasm.org/>.

**Trap recorded for future authoring — "binary exists" ≠ "actually works":**

- `brms` **is** in the wasm repo, but it is pure-R glue that requires a Stan backend
  (`rstan` or `cmdstanr` — both absent) to fit anything. It can be installed in webR but
  cannot sample.
- `nimble` **is** in the wasm repo, but its workflow compiles generated C++ at runtime —
  impossible in the browser (see §3). Only its non-compiled fallback paths could run.

Authoring rule that follows: availability checks must test the *workflow* (fit a tiny
model), not just `install()`.

## 3. The hard limits (why some packages will NEVER run in-browser)

Wasm packages are **cross-compiled ahead of time** on a host machine: the `rwasm`
package drives R's Makevars mechanism to build packages with the Emscripten toolchain
and deploys the binaries to a repository
([Building R Packages, webR docs](https://docs.r-wasm.org/webr/latest/building.html),
accessed 2026-07-02). There is **no C/C++/Fortran compiler inside the browser**, and no
way to link against system libraries at runtime. Concrete fallout:

- **The entire Stan family is out**: `rstan` fits models by translating them to C++ and
  compiling (CRAN: `NeedsCompilation: yes`, `SystemRequirements: GNU make`;
  [CRAN rstan page](https://cran.r-project.org/web/packages/rstan/index.html), accessed
  2026-07-02). No compiler in the browser → no model compilation → `rstan`, `rstanarm`,
  `cmdstanr`, and therefore working `brms`, will never run in webR. None of the Stan
  backends are in the wasm repo (checked 2026-07-02, §2).
- **`rjags` is out**: it links the external JAGS C++ system library. Not in the wasm
  repo.
- **`INLA` is out**: depends on shipped native binaries. Not in the wasm repo.
- **`nimble`'s compiled workflow is out** (runtime C++ generation + compilation), even
  though a binary of the package itself exists.

This aligns exactly with the repo's teaching bet: **hand-rolled base-R implementations
(including hand-rolled MCMC) run live in the browser; real inference tooling is shown
static with baked-in output** from the desktop/CI render.

For this repo *today* the limits cost nothing: `renv.lock` contains only render
infrastructure (knitr, rmarkdown, bslib, …) and every existing lesson is pure base R
with base graphics — 100% of current teaching code is webR-runnable.

## 4. Which extension: `quarto-live` (official), not `coatless/quarto-webr`

Two candidate Quarto extensions embed webR cells:

| | [r-wasm/quarto-live](https://github.com/r-wasm/quarto-live) | [coatless/quarto-webr](https://github.com/coatless/quarto-webr) |
|---|---|---|
| Status | **Official Quarto WebAssembly backend** (so described by quarto-webr's own docs banner, accessed 2026-07-02) | Community extension, explicitly "not affiliated with Posit, Quarto, or webR" |
| Latest release | **v0.2.0, 2026-05-22** (webR 0.6.0 inside) | 0.4.3, 2025-06-24 |
| Activity | Last push 2026-06-08 — active | Last push 2025-11-19 — ~7 months quiet |
| Teaching features | Exercises with hints/solutions/**grading**, CodeMirror editor (theming, autocomplete, persistence), OJS reactivity, resource loading, base-graphics output (ragg fallback since v0.1.3, 2026-02-02) | Code cells; fewer exercise/grading features |

(Release data from GitHub releases/API, checked 2026-07-02.)

**Choice: `quarto-live`.** Official, more actively maintained, tracks current webR
within days, and its exercise/hint/solution/grading machinery maps directly onto this
repo's practice-problem and check-yourself patterns. `quarto-webr` remains a known-good
fallback (it proved website/book integration earlier than quarto-live — see §5) if
Stage 2 hits a blocking integration bug.

## 5. Does it compose with this repo's pipeline? Yes, with two knowns to manage

The repo is a single Quarto **website** project rendered by **knitr** under **renv**.
Evidence that quarto-live fits:

- **Install is additive**: `quarto add r-wasm/quarto-live` vendors the extension into
  `_extensions/`; no change to the render engine
  ([quarto-live README](https://github.com/r-wasm/quarto-live/blob/main/README.md),
  accessed 2026-07-02).
- **knitr is explicitly supported**: a knitr document sets `format: live-html`,
  `engine: knitr`, and adds `{{< include _extensions/r-wasm/live/_knitr.qmd >}}`. Live
  `{webr}` cells are *not* executed by knitr at render time; normal ```` ```{r} ````
  chunks keep executing under renv exactly as today. The two coexist in one document —
  this is the mechanism for the interactive-vs-static split.
- **Works in `type: website` projects**: maintainer-confirmed working config in
  [quarto-live issue #93](https://github.com/r-wasm/quarto-live/issues/93)
  (georgestagg, 2025-04-23) — a website project with per-page `format: live-html`.
- **Static hosting stays sufficient**; GitHub Pages-class hosting is the stated
  deployment target (README, accessed 2026-07-02). Rendered pages remain viewable
  through `code-server` + `quarto preview` on the phone; webR fetches its runtime from
  CDN at page load (needs network — see risks).
- **Base graphics work client-side** (canvas, with a ragg fallback added in v0.1.3
  release notes, 2026-02-02) — matching the repo's base-graphics-only convention.

Two knowns to manage in Stage 2 (neither is a blocker):

1. **Theming quirk in website projects** (the actual subject of issue #93, open,
   created 2025-03-06): a site-wide `theme`/CSS declared under `format: html` may not
   apply to `live-html` pages until the theme is also declared for the `live-html`
   format. Fix is YAML-level (declare the theme at project level for `live-html`, or
   per-page). The earlier
   [book-project friction thread (Posit forum, Jan–Feb 2025)](https://forum.posit.co/t/is-it-possible-to-use-quarto-live-in-a-quarto-book-project/197241)
   predates the documented knitr include pattern; the failure mode ("webr engine not
   registered") is resolved by the §5 config.
2. **Package-version drift**: renv pins CRAN versions for the desktop render; webR
   pulls the wasm repo's current build (tracking latest R minor). For base-R lessons
   this is a non-issue; if a lesson ever loads a package in a live cell, the authoring
   checklist must note the wasm version is not renv-pinned. (Freezing is possible later
   by self-hosting wasm binaries, but not needed now.)

## 6. Alternatives considered, and when they beat WebR

| Alternative | State (checked 2026-07-02) | When it wins |
|---|---|---|
| **httpgd** (live plots from a real R session, viewed in browser) | Active: v2.1.4, CRAN published 2026-03-04 | Real R session needed anyway (big compute, non-wasm packages) and the learner is at a machine or SSH session. Not static, needs a running server — doesn't meet "runnable in the rendered page". |
| **RStudio Server / Posit Workbench in a browser tab** | Mature | Full IDE work on the phone against real R. Heavyweight, needs a managed server, and is a separate surface from the lessons — not in-page. |
| **Static rendered output (status quo)** | — | Anything wasm can't run: Stan/JAGS/INLA comparisons, big data, long computations. This *is* the designated fallback mode, with outputs baked in at desktop/CI render time and labeled "runs on your machine, not here". |

None of the alternatives make code runnable *inside the rendered lesson with no
server*, which is the mission. WebR is the only fit; the alternatives slot in as the
static-fallback path (and httpgd/desktop R remain how the learner does real work).

## 7. Risks & mitigations

- **quarto-live is v0.x** (73 open issues, checked 2026-07-02). Mitigation: PoC on one
  real lesson in Stage 2 before templating; quarto-webr as fallback extension.
- **In-browser execution can't be verified in the Claude Code sandbox** (no browser).
  Mitigation (per project plan): manual phone/desktop check of the rendered page, or a
  CI-only Playwright job on a GitHub Actions runner. `quarto render` success remains
  the automated gate.
- **Phone memory/network**: webR runtime (~tens of MB) downloads at page load; wasm
  heap is browser-limited. Teaching-scale simulations are far below these limits, but
  the Stage 2 PoC must include an actual phone check (this is the learner's stated
  reading device).
- **Offline reading breaks for live cells** (CDN fetch at load). Acceptable: static
  code + baked output still renders; self-hosting webR assets is a later option.

## 8. Recommended shape for Stages 2–4

- **Stage 2** — adopt per-lesson opt-in: `format: live-html` + `engine: knitr` + the
  `_knitr.qmd` include on lessons that earn interactivity; project stays `type:
  website` with the theme declared for `live-html` (watch #93). Interactive `{webr}`
  cells go where the learner solves or manipulates (practice, check-yourself,
  tweak-a-parameter intuition builds); everything else stays as today's knitr chunks.
  Non-wasm tooling renders static with baked output and the "runs on your machine"
  label. Template + authoring-doc changes ride this stage; PoC on
  `simple-linear-regression`.
- **Stage 3** — the equivalence harness runs in **native R under renv** (never in the
  browser): install real reference libraries, freeze fixtures to the repo, and let both
  CI (native) and live `{webr}` cells (via quarto-live's resource-loading mechanism)
  assert the from-scratch reimplementation matches within tolerance. Record the
  validation tier (full / reported-numbers / analytic) in the fixture metadata, since
  §3 guarantees some references (Stan-class) can never run in-browser and some sources
  won't run at all.
- **Stage 4** — the port-a-library skill emits lessons in the Stage 2 interactive/static
  split and validates through the Stage 3 harness; the wasm-availability check (§2,
  including the workflow-not-binary trap) becomes a step in its source-analysis phase.

## Sources

All URLs accessed 2026-07-02 unless noted.

- webR docs — <https://docs.r-wasm.org/webr/latest/> (packages: `/packages.html`; building: `/building.html`)
- webR releases — <https://github.com/r-wasm/webr/releases> (v0.6.0, 2026-05-19)
- webR 0.5.4 announcement — <https://tidyverse.org/blog/2025/07/webr-0-5-4/> (2025-07)
- quarto-live — <https://github.com/r-wasm/quarto-live> (v0.2.0, 2026-05-22; v0.1.3, 2026-02-02); docs <https://r-wasm.github.io/quarto-live/>
- quarto-live issue #93 (website project + theming) — <https://github.com/r-wasm/quarto-live/issues/93> (2025-03-06; maintainer config 2025-04-23)
- quarto-webr — <https://github.com/coatless/quarto-webr> (0.4.3, 2025-06-24); docs <https://quarto-webr.thecoatlessprofessor.com/>
- Posit forum, quarto-live in a book project — <https://forum.posit.co/t/is-it-possible-to-use-quarto-live-in-a-quarto-book-project/197241> (Jan–Feb 2025)
- wasm package index — `https://repo.r-wasm.org/bin/emscripten/contrib/4.5/PACKAGES` (23,559 packages; availability spot-checks in §2)
- CRAN rstan — <https://cran.r-project.org/web/packages/rstan/index.html>
- CRAN httpgd — <https://cran.r-project.org/web/packages/httpgd/index.html> (2.1.4, published 2026-03-04)
