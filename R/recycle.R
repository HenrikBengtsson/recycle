#' Removes variable but recycles its value iff possible
#'
#' @param var A variable
#' @return The value of the recycled variable
#'
#' @examples
#' ## Creates a variable
#' x <- rnorm(1e6); x[1] <- 1
#' print(ax <- address(x))
#' ## Remove the variable, but recycle its values
#' y <- recycle(x)
#' print(ay <- address(y))
#' stopifnot(ay == ax)
#'
#' @aliases recycle
#' @export
#' @export recycle
#' @useDynLib recycle
nab <- function(var) {
  name <- substitute(var)
  rm(list="var", inherits=TRUE)
  .Call("recycle_by_name", as.character(name), parent.frame(), PACKAGE="recycle")
}

recycle <- nab

recycle_by_name <- function(name) {
  .Call("recycle_by_name", as.character(name), parent.frame(), PACKAGE="recycle")
}
