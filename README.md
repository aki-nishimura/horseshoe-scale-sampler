Local scale sampler for horseshoe models
========

The horseshoe prior, expressed as a Gaussian scale mixture as
\[
\beta \, | \, \tau, \lambda \sim \mathcal{N}(0, \tau^2 \lambda^2), \
\lambda \sim \textrm{Cauchy}^+(0, 1),
\]
is one of the most popular choice for Bayesian shrinkage models.
In Gibbs sampling the horseshoe model posteriors, we need to update $\lambda$ from its conditional distribution
\[
\pi(\lambda \, | \, \tau, \beta)
  \propto \frac{1}{\lambda} \exp\left(- \frac{\beta^2}{2 \tau^2 \lambda^2} \right) \frac{1}{1 + \lambda^2}.
\]
The Python and R module here implement a rejection sampler for the above conditional distribution.
The rejection sampler is simple and fast, with provably high acceptance probability,  providing a more efficient alternative to the previously proposed approaches.
Further details on the rejection sampler, as well as comparison with the previously proposed approaches, can be found in Appendix C of the reference below.

Reference & Citation
--------
If you find this package useful, please consider citing
> Akihiko Nishimura and Marc A. Suchard (2018).
> Regularization of Bayesian shrinkage priors and inference via geometrically / uniformly ergodic Gibbs sampler. arXiv:

[TODO]: <> (Add the link to the arXiv paper.)
