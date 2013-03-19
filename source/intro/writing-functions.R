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
## as $\sqrt{\mathrm{var}(x)/n}$ (that is the square root of the
## variance divided by the sample size.

## Start by reloading our data set again.
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

## The result of the last line is "returned" from the function.

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
## This can often help you structure your function and your thoughts.

## These are also treated specially --- they do not affect the main
## workspace (the "global environment") and are destroyed when the
## function ends.  If you had some value `v` in the global
## environment, it would be ignored in this function as soon as the
## local `v` was defined, with the local definition used instead.
v <- 1000
standard.error(data$Height)

## Another example.

## We used the variance function above, but let's rewrite it.
## The sample variance is defined as
## $$\frac{1}{n-1}\left(\sum_{i=1}^n (x_i - \bar x)^2 \right)$$

## This case is more compliated, so we'll do it in pieces.

## We're going to use `x` for the argument, so name our first input
## data `x` so we can use it.
x <- data$Height

## The first term is easy:
n <- length(x)
(1 / (n-1))

## The second term is harder.  We want the difference between all the
## `x` values and the mean.
m <- mean(x)
x - m

## Then we want to square those differences:
(x - m)^2

## and compute the sum:
sum((x - m)^2)

## Watch that you don't do this, which is quite different
sum(x - m)^2
## (this follows from the definition of the mean)

## Putting both halves together, the variance is
(1 / (n-1)) * sum((x - m)^2)

## Which agrees with R's variance function
var(x)

## The `rm` function cleans up:
rm(n, x, m)

## We can then define our function, using the pieces that we wrote above.
variance <- function(x) {
  n <- length(x)
  m <- mean(x)
  (1 / (n-1)) * sum((x - m)^2)
}

## And test it:
variance(data$Height)
var(data$Height)

variance(data$Weight)
var(data$Weight)

## ### An aside on floating point comparisons:
## Our function does not exactly agree with R's function
variance(data$Height) == var(data$Height)

## This is not because one is more accurate than the other, it is
## because "machine precision" is finite (that is, the number of
## decimal places being kept).
variance(data$Height) - var(data$Height)

## This affects all sorts of things:
sqrt(2) * sqrt(2)     # looks like 2
sqrt(2) * sqrt(2) - 2 # but not quite

## So be careful with `==` for floating point comparisons.  Usually
## you have do something like:
##+ eval=FALSE
abs(x - y) < eps
## For some small value `eps`.  The `all.equal` function can be very
## helpful here.

## ### Exercise: define a function to compute skew

## Skewness is a measure of asymmetry of a probability distribution.

## It can be defined as
## 
## $$ \frac{\frac{1}{n-2}\left(\sum_{i=1}^n(x_i - \bar x)^3\right)}
##         {\mathrm{var}(x)^{3/2}} $$

## Write a function that computes the skewness.

## Hints:
## 
## * Don't try to do this in one step, but use intermediate variables
##   like the second version of `standard.error`, or like our
##   `variance` function.
##
## * The term on the top of the fraction is a lot like the `variance`
##   function.
##   
## * Remember that parentheses can help with order-of-operation
##   control.
##   
## * Get the pieces of your function working before putting it all
##   together.
skewness <- function(x) {
  n <- length(x)
  v <- var(x)
  m <- mean(x)
  third.moment <- (1 / (n-2)) * sum((x - m)^3)
  third.moment / (var(x)^(3/2))
}

skewness(data$Height) # should be 0.301
skewness(data$Weight) # should be 1.954

## ---
## Back to [main page](/intro)
