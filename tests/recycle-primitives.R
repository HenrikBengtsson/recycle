library("recycle")
library("R.utils")

opts <- options(warn=1L)

## Mathematical primitives taking a numeric vector as input
## and returning another vector
prims <- c("abs", "acos", "acosh", "asin", "asinh", "atan", "atanh", "ceiling", "cos", "cosh", "cospi", "cummax", "cummin", "cumprod", "cumsum", "digamma", "exp", "expm1", "floor", "gamma", "log", "log10", "log1p", "log2", "sin", "sinh", "sinpi", "sqrt", "tan", "tanh", "tanpi", "trigamma")

## Record which functions copies and which can recycle
data <- data.frame(name=prims, copies=FALSE, recycable=FALSE)

for (kk in seq_along(prims)) {
  prim <- prims[[kk]]
  mprintf("Primitive function #%d ('%s'):\n", kk, prim)
  fun <- get(prim, mode="function")

  x <- 0; x[1] <- 1.0
  mprintf(" named(x): %s\n", named(x))
  mprintf(" address(x): %s\n", ax <- address(x))

  ## Call without recycling
  mprintf(" y <- %s(x)\n", prim)
  y0 <- fun(x)
  mstr(y0)
  mprintf(" named(y0): %s\n", named(y0))
  mprintf(" address(y0): %s\n", ay0 <- address(y0))
  data$copies[[kk]] <- !identical(ay0, ax)

  ## Call with recycling
  mprintf(" y <- %s(r(x))\n", prim)
  y1 <- fun(r(x))
  mstr(y1)
  mprintf(" named(y1): %s\n", named(y1))
  mprintf(" address(y1): %s\n", ay1 <- address(y1))
  data$recycable[[kk]] <- identical(ay1, ax)

  stopifnot(identical(y1, y0))
}

mprint(data)

options(opts)
