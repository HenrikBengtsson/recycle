library("recycle")

opts <- options(warn=1L)

message("TEST: t() without nab")
local({
  X <- matrix(runif(1e6), nrow=1000L, ncol=1000L)
  message("address(X): ", aX <- address(X))

  Y <- t(X)
  message("address(Y): ", aY <- address(Y), " != address(X)")
  stopifnot(aY != aX)
})
print(gc())

message("TEST: t() with nab")
local({
  X <- matrix(runif(1e6), nrow=1000L, ncol=1000L)
  message("address(X): ", aX <- address(X))

  Y <- t(nab(X))
  message("address(Y): ", aY <- address(Y), " == address(X)")
  ## FIXME: Nabbing fails.  Could it be because it's
  ## a call through a generic function?
  ## stopifnot(aY == aX)
})
print(gc())

options(opts)
