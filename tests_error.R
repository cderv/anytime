years <- seq(1920, 1000, by = -1)

try_conversion <- function(years) {
    error <- FALSE
    for(year in years) {
        message("Year: ", year)
        res <- tryCatch(
            callr::r(function(year) anytime::anytime(paste0(year, "-01-01 00:00:00")), args = list(year = year)),
            error = function(cnd) {
                error <<- TRUE
                message("Error for year ", year)
            })
        if (error) {
                stop("Error found for year : ", year, call. = FALSE)
        }
        message("-> Result: ", res, " and TZ = ", lubridate::tz(res))
    }
    "no error"
}

try_conversion(years)

## Try with dates
years <- 2999:3002
months <- stringr::str_pad(1:12, 2, pad = 0)
days <- stringr::str_pad(1:28, 2, pad = 0)
dates <- tidyr::crossing(years, months, days)
dates <- glue::glue_data(dates, "{years}-{months}-{days}")

try_conversion_date <- function(dates) {
    error <- FALSE
    for(date in dates) {
        message("dates: ", date)
        res <- tryCatch(
            callr::r(function(date) anytime::anytime(date), args = list(date = date)),
            error = function(cnd) {
                error <<- TRUE
                message("Error for date ", date)
            })
        if (error) {
            stop("Error found for date : ", date, call. = FALSE)
        }
        message("-> Result: ", res, " and TZ = ", lubridate::tz(res))
    }
    "no error"
}

try_conversion_date(dates)
try_conversion_date(test)

try_conversion_date(seq(32535212400, by = 3600, length.out = 1000))

## Synthese
callr::r(function() anytime::anytime("3001-01-01 08:59:59"))
callr::r(function() anytime::anytime("3001-01-01 09:00:00"))
callr::r(function() anytime::anytime("3001-01-01 08:59:59", tz = "UTC"))
callr::r(function() anytime::anytime("3001-01-01 09:00:00", tz = "UTC"))
callr::r(function() anytime::anytime("3001-01-01 07:59:59", asUTC = TRUE))
callr::r(function() anytime::anytime("3001-01-01 08:00:00", asUTC = TRUE))
Sys.setenv(TZ="UTC")
callr::r(function() anytime::anytime("3001-01-01 07:59:59"))
callr::r(function() anytime::anytime("3001-01-01 08:00:00"))
Sys.unsetenv("TZ")
