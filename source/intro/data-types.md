---
layout: page
title: "Data types"
date: 2013-03-18 10:25
comments: true
sharing: true
footer: false
---

Data can have different "types".  The core data types in R are
"logical" (true/false), "integer" (-1, 0, 1, etc), "numeric" or
"double" (floating point numbers, a.k.a. decimals or real numbers),
and "character" (strings).  There is also "complex" type for
complex numbers, but you have to go out of your way to find them.

A `logical` vector:

```r
c(TRUE, FALSE)
```

```
## [1]  TRUE FALSE
```

An `integer` vector: (you rarely need to specify these
explicitly).

```r
c(1L, 2L)
```

```
## [1] 1 2
```

A `numeric` vector:

```r
c(1, 2)
```

```
## [1] 1 2
```

A `character` vector:

```r
c("string1", "string 2 with spaces")
```

```
## [1] "string1"              "string 2 with spaces"
```

(even though they are called "characters", there is no special type
for single letters, etc.  So people will refer to these as strings
and characters fairly interchangeably).

Note that the strings *must* be quoted.  You can use single or
double quotes as you fancy, but be consistent.  The difference
between integer and numeric is subtle and can usually be ignored.
To force numbers to be integers, you need to specify them with an
"L" after, as above.  Generally don't worry about this.

It is possible to refer to `TRUE` and `FALSE` as `T` and `F`, and
this practice is fairly widespread.  **Do not do it**.  The values
`TRUE` and `FALSE` are special values are protected -- they can
never be overwritten:

```r
TRUE <- FALSE  # invalid code, causes error
```

```
## Error: invalid (do_set) left-hand side to assignment
```


Wheras the values `T` and `F` are just variables bound to the
values `TRUE` and `FALSE`.

```r
T <- FALSE
F <- TRUE
T  # is now FALSE!
```

```
## [1] FALSE
```

```r
F  # is now TRUE!
```

```
## [1] TRUE
```


Do this at the top of of someone's script and watch their world
burn.

Some functions will work on any type, others will require specific
types.  For example, `length` will give the length for any vector


```r
length(c(1, 2, 3, 4))
```

```
## [1] 4
```

```r
length(c("a", "b", "c", "d"))
```

```
## [1] 4
```


`max` will give the maximum value for a vector:

```r
max(c(1, 2, 3, 4))
```

```
## [1] 4
```

```r
max(c("a", "b", "c", "d"))
```

```
## [1] "d"
```


but `sum` requires a vector that is *not* a character vector:

```r
sum(c(1, 2, 3, 4))
```

```
## [1] 10
```

```r
sum(c("a", "b", "c", "d"))
```

```
## Error: invalid 'type' (character) of argument
```


How do you tell which of these types you have?  Use the `typeof`
function:

```r
typeof(c(TRUE, FALSE))
```

```
## [1] "logical"
```

```r
typeof(c(1L, 2L))
```

```
## [1] "integer"
```

```r
typeof(c(1, 2))
```

```
## [1] "double"
```

```r
typeof(c("a", "b", "c"))
```

```
## [1] "character"
```


Note that the type of the number 1 is `numeric`:

```r
typeof(1)
```

```
## [1] "double"
```


Unless you ask nicely, all values in R are numeric and not
integer.  But this usually does not matter.

Note: this section actually grossly oversimplifies what is going
on; see the difference between `mode`, `storage.mode`, `class` and
`typeof`.

## Container data types

In R's terminology, the types above are "atomic data types" as they
cannot be subdivided any further.  Data go into containers, which
also have types.

The simplest of these is the *vector*, which we've already seen.  A
vector contains zero or more elements of *a single atomic type*.
So you have a vector of integers, or a vector of characters, etc.
You can't have a mix of types within a vector.

```r
c(1.5, "a")  # The number 1.5 is converted into a character string
```

```
## [1] "1.5" "a"
```


Next simplest is a *matrix*.  This is a two dimensional object with
all elements being the same type.  These can be constructed with
the `matrix` function

```r
m <- matrix(c(1, 2, 3, 4, 5, 6), 2, 3)
m
```

```
##      [,1] [,2] [,3]
## [1,]    1    3    5
## [2,]    2    4    6
```


