library("recycle")

local({
  message("TEST #1: Will not be able to recycle")

  ## Create x
  x <- rnorm(10); x[1] <- 1
  stopifnot(named(x) == 1); ax0 <- address(x)

  ## Make 'y' "reference" the same value as 'x'
  y <- x
  stopifnot(named(x) > 1)
  stopifnot((ax1 <- address(x)) == ax0)
  stopifnot(named(y) > 1)
  stopifnot((ay1 <- address(y)) == ax1)

  ## Force a copy of 'y', making 'y' the only reference
  y[1] <- 0L
  stopifnot(named(y) == 1)
  stopifnot((ax2 <- address(x)) == ax1)
  stopifnot((ay2 <- address(y)) != ay1)

  ## Remove 'x' but try to recycle it's value into 'z'
  ## (the recycling will not succeed because the value
  ##  that 'x' referred to already had too many reference)
  z <- recycle(x)
  stopifnot(!exists("x", inherits=FALSE))  # 'x' was removed
  stopifnot(named(z) == 2) ## Not recycled!
  stopifnot((ay3 <- address(y)) == ay2)
  az3 <- address(z)

  ## Force a copy of 'z', making 'z' the only reference
  z[1] <- 0L
  stopifnot(named(z) == 1)
  stopifnot((ay4 <- address(y)) == ay3)
  stopifnot((az4 <- address(z)) != az3)
})


local({
  message("TEST #2: Will be able to recycle")
  rm(list=ls())

  ## Create x
  x <- rnorm(10); x[1] <- 1
  stopifnot(named(x) == 1); ax0 <- address(x)

  ## Remove 'x' but try to recycle it's value into 'z'
  ## (the recycling will not succeed because the value
  ##  that 'x' referred to already had too many reference)
  z <- recycle(x)
  stopifnot(named(z) == 1) ## Recycled!
  stopifnot(!exists("x", inherits=FALSE))  # 'x' was removed
  az1 <- address(z)
  stopifnot((az2 <- address(z)) == az1)
  stopifnot(named(z) == 1) ## Not recycled!

  ## Change 'z'; no extra copy because the only reference
  z[1] <- 0L
  stopifnot(named(z) == 1)
  stopifnot((az2 <- address(z)) == az1)

  ## Make 'y' "reference" the same value as 'x'
  y <- z
  stopifnot(named(z) == 2)
  stopifnot(named(y) == 2)
  stopifnot((az3 <- address(z)) == az2)
  stopifnot((ay3 <- address(y)) == az3)

  ## Force a copy of 'z', making 'z' the only reference
  z[1] <- 1L
  stopifnot(named(z) == 1)
  stopifnot((ay4 <- address(y)) == ay3)
  stopifnot((az4 <- address(z)) != az3)
})
