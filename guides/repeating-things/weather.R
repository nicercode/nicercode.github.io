## 1. Create the data:

library(RCurl)
library(rjson)

url.base <- function()
  "http://api.openweathermap.org/data"

city.to.id <- function(city, country="AU") {
  url <- sprintf("%s/2.5/find?q=%s", url.base(), city)
  res <- fromJSON(getURLContent(url))
  if (!is.null(country)) {
    ok <- sapply(res$list, function(x) x$sys$country %in% country)
    res$list <- res$list[ok]
  }

  n <- length(res$list)
  if (n < 1)
    stop("Failed to find information for city", city)
  if (n > 1)
    warning("More than one possible hit, returning first")
  res$list[[1]]$id
}

from.kelvin <- function(x) x - 273.15

past.weather <- function(id, by="day", n=30) {
  by <- match.arg(by, c("day", "hour", "tick"))
  url <- sprintf("%s/2.1/history/city/?id=%d?type=%s&cnt=%d",
                 url.base(), id, by, n)
  res <- fromJSON(getURLContent(url))

  dat <- res$list
  temp <- t(sapply(dat, function(x)
                   from.kelvin(c(temp=x$main$temp,
                                 temp.min=x$main$temp_min,
                                 temp.max=x$main$temp_max))))
  time <- as.POSIXct(sapply(dat, function(x) x$dt),
                     origin="1970-01-01", tz="UTC+10")
  data.frame(time=time, temp)
}

cities <- c("Melbourne", "Sydney", "Brisbane", "Cairns")
ids <- sapply(cities, city.to.id)

res <- lapply(ids, past.weather, n=100)
names(res) <- cities

path <- "data"
dir.create(path, recursive=TRUE, showWarnings=FALSE)
for (city in cities)
  write.csv(res[[city]], file.path(path, paste0(city, ".csv")),
            row.names=FALSE)


######################################################################

## 2. Use the data:

## Use the data:
download.maybe <- function(url, refetch=FALSE, path=".") {
  dest <- file.path(path, basename(url))
  if (refetch || !file.exists(dest))
    download.file(url, dest)
  dest
}

path <- "data"
dir("data")

cities <- c("Melbourne", "Sydney", "Brisbane", "Cairns")

## could download file:
urls <-
  sprintf("http://nicercode.github.io/guides/repeating-things/data/%s.csv",
          cities)

## Download all the csv files from the urls
files <- sapply(urls, download.maybe, path=path)
names(files) <- cities

load.file <- function(filename) {
  d <- read.csv(filename, stringsAsFactors=FALSE)
  d$time <- as.POSIXlt(d$time)
  d
}

data <- lapply(files, load.file)

## How many rows of data per city?
sapply(data, nrow)

## What is the hottest temperature recorded by city?
sapply(data, function(x) max(x$temp))

## Fit a series of autocorrelation models to each city
autocor <- lapply(data, function(x) acf(x$temp, lag.max=24))
plot(autocor$Sydney)
plot(autocor$Cairns)

## For loops can be easier to plot data:
xlim <- range(sapply(data, function(x) range(x$time)))
ylim <- range(sapply(data, function(x) range(x[-1])))
plot(data[[1]]$time, data[[1]]$temp, ylim=ylim, type="n",
     xlab="Time", ylab="Temperature")
for (x in data)
  lines(x$time, x$temp)

## But mapply can be fun too:
mapply(function(x, col)
       polygon(c(x$time, rev(x$time)), c(x$temp.min, rev(x$temp.max)),
               col=col),
       data, c("#ff000066", "#00ff0066", "#0000ff66", "#00000066"))

