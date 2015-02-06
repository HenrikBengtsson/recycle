library("recycle")

opts <- options(warn=1L)

message("TEST: sqrt()")
local({
  X <- matrix(runif(1e6), nrow=1000L, ncol=1000L)
  message("address(X): ", aX <- address(X))
  Y <- sqrt(X)
  message("address(Y): ", aY <- address(Y), " != address(X)")
  stopifnot(aY != aX)

  X <- matrix(runif(1e6), nrow=1000L, ncol=1000L)
  message("address(X): ", aX <- address(X))
  Y <- sqrt(nab(X))
  message("address(Y): ", aY <- address(Y), " == address(X)")
  stopifnot(aY == aX)
})
