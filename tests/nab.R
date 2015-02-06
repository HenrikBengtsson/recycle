library("recycle")

message("TEST #1: Using nab() to remove a variable (in global)")
x <- 1
stopifnot(exists("x", inherits=FALSE))

x <- 1
rm(list="x", inherits=TRUE)
stopifnot(!exists("x", inherits=FALSE))

x <- 1
nab(x)
stopifnot(!exists("x", inherits=FALSE))


local({
  message("TEST #2: Using nab() to remove a variable (in local)")
  x <- 1
  stopifnot(exists("x", inherits=FALSE))

  x <- 1
  rm(list="x", inherits=TRUE)
  stopifnot(!exists("x", inherits=FALSE))

  x <- 1
  nab(x)
  stopifnot(!exists("x", inherits=FALSE))
})


message("TEST #3: Using nab() to remove a variable (in function)")
foo <- function() {
  x <- 1
  stopifnot(exists("x", inherits=FALSE))

  x <- 1
  rm(list="x", inherits=TRUE)
  stopifnot(!exists("x", inherits=FALSE))

  x <- 1
  nab(x)
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



message("TEST #3: Using nab() to remove an argument in function")
foo <- function(x=1) {
  stopifnot(exists("x", inherits=FALSE))

  nab(x)
  stopifnot(!exists("x", inherits=FALSE))
  ls()
}
names <- foo()
stopifnot(length(names) == 0L)
