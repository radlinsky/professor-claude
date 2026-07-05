# Resources: Sherman–Morrison rank-1 updates

All links verified 2026-07-05.

- 📖 [Wikipedia — Sherman–Morrison formula](https://en.wikipedia.org/wiki/Sherman%E2%80%93Morrison_formula)
  (article) — states the identity
  $(A+uv^\top)^{-1} = A^{-1} - \dfrac{A^{-1}uv^\top A^{-1}}{1+v^\top A^{-1}u}$ exactly, with
  a short proof and the singular-when-denominator-zero condition — this module in reference
  form.
- 📖 [The Matrix Cookbook (Petersen & Pedersen), §3.2](https://www.math.uwaterloo.ca/~hwolkowi/matrixcookbook.pdf)
  (PDF) — the "Inverses → Exact Relations" section collects Sherman–Morrison and the
  Woodbury identity (the rank-$k$ generalization) alongside the other inverse identities;
  a handy one-page lookup.
- 📖 [VMLS Ch. 11 — Matrix inverses](https://web.stanford.edu/~boyd/vmls/vmls.pdf)
  (book, PDF) — background on what a matrix inverse is and the cost of computing one, the
  footing this module's $O(p^3)$-vs-$O(p^2)$ argument stands on.
