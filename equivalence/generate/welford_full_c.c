/* AUTHORING-TIME generator — FULL tier, compiled C reference.
 *
 * Computes the sample mean and variance (n - 1 divisor) via Welford's online
 * algorithm and prints a complete fixture JSON to stdout. This proves the compiled
 * toolchain end to end: gcc -> run -> fixture -> harness check. The base-R
 * reimplementation (equivalence/reimplementations/welford.R) must reproduce these
 * two numbers within tolerance.
 *
 * Build & run from the repo root (regenerate-all.sh does this):
 *   gcc -O2 -o equivalence/env/welford equivalence/generate/welford_full_c.c
 *   equivalence/env/welford > equivalence/fixtures/welford-full-c.json
 */
#include <stdio.h>

int main(void) {
    /* Fixed inputs are baked in AND echoed into the fixture, so the R side reads the
     * exact same numbers the C reference used. */
    double x[] = {2, 4, 4, 4, 5, 5, 7, 9};
    int n = (int) (sizeof(x) / sizeof(x[0]));

    double mean = 0.0, M2 = 0.0;
    for (int i = 0; i < n; i++) {
        double delta = x[i] - mean;
        mean += delta / (i + 1);
        M2 += delta * (x[i] - mean);
    }
    double variance = M2 / (n - 1);   /* sample variance, matching R's var() */

    printf("{\n");
    printf("  \"meta\": {\n");
    printf("    \"slug\": \"welford\",\n");
    printf("    \"tier\": \"full\",\n");
    printf("    \"source\": \"C Welford online mean/variance (gcc)\",\n");
    printf("    \"tolerance\": {\"abs\": 1e-9, \"rel\": 1e-9},\n");
    printf("    \"generator\": \"equivalence/generate/welford_full_c.c\"\n");
    printf("  },\n");
    printf("  \"inputs\": {\"x\": [");
    for (int i = 0; i < n; i++) printf("%s%.17g", i ? ", " : "", x[i]);
    printf("]},\n");
    printf("  \"reference\": {\"mean\": %.17g, \"var\": %.17g}\n", mean, variance);
    printf("}\n");
    return 0;
}
