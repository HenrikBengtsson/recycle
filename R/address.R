#' Gets the internal memory address of a variable
#'
#' @param var A variable
#' @return A character string
#'
#' @export
#' @useDynLib recycle
address <- function(var) {
  name <- substitute(var)
  expr <- substitute(.Internal(inspect(name)), list(name=name))

  con <- textConnection("info", open="w")
  on.exit(close(con))
  sink(con)
  eval(expr, envir=parent.frame())
  sink()

  info <- gsub("@", "", gsub(" .*", "", info))
  info
}
