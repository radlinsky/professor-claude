# AUTHORING-TIME generator -- FULL tier, reference = coloc::coloc.abf (v5.2.3).
#
# The "real library" being ported here is Wakefield's approximate Bayes factor as
# implemented in the coloc R package (Giambartolomei et al. 2014; Wakefield 2009). We
# simulate one study's per-SNP summary statistics (effect estimates beta and standard
# errors se), run them through coloc.abf as a case-control dataset, and freeze the
# per-SNP log approximate Bayes factors it reports (results$lABF.df1). The from-scratch
# reimplementation (equivalence/reimplementations/wakefield-abf.R) must reproduce them.
#
# For a case-control ("cc") dataset coloc uses a fixed effect-size prior sd.prior = 0.2,
# so the prior variance is W = 0.2^2 = 0.04 -- Wakefield's default log-OR prior. That
# exact W is stored in the fixture inputs so the reimplementation uses the same number.
#
# Run from the repo root (regenerate-all.sh runs it with renv's autoloader off and
# R_LIBS_USER pointed at the throwaway lib holding coloc + jsonlite):
#   RENV_CONFIG_AUTOLOADER_ENABLED=FALSE R_LIBS_USER=equivalence/env/rlib \
#     Rscript equivalence/generate/wakefield-abf_full_coloc.R

suppressWarnings(suppressMessages({
  options(repos = "https://cloud.r-project.org")
  for (pkg in c("jsonlite", "coloc")) {
    if (!requireNamespace(pkg, quietly = TRUE)) install.packages(pkg)
  }
  library(jsonlite); library(coloc)
}))

W <- 0.2^2   # coloc's case-control effect-size prior variance (sd.prior = 0.2)

# One simulated GWAS region: Q SNPs, a clear signal at SNP 4, noise elsewhere.
set.seed(2009)
Q     <- 10
beta  <- rnorm(Q, 0, 0.03); beta[4] <- 0.16
se    <- rep(0.03, Q)
maf   <- runif(Q, 0.1, 0.5)
snp   <- paste0("rs", seq_len(Q))

# Two identical-shape datasets are the minimal input coloc.abf accepts; we only freeze
# trait 1's per-SNP lABF (the Wakefield ABF), so dataset 2 is a throwaway copy.
mkds <- function(b) list(beta = b, varbeta = se^2, snp = snp,
                         type = "cc", N = 5000, s = 0.5, MAF = maf)
res  <- suppressWarnings(coloc.abf(mkds(beta), mkds(beta)))
labf <- res$results$lABF.df1[match(snp, res$results$snp)]   # align to input order

fx <- list(
  meta = list(
    slug = "wakefield-abf",
    tier = "full",
    source = paste0("coloc::coloc.abf ", as.character(packageVersion("coloc"))),
    tolerance = list(abs = 1e-8, rel = 1e-8),
    seed = 2009,
    generated = format(Sys.time(), "%Y-%m-%dT%H:%M:%S%z"),
    generator = "equivalence/generate/wakefield-abf_full_coloc.R"
  ),
  inputs    = list(beta = beta, se = se, W = W),
  reference = list(labf = as.numeric(labf))
)

write_json(fx, "equivalence/fixtures/wakefield-abf-full-coloc.json",
           auto_unbox = TRUE, digits = 15, pretty = TRUE)
cat("wrote equivalence/fixtures/wakefield-abf-full-coloc.json\n")
