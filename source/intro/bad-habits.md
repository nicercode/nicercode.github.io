---
layout: page
title: "Bad Habits"
date: 2013-03-18 10:25
comments: true
sharing: true
footer: false
---

It is easy to pick up bad habits.  Here is a non-exaustive list in no
particular order

1. Avoid indexing by location unless you compute those locations
(covered in [Loading data](loading-data.html)

2. Don't use `T` and `F` as shortcuts for `TRUE` and `FALSE`.  This
   dates back to the language that predates R.  For why not to do
   this, try running `T <- FALSE`.  Now both `T` and `F` are `FALSE`!
   Try running `TRUE <- FALSE` --- R prevents you from doing this.
   
3. Don't be inconsistent (i.e., be consistent) with assignment
   symbols, variable names, etc.  The more consistent you are, the
   easier you will find it to revisit your code in the future.
   
4. Don't use `attach`.  I'm debating even listing this function's
   name, but don't use it.  If you see it in somebody's code, don't
   copy it.  Just trust me on this one.
   
5. Avoid copy and pasting large chunks of code between projects.  Once
   you get in the habit of making functions, copy *those* around, but
   I have seen huge messes of code with problems that are impossible
   to track down due to this.
   
6. Don't write enormously long functions that are difficult to read
   (this is sometimes unavoidable to a degree in cleaning up
   ecological data).  Try to have each function do just one thing.
   
7. Don't write functions that depend on global variables, as this
   makes it hard to use those functions elsewhere (which was the point
   of writing them!).  All data should be given as a
   
8. Do document your work.  You probably cannot have enough describing
   where data files came from, what scripts do what, how particular
   pieces of code work.  Avoid writing comments that just repeat what
   the code says, and try and write comments that describe your
   intent, reasons for approaches, sources of data / code / algorithm
   --- things that will make your life easier when you come back to a
   project.
   
9. Keep things tidy.  Tidy computing workspaces are as important as
   tidy as tidy lab workspaces.  People have thought about this a bit,
   e.g.: [Noble 2009](http://dx.doi.org/10.1371/journal.pcbi.1000424)
   (PLOS Computational Biology).  This is a constant battle against
   entropy.
   
10. Indent your code, and do it consistently.  There are many styles
   (google around to be amazed) but proper indentation is the
   difference between easy to read and hard to read code, as indent
   depth implies something about program structure.  Take our variance
   function from earlier.
   
```r
variance <- function(x) {
  n <- length(x)
m <- mean(x)
(1 / (n-1)) * sum((x - m)^2)
  }
variance(data$Height)
```
vs
```r
variance <- function(x) {
  n <- length(x)
  m <- mean(x)
  (1 / (n-1)) * sum((x - m)^2)
}
variance(data$Height)
```

