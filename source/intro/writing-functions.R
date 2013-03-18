## ---
## layout: page
## title: "Writing functions"
## date: 2013-03-18 10:25
## comments: true
## sharing: true
## footer: false
## ---

## At some point, you will want to write a function, and it will
## probably be sooner than you think.  Functions are core to the way
## that R works, and the sooner that you get comfortable writing them,
## the sooner you'll be able to leverage R's power, and start having
## fun with it.

## The first function most people seem to need to write is to compute
## the standard error of the mean for some variable.  This is defined
## as $\sqrt{\var(x)/n}$ (that is the square root of the variance
## divided by the sample size.

data <- read.csv("data/seed_root_herbivores.csv")

## We can already easily compute the mean
mean(data$Height)

## and the variance
var(data$Height)

## and the sample size
length(data$Height)

## so it seems easy to compute the standard error:
sqrt(var(data$Height) / length(data$Height))

## notice how `data$Height` is repeated there --- not desirable.

## Suppose we now want the standard error of the dry weight too:
sqrt(var(data$Weight) / length(data$Weight))

## This is basically identical to the height case above.  We've copied
## and pasted the definition and replaced the variable that we are
## interested in.  This sort of substitution is tedious and error
## prone, and the sort of things that computers are a lot better at
## doing reliably than humans are.

## It is also just not that clear from what is written what the
## *point* of these lines is.  Later on, you'll be wondering what
## those lines are doing.

## Look more carefully at the two statements and see the similarity in
## form, and what is changing between them.  This pattern is the key
## to writing functions.
##+ eval=FALSE
sqrt(var(data$Height) / length(data$Height))
sqrt(var(data$Weight) / length(data$Weight))

## Here is the syntax for defining a function, used to make a standard
## error function:
standard.error <- function(x) {
  sqrt(var(x) / length(x))
}

## We can call it like this:
standard.error(data$Height)
standard.error(data$Weight)

## Note that `x` has a special meaning within the curly braces.  If we
## do this:
x <- 1:100
standard.error(data$Height)

## we get the same answer.  Because `x` appears in the "argument
## list", it will be treated specially.  Note also that it is
## completely unrelated to the name of what is provided as value to
## the function.

## You can define variables within functions

standard.error <- function(x) {
  v <- var(x)
  n <- length(x)
  sqrt(v / n)
}

## These are also treated specially --- they do not affect the main
## workspace (the "global environment") and are destroyed when the
## function ends.  However, if you had some value `v` in the global
## environment, it would be ignored in this function now, as the
## *local* definition of `v` is used.
v <- 1000
standard.error(data$Height)

### Exercise: define a function to compute skew

## Skewness is a measure of asymmetry of a probability distribution.

## It can be defined as
##
## $$ \frac{\frac{1}{n-2}(\sum_{i=0}{n}(x_i - \bar x))^3}{
##    \var(x) $$
