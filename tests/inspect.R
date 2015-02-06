library("recycle")

message("TEST #1: address()")
x <- 1; x[1] <- 1
message(ax0 <- address(x))
x[1] <- 2
message(ax1 <- address(x))
stopifnot(ax1 == ax0)
message(ax2 <- address(x))
stopifnot(ax2 == ax1)



message("TEST #2: named()")
x <- 1; x[1] <- 1
message(named0 <- named(x))
message(named1 <- named(x))
stopifnot(named1 == named0)
message(ax1 <- address(x))
message(named2 <- named(x))
stopifnot(named2 == named1)
