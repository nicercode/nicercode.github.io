---
layout: page
title: "Missing data"
date: 2013-03-18 10:25
comments: true
sharing: true
footer: false
---

Missing data are a fact of life in biology.  Individuals die,
equipment breaks, you forget to measure something, you can't read
your writing, etc.

If you load in data with blank cells, they will appear as an `NA`
value.

```r
data <- read.csv("data/seed_root_herbivores.csv")
```


Some data to play with.

```r
x <- data$Height[1:10]
```


If the 5th element was missing

```r
x[5] <- NA
```


This is what it would look like:

```r
x
```

```
##  [1] 31 41 42 64 NA 52 57 27 40 33
```


Note that this is *not* a string "NA"; that is something different
entirely.

Treat a missing value as a number that could stand in for
anything.  So what is

```r
1 + NA
1 * NA
NA + NA
```


These are all NA because if the input could be anything, the output
could be anything.

What is the value of this:

```r
mean(x)
```


It's `NA` too because `x[1] + x[2] + NA + ...` must be `NA`.  And
then `NA/length(x)` is also `NA`.

This is a pretty common situation for data, so the mean function
takes an `na.rm` argument

```r
mean(x, na.rm = TRUE)
```

```
## [1] 43
```


`sum` takes the same argument too:

```r
sum(x, na.rm = TRUE)
```

```
## [1] 387
```


Be careful though:

```r
sum(x, na.rm = TRUE)/length(x)  # not the mean!
```

```
## [1] 38.7
```

```r
mean(x, na.rm = TRUE)
```

```
## [1] 43
```


The `na.omit` function will strip out all NA values:

```r
na.omit(x)
```

```
## [1] 31 41 42 64 52 57 27 40 33
## attr(,"na.action")
## [1] 5
## attr(,"class")
## [1] "omit"
```

So we can do this:

```r
length(na.omit(x))
```

```
## [1] 9
```


You can't test for `NA`-ness with `==`:

```r
x == NA
```

```
##  [1] NA NA NA NA NA NA NA NA NA NA
```

(why not?)

Use `is.na` instead:

```r
is.na(x)
```

```
##  [1] FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE
```


So `na.omit` is (roughly) equivalent to

```r
x[!is.na(x)]
```

```
## [1] 31 41 42 64 52 57 27 40 33
```


## Excercise

Our standard error function doesn't deal well with missing values:

```r
standard.error <- function(x) {
    v <- var(x)
    n <- length(x)
    sqrt(v/n)
}
```


Can you write one that always filters missing values?

If we get time, we'll talk about how to write one that optionally
gets rid of missing values.

## Other special values:

Positive and negative infinities

```r
1/0
```

```
## [1] Inf
```

```r
-1/0
```

```
## [1] -Inf
```


Not a number (different to `NA`, but usually treatable the same
way).

```r
0/0
```

```
## [1] NaN
```


We saw `NULL` before.  It's the weirdest.
