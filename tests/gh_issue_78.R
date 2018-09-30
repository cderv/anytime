
## https://github.com/eddelbuettel/anytime/issues/78 as well as
## https://github.com/eddelbuettel/anytime/issues/76

library(anytime)

anydate("3003-01-01")    # crashed on Windows before tm_isdst disable for post 3002 years

stopifnot(anydate("3003-01-01") == as.Date("3003-01-01"))
