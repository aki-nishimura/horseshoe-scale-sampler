source('horseshoe_scale_sampler.R')

## Sample the horseshoe local scale conditionally on fixed beta and global scale.
gscale <- rexp(1)
beta <- .1 * gscale

n_samples <- 10^5
lscale_samples <-
  sapply(1:n_samples, function(i) sample_local_scale(beta, gscale))


## Visually compare the empirical distribution to the target.
compute_target_pdf <- function(x, beta, gscale, normalized = TRUE) {
  log_prior <- - log(1 + x^2)
  loglik <- - .5 * (beta / gscale / x)^2 - log(x)
  logp <- loglik + log_prior
  logp <- logp - max(logp)
  # Avoid numerical under-flow when exponentiating.
  pdf <- exp(logp)
  if (normalized) {
    pdf <- pdf / trapz(pdf, x)
  }
  return(pdf)
}

trapz <- function(f, x) {
  dx <- tail(x, -1) - head(x, -1)
  return(
    sum((head(f, -1) + tail(f, -1)) * dx / 2)
  )
}

# Restrict the plot range; otherwise, the empirical 
# distribution of a heavy-tailed target is unstable.
max_quantile <- .99
upper_xlim <- quantile(lscale_samples, max_quantile)
breaks <- seq(0, upper_xlim, length.out = 100)

hist(
  lscale_samples[lscale_samples < upper_xlim], 
  breaks = breaks, col='blue',
  xlab = bquote(lambda ~ "|" ~ beta / tau ~ "=" ~ .(beta / gscale)),
  main=NULL,
  prob=TRUE
)

x <- seq(0, upper_xlim, length.out = 10^5)[-1]
pdf <- compute_target_pdf(x, beta, gscale)
lines(x, pdf, col = 'orange', lw=2)

legend(
  "topright", 
  legend = c('empirical dist', 'target density'),
  lty = c(2, 1), lwd=c(10, 2), bty='n',
  col = c('blue', 'orange')
)