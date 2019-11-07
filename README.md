Local scale sampler for horseshoe models
========

The horseshoe prior, expressed as a Gaussian scale mixture as
<p align="center">
  <img src="https://latex.codecogs.com/gif.latex?%5Cbeta%20%5C%2C%20%7C%20%5C%2C%20%5Ctau%2C%20%5Clambda%20%5Csim%20%5Cmathcal%7BN%7D%280%2C%20%5Ctau%5E2%20%5Clambda%5E2%29%2C%20%5C%20%5Clambda%20%5Csim%20%5Ctextrm%7BCauchy%7D%5E&plus;%280%2C%201%29">,
</p>
is one of the most popular choice for Bayesian shrinkage models.
In Gibbs sampling the horseshoe model posteriors, we need to update &lambda; from its conditional distribution
<p align="center">
  <img src="https://latex.codecogs.com/gif.latex?%5Cpi%28%5Clambda%20%5C%2C%20%7C%20%5C%2C%20%5Ctau%2C%20%5Cbeta%29%20%5Cpropto%20%5Cfrac%7B1%7D%7B%5Clambda%7D%20%5Cexp%5Cleft%28-%20%5Cfrac%7B%5Cbeta%5E2%7D%7B2%20%5Ctau%5E2%20%5Clambda%5E2%7D%20%5Cright%29%20%5Cfrac%7B1%7D%7B1%20&plus;%20%5Clambda%5E2%7D">.
</p>
The Python and R module here implement a rejection sampler for the above conditional distribution.
The rejection sampler is simple and fast, with provably high acceptance probability,  providing a more efficient alternative to the previously proposed approaches.
Further details on the rejection sampler, as well as comparison with the previously proposed approaches, can be found in Appendix C of the reference below.

Reference & Citation
--------
If you find code here useful, please consider citing
> Akihiko Nishimura and Marc A. Suchard (2018).
> Regularization of Bayesian shrinkage priors and inference via geometrically / uniformly ergodic Gibbs sampler. arXiv:1911.02160.
