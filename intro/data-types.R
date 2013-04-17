## ---
## layout: page
## title: "Data types"
## date: 2013-03-18 10:25
## comments: true
## sharing: true
## footer: false
## ---

## Data can have different "types".  The core data types in R are
## "logical" (true/false), "integer" (-1, 0, 1, etc), "numeric" or
## "double" (floating point numbers, a.k.a. decimals or real numbers),
## and "character" (strings).  There is also "complex" type for
## complex numbers, but you have to go out of your way to find them.

## A `logical` vector:
c(TRUE, FALSE)
## An `integer` vector: (you rarely need to specify these
## explicitly).
c(1L, 2L)
## A `numeric` vector:
c(1.0, 2.0)
## A `character` vector:
c("string1", "string 2 with spaces")
## (even though they are called "characters", there is no special type
## for single letters, etc.  So people will refer to these as strings
## and characters fairly interchangeably).

## Note that the strings *must* be quoted.  You can use single or
## double quotes as you fancy, but be consistent.  The difference
## between integer and numeric is subtle and can usually be ignored.
## To force numbers to be integers, you need to specify them with an
## "L" after, as above.  Generally don't worry about this.

## It is possible to refer to `TRUE` and `FALSE` as `T` and `F`, and
## this practice is fairly widespread.  **Do not do it**.  The values
## `TRUE` and `FALSE` are special values are protected -- they can
## never be overwritten:
TRUE <- FALSE # invalid code, causes error

## Wheras the values `T` and `F` are just variables bound to the
## values `TRUE` and `FALSE`.
T <- FALSE
F <- TRUE
T # is now FALSE!
F # is now TRUE!

## Do this at the top of of someone's script and watch their world
## burn.

## Some functions will work on any type, others will require specific
## types.  For example, `length` will give the length for any vector

length(c(1, 2, 3, 4))
length(c("a", "b", "c", "d"))

## `max` will give the maximum value for a vector:
max(c(1, 2, 3, 4))
max(c("a", "b", "c", "d"))

## but `sum` requires a vector that is *not* a character vector:
sum(c(1, 2, 3, 4))
sum(c("a", "b", "c", "d"))

## How do you tell which of these types you have?  Use the `typeof`
## function:
typeof(c(TRUE, FALSE))
typeof(c(1L, 2L))
typeof(c(1.0, 2.0))
typeof(c("a", "b", "c"))

## Note that the type of the number 1 is `numeric`:
typeof(1)

## Unless you ask nicely, all values in R are numeric and not
## integer.  But this usually does not matter.

## Note: this section actually grossly oversimplifies what is going
## on; see the difference between `mode`, `storage.mode`, `class` and
## `typeof`.

## ## Container data types

## In R's terminology, the types above are "atomic data types" as they
## cannot be subdivided any further.  Data go into containers, which
## also have types.

## The simplest of these is the *vector*, which we've already seen.  A
## vector contains zero or more elements of *a single atomic type*.
## So you have a vector of integers, or a vector of characters, etc.
## You can't have a mix of types within a vector.
c(1.5, "a") # The number 1.5 is converted into a character string

## Next simplest is a *matrix*.  This is a two dimensional object with
## all elements being the same type.  These can be constructed with
## the `matrix` function
m <- matrix(c(1, 2, 3, 4, 5, 6), 2, 3)
m

## Notice that the elements are added column-wise.  A matrix is simply
## a vector that knows its dimension (in this case 2-by-3).  You can
## do element-wise operators on a matrix:
2 * m
log(m)

## A "list" is totally different to a vector, but is easily confused.
## A list can contain different types of data.  So we can do:
obj <- list(1.5, c(TRUE, FALSE), c("a", "b", "c"))
obj

## This is a list of length '3' with elements
## 1. a numeric vector of length 1 containing the element 1.5
## 2. a logical vector of length 2 containing the values `TRUE` and
## `FALSE`
## 3. a character vector of length 3 containing the elements "a", "b",
## and "c".

## A `data.frame` is actually a list internally, and many approaches
## for working with lists work with `data.frame`s.  Remember how
## `length` on a `data.frame` gave the number of columns?  This is
## why.

## ## Factors vs. strings

## By default, R reads in `data.frame`s with things that look like
## text as "factors"
data <- read.csv("data/seed_root_herbivores.csv")
data$Plot

## A factor is basically a vector of integers (1, 2, 3, ...) with a
## small character vector that specifies how to translate these:
unclass(data$Plot)
## (`unclass` is a function that stops things behaving using special
## abilities --- you won't use it much!).

## One of the most common issues that people have with factors is
## renaming elements.
x.character <- as.character(data$Plot)
x.character[x.character == "plot-2"] <- "new plot name"
x.character

## Won't work with factors:
x.factor <- data$Plot
x.factor[x.factor == "plot-2"] <- "new plot name"
x.factor

## Correct way:
x.factor <- data$Plot
levels(x.factor)[levels(x.factor) == "plot-2"] <- "new plot name"
x.factor

## Factors can be very useful, but can also be very annoying.  To
## disable automatic conversion, use the `stringsAsFactors` argument
## to `read.csv`.
data <- read.csv("data/seed_root_herbivores.csv",
                 stringsAsFactors=FALSE)
data$Plot

## My strategy:

## 1. only use factors when you know they are needed, otherwise prefer
##    character vectors.
## 2. delay conversion to factor as long as posible.

## They do have uses though.

## * Preserve ordering:

## By default, ordering is alphabetical; gets confused when number of
## digits changes ("a10" sorts before "a9").
table(data$Plot)

## In this data set, the plots are already in native order
unique(data$Plot)
## We can pass that in as the `levels` argument to factor to get this
## ordering
tmp <- factor(data$Plot, levels=unique(data$Plot))
## which is preserved in functions that use factors
table(tmp)

## (this emphasises the "delay conversion" part of the strategy
## above).

## * Factors are required for some analyses, and are needed to specify
##   "constrasts" in some models.

## ---
## Back to [main page](/intro)
