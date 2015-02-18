printf <- function(...) message(sprintf(...), appendLF=FALSE)

is_primitive <- function(names) {
  sapply(names, FUN=function(name) {
    is.primitive(get(name))
  })
}

#' Test reyclability of "base" functions
#'
#' @param sets Types of functions to test.
#' @param mode Data type on input arguments used for testing.
#' @param debug If TRUE, debug information is outputted, otherwise not.
#'
#' @return A \link{data.frame}.
#'
#' @export
recyclables <- function(sets=c("1arg", "2args"), mode=c("double", "integer", "logical"), debug=FALSE) {
  mode <- match.arg(mode)

  data <- list()
  if ("1arg" %in% sets)
    data[["1arg"]] <- recyclables_1arg(mode=mode, debug=debug)
  if ("2args" %in% sets)
    data[["2args"]] <- recyclables_2args(mode=mode, debug=debug)
  data <- Reduce(rbind, data)

  data <- data[order(data$input, !data$recycable, data$copies, data$primitive),]
  rownames(data) <- NULL
  data
}


recyclables_1arg <- function(mode=c("double", "integer", "logical"), debug=FALSE) {
  if (!debug) {
    printf <- str <- function(...) NULL
  }

  ##################################################################
  ## Mathematical primitives that takes:
  ## * one numeric vector as input
  ##################################################################
  math_prims <- c("abs", "acos", "acosh", "asin", "asinh", "atan", "atanh", "ceiling", "cos", "cosh", "cospi", "cummax", "cummin", "cumprod", "cumsum", "digamma", "exp", "expm1", "floor", "gamma", "log", "log10", "log1p", "log2", "sin", "sinh", "sinpi", "sqrt", "tan", "tanh", "tanpi", "trigamma", "xtfrm")

  math_misc <- c("c", "t", "rank", "sort", "order", "Im", "Re", "Arg", "Mod", "Conj", "!")

  funs <- c(math_prims, math_misc)
  funs <- sort(funs)

  ## Record which functions copies and which can recycle
  data <- data.frame(name=I(funs), input=I(mode), output=I(NA_character_), recycable=FALSE, copies=FALSE, primitive=is_primitive(funs))

  ## Default value
  default <- 1.0
  storage.mode(default) <- mode

  for (kk in seq_len(nrow(data))) {
    name <- data$name[[kk]]
    printf("Function #%d ('%s'):\n", kk, name)
    fun <- get(name, mode="function")

    x <- 0; x[1] <- default
    ax <- address(x)
    str(default)
    printf(" named(x): %s\n", named(x))
    printf(" address(x): %s\n", ax)

    ## Call without recycling
    printf(" y <- %s(x)\n", name)
    y0 <- fun(x)
    ay0 <- address(y0)
    str(y0)
    printf(" named(y0): %s\n", named(y0))
    printf(" address(y0): %s\n", ay0)
    data$copies[[kk]] <- !identical(ay0, ax)

    ## Call with recycling
    printf(" y <- %s(r(x))\n", name)
    y1 <- fun(r(x))
    ay1 <- address(y1)
    str(y1)
    printf(" named(y1): %s\n", named(y1))
    printf(" address(y1): %s\n", ay1)
    data$recycable[[kk]] <- identical(ay1, ax)

    data$output[[kk]] <- typeof(y0)

    stopifnot(identical(y1, y0))
  }

  ## Summary
  data <- data[order(!data$recycable, data$copies, data$primitive),]
  rownames(data) <- NULL

  data
} # recyclables_1arg()


recyclables_2args <- function(mode=c("double", "integer", "logical"), debug=FALSE) {
  if (!debug) {
    printf <- str <- function(...) NULL
  }

  ##################################################################
  ## Mathematical primitives that takes:
  ## * two numeric vectors as input
  ##################################################################
  math_prims <- c("+", "*", "-", "/", "==", "!=", ">", ">=", "<", "<=", "%%", "%/%", "^")

  funs <- c(math_prims)
  funs <- sort(funs)

  ## Record which functions copies and which can recycle
  data <- data.frame(name=I(funs), input=I(paste(c(mode, mode), collapse=",")), output=I(NA_character_), recycable=FALSE, copies=FALSE, primitive=is_primitive(funs))

  ## Default value
  default <- 1.0
  storage.mode(default) <- mode

  for (kk in seq_len(nrow(data))) {
    name <- data$name[[kk]]
    printf("Function #%d ('%s'):\n", kk, name)
    fun <- get(name, mode="function")

    u <- 0; u[1] <- default
    au <- address(u)
    str(default)
    printf(" named(u): %s\n", named(u))
    printf(" address(u): %s\n", au)

    v <- 0; v[1] <- default
    av <- address(v)
    str(default)
    printf(" named(v): %s\n", named(v))
    printf(" address(v): %s\n", av)

    ## Call without recycling
    printf(" y <- %s(u, v)\n", name)
    y0 <- fun(u, v)
    ay0 <- address(y0)
    str(y0)
    printf(" named(y0): %s\n", named(y0))
    printf(" address(y0): %s\n", ay0)
    data$copies[[kk]] <- !identical(ay0, au) && !identical(ay0, av)

    ## Call with recycling
    printf(" y <- %s(r(u), r(v))\n", name)
    y1 <- fun(r(u), r(v))
    ay1 <- address(y1)
    str(y1)
    printf(" named(y1): %s\n", named(y1))
    printf(" address(y1): %s\n", ay1)
    data$recycable[[kk]] <- identical(ay1, au) || identical(ay1, av)

    data$output[[kk]] <- typeof(y0)

    stopifnot(identical(y1, y0))
  }

  ## Summary
  data <- data[order(!data$recycable, data$copies, data$primitive),]
  rownames(data) <- NULL

  data
} # recyclables_2args()
