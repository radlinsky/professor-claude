# Resources: PCA and SVD

All links verified 2026-07-11; the two book links verified 2026-07-12.

- 📺 [StatQuest: Principal Component Analysis (PCA), Step-by-Step](https://www.youtube.com/watch?v=FgakZw6K1QQ)
  (video, ~22 min) -- walks PCA from scratch with small numeric examples, then shows
  scree plots and loading scores. Exactly this lesson's approach but animated. Watch
  after finishing the lesson to reinforce the eigenvalue-as-variance idea.
- 📺 [3Blue1Brown: Eigenvectors and eigenvalues (Essence of Linear Algebra, Ch. 14)](https://www.youtube.com/watch?v=PFDu9oVAE-g)
  (video, ~15 min) -- the best visual for "the matrix just stretches this direction"
  intuition. Watch after sub-spine B to see the funnel-picture idea animated in 2D and
  3D. Does not cover PCA specifically, but makes eigenvectors click.
- 🎮 [Setosa: Principal Component Analysis, visually explained](https://setosa.io/ev/principal-component-analysis/)
  (interactive) -- drag points in 2D and 3D and watch the PC directions update in real
  time; includes a 17-dimensional UK-food example. Great for building the "best camera
  angle" intuition from sub-spine C.
- 📖 [STHDA: Principal Component Analysis in R -- prcomp vs princomp](https://www.sthda.com/english/articles/31-principal-component-methods-in-r-practical-guide/118-principal-component-analysis-in-r-prcomp-vs-princomp/)
  (tutorial) -- a step-by-step R walkthrough of `prcomp()` with scree plots, biplots,
  and interpretation on a real dataset. Read after the practice set when you want to
  apply PCA to your own data.
- 📚 [Austin: Understanding Linear Algebra](https://scholarworks.gvsu.edu/books/26)
  (free textbook, CC-BY 4.0) -- the source behind this lesson's eigenvalue and SVD
  facts. Chapter 4 develops eigenvalues/eigenvectors gently and geometrically;
  Chapter 7 covers symmetric matrices, PCA, and the SVD with worked data examples
  (UK diets, image compression). Dip in when you want the full story behind a
  formula, one level deeper than this lesson.
- 📚 [An Introduction to Statistical Learning (ISLR), Ch. 12](https://www.statlearning.com)
  (free textbook PDF) -- the standard applied treatment of PCA: proportion of
  variance explained, scree plots, the scaling decision, and the USArrests example
  that practice Problem 7 walks you through. Read §12.1--12.2 after the practice set
  to see this module's ideas in the field's own words, with R labs.
