"""AUTHORING-TIME generator — FULL tier, Python reference.

Runs the genuine numpy.linalg.lstsq on simulated inputs and freezes inputs +
reference coefficients into equivalence/fixtures/ols-full-numpy.json. Runs under the
project venv so numpy never touches the R side or renv.lock.

Run from the repo root under the venv (regenerate-all.sh sets this up):
    equivalence/env/venv/bin/python equivalence/generate/ols_full_numpy.py
"""

import datetime
import json

import numpy as np

rng = np.random.default_rng(42)
n = 30
x1 = rng.normal(size=n)
x2 = rng.normal(size=n)
X = np.column_stack([np.ones(n), x1, x2])          # intercept + two predictors
beta_true = np.array([1.5, -2.0, 0.7])
y = X @ beta_true + rng.normal(scale=0.1, size=n)

beta_hat, *_ = np.linalg.lstsq(X, y, rcond=None)   # the REAL library

fixture = {
    "meta": {
        "slug": "ols",
        "tier": "full",
        "source": f"numpy.linalg.lstsq (numpy {np.__version__})",
        "tolerance": {"abs": 1e-8, "rel": 1e-6},
        "seed": 42,
        "generated": datetime.datetime.now().astimezone().isoformat(timespec="seconds"),
        "generator": "equivalence/generate/ols_full_numpy.py",
    },
    "inputs": {"X": X.tolist(), "y": y.tolist()},
    "reference": {"coef": beta_hat.tolist()},
}

out = "equivalence/fixtures/ols-full-numpy.json"
with open(out, "w") as f:
    json.dump(fixture, f, indent=2)
    f.write("\n")
print("wrote", out, " (coef =", beta_hat.tolist(), ")")
