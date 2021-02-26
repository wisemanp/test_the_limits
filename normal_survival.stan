data {
  int<lower=0> N_obs;
  int<lower=0> N_cens;
  real y_obs[N_obs];
  vector[N_cens] y_cens;
}
parameters {
  vector<upper=0>[N_cens] latent_y_cens_raw;
  real mu;
  real<lower=0> sigma;
}

transformed parameters {
  vector[N_cens] latent_y_cens;
  
  latent_y_cens = y_cens + latent_y_cens_raw;
}
model {
  latent_y_cens ~ normal(mu, sigma);
  y_obs ~ normal(mu, sigma);
  //target += N_cens * normal_lcdf(L | mu, sigma);
}
