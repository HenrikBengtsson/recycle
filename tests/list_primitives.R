library("recycle")

names <- list_primitives(names=TRUE)
str(names)

funs <- list_primitives(names=FALSE)
str(head(funs))
str(tail(funs))
stopifnot(all(sapply(funs, FUN=is.function)))
stopifnot(all(sapply(funs, FUN=is.primitive)))
