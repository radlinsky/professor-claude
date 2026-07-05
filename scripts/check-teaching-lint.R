#!/usr/bin/env Rscript
# check-teaching-lint.R — mechanical teaching-contract lint (issue #91).
#
# Two TEACHING.md rules are perfectly grep-shaped yet enforced by nothing today, so
# they ship on luck (Phase-2 bots caught them only sporadically):
#   * TEACHING.md:88 — never write "it is trivial", "obviously", "simply", "clearly",
#     or "it follows that" (the anti-condescension rule).
#   * TEACHING.md:177 — give every figure chunk a `fig-alt` (accessibility).
# A base-R script enforces both deterministically, cheaper and more reliable than
# adding judgment load to the auditor. Same posture as scripts/check-indexes.R and
# scripts/check-webr-cells.R: base R only (no packages), GitHub-Actions annotations,
# a fail counter, exit 1 on any hit.
#
# Run from the repo root: Rscript scripts/check-teaching-lint.R
#
# --- Lint 1: banned condescension words -------------------------------------------
#   Scans every .qmd under foundations/ and courses/, PROSE lines only — fenced code
#   blocks (``` ... ```) and `#|` chunk-option lines are excluded. Case-insensitive,
#   whole-phrase match on the five TEACHING.md phrases. A line carrying the explicit
#   opt-out marker `<!-- lint-ok -->` is skipped (e.g. a traps section quoting a
#   banned phrase to refute it).
#
# --- Lint 2: missing fig-alt ------------------------------------------------------
#   For every ```{r} / ```{webr} chunk whose body contains a top-level call to a known
#   plotting function, require a `#| fig-alt:` option in that chunk.
#   LIMITATION (documented per issue #91): detection uses a FIXED call-list —
#     plot(  hist(  curve(  barplot(  boxplot(  image(  pairs(  matplot(
#   A figure produced by any other function (ggplot2, lattice, a custom wrapper, etc.)
#   is NOT detected and will not be flagged. `abline(`-only chunks are excluded: abline
#   annotates an existing plot, it does not open a new figure. Extend the list if the
#   repo starts using other base-graphics entry points.

fail <- 0L
# Emit a GitHub Actions error annotation (file+line deep-links in the Actions UI) and
# bump the failure counter. line is omitted when a single line isn't meaningful.
err <- function(file, msg, line = NA) {
  if (is.na(line)) cat(sprintf("::error file=%s::%s\n", file, msg))
  else             cat(sprintf("::error file=%s,line=%d::%s\n", file, as.integer(line), msg))
  fail <<- fail + 1L
}

read_lines <- function(path) if (file.exists(path)) readLines(path, warn = FALSE) else character(0)

qmd_files <- list.files(c("foundations", "courses"), pattern = "\\.qmd$",
                        recursive = TRUE, full.names = TRUE)

# The five banned phrases (TEACHING.md:88), lower-cased for a case-insensitive match.
BANNED <- c("it is trivial", "obviously", "simply", "clearly", "it follows that")
# Plotting calls that open a new figure and thus require a fig-alt (see header note).
PLOT_CALLS <- c("plot", "hist", "curve", "barplot", "boxplot", "image", "pairs", "matplot")

# Match a banned phrase as a whole phrase (word boundaries at both ends), case-insensitive.
# \b handles the multi-word phrases fine (boundary sits at the outer edges).
banned_hits <- function(line) {
  low <- tolower(line)
  found <- character(0)
  for (p in BANNED) {
    if (grepl(paste0("\\b", gsub(" ", "\\\\s+", p), "\\b"), low, perl = TRUE)) {
      found <- c(found, p)
    }
  }
  found
}

## ---- Lint 1: banned words in prose ------------------------------------------------
cat("== Lint 1: banned condescension words (prose only) ==\n")
for (f in qmd_files) {
  lines <- read_lines(f)
  in_code <- FALSE
  for (i in seq_along(lines)) {
    ln <- lines[i]
    # Toggle on fenced code blocks: a line whose trimmed start is ``` opens/closes one.
    if (grepl("^\\s*```", ln)) { in_code <- !in_code; next }
    if (in_code) next                                   # inside a code block: not prose
    if (grepl("^\\s*#\\|", ln)) next                    # chunk-option line: not prose
    if (grepl("<!--\\s*lint-ok\\s*-->", ln)) next       # explicit opt-out for this line
    for (p in banned_hits(ln)) {
      err(f, sprintf("banned word/phrase in prose: \"%s\" (mark a legitimate mention with <!-- lint-ok -->)", p), i)
    }
  }
}

## ---- Lint 2: figure chunks missing fig-alt ----------------------------------------
cat("== Lint 2: figure chunks require #| fig-alt ==\n")
# Does a chunk body call one of the fixed plotting functions at all? (abline excluded.)
# Strip R comments first (naive: from the first `#` to end of line) so a plotting call
# mentioned only inside a `# your job: hist(...)` comment is not counted as a real call.
# The naive strip can also drop a `#` that sits inside a string literal, which at worst
# suppresses a real call written on a comment-bearing line — acceptable for a lint whose
# misses are already bounded by the fixed call-list.
has_plot_call <- function(body) {
  code <- sub("#.*$", "", body)
  for (fn in PLOT_CALLS) {
    if (any(grepl(paste0("\\b", fn, "\\s*\\("), code, perl = TRUE))) return(TRUE)
  }
  FALSE
}
for (f in qmd_files) {
  lines <- read_lines(f)
  i <- 1L; n <- length(lines)
  while (i <= n) {
    open <- grepl("^\\s*```\\{(r|webr)\\}", lines[i])
    if (open) {
      label <- sub("^\\s*```\\{(r|webr)[ ,]*", "", lines[i]); label <- sub("\\}.*$", "", label)
      opts <- character(0); body <- character(0)
      j <- i + 1L
      while (j <= n && !grepl("^\\s*```\\s*$", lines[j])) {
        if (grepl("^\\s*#\\|", lines[j])) opts <- c(opts, lines[j]) else body <- c(body, lines[j])
        j <- j + 1L
      }
      if (has_plot_call(body)) {
        has_alt <- any(grepl("^\\s*#\\|\\s*fig-alt\\s*:", opts))
        if (!has_alt) {
          tag <- if (nzchar(trimws(label))) sprintf("chunk '%s'", trimws(label)) else sprintf("chunk at line %d", i)
          err(f, sprintf("figure %s calls a plotting function but has no #| fig-alt", tag), i)
        }
      }
      i <- j + 1L                                       # resume past the closing fence
    } else {
      i <- i + 1L
    }
  }
}

## ---- done -------------------------------------------------------------------------
cat("\n")
if (fail == 0L) cat("check-teaching-lint: all checks passed\n") else cat(sprintf("check-teaching-lint: %d FAILURE(S) above\n", fail))
quit(status = if (fail > 0L) 1L else 0L)
