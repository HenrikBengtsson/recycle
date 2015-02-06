library("recycle")

opts <- options(warn=1L)

n <- 1e6

message("TEST: sqrt()")
foo <- function() {
  x <- runif(n)
  message("address(x): ", ax <- address(x))
  y <- sqrt(x)
  message("address(y): ", ay <- address(y), " != address(x)")
  stopifnot(ay != ax)
}
foo()
print(gc())

message("TEST: sqrt() with nab internally")
foo <- function() {
  x <- runif(n)
  message("address(x): ", ax <- address(x))
  y <- sqrt(nab(x))
  message("address(y): ", ay <- address(y), " == address(x)")
  stopifnot(ay == ax)
}
foo()
print(gc())



message("TEST: sqrt()")
local({
  x <- runif(n)
  message("address(x): ", ax <- address(x))
  y <- sqrt(x)
  message("address(y): ", ay <- address(y), " != address(x)")
  stopifnot(ay != ax)
})
print(gc())

message("TEST: sqrt() with nab locally")
local({
  x <- runif(n)
  message("address(x): ", ax <- address(x))
  y <- sqrt(nab(x))
  message("address(y): ", ay <- address(y), " == address(x)")
  stopifnot(ay == ax)
})
print(gc())


message("TEST: sqrt()")
foo <- function(x) {
  message("address(x): ", ax <- address(x))
  str(x)
  y <- sqrt(x)
  message("address(y): ", ay <- address(y), " != address(x)")
  stopifnot(ay != ax)
}
x <- runif(n)
foo(x)
print(gc())

message("TEST: sqrt() with nab in call")
foo <- function(x) {
  message("address(x): ", ax <- address(x))
  y <- sqrt(x)
  message("address(y): ", ay <- address(y), " == address(x)")
  ## FIXME:
  ## stopifnot(ay == ax)
}
x <- runif(n)
foo(nab(x))
print(gc())
