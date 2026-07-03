# AUTHORING-TIME generator — FALLBACK tier (no runnable reference).
#
# When no library and no reported numbers exist, the fixture holds a CLOSED-FORM /
# analytic expected value instead. Here the target is the integral of x^2 on [0, 1],
# whose exact value is 1/3. The from-scratch trapezoid, on a fine grid, must land on
# 1/3 within tolerance. Needs no external package.
#
# Run from the repo root (regenerate-all.sh runs it with renv's autoloader off so any
# jsonlite install lands in the separate lib, not the course renv):
#   RENV_CONFIG_AUTOLOADER_ENABLED=FALSE R_LIBS_USER=equivalence/env/rlib \
#     Rscript equivalence/generate/trapz_fallback_analytic.R

suppressWarnings(suppressMessages({
  if (!requireNamespace("jsonlite", quietly = TRUE)) {
    install.packages("jsonlite", repos = "https://cloud.r-project.org")
  }
  library(jsonlite)
}))

x <- seq(0, 1, length.out = 2001)   # fine grid: trapezoid error ~ h^2 is well under tol
y <- x^2

fixture <- list(
  meta = list(
    slug = "trapz-analytic",
    tier = "fallback",
    source = "closed form: integral_0^1 x^2 dx = 1/3",
    tolerance = list(abs = 1e-6, rel = 1e-6),
    generated = format(Sys.time(), "%Y-%m-%dT%H:%M:%S%z"),
    generator = "equivalence/generate/trapz_fallback_analytic.R"
  ),
  inputs = list(x = x, y = y),
  reference = list(integral = 1 / 3)
)

out <- "equivalence/fixtures/trapz-fallback-analytic.json"
write_json(fixture, out, auto_unbox = TRUE, digits = 15, pretty = TRUE)
cat("wrote", out, "  (analytic integral = 1/3)\n")
