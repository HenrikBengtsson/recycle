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
