data {
  int<lower=0> N_obs;
  real y_obs[N_obs];
  real sigma_obs[N_obs];
}
parameters {
  real mu;
  real<lower=0> sigma;
  real latent_y[N_obs];
}
model {
  latent_y ~ normal(mu, sigma);
  y_obs ~ normal(latent_y, sigma_obs);
}