Notice that the elements are added column-wise.  A matrix is simply
a vector that knows its dimension (in this case 2-by-3).  You can
do element-wise operators on a matrix:

```r
2 * m
```

```
##      [,1] [,2] [,3]
## [1,]    2    6   10
## [2,]    4    8   12
```

```r
log(m)
```

```
##        [,1]  [,2]  [,3]
## [1,] 0.0000 1.099 1.609
## [2,] 0.6931 1.386 1.792
```


A "list" is totally different to a vector, but is easily confused.
A list can contain different types of data.  So we can do:

```r
obj <- list(1.5, c(TRUE, FALSE), c("a", "b", "c"))
obj
```

```
## [[1]]
## [1] 1.5
## 
## [[2]]
## [1]  TRUE FALSE
## 
## [[3]]
## [1] "a" "b" "c"
```


This is a list of length '3' with elements
1. a numeric vector of length 1 containing the element 1.5
2. a logical vector of length 2 containing the values `TRUE` and
`FALSE`
3. a character vector of length 3 containing the elements "a", "b",
and "c".

A `data.frame` is actually a list internally, and many approaches
for working with lists work with `data.frame`s.  Remember how
`length` on a `data.frame` gave the number of columns?  This is
why.

## Factors vs. strings

By default, R reads in `data.frame`s with things that look like
text as "factors"

```r
data <- read.csv("data/seed_root_herbivores.csv")
data$Plot
```

```
##   [1] plot-2  plot-2  plot-2  plot-2  plot-2  plot-2  plot-4  plot-6 
##   [9] plot-6  plot-6  plot-8  plot-8  plot-8  plot-8  plot-8  plot-10
##  [17] plot-10 plot-10 plot-10 plot-12 plot-12 plot-12 plot-12 plot-12
##  [25] plot-14 plot-14 plot-14 plot-14 plot-14 plot-16 plot-16 plot-16
##  [33] plot-16 plot-16 plot-16 plot-16 plot-18 plot-18 plot-18 plot-18
##  [41] plot-18 plot-18 plot-20 plot-20 plot-20 plot-20 plot-20 plot-20
##  [49] plot-20 plot-20 plot-22 plot-22 plot-24 plot-24 plot-24 plot-24
##  [57] plot-24 plot-24 plot-26 plot-26 plot-26 plot-26 plot-26 plot-26
##  [65] plot-28 plot-28 plot-28 plot-28 plot-28 plot-28 plot-30 plot-30
##  [73] plot-30 plot-30 plot-30 plot-30 plot-30 plot-32 plot-32 plot-32
##  [81] plot-34 plot-34 plot-34 plot-34 plot-36 plot-36 plot-36 plot-36
##  [89] plot-36 plot-36 plot-36 plot-38 plot-38 plot-38 plot-38 plot-38
##  [97] plot-40 plot-40 plot-40 plot-40 plot-40 plot-40 plot-40 plot-40
## [105] plot-40 plot-42 plot-42 plot-44 plot-44 plot-44 plot-44 plot-44
## [113] plot-44 plot-46 plot-46 plot-46 plot-46 plot-46 plot-46 plot-46
## [121] plot-48 plot-48 plot-48 plot-48 plot-48 plot-48 plot-50 plot-50
## [129] plot-50 plot-50 plot-50 plot-50 plot-50 plot-50 plot-52 plot-52
## [137] plot-52 plot-52 plot-52 plot-52 plot-52 plot-54 plot-54 plot-54
## [145] plot-54 plot-54 plot-54 plot-54 plot-56 plot-56 plot-56 plot-56
## [153] plot-56 plot-56 plot-58 plot-58 plot-58 plot-58 plot-58 plot-58
## [161] plot-58 plot-60 plot-60 plot-60 plot-60 plot-60 plot-60 plot-60
## [169] plot-60
## 30 Levels: plot-10 plot-12 plot-14 plot-16 plot-18 plot-2 ... plot-8
```


A factor is basically a vector of integers (1, 2, 3, ...) with a
small character vector that specifies how to translate these:

```r
unclass(data$Plot)
```

