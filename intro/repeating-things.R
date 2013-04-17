## ---
## layout: page
## title: "Repeating things"
## date: 2013-03-18 10:25
## comments: true
## sharing: true
## footer: false
## ---

## If there is one piece of advice I would recommend keeping in your
## head when working with R, it is this:

## > Don't Repeat Yourself

## Many of the headaches that people end up having stem from repeating
## themselves.  This basically mortgages your future time.  It is
## common to see cases where people have copy-and-pasted some piece of
## code a bunch of times (changing one thing each time), then copy and
## pasted *that* a bunch of times, changing it a bit more.  In the
## end, the script is very long, hard to read, really hard to
## understand, and full of bugs.

## Believe me on the last case --- you *will* write code that has
## bugs.  The more code you write, the more bugs you will have.  The
## good thing is that unlike Excel bugs, you can see and find them.
## The other goood thing is that the less code you write, the more
## easily you will spot the bugs.

## There are many ways of ensuring that you don't repeat yourself.
## Mastering the different approaches can take many years.  However,
## try to notice when you feel like you are battling against the
## language, and you'll get a good hint for when you should be doing
## something differently.

## # Applying a function over and over and over and over

## We'll be using the data set again, with factors sorted
## alphabetically as discussed in the [last section](data-types.html).
data <- read.csv("data/seed_root_herbivores.csv",
                 stringsAsFactors=FALSE)
data$Plot <- factor(data$Plot, levels=unique(data$Plot))

## There are a few data columns in the data set that we've been
## using.
head(data)
## `No.stems`, `Height`, `Weight`, `Seed.heads`, `Seeds.in.25.heads`.

## What if we wanted to get the mean of each column?
mean.no.stems <- mean(data$No.stems)
mean.Height <- mean(data$Height)
mean.Weight <- mean(data$Weight)
mean.Seed.heads <- mean(data$Seed.heads)
mean.Seeds.in.25.heads <- mean(data$Seeds.in.25.heads)

## What if we wanted to get the variance of all these?  Copy and paste
## and change the function name?  Very repetitive, hard to see intent,
## easy to make mistakes, and **boring**.

## Notice the pattern though --- we are taking each column in turn and
## applying the same function to it.  Sombody else noticed this
## pattern too.

## The function that we will use is `sapply`.  It takes as its first
## argument a list, and applies a function to each element in turn.

## As a simple example, here is a little list with toy data:
obj <- list(a=1:5, b=c(1,5, 6), c=c(pi, exp(1)))
obj

## This computes the length of each element in `obj`
sapply(obj, length)

## This computes their sum
sapply(obj, sum)

## This computes the variance
sapply(obj, var)

## This works with any function you want to use as the second argument.

## Here are our variables:
response.variables <- c("No.stems", "Height", "Weight", "Seed.heads",
                        "Seeds.in.25.heads")

## [Remember](data-types.html) when I said that a `data.frame` is like
## a list; this is one case where we take advantage of that.
sapply(data[response.variables], mean)
## This does all of the repetitive hard work that we did before, but
## in one line.  Read it as:
## 
## "Apply to each element in `data` (subset by my response variables)
## the function `mean`"

## ## Exercise

## The coefficient of variation is defined as the standard deviation
## (square root of the variance) divided by the mean:
## $$\frac{\mathrm{x}}{\bar x}$$.  Compute the coefficient of
## variation of these variables, and tell me which variable has the
## largest CV.

## Hint:
coef.variation <- function(x) {
  sqrt(var(x)) / mean(x)
}

## Did you just do
sapply(data[response.variables], coef.variation)
## and look for the largest variable?

## did you do:
cvs <- sapply(data[response.variables], coef.variation)
which(cvs == max(cvs))

## you can also do:
which.max(cvs)

## Similarly, for minimum
which.min(cvs)

## ## Note

## There is a function `lapply` works well when you are not expecting
## the same length output for the result of applying your function to
## each element in the list.  It gives you the result back in a list,
## for example
lapply(obj, sum)

## compared with:
sapply(obj, sum)

## This is has its uses.  For example, suppose we wanted to double all
## the elements in `obj`.  We can't just multiply this list by 2:
obj * 2 # causes error

## However, we can do this with `lapply`, as long as we have a
## function that will double things:
double <- function(x) {
  2 * x
}

## Apply the `double` function to each element in our list:
lapply(obj, double)

## We have to use `lapply` rather than `sapply` because the result of
## the function on different elements is different lengths.

## Note also that `sapply` actually does the same thing here.  But if
## the elements of `obj` happened to have the same length they would
## give different answers.
sapply(obj, double)

obj2 <- list(a=1:3, b=c(1, 5, 6), c=c(pi, exp(1), log(10)))
## Returns a list:
lapply(obj2, double)
## Returns a matrix:
sapply(obj2, double)

## This is probably more than you need to know right now, but it may
## stick around in your head until needed.

## # The split--apply--combine pattern

## Fairly often, you'll want to do something like compute means for
## each level of a treatment.  To compute the mean height given the
## root herbivore treatment here we could do:
height.with    <- mean(data$Height[data$Root.herbivore])
height.without <- mean(data$Height[!data$Root.herbivore])
## Remember read `!` as "not".

