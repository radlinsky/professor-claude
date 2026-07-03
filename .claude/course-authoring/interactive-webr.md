# Interactive WebR chunks — the interactive/static contract

How runnable code gets into a lesson. This file is the single source of truth for the
**interactive-vs-static split**; it does not restate `TEACHING.md` (golden order,
predict-then-run, copy-able data, fig-alt) — those rules still bind, this file only
says which engine a chunk runs on and how to wire it. The viability rationale and the
package limits live in [`docs/webr-decision.md`](../../docs/webr-decision.md); read it
once before authoring interactive material.

## The one-sentence rule

**First-principles base-R code runs live in the browser (`{webr}` cells); code that
needs a package WebAssembly can't run is shown static with its output baked in at
build time and labelled "runs on your machine, not here."**

The learner reads lessons on a phone with no server, so "live" means WebR compiled to
WebAssembly, executing client-side in the rendered page.

## How the site is wired (already done — don't redo per course)

- The root `_quarto.yml` sets `format: live-html` for the **whole** project. Every page
  inherits it and the shared `cosmo` theme. Never add a per-file `format: html` — it
  drops that page out of the shared theme (the quarto-live website theming trap,
  quarto-live issue #93).
- The extension is vendored at `_extensions/r-wasm/live/` (pinned to the
  `r-wasm/quarto-live@v0.2.0` tag; its internal `_extension.yml` reads `0.1.3-dev`,
  which is cosmetic — it carries webR 0.6.0 / R 4.5). It is committed, so no
  `quarto add` is needed to render. If you ever re-run `quarto add`, do it in a
  checkout where no `.qmd` yet contains the include line below, or the add step fails
  trying to resolve the not-yet-installed include.

## Making a lesson interactive (per-file, opt-in)

A lesson/practice file that contains any `{webr}` cell needs **two** front-matter/body
additions and nothing else:

1. `engine: knitr` in the YAML header (so the file's normal `{r}` chunks still bake at
   build time; `{webr}` cells are handled by the quarto-live filter regardless).
2. The include line, once, immediately after the header:

   ```
   {{< include /_extensions/r-wasm/live/_knitr.qmd >}}
   ```

   The leading `/` makes it resolve from the repo root at any module depth. A file with
   **no** live cells needs neither line.

Then write live cells as ```` ```{webr} ```` instead of ```` ```{r} ````.

## Which chunks become `{webr}`, and which stay `{r}`

Interactivity is a teaching tool, not a default. Make a chunk live only when
**solving or manipulating it drives understanding** (this is the golden-order
"Explore it interactively" step and the practice/check-yourself code the learner
writes). Leave everything else as a static `{r}` chunk.

| Chunk role | Engine | Options |
|---|---|---|
| Concept plot the learner tweaks (change a parameter, watch it move) | `{webr}` | `autorun: true` — the picture appears on page load (dual coding); keep `fig-alt` |
| A cell that *computes the concept both by hand and via the built-in*, meant to be edited | `{webr}` | `autorun: true` |
| Practice / check-yourself **starter** the learner solves in-browser | `{webr}` | `autorun: false`, `edit: true` (the default) — they must write before running (predict-then-run) |
| Hidden `setup` chunk (`set.seed`, base-R prep) | `{r}` | `include: false` — build-time only; a `{webr}` session does not see it |
| Worked **answer** inside a `collapse="true"` callout | `{r}` | stays baked so the result is visible (even offline) the moment the callout opens |
| Code needing a non-WebR package (Stan/JAGS/INLA, anything in `docs/webr-decision.md` §3) | `{r}` | baked; wrap per the static-fallback pattern below |

Rules of thumb: **starters are live, answers are baked.** Don't make a chunk live by
reflex — a plain listing the learner only reads is a static `{r}` chunk. `{webr}` cells
in one document share a session, but keep each teaching cell self-contained anyway
(re-`c()` its data), matching the copy-able-data rule — the learner may run them in any
order.

Cell options worth knowing (full list: quarto-live docs → Code Cell Options):
`autorun`, `edit`, `runbutton`, `input:`/`define:` (pass data between a baked `{r}`
cell and a `{webr}` cell via OJS — the hybrid-execution mechanism), `warning`,
`fig-alt`, `fig-width`.

## The static fallback pattern ("runs on your machine, not here")

When the real method needs a package WebAssembly can't run, show it as a normal baked
`{r}` chunk (its output is computed at desktop/CI render time and frozen into the page)
and label it so the phone reader knows not to expect a Run button:

````markdown
::: {.callout-note title="Runs on your machine, not here"}
This uses **rstan**, which can't run in the browser (it compiles C++). The code and
its output are baked in at build time — copy it into your own R session to run it.
:::

```{r}
#| eval: true
# baked at build: real tooling, output frozen into the page
fit <- rstan::stan(...)
summary(fit)$summary
```
````

Before relying on a package in **any** cell (live or static), confirm its status the
way `docs/webr-decision.md` §2 describes — and remember the trap recorded there: a
binary existing in the wasm repo does **not** mean its workflow runs (`brms`/`nimble`
install but can't fit). Test the workflow, not the binary.

## Package/version notes

- Base-R lessons need nothing extra: no `webr::install`, no `renv` change.
- If a live cell ever loads a package, it comes from the wasm repo at the version webR
  ships — **not** the `renv`-pinned version the desktop render uses. Note this in the
  lesson if it could matter; the pin and the wasm build can drift.

## Verifying

- `quarto render` from the repo root must stay green — every baked `{r}` chunk still
  executes at build; `{webr}` cells are emitted as client-side editors and are **not**
  executed at build.
- In-browser execution can't be checked in the Claude Code sandbox (no browser). Confirm
  a live cell actually runs by opening the rendered page on a phone/desktop once, or via
  a CI-only Playwright job. Never claim in-browser execution was verified in the sandbox.
