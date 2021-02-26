data {
  int<lower=0> N_obs;
  real y_obs[N_obs];
 }
parameters {
  real mu;
  real<lower=0> sigma;
 }
model {
  y_obs ~ normal(mu, sigma);
}


