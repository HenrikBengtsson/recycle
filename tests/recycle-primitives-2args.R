library("recycle")

printf <- function(...) message(sprintf(...), appendLF=FALSE)
is_primitive <- function(names) {
  sapply(names, FUN=function(name) {
    is.primitive(get(name))
  })
}

opts <- options(warn=1L)


##################################################################
## Mathematical primitives that takes:
## * two numeric vectors as input
##################################################################
math_prims <- c("+", "*", "-", "/", "==", "!=", ">", ">=", "<", "<=", "%%", "%/%", "^")

funs <- c(math_prims)
funs <- sort(funs)

## Record which functions copies and which can recycle
data <- data.frame(name=I(funs), recycable=FALSE, copies=FALSE, primitive=is_primitive(funs))

for (kk in seq_len(nrow(data))) {
  name <- data$name[[kk]]
  printf("Function #%d ('%s'):\n", kk, name)
  fun <- get(name, mode="function")

  u <- 0; u[1] <- 1.0
  printf(" named(u): %s\n", named(u))
  printf(" address(u): %s\n", au <- address(u))

  v <- 0; v[1] <- 1.0
  printf(" named(v): %s\n", named(v))
  printf(" address(v): %s\n", av <- address(v))

  ## Call without recycling
  printf(" y <- %s(u, v)\n", name)
  y0 <- fun(u, v)
  str(y0)
  printf(" named(y0): %s\n", named(y0))
  printf(" address(y0): %s\n", ay0 <- address(y0))
  data$copies[[kk]] <- !identical(ay0, au) && !identical(ay0, av)

  ## Call with recycling
  printf(" y <- %s(r(u), r(v))\n", name)
  y1 <- fun(r(u), r(v))
  str(y1)
  printf(" named(y1): %s\n", named(y1))
  printf(" address(y1): %s\n", ay1 <- address(y1))
  data$recycable[[kk]] <- identical(ay1, au) || identical(ay1, av)

  stopifnot(identical(y1, y0))
}

## Summary
data <- data[order(!data$recycable, data$copies, data$primitive),]
rownames(data) <- NULL
print(data)



options(opts)
