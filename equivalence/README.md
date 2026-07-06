# Equivalence harness

Authoring-time infrastructure that lets a course prove its **from-scratch base-R
reimplementation** of a method reproduces the **real reference** — a library, a
paper's numbers, or a closed-form value — within tolerance. Stage 4's "port a
library into a built-up course" skill depends on this; a WebR lesson can run the very
same check client-side so the learner sees their rebuilt version match the real
thing.

Why a harness at all? WebR cannot compile C/C++/Fortran or link system libraries, so
the real reference (Stan, a compiled solver, numpy, …) can never run in the browser
(see [`docs/webr-decision.md`](../docs/webr-decision.md)). So we run the reference
**once, at authoring time, on the author's machine**, freeze its output, and check
against the frozen value everywhere after.

## The split that makes it work

| | Generate (heavy, authoring-time) | Check (light, everywhere) |
|---|---|---|
| What | install/compile the REAL reference in any language, run it on simulated inputs, freeze inputs + outputs to JSON | run the base-R reimplementation on the frozen inputs, assert it matches the frozen reference within tolerance |
| Needs | the multi-language toolchain (R lib, Python venv, C/C++/Fortran compiler) | only R + `jsonlite` |
| Runs in | `equivalence/generate/regenerate-all.sh` (author) | `equivalence/check.R` (author, CI, and — Stage 4 — a live `{webr}` cell) |
| Touches renv? | never (reference libs live in gitignored `equivalence/env/`) | no |

Because the fixture stores the **inputs** the reference saw, the reimplementation
reads the exact same numbers — cross-language RNG differences never enter the
comparison.

## Validation tiers

Every fixture records which tier produced it (`meta.tier`):

- **`full`** — the real library was installed/compiled and run on simulated inputs;
  the reimplementation must match it within tolerance. *(Self-tests: `pracma::trapz`,
  `numpy.linalg.lstsq`, a compiled C Welford, `coloc::coloc.abf` for Wakefield's ABF and
  colocalisation, `colocPropTest` for the proportional colocalisation test.)*
- **`partial`** — no runnable reference, but the paper or repo reports specific
  numbers/figures; the fixture holds those (transcribed, with citation in
  `meta.source`).
- **`fallback`** — no reference numbers at all; the fixture holds a closed-form /
  analytic expected value or a self-consistency invariant. *(Self-test: the
  trapezoid vs the exact integral ∫₀¹x²dx = 1/3.)*

Always record the strongest tier the source supports, and never let a missing
reference block a course — drop to the next tier and say so.

## Layout

```
equivalence/
├── harness.R            # check_fixture(): compare a reimplementation to a fixture within tol
├── check.R              # run every fixture's reimplementation; exit 1 on any fail (CI entrypoint)
├── reimplementations/   # the from-scratch base-R functions under test (Stage-4 lessons mirror these)
├── generate/            # authoring-time generators (R / Python / C …) + regenerate-all.sh
├── fixtures/            # frozen reference fixtures (committed JSON)
└── env/                 # gitignored: separate R lib, Python venv, compiled binaries
```

### Fixture format

One JSON object per target: `meta` (slug, tier, source + version, tolerance {abs, rel},
seed, generator path), `inputs` (the exact simulation inputs), `reference` (named
numeric outputs). Keys in `reference` are what a reimplementation must return.

## Run the checks

```bash
Rscript equivalence/check.R      # all targets should pass — one line per fixture
```

CI runs exactly this on every push/PR that touches `equivalence/`
(`.github/workflows/equivalence.yml`) — R + `jsonlite` only.

## Add a new target (author workflow)

1. **Write the reimplementation** in `reimplementations/<slug>.R` — a base-R function
   that a course will build up to, taking the fixture's `inputs` and returning a named
   list of outputs.
2. **Write a generator** in `generate/` that produces the fixture. Pick the strongest
   tier the source supports, using the recipe for its language below. Emit
   `fixtures/<slug>.json` with `meta` / `inputs` / `reference`. Update the examples above
   if your target demonstrates a new tier.
3. **Wire it into `check.R`** — add a `targets` entry mapping the fixture to the
   reimplementation call.
4. **Regenerate and check**: `bash equivalence/generate/regenerate-all.sh` then
   `Rscript equivalence/check.R`. Commit the reimplementation, the generator, and the
   fixture — **not** anything under `env/`.

### Per-language reference recipes (generate tier)

All reference environments live under `equivalence/env/` (gitignored) so nothing
pollutes the course renv or the render.

- **R** — install the reference package into a **separate** library with renv's
  autoloader off, so it never enters `renv.lock`:
  ```bash
  RENV_CONFIG_AUTOLOADER_ENABLED=FALSE R_LIBS_USER=equivalence/env/rlib \
    Rscript equivalence/generate/<slug>.R
  ```
- **Python** — a venv under `env/venv` from a pinned `generate/requirements.txt`. If
  the distro lacks `ensurepip` (`python3 -m venv` fails), `regenerate-all.sh` falls
  back to `virtualenv`, then to `get-pip.py`. Reference via `reticulate` is optional —
  a standalone `.py` generator is simplest.
- **C / C++ / Fortran** — compile a small driver that runs the reference and prints
  the fixture JSON; the binary is a build artifact under `env/`:
  ```bash
  gcc -O2 -o equivalence/env/<slug> equivalence/generate/<slug>.c   # or g++, gfortran
  equivalence/env/<slug> > equivalence/fixtures/<slug>.json
  ```

`regenerate-all.sh` wires all of the above for the self-test targets; copy its
structure for new ones.

## Notes

- `.renvignore` excludes `equivalence/` from renv's dependency scan, so
  `library(pracma)` etc. in the generators never make the project look out-of-sync and
  a stray `renv::snapshot()` can't add a reference lib to `renv.lock`.
- CI checks the frozen fixtures; it does **not** regenerate them. Regeneration is the
  author's heavier step and needs the full toolchain.
- Stage 4 wires these fixtures into interactive lessons — a `{webr}` cell sources a
  reimplementation and `check_fixture()` against an embedded fixture. See
  [`.claude/course-authoring/interactive-webr.md`](../.claude/course-authoring/interactive-webr.md).
