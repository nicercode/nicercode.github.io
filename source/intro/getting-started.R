## ---
## layout: page
## title: "Getting started"
## date: 2013-03-18 10:25
## comments: true
## sharing: true
## footer: false
## ---

### Set options
##+ echo=FALSE,results=FALSE
source("global_options.R")

## ## Using R as a calculator

## The simplest thing you could do with R is do arithmetic:
1 + 100

## Here, we've added 1 and and 100 together to make 101.  The `[1]`
## preceeding this we will explain in a minute.  For now, think of it
## as something that indicates output.

## Order of operations is same as in maths class (from highest to
## lowest precedence)

##   - Brackets
##   - Exponents
##   - Divide
##   - Multiply
##   - Add
##   - Subtract

## What will this evaluate to?
##+ eval=FALSE
3 + 5 * 2

## The "caret" symbol (or "hat") is the exponent (to-the-power-of)
## operator (read `x ^ y` as "`x` to the power of `y`").  What will
## this evaluate to?
##+ eval=FALSE
3 + 5 * 2 ^ 2

## Use brackets (actually parentheses) to group to force the order of
## evaluation if it differs from the default, or to set your own order.
(3 + 5) * 2

## But this can get unweidly when not needed:
##+ eval=FALSE
(3 + (5 * (2 ^ 2))) # hard to read
3 + 5 * 2 ^ 2       # easier to read, once you know rules
3 + 5 * (2 ^ 2)     # if you forget some rules, this might help

## See `?Arithmetic` for more information, and two more operators (you
## can also get there by `?"+"` (note the quotes)

## If R thinks that the statement is incomplete, it will change the
## prompt from `>` to `+` indicating that it is expecting more input.
## This is *not* an addition sign!  Press "`Esc`" if you want to
## cancel this statement and return to the prompt.

## The usual sort of comparison operators are available:
1 == 1  # equality (note two equals signs, read as "is equal to")
1 != 2  # inequality (read as "is not equal to")
1 <  2  # less than
1 <= 1  # less than or equal to
1 >  0  # greater than
1 >= -9 # greater than or equal to

## See `?Comparison` for more information (you can also get there by
## `help("==")`.

## Really small numbers get a scientific notation:
2/10000
## which you can write in too:
2e-04
## Read `e-XX` as "multiplied by `10^XX`", so `2e-4` is `2 * 10^(-4)`.

## ## Mathematical functions

## R has many built in mathematical functions that will work as you
## would expect:
sin(1)  # trig functions
asin(1) # inverse sin (also for cos and tan)
log(1)  # natural logarithm
log10(10) # base-10 logarithm
log2(100) # base-2 logarithm
exp(0.5) # e^(1/2)

## Plus things like probability density functions for many common
## distributions, and other mathematical functions (e.g., Gamma, Beta,
## Bessel).  If you need it, it's probably there.

## ## Variables and assignment
## You can assign values to variables using the assignment operator
## `<-`, like this:
x <- 1/40

## And now the **variable** `x` contains the **value** `0.025`:
x

## (note that it does not contain the *fraction* 1/40, it contains a
## *decimal approximation* of this fraction.  This appears exact in
## this case, but it is not.  These decimal approximations are called
## "[floating point numbers](http://en.wikipedia.org/wiki/Floating_point)"
## and at some point you will probably end up having to learn more
## about them than you'd like).

## Look up at the top right pane of RStudio, and you'll see that this
## has appeared in the "Workspace" pane.

## Our variable `x` can be used in place of a number in any
## calculation that expects a number.
log(x)
sin(x)

## The right hand side of the assignment can be any valid R
## expression.

## It is also possible to use the `=` operator for assignment:
x = 1/40

## ...but this is much less common among R users.  The most important
## thing is to **be consistent** with the operator you use.  There are
## occasionally places where it is less confusing to use `<-` than
## `=`, and it is the most common symbol used in the community.  So
## I'd recommend `<-`.

## Notice that assignment does not print a value.
x <- 100

## Notice also that variables can be reassigned (`x` used to contain
## the value 0.025 and and now it has the value 100).

## Assignment values can contain the variable being assigned to: What
## will `x` contain after running this?
x <- x + 1

## The right hand side is fully evaluated before the assignment
## occurs.

## Variable names can contain letters, numbers, underscores and
## periods.  The cannot start with a number.  They cannot contain
## spaces at all.  Different people use different conventions for long
## varaible names, these include

##   * periods.between.words
##   * underscores_between_words
##   * camelCaseToSeparateWords

## What you use is up to you, but **be consistent**.

## ### Exercise:

