# AUTHORING-TIME generator — FULL tier, R reference.
#
# Installs the real `pracma` package into a SEPARATE library (equivalence/env/rlib)
# so it never enters the course renv.lock, runs the genuine pracma::trapz on
# simulated inputs, and freezes inputs + reference into
# equivalence/fixtures/trapz-full-pracma.json.
#
# Run from the repo root with renv's autoloader OFF (so R_LIBS_USER is honoured and
# the install lands in the separate lib, not the course renv):
#   RENV_CONFIG_AUTOLOADER_ENABLED=FALSE R_LIBS_USER=equivalence/env/rlib \
#     Rscript equivalence/generate/trapz_full_pracma.R
# (regenerate-all.sh does this for you.)

suppressWarnings(suppressMessages({
  for (pkg in c("pracma", "jsonlite")) {
    if (!requireNamespace(pkg, quietly = TRUE)) {
      install.packages(pkg, repos = "https://cloud.r-project.org")
    }
  }
  library(pracma)
  library(jsonlite)
}))

set.seed(42)
x <- sort(runif(25, 0, pi))
y <- sin(x)

reference_integral <- pracma::trapz(x, y)   # the REAL library

fixture <- list(
  meta = list(
    slug = "trapz",
    tier = "full",
    source = paste0("pracma::trapz ", as.character(packageVersion("pracma"))),
    tolerance = list(abs = 1e-9, rel = 1e-7),
    seed = 42L,
    generated = format(Sys.time(), "%Y-%m-%dT%H:%M:%S%z"),
    generator = "equivalence/generate/trapz_full_pracma.R"
  ),
  inputs = list(x = x, y = y),
  reference = list(integral = reference_integral)
)

out <- "equivalence/fixtures/trapz-full-pracma.json"
write_json(fixture, out, auto_unbox = TRUE, digits = 15, pretty = TRUE)
cat("wrote", out, "  (integral =", reference_integral, ")\n")