```
##   [1]  6  6  6  6  6  6 17 28 28 28 30 30 30 30 30  1  1  1  1  2  2  2  2
##  [24]  2  3  3  3  3  3  4  4  4  4  4  4  4  5  5  5  5  5  5  7  7  7  7
##  [47]  7  7  7  7  8  8  9  9  9  9  9  9 10 10 10 10 10 10 11 11 11 11 11
##  [70] 11 12 12 12 12 12 12 12 13 13 13 14 14 14 14 15 15 15 15 15 15 15 16
##  [93] 16 16 16 16 18 18 18 18 18 18 18 18 18 19 19 20 20 20 20 20 20 21 21
## [116] 21 21 21 21 21 22 22 22 22 22 22 23 23 23 23 23 23 23 23 24 24 24 24
## [139] 24 24 24 25 25 25 25 25 25 25 26 26 26 26 26 26 27 27 27 27 27 27 27
## [162] 29 29 29 29 29 29 29 29
## attr(,"levels")
##  [1] "plot-10" "plot-12" "plot-14" "plot-16" "plot-18" "plot-2"  "plot-20"
##  [8] "plot-22" "plot-24" "plot-26" "plot-28" "plot-30" "plot-32" "plot-34"
## [15] "plot-36" "plot-38" "plot-4"  "plot-40" "plot-42" "plot-44" "plot-46"
## [22] "plot-48" "plot-50" "plot-52" "plot-54" "plot-56" "plot-58" "plot-6" 
## [29] "plot-60" "plot-8"
```

