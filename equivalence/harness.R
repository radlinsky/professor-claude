# equivalence/harness.R
#
# Authoring-time EQUIVALENCE HARNESS for Professor Fable.
#
# The idea: heavy reference libraries (in any language) are run ONCE at authoring
# time; their outputs are frozen into JSON fixtures checked into the repo. This file
# then lets a from-scratch base-R reimplementation be asserted against a frozen
# fixture WITHIN TOLERANCE. It is deliberately pure base R + jsonlite so the exact
# same check runs in three places: CI (native R via check.R), an author's console,
# and — for Stage 4 — inside a live `{webr}` cell client-side (jsonlite is available
# in the wasm repo). See equivalence/README.md for the full contract and the three
# validation tiers.
#
# A fixture never carries a reimplementation or a reference library — only frozen
# INPUTS and the frozen REFERENCE outputs. Because the inputs are stored, the
# reimplementation reads the exact numbers the real library saw, so cross-language
# RNG differences never enter the comparison.

suppressWarnings(suppressMessages(library(jsonlite)))

# Element-wise closeness: pass if EITHER absolute or relative tolerance is met, so a
# reference of 0 (abs) and a large reference (rel) are both handled sanely.
.close_enough <- function(got, ref, tol_abs, tol_rel) {
  got <- as.numeric(got)
  ref <- as.numeric(ref)
  if (length(got) != length(ref)) {
    return(list(ok = FALSE, max_abs = Inf, max_rel = Inf,
                note = sprintf("length mismatch: got %d, reference %d",
                               length(got), length(ref))))
  }
  d_abs <- abs(got - ref)
  d_rel <- d_abs / pmax(abs(ref), .Machine$double.eps)
  list(ok = all(d_abs <= tol_abs | d_rel <= tol_rel),
       max_abs = max(d_abs), max_rel = max(d_rel), note = "")
}

# check_fixture(path, reimpl_fn)
#   path       : path to a fixture JSON (meta / inputs / reference).
#   reimpl_fn  : function(inputs) -> named list of numeric outputs whose names match
#                the fixture's `reference` keys.
# Returns a list: slug, tier, source, pass (logical), and a per-output detail frame.
check_fixture <- function(path, reimpl_fn) {
  fx <- jsonlite::fromJSON(path, simplifyVector = TRUE)
  tol_abs <- if (!is.null(fx$meta$tolerance$abs)) fx$meta$tolerance$abs else 1e-8
  tol_rel <- if (!is.null(fx$meta$tolerance$rel)) fx$meta$tolerance$rel else 1e-6

  got <- reimpl_fn(fx$inputs)
  keys <- names(fx$reference)

  detail <- do.call(rbind, lapply(keys, function(k) {
    cmp <- .close_enough(got[[k]], fx$reference[[k]], tol_abs, tol_rel)
    data.frame(output = k, ok = cmp$ok,
               max_abs = cmp$max_abs, max_rel = cmp$max_rel,
               note = cmp$note, stringsAsFactors = FALSE)
  }))

  list(slug = fx$meta$slug, tier = fx$meta$tier, source = fx$meta$source,
       tol_abs = tol_abs, tol_rel = tol_rel,
       pass = all(detail$ok), detail = detail)
}

# Pretty one-line-per-output report for a single check result.
print_check <- function(res) {
  status <- if (isTRUE(res$pass)) "PASS" else "FAIL"
  cat(sprintf("[%s] %-16s tier=%-8s  (%s)\n",
              status, res$slug, res$tier, res$source))
  for (i in seq_len(nrow(res$detail))) {
    d <- res$detail[i, ]
    cat(sprintf("        %-10s ok=%-5s  max_abs=%.3e  max_rel=%.3e%s\n",
                d$output, d$ok, d$max_abs, d$max_rel,
                if (nzchar(d$note)) paste0("  [", d$note, "]") else ""))
  }
  invisible(res)
}
