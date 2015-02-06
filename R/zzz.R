.onUnload <- function (libpath) {
  library.dynam.unload("recycle", libpath)
}