(`unclass` is a function that stops things behaving using special
abilities --- you won't use it much!).

One of the most common issues that people have with factors is
renaming elements.

```r
x.character <- as.character(data$Plot)
x.character[x.character == "plot-2"] <- "new plot name"
x.character
```

```
##   [1] "new plot name" "new plot name" "new plot name" "new plot name"
##   [5] "new plot name" "new plot name" "plot-4"        "plot-6"       
##   [9] "plot-6"        "plot-6"        "plot-8"        "plot-8"       
##  [13] "plot-8"        "plot-8"        "plot-8"        "plot-10"      
##  [17] "plot-10"       "plot-10"       "plot-10"       "plot-12"      
##  [21] "plot-12"       "plot-12"       "plot-12"       "plot-12"      
##  [25] "plot-14"       "plot-14"       "plot-14"       "plot-14"      
##  [29] "plot-14"       "plot-16"       "plot-16"       "plot-16"      
##  [33] "plot-16"       "plot-16"       "plot-16"       "plot-16"      
##  [37] "plot-18"       "plot-18"       "plot-18"       "plot-18"      
##  [41] "plot-18"       "plot-18"       "plot-20"       "plot-20"      
##  [45] "plot-20"       "plot-20"       "plot-20"       "plot-20"      
##  [49] "plot-20"       "plot-20"       "plot-22"       "plot-22"      
##  [53] "plot-24"       "plot-24"       "plot-24"       "plot-24"      
##  [57] "plot-24"       "plot-24"       "plot-26"       "plot-26"      
##  [61] "plot-26"       "plot-26"       "plot-26"       "plot-26"      
##  [65] "plot-28"       "plot-28"       "plot-28"       "plot-28"      
##  [69] "plot-28"       "plot-28"       "plot-30"       "plot-30"      
##  [73] "plot-30"       "plot-30"       "plot-30"       "plot-30"      
##  [77] "plot-30"       "plot-32"       "plot-32"       "plot-32"      
##  [81] "plot-34"       "plot-34"       "plot-34"       "plot-34"      
##  [85] "plot-36"       "plot-36"       "plot-36"       "plot-36"      
##  [89] "plot-36"       "plot-36"       "plot-36"       "plot-38"      
##  [93] "plot-38"       "plot-38"       "plot-38"       "plot-38"      
##  [97] "plot-40"       "plot-40"       "plot-40"       "plot-40"      
## [101] "plot-40"       "plot-40"       "plot-40"       "plot-40"      
## [105] "plot-40"       "plot-42"       "plot-42"       "plot-44"      
## [109] "plot-44"       "plot-44"       "plot-44"       "plot-44"      
## [113] "plot-44"       "plot-46"       "plot-46"       "plot-46"      
## [117] "plot-46"       "plot-46"       "plot-46"       "plot-46"      
## [121] "plot-48"       "plot-48"       "plot-48"       "plot-48"      
## [125] "plot-48"       "plot-48"       "plot-50"       "plot-50"      
## [129] "plot-50"       "plot-50"       "plot-50"       "plot-50"      
## [133] "plot-50"       "plot-50"       "plot-52"       "plot-52"      
## [137] "plot-52"       "plot-52"       "plot-52"       "plot-52"      
## [141] "plot-52"       "plot-54"       "plot-54"       "plot-54"      
## [145] "plot-54"       "plot-54"       "plot-54"       "plot-54"      
## [149] "plot-56"       "plot-56"       "plot-56"       "plot-56"      
## [153] "plot-56"       "plot-56"       "plot-58"       "plot-58"      
## [157] "plot-58"       "plot-58"       "plot-58"       "plot-58"      
## [161] "plot-58"       "plot-60"       "plot-60"       "plot-60"      
## [165] "plot-60"       "plot-60"       "plot-60"       "plot-60"      
## [169] "plot-60"
```


Won't work with factors:

```r
x.factor <- data$Plot
x.factor[x.factor == "plot-2"] <- "new plot name"
```

```
## Warning: invalid factor level, NAs generated
```

```r
x.factor
```

```
##   [1] <NA>    <NA>    <NA>    <NA>    <NA>    <NA>    plot-4  plot-6 
##   [9] plot-6  plot-6  plot-8  plot-8  plot-8  plot-8  plot-8  plot-10
##  [17] plot-10 plot-10 plot-10 plot-12 plot-12 plot-12 plot-12 plot-12
##  [25] plot-14 plot-14 plot-14 plot-14 plot-14 plot-16 plot-16 plot-16
##  [33] plot-16 plot-16 plot-16 plot-16 plot-18 plot-18 plot-18 plot-18
##  [41] plot-18 plot-18 plot-20 plot-20 plot-20 plot-20 plot-20 plot-20
##  [49] plot-20 plot-20 plot-22 plot-22 plot-24 plot-24 plot-24 plot-24
##  [57] plot-24 plot-24 plot-26 plot-26 plot-26 plot-26 plot-26 plot-26
##  [65] plot-28 plot-28 plot-28 plot-28 plot-28 plot-28 plot-30 plot-30
##  [73] plot-30 plot-30 plot-30 plot-30 plot-30 plot-32 plot-32 plot-32
##  [81] plot-34 plot-34 plot-34 plot-34 plot-36 plot-36 plot-36 plot-36
##  [89] plot-36 plot-36 plot-36 plot-38 plot-38 plot-38 plot-38 plot-38
##  [97] plot-40 plot-40 plot-40 plot-40 plot-40 plot-40 plot-40 plot-40
## [105] plot-40 plot-42 plot-42 plot-44 plot-44 plot-44 plot-44 plot-44
## [113] plot-44 plot-46 plot-46 plot-46 plot-46 plot-46 plot-46 plot-46
## [121] plot-48 plot-48 plot-48 plot-48 plot-48 plot-48 plot-50 plot-50
## [129] plot-50 plot-50 plot-50 plot-50 plot-50 plot-50 plot-52 plot-52
## [137] plot-52 plot-52 plot-52 plot-52 plot-52 plot-54 plot-54 plot-54
## [145] plot-54 plot-54 plot-54 plot-54 plot-56 plot-56 plot-56 plot-56
## [153] plot-56 plot-56 plot-58 plot-58 plot-58 plot-58 plot-58 plot-58
## [161] plot-58 plot-60 plot-60 plot-60 plot-60 plot-60 plot-60 plot-60
## [169] plot-60
## 30 Levels: plot-10 plot-12 plot-14 plot-16 plot-18 plot-2 ... plot-8
```


Correct way:

```r
x.factor <- data$Plot
levels(x.factor)[levels(x.factor) == "plot-2"] <- "new plot name"
x.factor
```

```
##   [1] new plot name new plot name new plot name new plot name new plot name
##   [6] new plot name plot-4        plot-6        plot-6        plot-6       
##  [11] plot-8        plot-8        plot-8        plot-8        plot-8       
##  [16] plot-10       plot-10       plot-10       plot-10       plot-12      
##  [21] plot-12       plot-12       plot-12       plot-12       plot-14      
##  [26] plot-14       plot-14       plot-14       plot-14       plot-16      
##  [31] plot-16       plot-16       plot-16       plot-16       plot-16      
##  [36] plot-16       plot-18       plot-18       plot-18       plot-18      
##  [41] plot-18       plot-18       plot-20       plot-20       plot-20      
##  [46] plot-20       plot-20       plot-20       plot-20       plot-20      
##  [51] plot-22       plot-22       plot-24       plot-24       plot-24      
##  [56] plot-24       plot-24       plot-24       plot-26       plot-26      
##  [61] plot-26       plot-26       plot-26       plot-26       plot-28      
##  [66] plot-28       plot-28       plot-28       plot-28       plot-28      
##  [71] plot-30       plot-30       plot-30       plot-30       plot-30      
##  [76] plot-30       plot-30       plot-32       plot-32       plot-32      
##  [81] plot-34       plot-34       plot-34       plot-34       plot-36      
##  [86] plot-36       plot-36       plot-36       plot-36       plot-36      
##  [91] plot-36       plot-38       plot-38       plot-38       plot-38      
##  [96] plot-38       plot-40       plot-40       plot-40       plot-40      
## [101] plot-40       plot-40       plot-40       plot-40       plot-40      
## [106] plot-42       plot-42       plot-44       plot-44       plot-44      
## [111] plot-44       plot-44       plot-44       plot-46       plot-46      
## [116] plot-46       plot-46       plot-46       plot-46       plot-46      
## [121] plot-48       plot-48       plot-48       plot-48       plot-48      
## [126] plot-48       plot-50       plot-50       plot-50       plot-50      
## [131] plot-50       plot-50       plot-50       plot-50       plot-52      
## [136] plot-52       plot-52       plot-52       plot-52       plot-52      
## [141] plot-52       plot-54       plot-54       plot-54       plot-54      
## [146] plot-54       plot-54       plot-54       plot-56       plot-56      
## [151] plot-56       plot-56       plot-56       plot-56       plot-58      
## [156] plot-58       plot-58       plot-58       plot-58       plot-58      
## [161] plot-58       plot-60       plot-60       plot-60       plot-60      
## [166] plot-60       plot-60       plot-60       plot-60      
## 30 Levels: plot-10 plot-12 plot-14 plot-16 plot-18 ... plot-8
```


Factors can be very useful, but can also be very annoying.  To
disable automatic conversion, use the `stringsAsFactors` argument
to `read.csv`.

```r
data <- read.csv("data/seed_root_herbivores.csv", stringsAsFactors = FALSE)
data$Plot
```

```
##   [1] "plot-2"  "plot-2"  "plot-2"  "plot-2"  "plot-2"  "plot-2"  "plot-4" 
##   [8] "plot-6"  "plot-6"  "plot-6"  "plot-8"  "plot-8"  "plot-8"  "plot-8" 
##  [15] "plot-8"  "plot-10" "plot-10" "plot-10" "plot-10" "plot-12" "plot-12"
##  [22] "plot-12" "plot-12" "plot-12" "plot-14" "plot-14" "plot-14" "plot-14"
##  [29] "plot-14" "plot-16" "plot-16" "plot-16" "plot-16" "plot-16" "plot-16"
##  [36] "plot-16" "plot-18" "plot-18" "plot-18" "plot-18" "plot-18" "plot-18"
##  [43] "plot-20" "plot-20" "plot-20" "plot-20" "plot-20" "plot-20" "plot-20"
##  [50] "plot-20" "plot-22" "plot-22" "plot-24" "plot-24" "plot-24" "plot-24"
##  [57] "plot-24" "plot-24" "plot-26" "plot-26" "plot-26" "plot-26" "plot-26"
##  [64] "plot-26" "plot-28" "plot-28" "plot-28" "plot-28" "plot-28" "plot-28"
##  [71] "plot-30" "plot-30" "plot-30" "plot-30" "plot-30" "plot-30" "plot-30"
##  [78] "plot-32" "plot-32" "plot-32" "plot-34" "plot-34" "plot-34" "plot-34"
##  [85] "plot-36" "plot-36" "plot-36" "plot-36" "plot-36" "plot-36" "plot-36"
##  [92] "plot-38" "plot-38" "plot-38" "plot-38" "plot-38" "plot-40" "plot-40"
##  [99] "plot-40" "plot-40" "plot-40" "plot-40" "plot-40" "plot-40" "plot-40"
## [106] "plot-42" "plot-42" "plot-44" "plot-44" "plot-44" "plot-44" "plot-44"
## [113] "plot-44" "plot-46" "plot-46" "plot-46" "plot-46" "plot-46" "plot-46"
## [120] "plot-46" "plot-48" "plot-48" "plot-48" "plot-48" "plot-48" "plot-48"
## [127] "plot-50" "plot-50" "plot-50" "plot-50" "plot-50" "plot-50" "plot-50"
## [134] "plot-50" "plot-52" "plot-52" "plot-52" "plot-52" "plot-52" "plot-52"
## [141] "plot-52" "plot-54" "plot-54" "plot-54" "plot-54" "plot-54" "plot-54"
## [148] "plot-54" "plot-56" "plot-56" "plot-56" "plot-56" "plot-56" "plot-56"
## [155] "plot-58" "plot-58" "plot-58" "plot-58" "plot-58" "plot-58" "plot-58"
## [162] "plot-60" "plot-60" "plot-60" "plot-60" "plot-60" "plot-60" "plot-60"
## [169] "plot-60"
```


My strategy:

1. only use factors when you know they are needed, otherwise prefer
   character vectors.
2. delay conversion to factor as long as posible.

They do have uses though.

* Preserve ordering:

By default, ordering is alphabetical; gets confused when number of
digits changes ("a10" sorts before "a9").

```r
table(data$Plot)
```

```
## 
## plot-10 plot-12 plot-14 plot-16 plot-18  plot-2 plot-20 plot-22 plot-24 
##       4       5       5       7       6       6       8       2       6 
## plot-26 plot-28 plot-30 plot-32 plot-34 plot-36 plot-38  plot-4 plot-40 
##       6       6       7       3       4       7       5       1       9 
## plot-42 plot-44 plot-46 plot-48 plot-50 plot-52 plot-54 plot-56 plot-58 
##       2       6       7       6       8       7       7       6       7 
##  plot-6 plot-60  plot-8 
##       3       8       5
```


In this data set, the plots are already in native order

```r
unique(data$Plot)
```

```
##  [1] "plot-2"  "plot-4"  "plot-6"  "plot-8"  "plot-10" "plot-12" "plot-14"
##  [8] "plot-16" "plot-18" "plot-20" "plot-22" "plot-24" "plot-26" "plot-28"
## [15] "plot-30" "plot-32" "plot-34" "plot-36" "plot-38" "plot-40" "plot-42"
## [22] "plot-44" "plot-46" "plot-48" "plot-50" "plot-52" "plot-54" "plot-56"
## [29] "plot-58" "plot-60"
```

We can pass that in as the `levels` argument to factor to get this
ordering

```r
tmp <- factor(data$Plot, levels = unique(data$Plot))
```

which is preserved in functions that use factors

```r
table(tmp)
```

```
## tmp
##  plot-2  plot-4  plot-6  plot-8 plot-10 plot-12 plot-14 plot-16 plot-18 
##       6       1       3       5       4       5       5       7       6 
## plot-20 plot-22 plot-24 plot-26 plot-28 plot-30 plot-32 plot-34 plot-36 
##       8       2       6       6       6       7       3       4       7 
## plot-38 plot-40 plot-42 plot-44 plot-46 plot-48 plot-50 plot-52 plot-54 
##       5       9       2       6       7       6       8       7       7 
## plot-56 plot-58 plot-60 
##       6       7       8
```


(this emphasises the "delay conversion" part of the strategy
above).

* Factors are required for some analyses, and are needed to specify
  "constrasts" in some models.

---
Back to [main page](/intro)
