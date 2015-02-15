library("recycle")

message("*** Without recycling")

log_sqrt_abs <- function(x) {
  cat('log_sqrt_abs(x)...\n')
  cat(sprintf('  address(x)=%s, named(x)=%d\n', address(x), named(x)))
  ## Note that we cannot do
  ##   x <- abs(r(x))
  ## here, because then 'x' will be removed and abs(x) won't see it.
  x <- abs(x)
  cat(sprintf('  address(x)=%s, named(x)=%d\n', address(x), named(x)))
  x <- sqrt(x)
  cat(sprintf('  address(x)=%s, named(x)=%d\n', address(x), named(x)))
  x <- log(x)
  cat(sprintf('  address(x)=%s, named(x)=%d\n', address(x), named(x)))
  cat('log_sqrt_abs(x)...OK\n')
  x
}

local({
  z <- runif(1e6)
  cat(sprintf('address(z)=%s, named(z)=%d\n', address(z), named(z)))
  stopifnot(named(z) == 1)

  y <- log_sqrt_abs(z)
  cat(sprintf('address(y)=%s, named(y)=%d\n', address(y), named(y)))
  stopifnot(named(y) == 2)
})


message("*** With recycling")

log_sqrt_abs <- function(x) {
  cat('log_sqrt_abs(x)...\n')
  cat(sprintf('  address(x)=%s, named(x)=%d\n', address(x), named(x)))
  ## Note that we cannot do
  ##   x <- abs(r(x))
  ## here, because then 'x' will be removed and abs(x) won't see it.
  x <- abs(x)
  cat(sprintf('  address(x)=%s, named(x)=%d\n', address(x), named(x)))
  x <- sqrt(r(x))
  cat(sprintf('  address(x)=%s, named(x)=%d\n', address(x), named(x)))
  x <- log(r(x))
  cat(sprintf('  address(x)=%s, named(x)=%d\n', address(x), named(x)))
  cat('log_sqrt_abs(x)...OK\n')
  ## Make sure to recycle() return value too, otherwise
  ## the return value will get named() == 2.
  r(x)
}

local({
  z <- runif(1e6)
  cat(sprintf('address(z)=%s, named(z)=%d\n', address(z), named(z)))
  stopifnot(named(z) == 1)

  y <- log_sqrt_abs(z)
  cat(sprintf('address(y)=%s, named(y)=%d\n', address(y), named(y)))
  stopifnot(named(y) == 1)
})
