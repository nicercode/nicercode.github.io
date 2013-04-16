---
layout: page
title: "Writing functions"
date: 2013-03-18 10:25
comments: true
sharing: true
footer: false
---

At some point, you will want to write a function, and it will
probably be sooner than you think.  Functions are core to the way
that R works, and the sooner that you get comfortable writing them,
the sooner you'll be able to leverage R's power, and start having
fun with it.

The first function most people seem to need to write is to compute
the standard error of the mean for some variable.  This is defined
as $\sqrt{\mathrm{var}(x)/n}$ (that is the square root of the
variance divided by the sample size.

Start by reloading our data set again.

```r
data <- read.csv("data/seed_root_herbivores.csv")
```


We can already easily compute the mean

```r
mean(data$Height)
```

```
## [1] 55.54
```


and the variance

```r
var(data$Height)
```

```
## [1] 250.6
```


and the sample size

```r
length(data$Height)
```

```
## [1] 169
```


so it seems easy to compute the standard error:

```r
sqrt(var(data$Height)/length(data$Height))
```

```
## [1] 1.218
```


notice how `data$Height` is repeated there --- not desirable.

Suppose we now want the standard error of the dry weight too:

```r
sqrt(var(data$Weight)/length(data$Weight))
```

```
## [1] 0.7616
```


This is basically identical to the height case above.  We've copied
and pasted the definition and replaced the variable that we are
interested in.  This sort of substitution is tedious and error
prone, and the sort of things that computers are a lot better at
doing reliably than humans are.

It is also just not that clear from what is written what the
*point* of these lines is.  Later on, you'll be wondering what
those lines are doing.

Look more carefully at the two statements and see the similarity in
form, and what is changing between them.  This pattern is the key
to writing functions.

```r
sqrt(var(data$Height)/length(data$Height))
sqrt(var(data$Weight)/length(data$Weight))
```


Here is the syntax for defining a function, used to make a standard
error function:

```r
standard.error <- function(x) {
    sqrt(var(x)/length(x))
}
```


The result of the last line is "returned" from the function.

We can call it like this:

```r
standard.error(data$Height)
```

```
## [1] 1.218
```

```r
standard.error(data$Weight)
```

```
## [1] 0.7616
```


Note that `x` has a special meaning within the curly braces.  If we
do this:

```r
x <- 1:100
standard.error(data$Height)
```

```
## [1] 1.218
```


we get the same answer.  Because `x` appears in the "argument
list", it will be treated specially.  Note also that it is
completely unrelated to the name of what is provided as value to
the function.

You can define variables within functions

```r
standard.error <- function(x) {
    v <- var(x)
    n <- length(x)
    sqrt(v/n)
}
```

This can often help you structure your function and your thoughts.

These are also treated specially --- they do not affect the main
workspace (the "global environment") and are destroyed when the
function ends.  If you had some value `v` in the global
environment, it would be ignored in this function as soon as the
local `v` was defined, with the local definition used instead.

```r
v <- 1000
standard.error(data$Height)
```

```
## [1] 1.218
```


Another example.

We used the variance function above, but let's rewrite it.
The sample variance is defined as
$$\frac{1}{n-1}\left(\sum_{i=1}^n (x_i - \bar x)^2 \right)$$

This case is more compliated, so we'll do it in pieces.

We're going to use `x` for the argument, so name our first input
data `x` so we can use it.

```r
x <- data$Height
```


The first term is easy:

```r
n <- length(x)
(1/(n - 1))
```

```
## [1] 0.005952
```


The second term is harder.  We want the difference between all the
`x` values and the mean.

```r
m <- mean(x)
x - m
```

```
##   [1] -24.5444 -14.5444 -13.5444   8.4556  -8.5444  -3.5444   1.4556
##   [8] -28.5444 -15.5444 -22.5444  -4.5444 -14.5444 -17.5444   5.4556
##  [15]  -9.5444 -21.5444  -5.5444  -4.5444 -22.5444 -14.5444  11.4556
##  [22] -25.5444  -7.5444 -18.5444   5.4556  -5.5444 -11.5444  -5.5444
##  [29] -10.5444  10.4556  20.4556  21.4556   4.4556  26.4556   5.4556
##  [36]  16.4556 -18.5444  -6.5444  16.4556   9.4556  -4.5444  21.4556
##  [43]   3.4556  11.4556 -13.5444 -22.5444 -16.5444 -12.5444 -14.5444
##  [50]   2.4556  -8.5444 -27.5444  -0.5444 -15.5444 -39.5444  -1.5444
##  [57]   1.4556  -9.5444 -25.5444 -19.5444   3.4556 -10.5444 -28.5444
##  [64]  -2.5444  16.4556 -11.5444  -1.5444  13.4556  28.4556 -15.5444
##  [71]   3.4556 -14.5444  33.4556 -13.5444  -0.5444  11.4556  -5.5444
##  [78]  -8.5444  -7.5444 -17.5444  -5.5444   3.4556  -9.5444 -23.5444
##  [85] -12.5444 -18.5444 -17.5444  15.4556  18.4556   1.4556  -9.5444
##  [92]   6.4556  -4.5444  -9.5444  -0.5444  14.4556  34.4556  19.4556
##  [99]   0.4556  14.4556   5.4556   1.4556   3.4556   7.4556   3.4556
## [106] -13.5444 -32.5444  -8.5444 -23.5444  -2.5444  24.4556  24.4556
## [113] -10.5444   8.4556  28.4556   4.4556 -12.5444 -19.5444  -4.5444
## [120] -11.5444  -3.5444   0.4556  17.4556   8.4556 -14.5444 -10.5444
## [127]  38.4556  17.4556   5.4556  11.4556  21.4556  -5.5444  11.4556
## [134]  41.4556  11.4556   6.4556  20.4556  12.4556  32.4556   8.4556
## [141]   1.4556  -4.5444  -5.5444   9.4556  -9.5444   7.4556  24.4556
## [148]  -1.5444   4.4556  -1.5444  -7.5444   0.4556   4.4556  -5.5444
## [155]  24.4556  15.4556  18.4556  -9.5444 -15.5444   8.4556 -10.5444
## [162]  12.4556  13.4556  27.4556  41.4556  23.4556  15.4556  -7.5444
## [169]  18.4556
```


Then we want to square those differences:

```r
(x - m)^2
```

```
##   [1]  602.4265  211.5390  183.4502   71.4975   73.0064   12.5626    2.1188
##   [8]  814.7816  241.6277  508.2490   20.6514  211.5390  307.8052   29.7638
##  [15]   91.0952  464.1603   30.7401   20.6514  508.2490  211.5390  131.2313
##  [22]  652.5153   56.9176  343.8940   29.7638   30.7401  133.2727   30.7401
##  [29]  111.1839  109.3200  418.4324  460.3437   19.8526  699.8999   29.7638
##  [36]  270.7875  343.8940   42.8289  270.7875   89.4088   20.6514  460.3437
##  [43]   11.9413  131.2313  183.4502  508.2490  273.7165  157.3614  211.5390
##  [50]    6.0301   73.0064  758.6928    0.2963  241.6277 1563.7579    2.3851
##  [57]    2.1188   91.0952  652.5153  381.9827   11.9413  111.1839  814.7816
##  [64]    6.4739  270.7875  133.2727    2.3851  181.0537  809.7224  241.6277
##  [71]   11.9413  211.5390 1119.2786  183.4502    0.2963  131.2313   30.7401
##  [78]   73.0064   56.9176  307.8052   30.7401   11.9413   91.0952  554.3378
##  [85]  157.3614  343.8940  307.8052  238.8762  340.6100    2.1188   91.0952
##  [92]   41.6750   20.6514   91.0952    0.2963  208.9650 1187.1898  378.5212
##  [99]    0.2076  208.9650   29.7638    2.1188   11.9413   55.5863   11.9413
## [106]  183.4502 1059.1366   73.0064  554.3378    6.4739  598.0774  598.0774
## [113]  111.1839   71.4975  809.7224   19.8526  157.3614  381.9827   20.6514
## [120]  133.2727   12.5626    0.2076  304.6987   71.4975  211.5390  111.1839
## [127] 1478.8348  304.6987   29.7638  131.2313  460.3437   30.7401  131.2313
## [134] 1718.5685  131.2313   41.6750  418.4324  155.1425 1053.3674   71.4975
## [141]    2.1188   20.6514   30.7401   89.4088   91.0952   55.5863  598.0774
## [148]    2.3851   19.8526    2.3851   56.9176    0.2076   19.8526   30.7401
## [155]  598.0774  238.8762  340.6100   91.0952  241.6277   71.4975  111.1839
## [162]  155.1425  181.0537  753.8111 1718.5685  550.1662  238.8762   56.9176
## [169]  340.6100
```


and compute the sum:

```r
sum((x - m)^2)
```

```
## [1] 42108
```


Watch that you don't do this, which is quite different

```r
sum(x - m)^2
```

```
## [1] 1.022e-25
```

(this follows from the definition of the mean)

Putting both halves together, the variance is

```r
(1/(n - 1)) * sum((x - m)^2)
```

```
## [1] 250.6
```


Which agrees with R's variance function

```r
var(x)
```

```
## [1] 250.6
```


The `rm` function cleans up:

```r
rm(n, x, m)
```


We can then define our function, using the pieces that we wrote above.

```r
variance <- function(x) {
    n <- length(x)
    m <- mean(x)
    (1/(n - 1)) * sum((x - m)^2)
}
```


And test it:

```r
variance(data$Height)
```

```
## [1] 250.6
```

```r
var(data$Height)
```

```
## [1] 250.6
```

```r

variance(data$Weight)
```

```
## [1] 98.02
```

```r
var(data$Weight)
```

```
## [1] 98.02
```


### An aside on floating point comparisons:
Our function does not exactly agree with R's function

```r
variance(data$Height) == var(data$Height)
```

```
## [1] FALSE
```


This is not because one is more accurate than the other, it is
because "machine precision" is finite (that is, the number of
decimal places being kept).

```r
variance(data$Height) - var(data$Height)
```

```
## [1] 2.842e-14
```


This affects all sorts of things:

```r
sqrt(2) * sqrt(2)  # looks like 2
```

```
## [1] 2
```

```r
sqrt(2) * sqrt(2) - 2  # but not quite
```

```
## [1] 4.441e-16
```


So be careful with `==` for floating point comparisons.  Usually
you have do something like:

```r
abs(x - y) < eps
```

For some small value `eps`.  The `all.equal` function can be very
helpful here.

### Exercise: define a function to compute skew

Skewness is a measure of asymmetry of a probability distribution.

It can be defined as

$$ \frac{\frac{1}{n-2}\left(\sum_{i=1}^n(x_i - \bar x)^3\right)}
        {\mathrm{var}(x)^{3/2}} $$

Write a function that computes the skewness.

Hints:

* Don't try to do this in one step, but use intermediate variables
  like the second version of `standard.error`, or like our
  `variance` function.

```r
##
```

* The term on the top of the fraction is a lot like the `variance`
  function.
  
* Remember that parentheses can help with order-of-operation
  control.
  
* Get the pieces of your function working before putting it all
  together.

```r
skewness <- function(x) {
    n <- length(x)
    v <- var(x)
    m <- mean(x)
    third.moment <- (1/(n - 2)) * sum((x - m)^3)
    third.moment/(var(x)^(3/2))
}

skewness(data$Height)  # should be 0.301
```

```
## [1] 0.3011
```

```r
skewness(data$Weight)  # should be 1.954
```

```
## [1] 1.954
```


---
Back to [main page](/intro)
