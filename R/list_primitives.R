#' Lists all primitives in R
#'
#' @param names If TRUE, names are returned, otherwise functions.
#'
#' @return A character vector or a list of functions.
#'
#' @details
#' This functions uses \code{methods:::.BasicFunsList}.
#'
#' @export
list_primitives <- function(names=FALSE) {
  ns <- getNamespace("methods")
  .BasicFunsList <- get(".BasicFunsList", mode="list", envir=ns)
  vars <- names(.BasicFunsList)

  if (!names) {
    envir <- baseenv()
    vars <- lapply(vars, FUN=function(name) {
      get(name, mode="function", envir=envir)
    })
  }

  vars
}
