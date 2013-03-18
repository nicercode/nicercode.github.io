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
## You probably have your data in an Excel spreadsheet.  It is
## possible to load these directly into R, but this is usually more
## hassle than it's worth.  The simplest way is to save a copy of the
## data as a comma separated values file (csv) and work with that.

## Things to bear in mind:
## 
##   * Merged rows and columns will not work.
##   * Spare rows at the top, or double header rows will not work.
##   * Dates will cause you pain at some point.
##   * Equations will (should) convert to the value displayed in Excel.

## You can't (easily) read directly from Excel (but see the
## [gdata](http://cran.r-project.org/web/packages/gdata/index.html)
## package that has a `read.xls` function, and see
## [this](http://rwiki.sciviews.org/doku.php?id=tips:data-io:ms_windows)
## page for other alternatives.  But generally going through a comma
## separated file is easy enough.

## This is usually all that is needed:
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
## not good) reason for this, that we might get to depending on time.

## Aside from issues around factors and character vectors (that we'll
## cover shortly) this really is almost all you need to know about
## loading data.

## However, it's useful to know things about saving it.

## * column names should be consistent, the right length, contain no
##   special characters.
## 
## * for missing values, either leave them blank or use NA.  But be
##   consistent and don't use -999 or ? or your cat's name.
## 
## * Think about the type of the data.  We'll cover this more, but are
##   you dealing with a TRUE/FALSE or a category or a count or a
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

##+ echo=FALSE,results=FALSE
data2 <- data
data2$Height[20] <- data2$Height[20] * 1.1
write.table(data2, "data/seed_root_herbivores.txt", sep=";",
            row.names=FALSE)
rm(data2)

### TODO: At this point, they may not know how to use the help
### properly, so move help on help further up?

## Exercise:

## The file data/seed_root_herbivores.txt has *almost* the same data,
## but in tab separated format (it does have the same number of rows
## and columns).  Look at the ?read.table help page and work out how
## to load this file in.
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

## This won't work, because the default arguments of `read.table` and
## `read.csv` are different for the header.
tmp <- read.table("data/seed_root_herbivores.txt", sep=";")
head(tmp)

## # Subsetting

## So, we see there is an issue in the file -- how to we get to it?

## There a bunch of different ways of extracting bits of your data.

## ## Columns of `data.frames`

## Get the column `a`
data$Plot

## This does *almost* the same thing
data[["Plot"]]

## This is the main difference: if the column name is in a variable,
## then `$` won't work, while `[[` will 
v <- "Plot"
## Won't work
data$v
## Works fine
data[[v]]

### plus abbrviated names and the dangers they can cause.

## This returns a `data.frame` with one column
data["Plot"]
## This returns a `data.frame` with two columns
data[c("Plot", "Weight")]

## The difference between `[` and `[[` can be confusing.

## The best explanation I have seen is that imagine that the thing you
## are subsetting is a train with a bunch of carriages.  `[x]` returns
## a new train with carriages represented by the variable `x`.  So
## `train[c(1,2)]` returns a train with just the first two carriages,
## and `train[1]` returns a train with just the first carriage.  The
## `[[` operator gets the *contents* of a single carriage.  So
## `train[[1]]` gets the *contents* of the first carriage, and
## `train[[c(1,2)]]` doesn't make any sense.

## ## Rows of `data.frames`

## Extracting a row always returns a new `data.frame`

data[10,]
data[10:20,]
data[c(1, 5, 10),]

## ## Be careful with indexing by location

## The above all index by *name* or by *location* (index).  Avoid
## doing things like this:
data.height <- data[[5]]

## Because if you change the order of your spreadsheet (add or delete
## a column), everything that depends on `data.height` may change.
## You may see people do this:
data.height <- data[,5]

## This should really be avoided.  By name is much more robust and
## easy to read.
data.height <- data$Height
data.height <- data[["Height"]]

## When should you index by number?

## When you are *computing* the indices.

## ## Indexing by logical vector

## This is one of the most powerful ways of indexing.

## Remember our data mismatch:
data != data2

## There is one entry in the `Height` row that disagrees.  How can we
## get the whole line that it is on?

## We could do it by index:
data[20,]
data2[20,]

## But that requires us to look for the error, note the row, write it
## down, etc.  Boring, and computers are less error prone than humans.

## This is a logical vector that indicates where the entries in vector
## 1 disagree with vector 2:
data.differ <- data$Height != data2$Height

## We can index by this - it will return rows for which there are true
## values:
data[data.differ,]
data2[data.differ,]

## ### Excercise:
## Return all the rows in `data` where the data agree.

## #### A solution:
data.same <- data$Height == data2$Height
data[data.same,]

## or:
data[!data.differ,]
## read `!x` as "not x",

## Subsetting can be useful when you want to look at bits of your
## data.  For example, all the rows where the Height is at least 10
## and there was no seed herbivore:
data[data$Height > 10 & data$Seed.herbivore,]

## ## Indexing need not make things smaller

## Given this vector with the first give letters of the alphabet:
x <- c("a", "b", "c", "d", "e")
## Repeat the first letter once, the second letter twice, etc.
x[c(1, 2, 2, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 5)]
## Much better!
x[rep(1:5, 1:5)]
## `rep` is incredibly useful, and can be used in many ways.  See the
## help page `?rep`
