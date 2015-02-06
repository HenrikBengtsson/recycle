library("recycle")

opts <- options(warn=1L)

message("TEST: Calling function in script")
wx <- function(X, W, nabbed=FALSE) {
  message("nabbed: ", nabbed)
  message("- named(W): ", named(W))
  message("- address(W): ", aW <- address(W))
  Y <- W # Make sure it's nab():ed
  W <- NULL
  message("- named(Y): ", named(Y))
  if (nabbed) {
    stopifnot(!exists("W", envir=parent.frame(), inherits=TRUE))
    ## FIXME: Above 'Y' gets NAMED=2, not NAMED=1.
##    stopifnot(named(Y) < 2)
    nabbed <- (named(Y) < 2)
    if (!nabbed) warning("Nabbing failed")
  } else {
    stopifnot(named(Y) == 2)
  }
  message("- address(Y): ", aY <- address(Y), " == address(W)")
  stopifnot(aY == aW)
  str(Y)
  Y[1,1] <- 1
  str(Y)
  message("- named(Y): ", named(Y))
  if (nabbed) {
    stopifnot(!exists("W", envir=parent.frame(), inherits=TRUE))
    message("- address(Y): ", aY <- address(Y), " == address(W)")
    stopifnot(aY == aW)
  } else {
    stopifnot(named(Y) == 2)
    message("- address(Y): ", aY <- address(Y), " != address(W)")
    stopifnot(aY != aW)
  }

  Y
} # wx()


message("TEST: Without nab")
X <- matrix(runif(1e6), nrow=1000L, ncol=1000L)
W <- matrix(runif(1e6), nrow=1000L, ncol=1000L)
message("address(X): ", aX <- address(X))
message("address(W): ", aW <- address(W))
Y <- wx(X, W=W)
message("named(Y): ", named(Y))
message("address(Y): ", aY <- address(Y), " != address(W)")
stopifnot(aY != aW, aY != aX)


message("TEST: With nab")
x <- matrix(runif(1e6), nrow=1000L, ncol=1000L)
W <- matrix(runif(1e6), nrow=1000L, ncol=1000L)
message("address(X): ", aX <- address(X))
message("address(W): ", aW <- address(W))
Y <- wx(X, W=force(nab(W)), nabbed=TRUE)
message("named(Y): ", named(Y))
message("address(Y): ", aY <- address(Y), " != address(W)")
## FIXME
##  stopifnot(aY == aW)

options(opts)
