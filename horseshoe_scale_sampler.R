#' Sample from the local scale parameters conditionally on 
#' the regression coefficients and global scale.
#' 
#' @param beta double
#' @param gscale double
sample_local_scale <- function(beta, gscale) {
  b <- .5 * (beta / gscale)**2
  # For numerical stability
  if (b == 0) {
    b <- 2^(-1023) 
  } else if (is.infinite(b)) {
    b <- 2^(1023)
  }
  local_prec_transformed <-
    sample_from_transformed_precision(b)
  local_prec <- exp(local_prec_transformed) - 1.
  return(1 / sqrt(local_prec))
}


#' Sample from a density proportional to exp(- b * exp(x)) by
#' rejection sampler.
sample_from_transformed_precision <- function(b) {
  accepted <- FALSE
  while (!accepted) {
    rv <- sample_from_bounding_dist(b)
    target_logp <- -b * exp(rv)
    bound_logp <- compute_bounding_logp(rv, b)
    accept_prob <- exp(target_logp - bound_logp)
    accepted <- accept_prob > runif(1)
  }
  return(rv)
}


sample_from_bounding_dist <- function(b) {
  if (b < 1) {
    rv <- sample_from_mixture(b)
  } else {
    rv <- rexp(1) / b
  }
  return(rv)
}

#' Sample from a mixture of Unif(0, - log(b)) and - log(b) + Exp(1).
sample_from_mixture <- function(b) {
  log_b <- log(b)
  mass_to_left <- exp(-b) * (-log_b)
  mass_to_right <- 0.36787944117144233 # = exp(-1)
  prob_to_left <- mass_to_left / (mass_to_left + mass_to_right)
  sampled_from_left <- (prob_to_left > runif(1))
  if (sampled_from_left) {
    rv <- (-log_b) * runif(1)
  } else {
    rv <- -log_b + rexp(1)
  }
  return(rv)
}


compute_bounding_logp <- function(x, b) {
  if (b < 1) {
    thresh <- -log(b)
    if (x < thresh) {
      logp <- -b
    } else {
      logp <- -1 - (x - thresh)
    }
  } else {
    logp <- -b * (1 + x)
  }
  return(logp)
}