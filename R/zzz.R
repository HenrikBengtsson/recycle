.onUnload <- function (libpath) {
  library.dynam.unload("recycle", libpath)
}

.onLoad <- function(libname, pkgname) {
}

.onAttach <- function(libname, pkgname) {
}
