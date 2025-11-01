# Wine-Data-Bayes
This project performs a Bayesian statistical analysis of a large wine review dataset to explore the relationships between wine ratings (points), price, and country of origin. The analysis leverages Bayesian estimation and hierarchical regression modeling using the rstan and rstanarm frameworks in R.

Key objectives:
- Estimate the posterior distribution of wine ratings (points) using a normal likelihood with unknown mean and standard deviation.
- Build a Bayesian hierarchical regression model to predict wine prices based on ratings and country.
- Evaluate convergence and model diagnostics using MCMC trace plots, density plots, and effective sample size metrics.

Data Preparation Process:

Got data from a Kaggle dataset (of ~130k entries), and then cleaned data to only include countries with >400 reviews, and removed any missing values. Used a log-transformed price variable (log_price) used for exploratory analysis

Bayesian Estimation:

Estimated using MCMC sampling (NUTS) via rstan. Diagnostics include:
- Posterior mean and 95% credible intervals for μ and σ
- Convergence checks using R-hat and autocorrelation plots

Bayesian Regression:

A hierarchical model predicting price based on points, grouped by country.
Country-level intercepts and slopes capture variability in the price–rating relationship.
Priors used:
- Intercept: Normal(35, 6.5)
- Slope: Informative prior assuming price increases ~$3 per rating point
- Variance: Weakly informative prior
Diagnostics:
- Effective sample size (neff_ratio)
- Convergence (R-hat ≈ 1.00)
- Posterior predictive checks and LOO cross-validation

Key Findings:

- Posterior mean rating (μ): 88.46
- Posterior σ: 3.25
- Global regression slope: ~6.11 → each point increase adds ~$6 on average
- Strong convergence: all chains well mixed (R-hat ≈ 1.00)
- LOO-CV results: Moderate predictive performance, with ~79% of actual prices within 50% credible intervals

How to Run:
1. Clone this repository
2. Download Kaggle Wine Reviews CSV
3. Place it in your working directory as "winemag-data-130k-v2.csv"
4. Run the R script and receive the visual outputs
