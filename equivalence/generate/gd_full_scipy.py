"""AUTHORING-TIME generator — FULL tier, Python reference (compiled Fortran).

Fits a line y ~ b0 + b1*x by minimizing the mean squared error with
scipy.optimize.minimize's L-BFGS-B routine (a compiled-Fortran quasi-Newton
optimizer, Byrd/Lu/Nocedal/Zhu) and freezes the data + the converged coefficients
into equivalence/fixtures/gradient-descent-full-scipy.json. The from-scratch base-R
gradient descent (equivalence/reimplementations/gradient_descent.R — the routine the
gradient-descent course builds up to) must reproduce these coefficients within
tolerance. Runs under the project venv so scipy never touches the R side or renv.lock.

Run from the repo root under the venv (regenerate-all.sh sets this up):
    equivalence/env/venv/bin/python equivalence/generate/gd_full_scipy.py
"""

import datetime
import json

import numpy as np
import scipy
from scipy.optimize import minimize

rng = np.random.default_rng(42)
n = 8
x = np.linspace(-3.5, 3.5, n)                        # readable, well-spread predictor
b0_true, b1_true = 2.0, -3.0
# a line plus a little noise; round to 2 dp so the course can embed clean numbers
y = np.round(b0_true + b1_true * x + rng.normal(scale=0.1, size=n), 2)


def mse(b):                                          # b = [intercept, slope]
    resid = (b[0] + b[1] * x) - y
    return float(np.mean(resid ** 2))


def grad(b):
    resid = (b[0] + b[1] * x) - y
    return np.array([2 * np.mean(resid), 2 * np.mean(resid * x)])


res = minimize(mse, np.zeros(2), jac=grad, method="L-BFGS-B")   # the REAL optimizer
coef = res.x                                         # [intercept, slope] at the bottom

# Hyperparameters the from-scratch gradient descent uses to reproduce `coef` within
# tolerance (well-conditioned here, so lr=0.1 converges to machine precision fast).
lr, n_iter = 0.1, 2000

fixture = {
    "meta": {
        "slug": "gradient-descent",
        "tier": "full",
        "source": f"scipy.optimize L-BFGS-B (scipy {scipy.__version__})",
        "tolerance": {"abs": 1e-6, "rel": 1e-6},
        "seed": 42,
        "generated": datetime.datetime.now().astimezone().isoformat(timespec="seconds"),
        "generator": "equivalence/generate/gd_full_scipy.py",
    },
    "inputs": {"x": x.tolist(), "y": y.tolist(), "lr": lr, "n_iter": n_iter},
    "reference": {"coef": coef.tolist()},
}

out = "equivalence/fixtures/gradient-descent-full-scipy.json"
with open(out, "w") as f:
    json.dump(fixture, f, indent=2)
    f.write("\n")
print("wrote", out, " (coef =", coef.tolist(), ")")
