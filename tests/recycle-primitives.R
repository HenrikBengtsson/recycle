library("recycle")

printf <- function(...) message(sprintf(...), appendLF=FALSE)
is_primitive <- function(names) {
  sapply(names, FUN=function(name) {
    is.primitive(get(name))
  })
}

opts <- options(warn=1L)

## Mathematical primitives taking a numeric vector as input
## and returning another vector
math_prims <- c("abs", "acos", "acosh", "asin", "asinh", "atan", "atanh", "ceiling", "cos", "cosh", "cospi", "cummax", "cummin", "cumprod", "cumsum", "digamma", "exp", "expm1", "floor", "gamma", "log", "log10", "log1p", "log2", "sin", "sinh", "sinpi", "sqrt", "tan", "tanh", "tanpi", "trigamma", "xtfrm")

math_misc <- c("c", "t", "rank", "sort", "order", "Im", "Re", "Arg", "Mod", "Conj")

funs <- c(math_prims, math_misc)
funs <- sort(funs)

## Record which functions copies and which can recycle
data <- data.frame(name=I(funs), recycable=FALSE, copies=FALSE, primitive=is_primitive(funs))

for (kk in seq_len(nrow(data))) {
  name <- data$name[[kk]]
  printf("Function #%d ('%s'):\n", kk, name)
  fun <- get(name, mode="function")

  x <- 0; x[1] <- 1.0
  printf(" named(x): %s\n", named(x))
  printf(" address(x): %s\n", ax <- address(x))

  ## Call without recycling
  printf(" y <- %s(x)\n", name)
  y0 <- fun(x)
  str(y0)
  printf(" named(y0): %s\n", named(y0))
  printf(" address(y0): %s\n", ay0 <- address(y0))
  data$copies[[kk]] <- !identical(ay0, ax)

  ## Call with recycling
  printf(" y <- %s(r(x))\n", name)
  y1 <- fun(r(x))
  str(y1)
  printf(" named(y1): %s\n", named(y1))
  printf(" address(y1): %s\n", ay1 <- address(y1))
  data$recycable[[kk]] <- identical(ay1, ax)

  stopifnot(identical(y1, y0))
}

## Summary
data <- data[order(!data$recycable, data$copies, data$primitive),]
rownames(data) <- NULL
print(data)

options(opts)
