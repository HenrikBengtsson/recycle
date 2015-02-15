#' Removes variable but recycles its value iff possible
#'
#' @param var A variable
#' @return The value of the recycled variable
#'
#' @examples
#' ## Creates a variable
#' x <- rnorm(1e6); x[1] <- 1
#' print(ax <- address(x))
#' ## Removes the variable, but recycle its values (iff possible)
#' y <- recycle(x)
#' print(ay <- address(y))
#' stopifnot(ay == ax)
#'
#' @aliases r
#' @export
#' @export r
#' @useDynLib recycle
recycle <- function(var) {
  name <- substitute(var)
  .Call("recycle_by_name", as.character(name), parent.frame(), PACKAGE="recycle")
}

r <- recycle