## Compute the difference in years between now and the year that you
## started at Macquarie University.  Divide this by the difference
## between now and the year when you were born.  Multiply this by 100
## to get the percentage of your life spent at university.  Use
## parentheses if you need them, use assignment if you need it.

## This problem is as much about thinking about formalising the
## ingredients of a problem as much as actually getting the syntax
## correct.

## ## Vectors

## R was designed for people who do data analysis.  There is a reason
## why "data" is a more common term than "datum" -- generally you have
## more than one piece of data (although the Guardian
## [argues](http://www.guardian.co.uk/news/datablog/2010/jul/16/data-plural-singular)
## that this distinction is old fashioned).  As a result in R **all**
## data types are actually vectors.  So the number '1' is actually a
## vector of numbers that happens to be of length 1.
1
length(1)

## To build a vector, use the `c` function (`c` stands for
## "concatenate").
x <- c(1, 2, 40, 1234)

## We have assigned this vector to the variable `x`.
x
length(x)

## (notice how RStudio has updated its description of `x`.  If you
## click it, you'll get an option to alter it, which is rarely what
## you want to do).

## This is a deep piece of engineering in the design; most of R thinks
## quite happily in terms of vectors.  If you wanted to double all the
## values in the vector, just multiply it by 2:
2 * x

## You can get the maximum value...
max(x)

## ...minimum value...
min(x)

## ...sum...
sum(x)

## ...mean value...
mean(x)

## ...and so on.  There are huge numbers of functions that operate on
## vectors.  It is more common that functions will than that they
## won't.

## Vectors can be summed together:
y <- c(0.1, 0.2, 0.3, 0.4)
x + y

## And they can be concatenated together:
c(x, y)

## and scalars can be added to them
x + 0.1

### Through here, perhaps get people to predict what the answer will
### That will make the recycled case more surprising.

## **Be careful** though: if you add/multiply together vectors that
## are of different lengths, but the lengths factor, R will silently
## "recycle" the length of the shorter one:
x
x * c(-2, 2)

## (note how the first and third element have been multiplied by -2
## while the second and fourth element are multiplied by 2).

## If the lengths to not factor (i.e., the length of the shorter
## vector is not a factor of the length of the longer vector) you will
## get a warning, but **the calculation will happen anyway**:
x * c(-2, 0, 2)

## This is almost never what you want.  Pay attention to warnings.
## Note that Warnings are different to Errors.  We just saw a warning,
## where what happened is (probably) undesirable but not fatal.
## You'll get Errors where what happened has been deemed
## unrecoverable.  For example
x + z # fails because there is no variable z

## Just as with the scalars, as well as doing arithemetic operators we
## can do comparisons.  This returns a new vector of `TRUE` and
## `FALSE` indicating which elements are less than 10:
x < 10

## You can do vector-vector comparisons too:
x < y # all false as y is quite small.

## And combined arithmetic operations with comparison operations.
## Both sides of the expression are fully evaluated before the
## comparison takes place.
x > 1/y

## Be careful with comparisons:
## This compares the first element with -20, the second with 20, the
## third with -20 and the fourth with 20.
x >= c(-20, 20)

## This does nothing sensible, really, and warns you again:
x == c(-2, 0, 2)

## All the comparison operators work in fairly predictible ways:
x == 40
x != 2

## Sequences are easy to make, and often useful.  Integer sequences
## can be made with the colon operator:
3:10 # sequence 3, 4, ..., 10

## Which also works backwards
10:3 # the reverse

## Step in different sizes
seq(3, 10, by=2)
seq(3, 10, length=10)

## Now we will see the meaning of the `[1]` term -- this indicates
## that you're looking at the first element of a vector.  If you make
## a really long vector, you'll see new numbers:
seq(3, by=2, length=100)

## ## Exercise:

## One thing you can do with sequences is you can very informally look
## at convergent sequences.  For example, the sum of squares of the
## reciprocals of integers:
## 
## $$\frac{1}{1} + \frac{1}{4} + \frac{1}{9} + \frac{1}{16}$$
## 
## $$\frac{1}{1} + \frac{1}{2^2} + \frac{1}{3^2} + \frac{1}{4^2} +
## \cdots + \frac{1}{n^2}$$
## 

## 1. What is the sum of the first four squares?
## 2. What is the sum of the first 100?
## 3. ...of the first 10,000?
## 4. if $x$ is the answer to 3, what is the square root of $6x$?

## ### A possible solution

## 1\.
1 + 1/4 + 1/9 + 1/16 # starting to get tedious to type

## 2\.
squares <- (1:100)^2
sum(1/squares)

## 3\.
sum(1 / (1:10000)^2)

## 4\.
x <- sum(1 / (1:10000)^2)
sqrt(x * 6)

## ---
## Back to [main page](/intro)
