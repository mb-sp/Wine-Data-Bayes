setwd("C:\\Users\\Matt\\Downloads")
install.packages("tidyverse")
install.packages("bayesrules")
install.packages("rstan")
install.packages("rstanarm")
install.packages("ggplot2")
install.packages("bayesplot")
install.packages("tidyr")
install.packages("gridExtra")
library(tidyverse)
library(bayesrules)
library(rstan)
library(rstanarm)
library(ggplot2)
library(bayesplot)
library(tidyr)
library(gridExtra)

winedata <- read.csv("winemag-data-130k-v2.csv")
winedata <- winedata %>% filter(!is.na(points), !is.na(variety)) %>% mutate(variety_code = as.numeric(factor(variety)))
### Parameters: variety (discrete) and points (continuous)
edited_data <- list(n = nrow(winedata), v = 709, variety = winedata$variety_code + 1, points = winedata$points)

theoretical_posterior <- sum(winedata$points) / 129971 ### Theoretical posterior for points
theoretical_posterior

model <- "
  data{
    int<lower = 1> n;
    real points[n];
  }
  parameters{
    real mu;
    real <lower = 0> sigma;
  }
  model{
    mu ~ normal(90, 5);
    sigma ~ cauchy(0, 5);
    points ~ normal(mu, sigma);
  }"

stan_model <- stan(model_code = model, data = edited_data, iter = 6*1000, chains = 4)
summary(stan_model)
post_mu <- rstan::extract(stan_model)$mu
posterior_total_mean <- mean(post_mu)
posterior_total_mean

mcmc_trace(stan_model, pars = "mu")
mcmc_dens(stan_model, pars = "mu")
mcmc_acf(stan_model, pars = "mu")
neff_ratio(stan_model, pars = "mu")
rhat(stan_model, pars = "mu")