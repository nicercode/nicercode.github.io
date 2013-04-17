## ---
## layout: page
## title: "Reading in data"
## date: 2013-03-18 10:25
## comments: true
## sharing: true
## footer: false
## ---

### Set options
##+ echo=FALSE,results=FALSE
source("global_options.R")

## As empirical biologists, you'll generally have data to read in.
## You probably have your data in an Excel spreadsheet.  The simplest
## way to load these into R is to save a copy of the data as a comma
## separated values file (csv) and work with that.

## It is actually possibl to read directly from Excel (but see the
## [gdata](http://cran.r-project.org/web/packages/gdata/index.html)
## package that has a `read.xls` function, and see
## [this](http://rwiki.sciviews.org/doku.php?id=tips:data-io:ms_windows)
## page for other alternatives.  This is usually more hassle than it's
## worth, and going through a comma separated file is easy enough.

## To load the data into R:
data <- read.csv("data/seed_root_herbivores.csv")

## (this doesn't usually produce any output -- the data is "just
## there" now).

## Clicking the little table icon next to the data in the Workspace
## browser will view the data.  Running `View(data)` will do the same
## thing.

## The `data` variable contains `data.frame` object.  It is a number
## of columns of the same length, arranged like a matrix.  That
## sentence is tricky, for reasons that will become apparent.

## Often, looking at the first few rows is all you need to remind
## yourself about what is in a data set.
head(data)

## You can get a vector of names of columns
names(data)

## You can get the number of rows:
nrow(data)

## and the number of columns
ncol(data)
length(data)

## The last one is surprising to most people.  There is a logical (if
## not good) reason for this, which we will get to later.

## Aside from issues around factors and character vectors (that we'll
## cover shortly) this is most of what you need to know about loading
## data.

## However, it's useful to know things about saving it.

## * column names should be consistent, the right length, contain no
##   special characters.
## 
## * for missing values, either leave them blank or use NA.  But be
##   consistent and don't use -999 or ? or your cat's name.
## 
## * Be careful with whitespace "x" will be treated differently to
##   "x ", and Excel makes it easy to accidently do the latter.
##   Consider the `strip.white=TRUE` argument to `read.csv`.
## 
## * Think about the type of the data.  We'll cover this more, but are
##   you dealing with a `TRUE`/`FALSE` or a category or a count or a
##   measurements.
## 
## * Dates and times will cause you nothing but pain.  Excel and R
##   *both* have issues with dates and times, and exporting through
##   CSV can make them worse.  I had a case with two different
##   year-zero offsets being used in one exported file.  I recommend
##   Year-Month-Day ([ISO 8601](http://en.wikipedia.org/wiki/ISO_8601)
##   format, or different colummns for different entries and combine
##   later.
## 
## * Watch out for dashes between numbers.  Excel will convert these
##   into dates.  So if you have "Site-Plant" style numbers 5-20 will
##   get converted into the 20th of May 1904 or something equally
##   useless.  Similar problems happen to
##   [gene names](http://www.biomedcentral.com/1471-2105/5/80)
##   in bioinformatics!
##  
## * Merged rows and columns will not work (or at least not in an
##   easily predictible way.
## 
## * Spare rows at the top, or double header rows will not work
##   without jumping through hoops.
## 
## * Equations will (should) convert to the value displayed in Excel
##   on export.

##+ echo=FALSE,results=FALSE
data2 <- data
data2$Height[20] <- data2$Height[20] * 1.1
write.table(data2, "data/seed_root_herbivores.txt", sep=";",
            row.names=FALSE)
rm(data2)

### TODO: At this point, they may not know how to use the help
### properly, so move help on help further up?

## ## Exercise:

## The file `data/seed_root_herbivores.txt` has *almost* the same
## data, but in tab separated format (it does have the same number of
## rows and columns).  Look at the ?read.table help page and work out
## how to load this file in.
## 
## Remember: `==` tests for equality, `!=` tests for inequality

###  Hint: Look at the `header` argument of `read.table`

### Mention double data entry as a source of this, or someone updated
### an upstream source (such as weather data), or you fixed and have
### two copies and don't remember which is correct.

### A possible solution:
data2 <- read.table("data/seed_root_herbivores.txt",
                    header=TRUE, sep=";")
data2 == data
## or
data2 != data

## The point here is that many of the functions and operators in R
## will try to do the Right Thing, depending on what you give them.

## This won't work, because the default arguments of `read.table` and
## `read.csv` are different for the header.
tmp <- read.table("data/seed_root_herbivores.txt", sep=";")
head(tmp)

## Notice that a fake header (V1, V2, etc) has been created and the
## actual header is now the first row of data.

## ## Looking at your data

## There are other ways of looking at your data.  The `summary`
## function works with most types, and gives a by-column summary of
## the data set
summary(data)

