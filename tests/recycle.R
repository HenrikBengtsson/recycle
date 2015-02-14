library("recycle")

message("TEST #1: Using recycle() to remove a variable (in global)")
x <- 1
stopifnot(exists("x", inherits=FALSE))

x <- 1
rm(list="x", inherits=TRUE)
stopifnot(!exists("x", inherits=FALSE))

x <- 1
recycle(x)
stopifnot(!exists("x", inherits=FALSE))


local({
  message("TEST #2: Using recycle() to remove a variable (in local)")
  x <- 1
  stopifnot(exists("x", inherits=FALSE))

  x <- 1
  rm(list="x", inherits=TRUE)
  stopifnot(!exists("x", inherits=FALSE))

  x <- 1
  recycle(x)
  stopifnot(!exists("x", inherits=FALSE))
})


message("TEST #3: Using recycle() to remove a variable (in function)")
foo <- function() {
  x <- 1
  stopifnot(exists("x", inherits=FALSE))

  x <- 1
  rm(list="x", inherits=TRUE)
  stopifnot(!exists("x", inherits=FALSE))

  x <- 1
  recycle(x)
  stopifnot(!exists("x", inherits=FALSE))
  ls()
}
names <- foo()
stopifnot(length(names) == 0L)


message("TEST #3: Using rm() to remove an argument in function")
foo <- function(x=1) {
  stopifnot(exists("x", inherits=FALSE))

  rm(list="x", inherits=TRUE)
  stopifnot(!exists("x", inherits=FALSE))
  ls()
}
names <- foo()
stopifnot(length(names) == 0L)



message("TEST #3: Using recycle() to remove an argument in function")
foo <- function(x=1) {
  stopifnot(exists("x", inherits=FALSE))

  recycle(x)
  stopifnot(!exists("x", inherits=FALSE))
  ls()
}
names <- foo()
stopifnot(length(names) == 0L)
