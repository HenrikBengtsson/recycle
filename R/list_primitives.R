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
list_primitives <- function(names=TRUE) {
  ns <- getNamespace("methods")
  .BasicFunsList <- get(".BasicFunsList", mode="list", envir=ns)

  if (names) {
    vars <- names(.BasicFunsList)
    vars <- sort(vars)
  } else {
    envir <- baseenv()
    vars <- lapply(names(.BasicFunsList), FUN=function(name) {
      get(name, mode="function", envir=envir)
    })
    names(vars) <- names(.BasicFunsList)
  }

  vars
}