## # Subsetting

## So, we see there is an issue in the file -- how to we get to it?

## There a bunch of different ways of extracting bits of your data.

## ## Columns of `data.frames`

## Get the column `Plot`
data$Plot

## This does *almost* the same thing
data[["Plot"]]

## This is the main difference: if the column name is in a variable,
## then `$` won't work, while `[[` will.  Let's define a variable `v`
## that has the name if the first column as its value:
v <- "Plot"

## We can extract this column of the data set using the `[[` notation:
data[[v]]
## but using the `$` notation won't work as it will look for the
## column *called* `v`:
data$v
## It returns `NULL` to indicate that the column does not exist
## (confusingly, this value can be difficult to work with and give
## cryptic error messages.  More confusingly, getting a nonexistant
## column with `[[` generates an error instead).

## Also, `data$P` will "expand" to make `data$Plot`, but `data$S` will
## return `NULL` because that is ambiguous.  Always use the full name!

## Single square brackets also index the data, but do so differently.
## This returns a `data.frame` with one column:
head(data["Plot"])
## This returns a `data.frame` with two columns:
head(data[c("Plot", "Weight")])
## (I'm just using `head` here to keep the output under control.  If
## you actually wanted a `data.frame` like this you might do
data.sub <- data[c("Plot", "Weight")]
## and then continue to use the new `data.sub` object).

## The difference between `[` and `[[` can be confusing.

## The best explanation I have seen is that imagine that the thing you
## are subsetting is a train with a bunch of carriages.  `[x]` returns
## a new train with carriages represented by the variable `x`.  So
## `train[c(1,2)]` returns a train with just the first two carriages,
## and `train[1]` returns a train with just the first carriage.  The
## `[[` operator gets the *contents* of a single carriage.  So
## `train[[1]]` gets the *contents* of the first carriage, and
## `train[[c(1,2)]]` doesn't make any sense.

## ## Looking at your data (cont.)

## Plotting is covered in the next R module, but it's one of the best
## things about R so I can't resist showing how to do it:

## Here is a histogram of the height variable:
hist(data$Height)
## (it will appear in the bottom right of your screen)

## Here is a scatter plot of Height vs weight:
plot(data$Weight, data$Height)
## The order of arguments is *x*-variable, *y*-variable.

## There is an alternative interface using R's "formulae" -- you'll
## see this a lot in statistical models.  Read this as "`Height` is a
## function of `Weight`".  It makes nicer axis labels, too.
plot(Height ~ Weight, data)

## Here is a series of bivariate plots for height, weight and the
## number of seed heads:
pairs(data[c("Height", "Weight", "Seed.heads")])

## The take-home being that R makes it very easy to create graphs, and
## most people who use it casually just make plots of whatever they're
## looking at.  The plots can vary from quick and dirty like this to
## really beautiful pieces of art.

## ## Rows of `data.frames`

## Extracting a row always returns a new `data.frame`
data[10,]
data[10:20,]
data[c(1, 5, 10),]

## ## Be careful with indexing by location

## The above all index by *name* or by *location* (index).  However,
## you generally want to avoid referencing by number in your saved
## code, e.g.:
data.height <- data[[5]]

## This is because if you change the order of your spreadsheet (add or
## delete a column), everything that depends on `data.height` may
## change.  You may also see people do this in their code.
data.height <- data[,5]

## This should really be avoided.  By name is much more robust and
## easy to read later on, even if it is more typing at first.
data.height <- data$Height
data.height <- data[["Height"]]

## When should you index by location?

## When you are *computing* the indices.  As an example: suppose that
## you wanted every other row (perhaps you're trying to generate a
## nonrandom some sample of data?)  Remember `seq` from above?  We can
## generate a sequnce of integers 1, 3, ..., up to the last (or second
## to last) row in our data set like this:
idx <- seq(1, nrow(data), by=2)
## Then subset like this:
data.oddrows <- data[idx,]

## Our new data set has half the rows of the old data set:
nrow(data.oddrows)
nrow(data)

## Because row names are preserved, you can see the odd numbers in the
## row names.
head(data.oddrows)

## ## Indexing by logical vector

## This is one of the most powerful ways of indexing.

## Remember our data mismatch:
data != data2

## There is one entry in the `Height` row that disagrees.  How can we
## extract the line that the mismatch is on?

## We could do it by index:
data[20,]
data2[20,]

## But that requires us to look for the error, note the row, write it
## down, etc.  Boring, and computers are less error prone than
## humans.  Plus, I just said that we should not do that.

## This is a logical vector that indicates where the entries in vector
## 1 disagree with vector 2:
data.differ <- data$Height != data2$Height

## We can index by this - it will return rows for which there are true
## values:
data[data.differ,]
data2[data.differ,]

