library("recycle")

rnorm2 <- function(n, mean = 0, sd = 1) {
  cat('rnorm2()...\n')

  x1 <- runif(n, min=0, max=1)
  cat(sprintf('  address(x1)=%s, named(x1)=%d\n', address(x1), named(x1)))
  x1 <- log(x1)
  cat(sprintf('  address(x1)=%s, named(x1)=%d\n', address(x1), named(x1)))
  x1 <- -2.0 * x1
  cat(sprintf('  address(x1)=%s, named(x1)=%d\n', address(x1), named(x1)))
  x1 <- sqrt(x1)
  cat(sprintf('  address(x1)=%s, named(x1)=%d\n', address(x1), named(x1)))
  x1 <- sd * x1
  cat(sprintf('  address(x1)=%s, named(x1)=%d\n', address(x1), named(x1)))

  x2 <- runif(n, min=0, max=2*pi)
  cat(sprintf('  address(x2)=%s, named(x2)=%d\n', address(x2), named(x2)))
  x2 <- sin(x2)
  cat(sprintf('  address(x2)=%s, named(x2)=%d\n', address(x2), named(x2)))

  x <- x1 * x2
  cat(sprintf('  address(x)=%s, named(x)=%d\n', address(x), named(x)))

  x <- mean + x
  cat(sprintf('  address(x)=%s, named(x)=%d\n', address(x), named(x)))

  cat('rnorm2()...OK\n')

  x
}


rnorm2_r <- function(n, mean = 0, sd = 1) {
  cat('rnorm2_r()...\n')

  x1 <- runif(n, min=0, max=1)
  cat(sprintf('  address(x1)=%s, named(x1)=%d\n', address(x1), named(x1)))
  x1 <- log(r(x1))
  cat(sprintf('  address(x1)=%s, named(x1)=%d\n', address(x1), named(x1)))
  x1 <- -2.0 * r(x1)
  cat(sprintf('  address(x1)=%s, named(x1)=%d\n', address(x1), named(x1)))
  x1 <- sqrt(r(x1))
  cat(sprintf('  address(x1)=%s, named(x1)=%d\n', address(x1), named(x1)))
  x1 <- sd * r(x1)
  cat(sprintf('  address(x1)=%s, named(x1)=%d\n', address(x1), named(x1)))

  x2 <- runif(n, min=0, max=2*pi)
  cat(sprintf('  address(x2)=%s, named(x2)=%d\n', address(x2), named(x2)))
  x2 <- sin(r(x2))
  cat(sprintf('  address(x2)=%s, named(x2)=%d\n', address(x2), named(x2)))

  x <- r(x1) * r(x2)
  cat(sprintf('  address(x)=%s, named(x)=%d\n', address(x), named(x)))

  x <- mean + r(x)
  cat(sprintf('  address(x)=%s, named(x)=%d\n', address(x), named(x)))

  cat('rnorm2_r()...OK\n')

  r(x)
}


n <- 1e6

set.seed(0xBEEF)
y1 <- rnorm2(n)
cat(sprintf('address(y1)=%s, named(y1)=%d\n', address(y1), named(y1)))
str(y1)

set.seed(0xBEEF)
y2 <- rnorm2_r(n)
cat(sprintf('address(y2)=%s, named(y2)=%d\n', address(y2), named(y2)))
str(y2)

## Sanity check
stopifnot(identical(y2, y1))
