---
layout: post
title: Acceptance-Rejection versus Inverse transformation
---
- Acceptance-rejection method

```
library(rbenchmark)
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

result <- rejection(f, M, g,rg, 1e5)
hist(result,freq = FALSE)
points(seq(0,1,0.01),dbeta(seq(0,1,0.01),alpha,beta),type = "l")
```

- Inverse transformation

```
U <- runif(1e5)
alpha <- 4
beta <- 3
b_rand <- qbeta(U, alpha, beta)
hist(b_rand, col="skyblue", main = "Inverse U", freq=FALSE)
points(seq(0,1,0.01),dbeta(seq(0,1,0.01),alpha,beta),type = "l")
```

- Let's now timeit for two different method to generate beta distribution sample

```
benchmark("Acceptance-rejection" = {result <- rejection(f, M, g,rg, 1e5)}
, "Inverse-transformed" = {U <- runif(1e5)
          alpha <- 4
          beta <- 3
          b_rand <- qbeta(U, alpha, beta)}, 
replications=5,
columns = c("test","replications","elapsed","relative","user.self","sys.self"))
```

- We confirm that for this scenario, Inverse transform method is faster than Acceptance-rejection method.
                  test replications elapsed relative user.self sys.self
1 Acceptance-rejection            5    3.45      2.5      3.37     0.01
2  Inverse-transformed            5    1.38      1.0      1.37     0.00

However, this is not always true.
For example, for generating incomplete beta distribution, Acceptance-Rejection method could be faster.