## You can convert from a logical (`TRUE`/`FALSE`) vector to an
## integer vector with the `which` function:
which(data.differ)

## This can be really useful.

## ### Excercise:
## 1. Return all the rows in `data` where both data sets have the *same*
##    value for `Height`.
## 2. Return all the rows in `data` from `plot-8`

## #### A solution:
data.same <- data$Height == data2$Height
data[data.same,]

## or:
data[!data.differ,]
## read `!x` as "not x",

data[data$Plot == "plot-8",]

## Subsetting can be useful when you want to look at bits of your
## data.  For example, all the rows where the Height is at least 10
## and there was no seed herbivore:
data[data$Height > 10 & data$Seed.herbivore,]

## The `&` operator here is a logical "and" (read `x & y` as "x and
## y"):

##  * `TRUE  & TRUE`  is `TRUE`
##  * `TRUE  & FALSE` is `FALSE`
##  * `FALSE & TRUE`  is `FALSE`
##  * `FALSE & FALSE` is `FALSE`

## In contrast, the `|` operator is a logical "or" (read as "or")

##  * `TRUE  | TRUE`  is `TRUE`
##  * `TRUE  | FALSE` is `TRUE`
##  * `FALSE | TRUE`  is `TRUE`
##  * `FALSE | FALSE` is `FALSE`

## The other, less common, operator is the exclusive or:

##  * `xor(TRUE,  TRUE)`  is `FALSE`
##  * `xor(TRUE,  FALSE)` is `TRUE`
##  * `xor(FALSE, TRUE)`  is `TRUE`
##  * `xor(FALSE, FALSE)` is `FALSE`

## So you can do all sorts of crazy things like
data[data$Plot == "plot-2" & data$Seed.herbivore & data$Root.herbivore,]
## and get all the cases in plot 2 where there were both seed
## herbivores and root herbivores.  Or
data[data$Height > 75 & (data$Seed.herbivore | data$Root.herbivore),]
## and get all the plants that are quite tall in treatments with
## *either* a seed herbivore or a root herbivore (or both).
## 
## You can build these up if you want:
idx.tall <- data$Height > 75
idx.herbivore <- data$Seed.herbivore | data$Root.herbivore
idx.select <- idx.tall & idx.herbivore
data[idx.select,]

## whatever you find easiest to read and write.

## > Programs should be written for people to read, and only
## > incidentally for machines to execute (Structure and
## > Interpretation of Computer Programs" by Abelson and Sussman)

## ### The `subset` function to simplify writing complex subsets

## There is a function `subset` that may help you write complex
## subsets.
subset(data, Height > 75 & (Seed.herbivore | Root.herbivore))

## This can help, especially interactively, but it can also bite you.
## It is not always obvious where the "value" of the variables in the
## second argument are coming from.  For example:
subset(data, idx.tall & (Seed.herbivore | Root.herbivore))
## This works fine, because it found `idx.tall`.  So when you read
## your code, you need to think carefully about which values are
## coming from the `data.frame` and which are coming from elsewhere.

## This is an unfortunate example of a function designed to be used by
## beginners, but it only really understandable once you understand
## more of what is going on.  You'll see it used widely, and it can
## simplify things.  But be careful.

## ## Adding new columns

## It is easy to add new columns, perhaps based on old ones:
data$small.plant <- data$Height < 50
head(data)

## You can delete a column by setting it to `NULL`:
data$small.plant <- NULL
head(data)

## In this data set, the last column contains the number of seeds in
## 25 seed heads.  However, there weren't always 25 seed heads on a
## plant:
data[data$Seed.heads < 25,]

## In these three cases, the column contains the number of seeds over
## *all* seed heads.

## **Question**: How do we compute the mean number of seeds per seed
## head?

data$Seeds.per.head <- data$Seeds.in.25.heads / 25
idx.few.heads <- data$Seed.heads < 25
data$Seeds.per.head[idx.few.heads] <-
  data$Seeds.in.25.heads[idx.few.heads] / data$Seed.heads[idx.few.heads]

## R generally offers several ways of doing things:
alternative <- data$Seeds.in.25.heads / pmin(data$Seed.heads, 25)
alternative == data$Seeds.per.head

## Use the `all` function to determine if all values are TRUE:
all(alternative == data$Seeds.per.head)

## ## (bonus topic) Indexing need not make things smaller

## Given this vector with the first give letters of the alphabet:
x <- c("a", "b", "c", "d", "e")
## Repeat the first letter once, the second letter twice, etc.
x[c(1, 2, 2, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 5)]
## Much better!
x[rep(1:5, 1:5)]
## `rep` is incredibly useful, and can be used in many ways.  See the
## help page `?rep`

## ---
## Back to [main page](/intro)