## (notice that plant height is taller when herbivores are absent).

## However, suppose that we want to get mean height by *plot*:
height.2 <- mean(data$Height[data$Plot == "plot-2"])
height.4 <- mean(data$Height[data$Plot == "plot-4"])
height.6 <- mean(data$Height[data$Plot == "plot-6"])
## and so on until we go out of our minds.

## There is a function `tapply` that automates this.
## 
## It's arguments are
args(tapply)

## The first argument, `X` is our *data* variable; the thing that we
## want the means of.

## The second argument, `INDEX` is the *grouping* variable; the thing
## that we want means at each distinct value/level of.

## The third argument, `FUN` is the function that you want to apply;
## in our case `mean`.

## So we have:
tapply(data$Height, data$Plot, mean)

## For the first example (present/absent) we have:
tapply(data$Height, data$Root.herbivore, mean)

## Notice that there was no more work going from 2 levels to 30
## levels!

## Also notice that it's really easy to change variables (as above) or
## change functions:
tapply(data$Height, data$Root.herbivore, var)

## This approach has been called the "split--apply-combine" pattern.
## There is a package [plyr](http://plyr.had.co.nz/) that a lot of
## people like that can make this easier.

## ## Two factors at once

## The experiment here is a 2x2 factorial design (though imbalanced as
## all ecological data end up being after they've been left in the
## field for a while).

## You can do that with `tapply` above, but it gets quite hard.  The
## `aggregate` function can do this nicely though.

## There are two interfaces to this (see the help page `?aggregate`).
## In the first, you supply the response variable as the first
## argument, the grouping variables as the second, and the function as
## the third (just like `tapply`).
aggregate(data$Height, data[c("Root.herbivore", "Seed.herbivore")],
          mean)

## or similarly, take a 1 column data frame:
aggregate(data["Height"], data[c("Root.herbivore", "Seed.herbivore")],
          mean)

## The other interface uses R's formula interface, which can be a lot
## shorter and easier to read.  
aggregate(Height ~ Root.herbivore + Seed.herbivore, data=data, mean)

## This is why I think it is important to get used to writing
## functions:
standard.error <- function(x) {
  sqrt(var(x) / length(x))
}
## Because your own functions work just as well with these tools:
aggregate(Height ~ Root.herbivore + Seed.herbivore, data=data,
          standard.error)
## (now you have everything for an interaction plot to start seeing
## how the different herbivores interact to effect plant growth).

## # Explicit loops

## In contrast with most programming languages, we have not covered a
## basic loop yet.  You may be familiar with these if you've written
## basic, python, perl, etc.

## The idea is the same as the first section in this page.  You want
## to apply a function (or do some calculation) over a series of
## elements in a list.

## For example, the `print` function prints a representation of an
## object to the screen.  Suppose we wanted to print all the elements
## of our list `obj`.

## This is confusing!
sapply(obj, print)

## This is because we want to just print the result to the screen and
## we don't actually want to do anything with the result (it turns out
## that `print` silently returns what is passed into it.
for ( el in obj ) {
  print(el)
}

## The element `i` is created at the beginning of the loop, and set to
## the first element in obj.  Each time "around" the loop it is set to
## the next element (so on the second iteration it will be the second
## element, and so on).

## Note that in contrast with functions, the variables created by
## loops do actually replace things in the global environment:
el
## Strictly, in the *enclosing environment*, so a loop within a
## function leaves the global environment unaffected.

## If you want to *do* something with the results of the loop, you
## need more scaffolding.  Let's do the mean example again and get the
## mean of each element in the list.

## First, we need somewhere to put the output.  The function `numeric`
## creates a numeric vector of the requested length.  
n <- length(obj)
out <- numeric(n)
## You could use `rep` here if you'd rather.

## Then, rather than loop over the elements directly as above, we loop
## over their *indices*:
for ( i in 1:n ) {
  out[i] <- mean(obj[[i]])
}
## Read the line within the loop as "into the i'th element of output
## (`out`) save the result of running the function on the i'th element
## if the input (`obj`)".  The double square brackets are needed (Why?
## Because `out[i]` would be a list with one element while `out[[i]]`
## is the `i`th element itself.).
out

## This does not have names like the `sapply` version did.  If we want
## names, add them back with `names`.
names(out) <- names(obj)

## There are times where loops are absolutely the best (or the only
## way) of doing something.

## For example, if you want a cumulative sum over list elements (so
## that `out[[i]]` contains the sum of `obj[[1]]`, `obj[[2]]`, ...,
## `obj[[i]]`), you might do that with a loop:
n <- length(obj)
out <- numeric(n)
total <- 0.0 # running total
for ( i in 1:n ) {
  total <- total + sum(obj[[i]])
  out[[i]] <- total
}
names(out) <- names(obj)

## Although we can actually do that with the built-in function
## `cumsum` and `sapply`ing over the list to get the sums.
cumsum(sapply(obj, sum))

## ---
## Back to [main page](/intro)
