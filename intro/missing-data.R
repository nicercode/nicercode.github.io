## ---
## layout: page
## title: "Missing data"
## date: 2013-03-18 10:25
## comments: true
## sharing: true
## footer: false
## ---

## Missing data are a fact of life in biology.  Individuals die,
## equipment breaks, you forget to measure something, you can't read
## your writing, etc.

## If you load in data with blank cells, they will appear as an `NA`
## value.
data <- read.csv("data/seed_root_herbivores.csv")

## Some data to play with.
x <- data$Height[1:10]

## If the 5th element was missing
x[5] <- NA

## This is what it would look like:
x

## Note that this is *not* a string "NA"; that is something different
## entirely.

## Treat a missing value as a number that could stand in for
## anything.  So what is
##+eval=FALSE
1 + NA
1 * NA
NA + NA

## These are all NA because if the input could be anything, the output
## could be anything.

## What is the value of this:
##+ eval=FALSE
mean(x)

## It's `NA` too because `x[1] + x[2] + NA + ...` must be `NA`.  And
## then `NA/length(x)` is also `NA`.

## This is a pretty common situation for data, so the mean function
## takes an `na.rm` argument
mean(x, na.rm=TRUE)

## `sum` takes the same argument too:
sum(x, na.rm=TRUE)

## Be careful though:
sum(x, na.rm=TRUE) / length(x) # not the mean!
mean(x, na.rm=TRUE)

## The `na.omit` function will strip out all NA values:
na.omit(x)
## So we can do this:
length(na.omit(x))

## You can't test for `NA`-ness with `==`:
x == NA
## (why not?)

## Use `is.na` instead:
is.na(x)

## So `na.omit` is (roughly) equivalent to
x[!is.na(x)]

## ## Excercise

## Our standard error function doesn't deal well with missing values:
standard.error <- function(x) {
  v <- var(x)
  n <- length(x)
  sqrt(v / n)
}

## Can you write one that always filters missing values?

## If we get time, we'll talk about how to write one that optionally
## gets rid of missing values.

## ## Other special values:

## Positive and negative infinities
1 / 0
-1 / 0

## Not a number (different to `NA`, but usually treatable the same
## way).
0/0

## We saw `NULL` before.  It's the weirdest.
