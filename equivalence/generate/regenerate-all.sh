#!/usr/bin/env bash
# Regenerate EVERY self-test fixture from its real reference, in every language.
#
# This is the HEAVY, authoring-time half of the harness — it installs/compiles the
# real reference libraries into a gitignored, throwaway environment (equivalence/env)
# and freezes their outputs into equivalence/fixtures/*.json. It is NOT run by CI or
# by the learner-facing render; CI only runs the light `equivalence/check.R` against
# the frozen fixtures.
#
# Reproducibility without polluting the course: every reference environment lives
# under equivalence/env/ (gitignored) — a separate R library, a Python venv, and a
# compiled C binary. None of them touch renv.lock or the Quarto render.
#
# Run from anywhere:
#   bash equivalence/generate/regenerate-all.sh

set -euo pipefail
cd "$(dirname "$0")/../.."          # repo root
ROOT="$PWD"
ENV="$ROOT/equivalence/env"
mkdir -p "$ENV"

# The R generators run with renv's autoloader DISABLED so R_LIBS_USER is honoured and
# reference packages (pracma) install into the throwaway lib below — never into the
# course renv library, and never into renv.lock.
mkdir -p "$ENV/rlib"

echo "== [R / full] pracma::trapz -> trapz-full-pracma.json =="
env RENV_CONFIG_AUTOLOADER_ENABLED=FALSE R_LIBS_USER="$ENV/rlib" \
  Rscript equivalence/generate/trapz_full_pracma.R

echo "== [R / fallback] closed-form 1/3 -> trapz-fallback-analytic.json =="
env RENV_CONFIG_AUTOLOADER_ENABLED=FALSE R_LIBS_USER="$ENV/rlib" \
  Rscript equivalence/generate/trapz_fallback_analytic.R

echo "== [R / full] stats::lm -> multiple-regression-full-lm.json + collinear =="
env RENV_CONFIG_AUTOLOADER_ENABLED=FALSE R_LIBS_USER="$ENV/rlib" \
  Rscript equivalence/generate/multiple-regression_full_lm.R

echo "== [R / full] Swap-Stepwise oracles -> swap-stepwise-*.json (5 fixtures) =="
env RENV_CONFIG_AUTOLOADER_ENABLED=FALSE R_LIBS_USER="$ENV/rlib" \
  Rscript equivalence/generate/swap_stepwise_full_oracles.R

echo "== [Python / full] numpy.linalg.lstsq -> ols-full-numpy.json =="
# Create the venv WITH pip. `python3 -m venv` needs the distro's ensurepip
# (python3-venv package); when that is missing we fall back to `virtualenv` (bundles
# its own pip) or, last resort, get-pip.py. The venv lives under the gitignored env/.
if [ ! -x "$ENV/venv/bin/python" ] || ! "$ENV/venv/bin/python" -m pip --version >/dev/null 2>&1; then
  rm -rf "$ENV/venv"
  if python3 -m venv "$ENV/venv" 2>/dev/null && "$ENV/venv/bin/python" -m pip --version >/dev/null 2>&1; then
    : # stdlib venv worked
  elif command -v virtualenv >/dev/null 2>&1; then
    virtualenv -q -p python3 "$ENV/venv"
  else
    python3 -m venv --without-pip "$ENV/venv"
    curl -fsSL https://bootstrap.pypa.io/get-pip.py | "$ENV/venv/bin/python"
  fi
fi
"$ENV/venv/bin/python" -m pip install --quiet --upgrade pip
"$ENV/venv/bin/python" -m pip install --quiet -r equivalence/generate/requirements.txt
"$ENV/venv/bin/python" equivalence/generate/ols_full_numpy.py

echo "== [Python / full] scipy.optimize L-BFGS-B -> gradient-descent-full-scipy.json =="
"$ENV/venv/bin/python" equivalence/generate/gd_full_scipy.py

echo "== [C / full] Welford (gcc) -> welford-full-c.json =="
gcc -O2 -o "$ENV/welford" equivalence/generate/welford_full_c.c
"$ENV/welford" > equivalence/fixtures/welford-full-c.json
echo "wrote equivalence/fixtures/welford-full-c.json"

echo
echo "All fixtures regenerated. Verify with:  Rscript equivalence/check.R"
