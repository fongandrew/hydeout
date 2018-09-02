---
layout: post
title: Acceptance-Rejection versus Inverse transformation
---

'''r
alpha <- 4
beta <- 3
rejection <- function(f, M, g, rg,n) {
  naccepts <- 0
  result.sample <- rep(NA, n)
  
  while (naccepts < n) {
    y <- rg(1)
    u <- runif(1)
    
    if ( u <= f(y) / (M*g(y)) ) {
      naccepts <- naccepts + 1
      result.sample[naccepts] = y
    }
  }
  
  result.sample
}
f <- function(x) 100*(x^(alpha-1))*(1-x)^(beta-1)
g <- function(x) 1
rg <- runif
M <- f((alpha-1)/(alpha+beta-1))
'''
