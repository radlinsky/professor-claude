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
  which is cosmetic — it carries webR 0.6.0 / R 4.5). **The tag recorded here is the
  source of truth for the vendored version**, not the `_extension.yml` string. It is
  committed, so no `quarto add` is needed to render.

### Updating the vendored extension

When upstream ships a webR/R bump you need, update the vendored copy this way:

1. Check the upstream release/tag at `r-wasm/quarto-live` and its bundled webR/R
   versions against the assumptions in `docs/webr-decision.md` §2 — confirm the new
   versions still hold.
2. Run `quarto add r-wasm/quarto-live@<tag>` in a **scratch checkout that does NOT yet
   contain the `_knitr.qmd` include lines** (the add step fails trying to resolve a
   not-yet-installed include if any `.qmd` already carries the include), then copy
   `_extensions/r-wasm/live/` over into this repo.
3. Note that `_extension.yml`'s internal version string may not match the tag — record
   the ACTUAL tag in the pin note above so a forker can tell the real version.
4. Run `quarto render`, run the webr verification (script/manual per §Verifying below),
   and update `docs/webr-decision.md`'s version references if webR/R changed.

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
- **Native-R proxy check (automated).** Run `Rscript scripts/check-webr-cells.R` from
  the repo root. It executes every `#| autorun: true` `{webr}` cell (the cells that run
  on page load and must be error-free) in a fresh R session per document, sharing state
  across a document's cells, and exits 1 naming the file + cell index on any error.
  Starter cells (autorun off) are intentionally incomplete and are never run. Because the
  contract requires live cells to be base R and self-contained, native execution is a
  faithful proxy for in-browser execution (minus wasm quirks). `render.yml` runs this
  script in CI after the render step.
- **Manual in-browser spot-check.** The proxy above does not exercise the actual webR
  runtime, so once per meaningful change spot-check in a real browser:
  1. `quarto render` (or `quarto preview`) the page.
  2. Open the rendered lesson in a browser (phone or desktop).
  3. Wait for the webR runtime banner to finish loading (the first run downloads the
     engine).
  4. Confirm every autorun cell shows output with no red error.
  5. Click **Run** on one starter cell after typing a trivial answer, and confirm it
     executes.
- In-browser execution can't be checked in the Claude Code sandbox (no browser). Never
  claim in-browser execution was verified in the sandbox — the native proxy above is not
  a substitute for the manual browser spot-check.
