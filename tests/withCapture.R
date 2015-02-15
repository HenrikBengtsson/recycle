library("recycle")
library("R.utils")
printf <- function(...) cat(sprintf(...))


cat("*** As is\n")
local({
  x <- runif(10)
  x[1] <- x[1]
  printf(" address(x)=%s, named(x)=%d\n", ax <- address(x), nx <-named(x))
  x <- r(x)
  printf(" address(x)=%s, named(x)=%d\n", ax1 <- address(x), nx1 <- named(x))
  x <- sqrt(r(x))
  printf(" address(x)=%s, named(x)=%d\n", ax1 <- address(x), nx1 <- named(x))
})
cat("\n\n")

cat("*** withCapture()\n")
out <- withCapture(local({
  x <- runif(10)
  x[1] <- x[1]
  printf(" address(x)=%s, named(x)=%d\n", ax <- address(x), nx <-named(x))
  x <- r(x)
  printf(" address(x)=%s, named(x)=%d\n", ax1 <- address(x), nx1 <- named(x))
  x <- sqrt(r(x))
  printf(" address(x)=%s, named(x)=%d\n", ax1 <- address(x), nx1 <- named(x))
}))
cat(out)
cat("\n\n")
