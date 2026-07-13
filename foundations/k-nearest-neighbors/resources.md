# Resources: k-nearest neighbors

All links verified 2026-07-11 (ISLR link verified 2026-07-12).

- 📺 [StatQuest: K-nearest neighbors, Clearly Explained](https://www.youtube.com/watch?v=HVXime0nQeI)
  (video) --- Josh Starmer walks through kNN classification and regression with
  small numeric examples, exactly matching this module's "compute distances, sort,
  vote" approach. Watch after the lesson to reinforce the intuition.
- 🎮 [K-Nearest Neighbors Interactive Demo](https://www.interactive-ml.com/knn.html)
  (interactive) --- click anywhere on a 2D plot to place a test point and watch
  kNN classify it in real time. Adjust k with a slider to see how small k gives
  noisy boundaries and large k oversmooths. Great for building the
  flexibility-vs-smoothness intuition from the lesson.
- 📖 [K-Nearest Neighbors (KNN) Classification with R Tutorial — DataCamp](https://www.datacamp.com/tutorial/k-nearest-neighbors-knn-classification-with-r-tutorial)
  (article) --- a practical R walkthrough using `class::knn()` and the `caret`
  package on a real dataset, covering data splitting, feature scaling, and
  choosing k. Read after the practice set when you are ready to apply kNN to
  larger data.
- 📚 [An Introduction to Statistical Learning (ISLR), 2nd ed. — official free PDF](https://www.statlearning.com/)
  (book chapter, §2.2.3, ~5 pages) --- the textbook treatment of the kNN
  classifier this lesson cites: how kNN approximates the ideal (Bayes) classifier
  and how the choice of k trades flexibility against smoothness, with the famous
  K=1 vs K=100 decision-boundary pictures. Read §2.2.3 after the lesson when you
  want the formal statistics-textbook framing; the R labs come later in the book.
