## # tapply
library(downloader)
download("https://raw.github.com/audy/smalldata/master/seinfeld.csv",
         "seinfeld.csv")
dat <- read.csv("seinfeld.csv", stringsAsFactors=FALSE)

## Columns are Season (number), Episode (number), Title (of the
## episode), Rating (according to IMDb) and Votes (to construct the
## rating).
head(dat)

## Make sure it's sorted sensibly
dat <- dat[order(dat$Season, dat$Episode),]

## Biologically, this could be Site / Individual / ID / Mean size /
## Things measured.

## Hypothesis: Seinfeld used to be funny, but got progressively less
## good as it became too mainstream.  Or, does the mean episode rating
## per season decrease?

mean(dat$Rating[dat$Season == 1])
mean(dat$Rating[dat$Season == 2])
## and so on until:
mean(dat$Rating[dat$Season == 9])

## As with most things, we *could* do this with a for loop:

seasons <- sort(unique(dat$Season))
rating  <- numeric(length(seasons))
for (i in seq_along(seasons))
  rating[i] <- mean(dat$Rating[dat$Season == seasons[i]])

## That's actually not that horrible to do.  But we could do it
## easier.  We could first *split* the ratings by season:
ratings.split <- split(dat$Rating, dat$Season)
head(ratings.split)

## Then use sapply to loop over this list, computing the mean
rating <- sapply(ratings.split, mean)

## Then if we wanted to apply a different function (say, compute the
## per-season standard error) we could just do:
se <- function(x)
  sqrt(var(x) / length(x))
rating.se <- sapply(ratings.split, se)

plot(rating ~ seasons, ylim=c(7, 9), pch=19)
arrows(seasons, rating - rating.se, seasons, rating + rating.se,
       code=3, angle=90, length=0.02)

## But there's repetition there.  Let's abstract that away a bit.
## Suppose we want a:
##   1. response variable (like Rating was)
##   2. grouping variable (like Season was)
##   3. function to apply to each level

## This just writes out *exactly* what we had before
summarise.by.group <- function(response, group, func) {
  levels <- sort(unique(group))
  response.split <- split(response, group)
  sapply(response.split, func)
}

## We can compute the mean rating by season again:
rating.new <- summarise.by.group(dat$Rating, dat$Season, mean)

## which is the same as what we got before:
identical(rating.new, rating)

## Of course, we're not the first people to try this.  This is what
## the `tapply` function does (but with a few bells and whistles,
## especially around missing values, factor levels, additional
## arguments and multiple grouping factors at once).
tapply(dat$Rating, dat$Season, mean)

## There are a couple of limitations of `tapply`.

## The first is that getting the season out of `tapply` is quite
## hard.  We could do:
as.numeric(names(rating))

## But that's quite ugly, not least because it involves the conversion
## numeric -> string -> numeric.

## Better could be to use
sort(unique(dat$Season))

## But that requires knowing what is going on inside of `tapply`.

## I suspect that this approach:
first <- function(x) x[[1]]
tapply(dat$Season, dat$Season, first)

## is probably the most fool-proof, but it's certainly not pretty.

## The `aggregate` function provides a simplfied interface to `tapply`
## that avoids this issue.  It has two interfaces: the first is
## similar to what we used before, but the grouping variable now must
## be a list or data frame:
aggregate(dat$Rating, dat["Season"], mean)

## (note that `dat["Season"]` returns a one-column data frame).  The
## column 'x' is our response variable, Rating, grouped by season.  We
## can get its name included in the column names here by specifying
## the first argument as a `data.frame` too:
aggregate(dat["Rating"], dat["Season"], mean)

## The other interface is the formula interface, that will be familiar
## from fitting linear models:
aggregate(Rating ~ Season, dat, mean)

## This interface is really nice; we can get the number of votes here
## too.
aggregate(cbind(Rating, Votes) ~ Season, dat, mean)

## If you have multiple grouping variables, you can write things like:
## ```
## aggregate(response ~ factor1 + factor2, dat, function)
## ```
## to apply a function to each pair of levels of factor1 and factor2.

## # replicate

## This is great in Monte Carlo simulation situations.  For example.
## Suppose that you flip a fair coin n times and count the number of
## heads:

trial <- function(n)
  sum(runif(n) < 0.5) # could have done a binomial draw...

## You can run the trial a bunch of times:
trial(10)
trial(10)
trial(10)

## and get a feel for the results.  If you want to replicate the trial
## 100 times and look at the distribution of results, you could do:
replicate(100, trial(10))

## and then you could plot these:
plot(table(replicate(10000, trial(50))))

## # for loops

## "`for`" loops shine where the output of one iteration depends on
## the result of the previous iteration.

## Suppose you wanted to model random walk.  Every time step, with 50%
## probability move left or right.

## Start at position 0
x <- 0
## Move left or right with probability p (0.5 = unbiased)
p <- 0.5

## Update the position
x <- x + if (runif(1) < p) -1 else 1

## Let's abstract the update into a function:
step <- function(x, p=0.5)
  x + if (runif(1) < p) -1 else 1

## Repeat a bunch of times:
x <- step(x)
x <- step(x)

## To find out where we got to after 20 steps:
for (i in 1:20)
  x <- step(x)

## If we want to collect where we're up to at the same time:
nsteps <- 200
x <- numeric(nsteps + 1)
x[1] <- 0 # start at 0
for (i in seq_len(nsteps))
  x[i+1] <- step(x[i])
plot(x, type="l")

## Pulling *that* into a function:
random.walk <- function(nsteps, x0=0, p=0.5) {
  x <- numeric(nsteps + 1)
  x[1] <- x0
  for (i in seq_len(nsteps))
    x[i+1] <- step(x[i])
  x
}

## We can then do 30 random walks:
walks <- replicate(30, random.walk(100))
matplot(walks, type="l", lty=1, col=rainbow(nrow(walks)))

## Of course, in this case, if we think in terms of vectors we can
## actually implement random walk using implicit vectorisation:
random.walk <- function(nsteps, x0=0, p=0.5)
  cumsum(c(x0, ifelse(runif(nsteps) < p, -1, 1)))

walks <- replicate(30, random.walk(100))
matplot(walks, type="l", lty=1, col=rainbow(nrow(walks)))

## Which reinforces one of the advantages of thinking in terms of
## functions: you can change the implementation detail without the
## rest of the program changing.
