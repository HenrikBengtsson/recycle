#' Gets the internal memory address of a variable
#'
#' @param var A variable
#' @return A character string
#'
#' @export
#' @useDynLib recycle
address <- function(var) {
  name <- substitute(var)
##  named <- .Call("named", as.character(name), parent.frame(), PACKAGE="recycle")
  expr <- substitute(.Internal(inspect(name)), list(name=name))

  con <- textConnection("info", open="w")
  on.exit(close(con))

  sink(con)
  eval(expr, envir=parent.frame())
  sink()
  info <- gsub("@", "", gsub(" .*", "", info))
##  .Call("set_named", as.character(name), as.integer(named), parent.frame(), PACKAGE="recycle")
  info
}

#' Gets the NAMED status of a variable
#'
#' @param var A variable
#' @return An integer (0, 1, or 2).
#'
#' @export
#' @useDynLib recycle
named <- function(var) {
  name <- substitute(var)
  .Call("named", as.character(name), parent.frame(), PACKAGE="recycle")
}

set_named <- function(var, named) {
  name <- substitute(var)
  .Call("set_named", as.character(name), as.integer(named), parent.frame(), PACKAGE="recycle")
}
