rnorm2_0 <- function(n, mean = 0, sd = 1) {
  x1 <- runif(n, min=0, max=1)
  x1 <- log(x1)
  x1 <- -2.0 * x1
  x1 <- sqrt(x1)
  x1 <- sd * x1
  x2 <- runif(n, min=0, max=2*pi)
  x2 <- sin(x2)
  x <- x1 * x2
  x <- mean + x
  x
}

rnorm2_1 <- function(n, mean = 0, sd = 1) {
  mean + sd * (sqrt(-2.0 * log(runif(n, min=0, max=1))) * sin(runif(n, min=0, max=2*pi)))
}

rnorm2_2 <- function(n, mean = 0, sd = 1) {
  x1 <- runif(n, min=0, max=1)
  x1 <- log(r(x1))
  x1 <- -2.0 * r(x1)
  x1 <- sqrt(r(x1))
  x1 <- sd * r(x1)
  x2 <- runif(n, min=0, max=2*pi)
  x2 <- sin(r(x2))
  x <- r(x1) * r(x2)
  x <- mean + r(x)
  r(x)
}
