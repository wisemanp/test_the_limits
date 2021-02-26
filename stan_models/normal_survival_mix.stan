data {
  int<lower=0> N_obs;
  int<lower=0> N_cens;
  real y_obs[N_obs];
  real y_err[N_obs];
  vector[N_cens] y_cens;
}
parameters {
  vector<upper=0>[N_cens] latent_y_cens_raw;
  real latent_y[N_obs];
  real mu1;
  real<lower=mu1> mu2;
  real<lower=0> sigma1;
  real<lower=0> sigma2;
  real<lower=0,upper=1> theta;
}

transformed parameters {
  vector[N_cens] latent_y_cens;
  latent_y_cens = y_cens + latent_y_cens_raw;
}
model {
  mu1 ~ normal(9.5,0.5);
  mu2 ~ normal(10.5,0.5);
  sigma1 ~ normal(0.5,0.5);
  sigma2 ~ normal(0.5,0.5);
  theta ~ beta(5,5); 
  y_obs ~ normal(latent_y,y_err);
  for (n in 1:N_obs)
    target += log_mix(theta,
                      normal_lpdf(latent_y[n]|mu1,sigma1),
                      normal_lpdf(latent_y[n]|mu2,sigma2));
  
  for (n in 1:N_cens)
    target += log_mix(theta,
                      normal_lpdf(latent_y_cens[n]|mu1,sigma1),
                      normal_lpdf(latent_y_cens[n]|mu2,sigma2));
  
  
  //target += N_cens * normal_lcdf(L | mu, sigma);
}

