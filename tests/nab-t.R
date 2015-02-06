library("recycle")

opts <- options(warn=1L)

message("TEST: t()")
local({
  X <- matrix(runif(1e6), nrow=1000L, ncol=1000L)
  message("address(X): ", aX <- address(X))
  Y <- t(X)
  message("address(Y): ", aY <- address(Y), " != address(X)")
  stopifnot(aY != aX)

  X <- matrix(runif(1e6), nrow=1000L, ncol=1000L)
  message("address(X): ", aX <- address(X))
  Y <- sqrt(nab(X))
  message("address(Y): ", aY <- address(Y), " == address(X)")
  stopifnot(aY == aX)
})

options(opts)
