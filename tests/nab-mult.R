library("recycle")

opts <- options(warn=1L)


message("TEST #3: Multiplication")
local({
  wx <- function(X, W) {
    message("- address(W): ", aW <- address(W))
    message("- named(W): ", named(W))
    Y <- nab(W)
#    Y <- W
    message("- address(Y): ", aY <- address(Y))
    message("- named(Y): ", named(Y))
    Y[1,1] <- 1
    message("- named(Y): ", named(Y))
    message("- address(Y): ", aY <- address(Y))
    nab(Y)
  }

  X <- matrix(runif(1e6), nrow=1000L, ncol=1000L)
  W <- matrix(runif(1e6), nrow=1000L, ncol=1000L)
  message("address(X): ", aX <- address(X))
  message("address(W): ", aW <- address(W))
  Y <- wx(X, W=W)
  message("named(Y): ", named(Y))
  message("address(Y): ", aY <- address(Y), " != address(W)")
  stopifnot(aY != aW, aY != aX)

  X <- matrix(runif(1e6), nrow=1000L, ncol=1000L)
  W <- matrix(runif(1e6), nrow=1000L, ncol=1000L)
  message("address(X): ", aX <- address(X))
  message("address(W): ", aW <- address(W))
  Y <- wx(X, W=nab(W))
  message("named(Y): ", named(Y))
  message("address(Y): ", aY <- address(Y), " != address(W)")
  ## FIXME
##  stopifnot(aY == aW)
})

options(opts)
