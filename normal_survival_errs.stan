functions {
  real double_normal_lpdf(real y,real mu1, real mu2, real sigma1, real sigma2){
    real lprob;
    
    lprob = normal_lpdf(y|mu1,sigma1)+normal_lpdf(y|mu2,sigma2);
    
    return lprob;
   }
}
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
}

transformed parameters {
  vector[N_cens] latent_y_cens;
  latent_y_cens = y_cens + latent_y_cens_raw;
}
model {
  for(n in 1:N_obs){
    latent_y[n] ~ double_normal(mu1,mu2,sigma1,sigma2);
  }
  for(n in 1:N_cens){
    latent_y_cens[n] ~ double_normal(mu1,mu2,sigma1,sigma2);
  }
  y_obs ~ normal(latent_y, y_err);
  //target += N_cens * normal_lcdf(L | mu, sigma);
}

