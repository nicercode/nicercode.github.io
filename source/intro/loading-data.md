---
layout: page
title: "Reading in data"
date: 2013-03-18 10:25
comments: true
sharing: true
footer: false
---




As empirical biologists, you'll generally have data to read in.
You probably have your data in an Excel spreadsheet.  The simplest
way to load these into R is to save a copy of the data as a comma
separated values file (csv) and work with that.

It is actually possibl to read directly from Excel (but see the
[gdata](http://cran.r-project.org/web/packages/gdata/index.html)
package that has a `read.xls` function, and see
[this](http://rwiki.sciviews.org/doku.php?id=tips:data-io:ms_windows)
page for other alternatives.  This is usually more hassle than it's
worth, and going through a comma separated file is easy enough.

To load the data into R:

```r
data <- read.csv("data/seed_root_herbivores.csv")
```


(this doesn't usually produce any output -- the data is "just
there" now).

Clicking the little table icon next to the data in the Workspace
browser will view the data.  Running `View(data)` will do the same
thing.

The `data` variable contains `data.frame` object.  It is a number
of columns of the same length, arranged like a matrix.  That
sentence is tricky, for reasons that will become apparent.

Often, looking at the first few rows is all you need to remind
yourself about what is in a data set.

```r
head(data)
```

```plain
    Plot Seed.herbivore Root.herbivore No.stems Height Weight Seed.heads
1 plot-2           TRUE           TRUE        1     31   4.16         83
2 plot-2           TRUE           TRUE        3     41   5.82        175
3 plot-2           TRUE           TRUE        1     42   3.51         72
4 plot-2           TRUE          FALSE        1     64   7.16        125
5 plot-2           TRUE          FALSE        1     47   6.17        212
6 plot-2           TRUE          FALSE        1     52   5.32        114
  Seeds.in.25.heads
1                 7
2                 0
3                32
4                22
5                 3
6                19
```


You can get a vector of names of columns

```r
names(data)
```

```plain
[1] "Plot"              "Seed.herbivore"    "Root.herbivore"   
[4] "No.stems"          "Height"            "Weight"           
[7] "Seed.heads"        "Seeds.in.25.heads"
```


You can get the number of rows:

```r
nrow(data)
```

```plain
[1] 169
```


and the number of columns

```r
ncol(data)
```

```plain
[1] 8
```

```r
length(data)
```

```plain
[1] 8
```


The last one is surprising to most people.  There is a logical (if
not good) reason for this, which we will get to later.

Aside from issues around factors and character vectors (that we'll
cover shortly) this is most of what you need to know about loading
data.

However, it's useful to know things about saving it.

* column names should be consistent, the right length, contain no
  special characters.

* for missing values, either leave them blank or use NA.  But be
  consistent and don't use -999 or ? or your cat's name.

* Be careful with whitespace "x" will be treated differently to
  "x ", and Excel makes it easy to accidently do the latter.
  Consider the `strip.white=TRUE` argument to `read.csv`.

* Think about the type of the data.  We'll cover this more, but are
  you dealing with a `TRUE`/`FALSE` or a category or a count or a
  measurements.

* Dates and times will cause you nothing but pain.  Excel and R
  *both* have issues with dates and times, and exporting through
  CSV can make them worse.  I had a case with two different
  year-zero offsets being used in one exported file.  I recommend
  Year-Month-Day ([ISO 8601](http://en.wikipedia.org/wiki/ISO_8601)
  format, or different colummns for different entries and combine
  later.

* Watch out for dashes between numbers.  Excel will convert these
  into dates.  So if you have "Site-Plant" style numbers 5-20 will
  get converted into the 20th of May 1904 or something equally
  useless.  Similar problems happen to
  [gene names](http://www.biomedcentral.com/1471-2105/5/80)
  in bioinformatics!
 
* Merged rows and columns will not work (or at least not in an
  easily predictible way.

* Spare rows at the top, or double header rows will not work
  without jumping through hoops.

* Equations will (should) convert to the value displayed in Excel
  on export.





## Exercise:

The file `data/seed_root_herbivores.txt` has *almost* the same
data, but in tab separated format (it does have the same number of
rows and columns).  Look at the ?read.table help page and work out
how to load this file in.

Remember: `==` tests for equality, `!=` tests for inequality




```r
data2 <- read.table("data/seed_root_herbivores.txt",
                    header=TRUE, sep=";")
data2 == data
```

```plain
       Plot Seed.herbivore Root.herbivore No.stems Height Weight
  [1,] TRUE           TRUE           TRUE     TRUE   TRUE   TRUE
  [2,] TRUE           TRUE           TRUE     TRUE   TRUE   TRUE
  [3,] TRUE           TRUE           TRUE     TRUE   TRUE   TRUE
  [4,] TRUE           TRUE           TRUE     TRUE   TRUE   TRUE
  [5,] TRUE           TRUE           TRUE     TRUE   TRUE   TRUE
  [6,] TRUE           TRUE           TRUE     TRUE   TRUE   TRUE
  [7,] TRUE           TRUE           TRUE     TRUE   TRUE   TRUE
  [8,] TRUE           TRUE           TRUE     TRUE   TRUE   TRUE
  [9,] TRUE           TRUE           TRUE     TRUE   TRUE   TRUE
 [10,] TRUE           TRUE           TRUE     TRUE   TRUE   TRUE
 [11,] TRUE           TRUE           TRUE     TRUE   TRUE   TRUE
 [12,] TRUE           TRUE           TRUE     TRUE   TRUE   TRUE
 [13,] TRUE           TRUE           TRUE     TRUE   TRUE   TRUE
 [14,] TRUE           TRUE           TRUE     TRUE   TRUE   TRUE
 [15,] TRUE           TRUE           TRUE     TRUE   TRUE   TRUE
 [16,] TRUE           TRUE           TRUE     TRUE   TRUE   TRUE
 [17,] TRUE           TRUE           TRUE     TRUE   TRUE   TRUE
 [18,] TRUE           TRUE           TRUE     TRUE   TRUE   TRUE
 [19,] TRUE           TRUE           TRUE     TRUE   TRUE   TRUE
 [20,] TRUE           TRUE           TRUE     TRUE  FALSE   TRUE
 [21,] TRUE           TRUE           TRUE     TRUE   TRUE   TRUE
       Seed.heads Seeds.in.25.heads
  [1,]       TRUE              TRUE
  [2,]       TRUE              TRUE
  [3,]       TRUE              TRUE
  [4,]       TRUE              TRUE
  [5,]       TRUE              TRUE
  [6,]       TRUE              TRUE
  [7,]       TRUE              TRUE
  [8,]       TRUE              TRUE
  [9,]       TRUE              TRUE
 [10,]       TRUE              TRUE
 [11,]       TRUE              TRUE
 [12,]       TRUE              TRUE
 [13,]       TRUE              TRUE
 [14,]       TRUE              TRUE
 [15,]       TRUE              TRUE
 [16,]       TRUE              TRUE
 [17,]       TRUE              TRUE
 [18,]       TRUE              TRUE
 [19,]       TRUE              TRUE
 [20,]       TRUE              TRUE
 [21,]       TRUE              TRUE
 [ reached getOption("max.print") -- omitted 148 rows ]
```

or

```r
data2 != data
```

```plain
        Plot Seed.herbivore Root.herbivore No.stems Height Weight
  [1,] FALSE          FALSE          FALSE    FALSE  FALSE  FALSE
  [2,] FALSE          FALSE          FALSE    FALSE  FALSE  FALSE
  [3,] FALSE          FALSE          FALSE    FALSE  FALSE  FALSE
  [4,] FALSE          FALSE          FALSE    FALSE  FALSE  FALSE
  [5,] FALSE          FALSE          FALSE    FALSE  FALSE  FALSE
  [6,] FALSE          FALSE          FALSE    FALSE  FALSE  FALSE
  [7,] FALSE          FALSE          FALSE    FALSE  FALSE  FALSE
  [8,] FALSE          FALSE          FALSE    FALSE  FALSE  FALSE
  [9,] FALSE          FALSE          FALSE    FALSE  FALSE  FALSE
 [10,] FALSE          FALSE          FALSE    FALSE  FALSE  FALSE
 [11,] FALSE          FALSE          FALSE    FALSE  FALSE  FALSE
 [12,] FALSE          FALSE          FALSE    FALSE  FALSE  FALSE
 [13,] FALSE          FALSE          FALSE    FALSE  FALSE  FALSE
 [14,] FALSE          FALSE          FALSE    FALSE  FALSE  FALSE
 [15,] FALSE          FALSE          FALSE    FALSE  FALSE  FALSE
 [16,] FALSE          FALSE          FALSE    FALSE  FALSE  FALSE
 [17,] FALSE          FALSE          FALSE    FALSE  FALSE  FALSE
 [18,] FALSE          FALSE          FALSE    FALSE  FALSE  FALSE
 [19,] FALSE          FALSE          FALSE    FALSE  FALSE  FALSE
 [20,] FALSE          FALSE          FALSE    FALSE   TRUE  FALSE
 [21,] FALSE          FALSE          FALSE    FALSE  FALSE  FALSE
       Seed.heads Seeds.in.25.heads
  [1,]      FALSE             FALSE
  [2,]      FALSE             FALSE
  [3,]      FALSE             FALSE
  [4,]      FALSE             FALSE
  [5,]      FALSE             FALSE
  [6,]      FALSE             FALSE
  [7,]      FALSE             FALSE
  [8,]      FALSE             FALSE
  [9,]      FALSE             FALSE
 [10,]      FALSE             FALSE
 [11,]      FALSE             FALSE
 [12,]      FALSE             FALSE
 [13,]      FALSE             FALSE
 [14,]      FALSE             FALSE
 [15,]      FALSE             FALSE
 [16,]      FALSE             FALSE
 [17,]      FALSE             FALSE
 [18,]      FALSE             FALSE
 [19,]      FALSE             FALSE
 [20,]      FALSE             FALSE
 [21,]      FALSE             FALSE
 [ reached getOption("max.print") -- omitted 148 rows ]
```


The point here is that many of the functions and operators in R
will try to do the Right Thing, depending on what you give them.

This won't work, because the default arguments of `read.table` and
`read.csv` are different for the header.

```r
tmp <- read.table("data/seed_root_herbivores.txt", sep=";")
head(tmp)
```

```plain
      V1             V2             V3       V4     V5     V6         V7
1   Plot Seed.herbivore Root.herbivore No.stems Height Weight Seed.heads
2 plot-2           TRUE           TRUE        1     31   4.16         83
3 plot-2           TRUE           TRUE        3     41   5.82        175
4 plot-2           TRUE           TRUE        1     42   3.51         72
5 plot-2           TRUE          FALSE        1     64   7.16        125
6 plot-2           TRUE          FALSE        1     47   6.17        212
                 V8
1 Seeds.in.25.heads
2                 7
3                 0
4                32
5                22
6                 3
```


Notice that a fake header (V1, V2, etc) has been created and the
actual header is now the first row of data.

## Looking at your data

There are other ways of looking at your data.  The `summary`
function works with most types, and gives a by-column summary of
the data set

```r
summary(data)
```

```plain
      Plot     Seed.herbivore  Root.herbivore     No.stems    
 plot-40:  9   Mode :logical   Mode :logical   Min.   : 1.00  
 plot-20:  8   FALSE:90        FALSE:58        1st Qu.: 1.00  
 plot-50:  8   TRUE :79        TRUE :111       Median : 1.00  
 plot-60:  8   NA's :0         NA's :0         Mean   : 1.98  
 plot-16:  7                                   3rd Qu.: 3.00  
 plot-30:  7                                   Max.   :10.00  
 (Other):122                                                  
     Height         Weight        Seed.heads   Seeds.in.25.heads
 Min.   :16.0   Min.   : 0.26   Min.   :   3   Min.   :  0.0    
 1st Qu.:44.0   1st Qu.: 4.08   1st Qu.:  93   1st Qu.: 10.0    
 Median :54.0   Median : 8.05   Median : 175   Median : 19.0    
 Mean   :55.5   Mean   :11.20   Mean   : 226   Mean   : 22.1    
 3rd Qu.:67.0   3rd Qu.:14.77   3rd Qu.: 303   3rd Qu.: 32.0    
 Max.   :97.0   Max.   :55.51   Max.   :1003   Max.   :100.0    
                                                                
```


# Subsetting

So, we see there is an issue in the file -- how to we get to it?

There a bunch of different ways of extracting bits of your data.

## Columns of `data.frames`

Get the column `Plot`

```r
data$Plot
```

```plain
  [1] plot-2  plot-2  plot-2  plot-2  plot-2  plot-2  plot-4  plot-6 
  [9] plot-6  plot-6  plot-8  plot-8  plot-8  plot-8  plot-8  plot-10
 [17] plot-10 plot-10 plot-10 plot-12 plot-12 plot-12 plot-12 plot-12
 [25] plot-14 plot-14 plot-14 plot-14 plot-14 plot-16 plot-16 plot-16
 [33] plot-16 plot-16 plot-16 plot-16 plot-18 plot-18 plot-18 plot-18
 [41] plot-18 plot-18 plot-20 plot-20 plot-20 plot-20 plot-20 plot-20
 [49] plot-20 plot-20 plot-22 plot-22 plot-24 plot-24 plot-24 plot-24
 [57] plot-24 plot-24 plot-26 plot-26 plot-26 plot-26 plot-26 plot-26
 [65] plot-28 plot-28 plot-28 plot-28 plot-28 plot-28 plot-30 plot-30
 [73] plot-30 plot-30 plot-30 plot-30 plot-30 plot-32 plot-32 plot-32
 [81] plot-34 plot-34 plot-34 plot-34 plot-36 plot-36 plot-36 plot-36
 [89] plot-36 plot-36 plot-36 plot-38 plot-38 plot-38 plot-38 plot-38
 [97] plot-40 plot-40 plot-40 plot-40 plot-40 plot-40 plot-40 plot-40
[105] plot-40 plot-42 plot-42 plot-44 plot-44 plot-44 plot-44 plot-44
[113] plot-44 plot-46 plot-46 plot-46 plot-46 plot-46 plot-46 plot-46
[121] plot-48 plot-48 plot-48 plot-48 plot-48 plot-48 plot-50 plot-50
[129] plot-50 plot-50 plot-50 plot-50 plot-50 plot-50 plot-52 plot-52
[137] plot-52 plot-52 plot-52 plot-52 plot-52 plot-54 plot-54 plot-54
[145] plot-54 plot-54 plot-54 plot-54 plot-56 plot-56 plot-56 plot-56
[153] plot-56 plot-56 plot-58 plot-58 plot-58 plot-58 plot-58 plot-58
[161] plot-58 plot-60 plot-60 plot-60 plot-60 plot-60 plot-60 plot-60
[169] plot-60
30 Levels: plot-10 plot-12 plot-14 plot-16 plot-18 plot-2 ... plot-8
```


This does *almost* the same thing

```r
data[["Plot"]]
```

```plain
  [1] plot-2  plot-2  plot-2  plot-2  plot-2  plot-2  plot-4  plot-6 
  [9] plot-6  plot-6  plot-8  plot-8  plot-8  plot-8  plot-8  plot-10
 [17] plot-10 plot-10 plot-10 plot-12 plot-12 plot-12 plot-12 plot-12
 [25] plot-14 plot-14 plot-14 plot-14 plot-14 plot-16 plot-16 plot-16
 [33] plot-16 plot-16 plot-16 plot-16 plot-18 plot-18 plot-18 plot-18
 [41] plot-18 plot-18 plot-20 plot-20 plot-20 plot-20 plot-20 plot-20
 [49] plot-20 plot-20 plot-22 plot-22 plot-24 plot-24 plot-24 plot-24
 [57] plot-24 plot-24 plot-26 plot-26 plot-26 plot-26 plot-26 plot-26
 [65] plot-28 plot-28 plot-28 plot-28 plot-28 plot-28 plot-30 plot-30
 [73] plot-30 plot-30 plot-30 plot-30 plot-30 plot-32 plot-32 plot-32
 [81] plot-34 plot-34 plot-34 plot-34 plot-36 plot-36 plot-36 plot-36
 [89] plot-36 plot-36 plot-36 plot-38 plot-38 plot-38 plot-38 plot-38
 [97] plot-40 plot-40 plot-40 plot-40 plot-40 plot-40 plot-40 plot-40
[105] plot-40 plot-42 plot-42 plot-44 plot-44 plot-44 plot-44 plot-44
[113] plot-44 plot-46 plot-46 plot-46 plot-46 plot-46 plot-46 plot-46
[121] plot-48 plot-48 plot-48 plot-48 plot-48 plot-48 plot-50 plot-50
[129] plot-50 plot-50 plot-50 plot-50 plot-50 plot-50 plot-52 plot-52
[137] plot-52 plot-52 plot-52 plot-52 plot-52 plot-54 plot-54 plot-54
[145] plot-54 plot-54 plot-54 plot-54 plot-56 plot-56 plot-56 plot-56
[153] plot-56 plot-56 plot-58 plot-58 plot-58 plot-58 plot-58 plot-58
[161] plot-58 plot-60 plot-60 plot-60 plot-60 plot-60 plot-60 plot-60
[169] plot-60
30 Levels: plot-10 plot-12 plot-14 plot-16 plot-18 plot-2 ... plot-8
```


This is the main difference: if the column name is in a variable,
then `$` won't work, while `[[` will.  Let's define a variable `v`
that has the name if the first column as its value:

```r
v <- "Plot"
```


We can extract this column of the data set using the `[[` notation:

```r
data[[v]]
```

```plain
  [1] plot-2  plot-2  plot-2  plot-2  plot-2  plot-2  plot-4  plot-6 
  [9] plot-6  plot-6  plot-8  plot-8  plot-8  plot-8  plot-8  plot-10
 [17] plot-10 plot-10 plot-10 plot-12 plot-12 plot-12 plot-12 plot-12
 [25] plot-14 plot-14 plot-14 plot-14 plot-14 plot-16 plot-16 plot-16
 [33] plot-16 plot-16 plot-16 plot-16 plot-18 plot-18 plot-18 plot-18
 [41] plot-18 plot-18 plot-20 plot-20 plot-20 plot-20 plot-20 plot-20
 [49] plot-20 plot-20 plot-22 plot-22 plot-24 plot-24 plot-24 plot-24
 [57] plot-24 plot-24 plot-26 plot-26 plot-26 plot-26 plot-26 plot-26
 [65] plot-28 plot-28 plot-28 plot-28 plot-28 plot-28 plot-30 plot-30
 [73] plot-30 plot-30 plot-30 plot-30 plot-30 plot-32 plot-32 plot-32
 [81] plot-34 plot-34 plot-34 plot-34 plot-36 plot-36 plot-36 plot-36
 [89] plot-36 plot-36 plot-36 plot-38 plot-38 plot-38 plot-38 plot-38
 [97] plot-40 plot-40 plot-40 plot-40 plot-40 plot-40 plot-40 plot-40
[105] plot-40 plot-42 plot-42 plot-44 plot-44 plot-44 plot-44 plot-44
[113] plot-44 plot-46 plot-46 plot-46 plot-46 plot-46 plot-46 plot-46
[121] plot-48 plot-48 plot-48 plot-48 plot-48 plot-48 plot-50 plot-50
[129] plot-50 plot-50 plot-50 plot-50 plot-50 plot-50 plot-52 plot-52
[137] plot-52 plot-52 plot-52 plot-52 plot-52 plot-54 plot-54 plot-54
[145] plot-54 plot-54 plot-54 plot-54 plot-56 plot-56 plot-56 plot-56
[153] plot-56 plot-56 plot-58 plot-58 plot-58 plot-58 plot-58 plot-58
[161] plot-58 plot-60 plot-60 plot-60 plot-60 plot-60 plot-60 plot-60
[169] plot-60
30 Levels: plot-10 plot-12 plot-14 plot-16 plot-18 plot-2 ... plot-8
```

but using the `$` notation won't work as it will look for the
column *called* `v`:

```r
data$v
```

```plain
NULL
```

It returns `NULL` to indicate that the column does not exist
(confusingly, this value can be difficult to work with and give
cryptic error messages.  More confusingly, getting a nonexistant
column with `[[` generates an error instead).

Also, `data$P` will "expand" to make `data$Plot`, but `data$S` will
return `NULL` because that is ambiguous.  Always use the full name!

Single square brackets also index the data, but do so differently.
This returns a `data.frame` with one column:

```r
head(data["Plot"])
```

```plain
    Plot
1 plot-2
2 plot-2
3 plot-2
4 plot-2
5 plot-2
6 plot-2
```

This returns a `data.frame` with two columns:

```r
head(data[c("Plot", "Weight")])
```

```plain
    Plot Weight
1 plot-2   4.16
2 plot-2   5.82
3 plot-2   3.51
4 plot-2   7.16
5 plot-2   6.17
6 plot-2   5.32
```

(I'm just using `head` here to keep the output under control.  If
you actually wanted a `data.frame` like this you might do

```r
data.sub <- data[c("Plot", "Weight")]
```

and then continue to use the new `data.sub` object).

The difference between `[` and `[[` can be confusing.

The best explanation I have seen is that imagine that the thing you
are subsetting is a train with a bunch of carriages.  `[x]` returns
a new train with carriages represented by the variable `x`.  So
`train[c(1,2)]` returns a train with just the first two carriages,
and `train[1]` returns a train with just the first carriage.  The
`[[` operator gets the *contents* of a single carriage.  So
`train[[1]]` gets the *contents* of the first carriage, and
`train[[c(1,2)]]` doesn't make any sense.

## Looking at your data (cont.)

Plotting is covered in the next R module, but it's one of the best
things about R so I can't resist showing how to do it:

Here is a histogram of the height variable:

```r
hist(data$Height)
```

![plot of chunk unnamed-chunk-20](../images/intro/intro-unnamed-chunk-20.png) 

(it will appear in the bottom right of your screen)

Here is a scatter plot of Height vs weight:

```r
plot(data$Weight, data$Height)
```

![plot of chunk unnamed-chunk-21](../images/intro/intro-unnamed-chunk-21.png) 

The order of arguments is *x*-variable, *y*-variable.

There is an alternative interface using R's "formulae" -- you'll
see this a lot in statistical models.  Read this as "`Height` is a
function of `Weight`".  It makes nicer axis labels, too.

```r
plot(Height ~ Weight, data)
```

![plot of chunk unnamed-chunk-22](../images/intro/intro-unnamed-chunk-22.png) 


Here is a series of bivariate plots for height, weight and the
number of seed heads:

```r
pairs(data[c("Height", "Weight", "Seed.heads")])
```

![plot of chunk unnamed-chunk-23](../images/intro/intro-unnamed-chunk-23.png) 


The take-home being that R makes it very easy to create graphs, and
most people who use it casually just make plots of whatever they're
looking at.  The plots can vary from quick and dirty like this to
really beautiful pieces of art.

## Rows of `data.frames`

Extracting a row always returns a new `data.frame`

```r
data[10,]
```

```plain
     Plot Seed.herbivore Root.herbivore No.stems Height Weight Seed.heads
10 plot-6           TRUE           TRUE        1     33   2.58         43
   Seeds.in.25.heads
10                 8
```

```r
data[10:20,]
```

```plain
      Plot Seed.herbivore Root.herbivore No.stems Height Weight Seed.heads
10  plot-6           TRUE           TRUE        1     33   2.58         43
11  plot-8          FALSE          FALSE        1     51   5.98        114
12  plot-8          FALSE           TRUE        1     41   2.75         60
13  plot-8          FALSE           TRUE        1     38   2.15         68
14  plot-8          FALSE          FALSE        4     61  21.59        330
15  plot-8          FALSE          FALSE        1     46   6.86        134
16 plot-10           TRUE           TRUE        1     34   3.36         97
17 plot-10           TRUE           TRUE        1     50  15.76        395
18 plot-10           TRUE           TRUE        1     51   8.73        280
19 plot-10           TRUE           TRUE        3     33   3.24         68
20 plot-12          FALSE           TRUE        1     41   2.49         58
   Seeds.in.25.heads
10                 8
11                 5
12                50
13                52
14                19
15                40
16                 9
17                24
18                11
19                21
20                11
```

```r
data[c(1, 5, 10),]
```

```plain
     Plot Seed.herbivore Root.herbivore No.stems Height Weight Seed.heads
1  plot-2           TRUE           TRUE        1     31   4.16         83
5  plot-2           TRUE          FALSE        1     47   6.17        212
10 plot-6           TRUE           TRUE        1     33   2.58         43
   Seeds.in.25.heads
1                  7
5                  3
10                 8
```


## Be careful with indexing by location

The above all index by *name* or by *location* (index).  However,
you generally want to avoid referencing by number in your saved
code, e.g.:

```r
data.height <- data[[5]]
```


This is because if you change the order of your spreadsheet (add or
delete a column), everything that depends on `data.height` may
change.  You may also see people do this in their code.

```r
data.height <- data[,5]
```


This should really be avoided.  By name is much more robust and
easy to read later on, even if it is more typing at first.

```r
data.height <- data$Height
data.height <- data[["Height"]]
```


When should you index by location?

When you are *computing* the indices.  As an example: suppose that
you wanted every other row (perhaps you're trying to generate a
nonrandom some sample of data?)  Remember `seq` from above?  We can
generate a sequnce of integers 1, 3, ..., up to the last (or second
to last) row in our data set like this:

```r
idx <- seq(1, nrow(data), by=2)
```

Then subset like this:

```r
data.oddrows <- data[idx,]
```


Our new data set has half the rows of the old data set:

```r
nrow(data.oddrows)
```

```plain
[1] 85
```

```r
nrow(data)
```

```plain
[1] 169
```


Because row names are preserved, you can see the odd numbers in the
row names.

```r
head(data.oddrows)
```

```plain
     Plot Seed.herbivore Root.herbivore No.stems Height Weight Seed.heads
1  plot-2           TRUE           TRUE        1     31   4.16         83
3  plot-2           TRUE           TRUE        1     42   3.51         72
5  plot-2           TRUE          FALSE        1     47   6.17        212
7  plot-4          FALSE           TRUE        3     57  23.44        522
9  plot-6           TRUE           TRUE        1     40   4.01         81
11 plot-8          FALSE          FALSE        1     51   5.98        114
   Seeds.in.25.heads
1                  7
3                 32
5                  3
7                  7
9                 46
11                 5
```


## Indexing by logical vector

This is one of the most powerful ways of indexing.

Remember our data mismatch:

```r
data != data2
```

```plain
        Plot Seed.herbivore Root.herbivore No.stems Height Weight
  [1,] FALSE          FALSE          FALSE    FALSE  FALSE  FALSE
  [2,] FALSE          FALSE          FALSE    FALSE  FALSE  FALSE
  [3,] FALSE          FALSE          FALSE    FALSE  FALSE  FALSE
  [4,] FALSE          FALSE          FALSE    FALSE  FALSE  FALSE
  [5,] FALSE          FALSE          FALSE    FALSE  FALSE  FALSE
  [6,] FALSE          FALSE          FALSE    FALSE  FALSE  FALSE
  [7,] FALSE          FALSE          FALSE    FALSE  FALSE  FALSE
  [8,] FALSE          FALSE          FALSE    FALSE  FALSE  FALSE
  [9,] FALSE          FALSE          FALSE    FALSE  FALSE  FALSE
 [10,] FALSE          FALSE          FALSE    FALSE  FALSE  FALSE
 [11,] FALSE          FALSE          FALSE    FALSE  FALSE  FALSE
 [12,] FALSE          FALSE          FALSE    FALSE  FALSE  FALSE
 [13,] FALSE          FALSE          FALSE    FALSE  FALSE  FALSE
 [14,] FALSE          FALSE          FALSE    FALSE  FALSE  FALSE
 [15,] FALSE          FALSE          FALSE    FALSE  FALSE  FALSE
 [16,] FALSE          FALSE          FALSE    FALSE  FALSE  FALSE
 [17,] FALSE          FALSE          FALSE    FALSE  FALSE  FALSE
 [18,] FALSE          FALSE          FALSE    FALSE  FALSE  FALSE
 [19,] FALSE          FALSE          FALSE    FALSE  FALSE  FALSE
 [20,] FALSE          FALSE          FALSE    FALSE   TRUE  FALSE
 [21,] FALSE          FALSE          FALSE    FALSE  FALSE  FALSE
       Seed.heads Seeds.in.25.heads
  [1,]      FALSE             FALSE
  [2,]      FALSE             FALSE
  [3,]      FALSE             FALSE
  [4,]      FALSE             FALSE
  [5,]      FALSE             FALSE
  [6,]      FALSE             FALSE
  [7,]      FALSE             FALSE
  [8,]      FALSE             FALSE
  [9,]      FALSE             FALSE
 [10,]      FALSE             FALSE
 [11,]      FALSE             FALSE
 [12,]      FALSE             FALSE
 [13,]      FALSE             FALSE
 [14,]      FALSE             FALSE
 [15,]      FALSE             FALSE
 [16,]      FALSE             FALSE
 [17,]      FALSE             FALSE
 [18,]      FALSE             FALSE
 [19,]      FALSE             FALSE
 [20,]      FALSE             FALSE
 [21,]      FALSE             FALSE
 [ reached getOption("max.print") -- omitted 148 rows ]
```


There is one entry in the `Height` row that disagrees.  How can we
extract the line that the mismatch is on?

We could do it by index:

```r
data[20,]
```

```plain
      Plot Seed.herbivore Root.herbivore No.stems Height Weight Seed.heads
20 plot-12          FALSE           TRUE        1     41   2.49         58
   Seeds.in.25.heads
20                11
```

```r
data2[20,]
```

```plain
      Plot Seed.herbivore Root.herbivore No.stems Height Weight Seed.heads
20 plot-12          FALSE           TRUE        1   45.1   2.49         58
   Seeds.in.25.heads
20                11
```


But that requires us to look for the error, note the row, write it
down, etc.  Boring, and computers are less error prone than
humans.  Plus, I just said that we should not do that.

This is a logical vector that indicates where the entries in vector
1 disagree with vector 2:

```r
data.differ <- data$Height != data2$Height
```


We can index by this - it will return rows for which there are true
values:

```r
data[data.differ,]
```

```plain
      Plot Seed.herbivore Root.herbivore No.stems Height Weight Seed.heads
20 plot-12          FALSE           TRUE        1     41   2.49         58
   Seeds.in.25.heads
20                11
```

```r
data2[data.differ,]
```

```plain
      Plot Seed.herbivore Root.herbivore No.stems Height Weight Seed.heads
20 plot-12          FALSE           TRUE        1   45.1   2.49         58
   Seeds.in.25.heads
20                11
```


You can convert from a logical (`TRUE`/`FALSE`) vector to an
integer vector with the `which` function:

```r
which(data.differ)
```

```plain
[1] 20
```


This can be really useful.

### Excercise:
1. Return all the rows in `data` where both data sets have the *same*
   value for `Height`.
2. Return all the rows in `data` from `plot-8`

#### A solution:

```r
data.same <- data$Height == data2$Height
data[data.same,]
```

```plain
       Plot Seed.herbivore Root.herbivore No.stems Height Weight
1    plot-2           TRUE           TRUE        1     31   4.16
2    plot-2           TRUE           TRUE        3     41   5.82
3    plot-2           TRUE           TRUE        1     42   3.51
4    plot-2           TRUE          FALSE        1     64   7.16
5    plot-2           TRUE          FALSE        1     47   6.17
6    plot-2           TRUE          FALSE        1     52   5.32
7    plot-4          FALSE           TRUE        3     57  23.44
8    plot-6           TRUE           TRUE        2     27   1.76
9    plot-6           TRUE           TRUE        1     40   4.01
10   plot-6           TRUE           TRUE        1     33   2.58
11   plot-8          FALSE          FALSE        1     51   5.98
12   plot-8          FALSE           TRUE        1     41   2.75
13   plot-8          FALSE           TRUE        1     38   2.15
14   plot-8          FALSE          FALSE        4     61  21.59
15   plot-8          FALSE          FALSE        1     46   6.86
16  plot-10           TRUE           TRUE        1     34   3.36
17  plot-10           TRUE           TRUE        1     50  15.76
18  plot-10           TRUE           TRUE        1     51   8.73
19  plot-10           TRUE           TRUE        3     33   3.24
21  plot-12          FALSE           TRUE        2     67  14.06
22  plot-12          FALSE           TRUE        4     30   3.94
    Seed.heads Seeds.in.25.heads
1           83                 7
2          175                 0
3           72                32
4          125                22
5          212                 3
6          114                19
7          522                 7
8           28                24
9           81                46
10          43                 8
11         114                 5
12          60                50
13          68                52
14         330                19
15         134                40
16          97                 9
17         395                24
18         280                11
19          68                21
21         253                 4
22          85                 6
 [ reached getOption("max.print") -- omitted 147 rows ]
```


or:

```r
data[!data.differ,]
```

```plain
       Plot Seed.herbivore Root.herbivore No.stems Height Weight
1    plot-2           TRUE           TRUE        1     31   4.16
2    plot-2           TRUE           TRUE        3     41   5.82
3    plot-2           TRUE           TRUE        1     42   3.51
4    plot-2           TRUE          FALSE        1     64   7.16
5    plot-2           TRUE          FALSE        1     47   6.17
6    plot-2           TRUE          FALSE        1     52   5.32
7    plot-4          FALSE           TRUE        3     57  23.44
8    plot-6           TRUE           TRUE        2     27   1.76
9    plot-6           TRUE           TRUE        1     40   4.01
10   plot-6           TRUE           TRUE        1     33   2.58
11   plot-8          FALSE          FALSE        1     51   5.98
12   plot-8          FALSE           TRUE        1     41   2.75
13   plot-8          FALSE           TRUE        1     38   2.15
14   plot-8          FALSE          FALSE        4     61  21.59
15   plot-8          FALSE          FALSE        1     46   6.86
16  plot-10           TRUE           TRUE        1     34   3.36
17  plot-10           TRUE           TRUE        1     50  15.76
18  plot-10           TRUE           TRUE        1     51   8.73
19  plot-10           TRUE           TRUE        3     33   3.24
21  plot-12          FALSE           TRUE        2     67  14.06
22  plot-12          FALSE           TRUE        4     30   3.94
    Seed.heads Seeds.in.25.heads
1           83                 7
2          175                 0
3           72                32
4          125                22
5          212                 3
6          114                19
7          522                 7
8           28                24
9           81                46
10          43                 8
11         114                 5
12          60                50
13          68                52
14         330                19
15         134                40
16          97                 9
17         395                24
18         280                11
19          68                21
21         253                 4
22          85                 6
 [ reached getOption("max.print") -- omitted 147 rows ]
```

read `!x` as "not x",


```r
data[data$Plot == "plot-8",]
```

```plain
     Plot Seed.herbivore Root.herbivore No.stems Height Weight Seed.heads
11 plot-8          FALSE          FALSE        1     51   5.98        114
12 plot-8          FALSE           TRUE        1     41   2.75         60
13 plot-8          FALSE           TRUE        1     38   2.15         68
14 plot-8          FALSE          FALSE        4     61  21.59        330
15 plot-8          FALSE          FALSE        1     46   6.86        134
   Seeds.in.25.heads
11                 5
12                50
13                52
14                19
15                40
```


Subsetting can be useful when you want to look at bits of your
data.  For example, all the rows where the Height is at least 10
and there was no seed herbivore:

```r
data[data$Height > 10 & data$Seed.herbivore,]
```

```plain
       Plot Seed.herbivore Root.herbivore No.stems Height Weight
1    plot-2           TRUE           TRUE        1     31   4.16
2    plot-2           TRUE           TRUE        3     41   5.82
3    plot-2           TRUE           TRUE        1     42   3.51
4    plot-2           TRUE          FALSE        1     64   7.16
5    plot-2           TRUE          FALSE        1     47   6.17
6    plot-2           TRUE          FALSE        1     52   5.32
8    plot-6           TRUE           TRUE        2     27   1.76
9    plot-6           TRUE           TRUE        1     40   4.01
10   plot-6           TRUE           TRUE        1     33   2.58
16  plot-10           TRUE           TRUE        1     34   3.36
17  plot-10           TRUE           TRUE        1     50  15.76
18  plot-10           TRUE           TRUE        1     51   8.73
19  plot-10           TRUE           TRUE        3     33   3.24
25  plot-14           TRUE           TRUE        1     61  12.74
26  plot-14           TRUE          FALSE        1     50   7.58
27  plot-14           TRUE           TRUE        1     44   1.57
28  plot-14           TRUE          FALSE        1     50   7.96
29  plot-14           TRUE           TRUE        3     45   5.59
37  plot-18           TRUE          FALSE        1     37   3.92
38  plot-18           TRUE          FALSE        1     49   3.99
39  plot-18           TRUE          FALSE        1     72  13.62
    Seed.heads Seeds.in.25.heads
1           83                 7
2          175                 0
3           72                32
4          125                22
5          212                 3
6          114                19
8           28                24
9           81                46
10          43                 8
16          97                 9
17         395                24
18         280                11
19          68                21
25         371                21
26         145                13
27          36                55
28         162                25
29         173                16
37          98                 1
38          96                 5
39         348                29
 [ reached getOption("max.print") -- omitted 58 rows ]
```


The `&` operator here is a logical "and" (read `x & y` as "x and
y"):

 * `TRUE  & TRUE`  is `TRUE`
 * `TRUE  & FALSE` is `FALSE`
 * `FALSE & TRUE`  is `FALSE`
 * `FALSE & FALSE` is `FALSE`

In contrast, the `|` operator is a logical "or" (read as "or")

 * `TRUE  | TRUE`  is `TRUE`
 * `TRUE  | FALSE` is `TRUE`
 * `FALSE | TRUE`  is `TRUE`
 * `FALSE | FALSE` is `FALSE`

The other, less common, operator is the exclusive or:

 * `xor(TRUE,  TRUE)`  is `FALSE`
 * `xor(TRUE,  FALSE)` is `TRUE`
 * `xor(FALSE, TRUE)`  is `TRUE`
 * `xor(FALSE, FALSE)` is `FALSE`

So you can do all sorts of crazy things like

```r
data[data$Plot == "plot-2" & data$Seed.herbivore & data$Root.herbivore,]
```

```plain
    Plot Seed.herbivore Root.herbivore No.stems Height Weight Seed.heads
1 plot-2           TRUE           TRUE        1     31   4.16         83
2 plot-2           TRUE           TRUE        3     41   5.82        175
3 plot-2           TRUE           TRUE        1     42   3.51         72
  Seeds.in.25.heads
1                 7
2                 0
3                32
```

and get all the cases in plot 2 where there were both seed
herbivores and root herbivores.  Or

```r
data[data$Height > 75 & (data$Seed.herbivore | data$Root.herbivore),]
```

```plain
       Plot Seed.herbivore Root.herbivore No.stems Height Weight
31  plot-16          FALSE           TRUE        3     76  18.55
42  plot-18           TRUE           TRUE        1     77  16.08
73  plot-30           TRUE           TRUE        1     89  27.70
111 plot-44          FALSE           TRUE        3     80  19.40
112 plot-44          FALSE           TRUE        1     80  15.61
115 plot-46           TRUE           TRUE        1     84  14.64
127 plot-50           TRUE          FALSE        2     94  55.51
131 plot-50           TRUE          FALSE        2     77  12.34
134 plot-50           TRUE          FALSE        3     97  41.21
137 plot-52          FALSE           TRUE        1     76  10.54
147 plot-54           TRUE           TRUE        1     80  28.16
155 plot-58           TRUE          FALSE        1     80  11.56
    Seed.heads Seeds.in.25.heads
31         379                19
42         261                27
73         561                 3
111        278                41
112        255                 3
115        288                34
127        963                39
131        182                49
134        685                25
137        231                35
147        376                12
155        220                20
```

and get all the plants that are quite tall in treatments with
*either* a seed herbivore or a root herbivore (or both).

You can build these up if you want:

```r
idx.tall <- data$Height > 75
idx.herbivore <- data$Seed.herbivore | data$Root.herbivore
idx.select <- idx.tall & idx.herbivore
data[idx.select,]
```

```plain
       Plot Seed.herbivore Root.herbivore No.stems Height Weight
31  plot-16          FALSE           TRUE        3     76  18.55
42  plot-18           TRUE           TRUE        1     77  16.08
73  plot-30           TRUE           TRUE        1     89  27.70
111 plot-44          FALSE           TRUE        3     80  19.40
112 plot-44          FALSE           TRUE        1     80  15.61
115 plot-46           TRUE           TRUE        1     84  14.64
127 plot-50           TRUE          FALSE        2     94  55.51
131 plot-50           TRUE          FALSE        2     77  12.34
134 plot-50           TRUE          FALSE        3     97  41.21
137 plot-52          FALSE           TRUE        1     76  10.54
147 plot-54           TRUE           TRUE        1     80  28.16
155 plot-58           TRUE          FALSE        1     80  11.56
    Seed.heads Seeds.in.25.heads
31         379                19
42         261                27
73         561                 3
111        278                41
112        255                 3
115        288                34
127        963                39
131        182                49
134        685                25
137        231                35
147        376                12
155        220                20
```


whatever you find easiest to read and write.

> Programs should be written for people to read, and only
> incidentally for machines to execute (Structure and
> Interpretation of Computer Programs" by Abelson and Sussman)

### The `subset` function to simplify writing complex subsets

There is a function `subset` that may help you write complex
subsets.

```r
subset(data, Height > 75 & (Seed.herbivore | Root.herbivore))
```

```plain
       Plot Seed.herbivore Root.herbivore No.stems Height Weight
31  plot-16          FALSE           TRUE        3     76  18.55
42  plot-18           TRUE           TRUE        1     77  16.08
73  plot-30           TRUE           TRUE        1     89  27.70
111 plot-44          FALSE           TRUE        3     80  19.40
112 plot-44          FALSE           TRUE        1     80  15.61
115 plot-46           TRUE           TRUE        1     84  14.64
127 plot-50           TRUE          FALSE        2     94  55.51
131 plot-50           TRUE          FALSE        2     77  12.34
134 plot-50           TRUE          FALSE        3     97  41.21
137 plot-52          FALSE           TRUE        1     76  10.54
147 plot-54           TRUE           TRUE        1     80  28.16
155 plot-58           TRUE          FALSE        1     80  11.56
    Seed.heads Seeds.in.25.heads
31         379                19
42         261                27
73         561                 3
111        278                41
112        255                 3
115        288                34
127        963                39
131        182                49
134        685                25
137        231                35
147        376                12
155        220                20
```


This can help, especially interactively, but it can also bite you.
It is not always obvious where the "value" of the variables in the
second argument are coming from.  For example:

```r
subset(data, idx.tall & (Seed.herbivore | Root.herbivore))
```

```plain
       Plot Seed.herbivore Root.herbivore No.stems Height Weight
31  plot-16          FALSE           TRUE        3     76  18.55
42  plot-18           TRUE           TRUE        1     77  16.08
73  plot-30           TRUE           TRUE        1     89  27.70
111 plot-44          FALSE           TRUE        3     80  19.40
112 plot-44          FALSE           TRUE        1     80  15.61
115 plot-46           TRUE           TRUE        1     84  14.64
127 plot-50           TRUE          FALSE        2     94  55.51
131 plot-50           TRUE          FALSE        2     77  12.34
134 plot-50           TRUE          FALSE        3     97  41.21
137 plot-52          FALSE           TRUE        1     76  10.54
147 plot-54           TRUE           TRUE        1     80  28.16
155 plot-58           TRUE          FALSE        1     80  11.56
    Seed.heads Seeds.in.25.heads
31         379                19
42         261                27
73         561                 3
111        278                41
112        255                 3
115        288                34
127        963                39
131        182                49
134        685                25
137        231                35
147        376                12
155        220                20
```

This works fine, because it found `idx.tall`.  So when you read
your code, you need to think carefully about which values are
coming from the `data.frame` and which are coming from elsewhere.

This is an unfortunate example of a function designed to be used by
beginners, but it only really understandable once you understand
more of what is going on.  You'll see it used widely, and it can
simplify things.  But be careful.

## Adding new columns

It is easy to add new columns, perhaps based on old ones:

```r
data$small.plant <- data$Height < 50
head(data)
```

```plain
    Plot Seed.herbivore Root.herbivore No.stems Height Weight Seed.heads
1 plot-2           TRUE           TRUE        1     31   4.16         83
2 plot-2           TRUE           TRUE        3     41   5.82        175
3 plot-2           TRUE           TRUE        1     42   3.51         72
4 plot-2           TRUE          FALSE        1     64   7.16        125
5 plot-2           TRUE          FALSE        1     47   6.17        212
6 plot-2           TRUE          FALSE        1     52   5.32        114
  Seeds.in.25.heads small.plant
1                 7        TRUE
2                 0        TRUE
3                32        TRUE
4                22       FALSE
5                 3        TRUE
6                19       FALSE
```


You can delete a column by setting it to `NULL`:

```r
data$small.plant <- NULL
head(data)
```

```plain
    Plot Seed.herbivore Root.herbivore No.stems Height Weight Seed.heads
1 plot-2           TRUE           TRUE        1     31   4.16         83
2 plot-2           TRUE           TRUE        3     41   5.82        175
3 plot-2           TRUE           TRUE        1     42   3.51         72
4 plot-2           TRUE          FALSE        1     64   7.16        125
5 plot-2           TRUE          FALSE        1     47   6.17        212
6 plot-2           TRUE          FALSE        1     52   5.32        114
  Seeds.in.25.heads
1                 7
2                 0
3                32
4                22
5                 3
6                19
```


In this data set, the last column contains the number of seeds in
25 seed heads.  However, there weren't always 25 seed heads on a
plant:

```r
data[data$Seed.heads < 25,]
```

```plain
       Plot Seed.herbivore Root.herbivore No.stems Height Weight
55  plot-24          FALSE           TRUE        1     16   0.26
85  plot-36          FALSE           TRUE        1     43   0.77
107 plot-42           TRUE           TRUE        1     23   0.47
    Seed.heads Seeds.in.25.heads
55           4                 1
85          14                 4
107          3                 0
```


In these three cases, the column contains the number of seeds over
*all* seed heads.

**Question**: How do we compute the mean number of seeds per seed
head?


```r
data$Seeds.per.head <- data$Seeds.in.25.heads / 25
idx.few.heads <- data$Seed.heads < 25
data$Seeds.per.head[idx.few.heads] <-
  data$Seeds.in.25.heads[idx.few.heads] / data$Seed.heads[idx.few.heads]
```


R generally offers several ways of doing things:

```r
alternative <- data$Seeds.in.25.heads / pmin(data$Seed.heads, 25)
alternative == data$Seeds.per.head
```

```plain
  [1] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
 [15] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
 [29] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
 [43] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
 [57] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
 [71] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
 [85] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
 [99] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
[113] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
[127] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
[141] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
[155] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
[169] TRUE
```


Use the `all` function to determine if all values are TRUE:

```r
all(alternative == data$Seeds.per.head)
```

```plain
[1] TRUE
```


## (bonus topic) Indexing need not make things smaller

Given this vector with the first give letters of the alphabet:

```r
x <- c("a", "b", "c", "d", "e")
```

Repeat the first letter once, the second letter twice, etc.

```r
x[c(1, 2, 2, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 5)]
```

```plain
 [1] "a" "b" "b" "c" "c" "c" "d" "d" "d" "d" "e" "e" "e" "e" "e"
```

Much better!

```r
x[rep(1:5, 1:5)]
```

```plain
 [1] "a" "b" "b" "c" "c" "c" "d" "d" "d" "d" "e" "e" "e" "e" "e"
```

`rep` is incredibly useful, and can be used in many ways.  See the
help page `?rep`

---
Back to [main page](/intro)
