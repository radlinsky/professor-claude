# Resources: The mean, variance & covariance

All links verified 2026-07-02.

- 📺 [StatQuest: Calculating the Mean, Variance and Standard Deviation, Clearly Explained!!!](https://youtu.be/SzZ6GpcfoQY)
  (video, ~8 min) — Josh Starmer works tiny numeric examples in exactly this lesson's
  spirit, including the calculate-vs-estimate distinction (μ/σ² vs x̄/s²). Watch
  after the toy example.
- 📺 [StatQuest: Why Dividing By N Underestimates the Variance](https://youtu.be/sHRBg6BhKjI)
  (video, ~5 min) — the full story behind this lesson's "why n − 1?" box, with pictures
  instead of algebra. Optional but very satisfying.
- 📺 [StatQuest: Covariance, Clearly Explained!!!](https://youtu.be/qtaqvPAeEJY)
  (video, ~9 min) — builds covariance from paired deviations just like our plant-and-water
  table, and explains why the raw number is hard to interpret (setting up
  correlation).
- 🎮 [Seeing Theory: Basic Probability](https://seeing-theory.brown.edu/basic-probability/index.html)
  (interactive) — Brown University's visual playground; the Expectation and
  Variance sections let you *watch* means and spreads emerge from random draws.

---

## 🔤 Reading the notation: is "Greek = population, Latin = sample" always true?

This lesson leans on the μ/σ² vs x̄/s² distinction. Here's how far that
Greek-vs-Latin instinct actually carries you.

**It's a strong prior, not a law.** The real rule is *parameter vs statistic*:

- **Greek lowercase = unknown population parameter** — a fixed truth you never
  observe.
- **Latin = something computed from your sample** — an estimate or an observed
  quantity.

The pairs where it holds cleanly (the ones from this lesson):

| Quantity    | Population (Greek) | Sample (Latin) |
| ----------- | ------------------ | -------------- |
| Mean        | μ                  | x̄              |
| Variance    | σ²                 | s²             |
| Std dev     | σ                  | s              |
| Covariance  | σ_XY               | s_XY           |
| Correlation | ρ                  | r              |

**The override that beats the alphabet: the hat.** A hat (^) means "estimate
of," whatever letter it sits on. So β̂, μ̂, σ̂ are all *sample* quantities written
in Greek. When you see a hat, trust it over the alphabet.

**Where the naive rule just breaks:**

- **Constants:** π ≈ 3.14159 is Greek but isn't a population anything.
- **Operators:** Σ (sum) and Π (product) are Greek — and Σ sits right inside
  every mean and variance formula you'll write. It's a verb ("add these up"),
  not a parameter.
- **Chosen constants:** α (significance level) is Greek but you *pick* it.
- **Statistics from data:** χ² is Greek but computed entirely from the sample.
- **Random variables:** capital Latin X, Y are *random variables*; lowercase
  x, y are their observed values — a different distinction that has nothing to
  do with population vs sample.

**Spotting the glyphs.** Stats reuses only ~15 Greek letters (α β γ δ ε θ λ μ
π ρ σ τ φ χ ψ, plus capitals Σ Π Δ Φ). Lowercase Greek looks distinct; the
**capitals are the trap** — Α Β Ε Ζ Η Ι Κ Μ Ν Ο Ρ Τ Χ are pixel-identical to
Latin A B E Z H I K M N O P T X, so a lone capital can't tell you which
alphabet you're in. Context does.

**Bottom line:** treat "Greek = population" as a reliable guess for the
estimator pairs above, then ask the real question — *is this computed from
data?* If yes, it's a statistic no matter what alphabet it wears, and a hat
says so out loud.
