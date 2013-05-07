---
layout: post
title: "How long is a function?"
date: 2013-05-07 11:10
comments: true
author: Rich FitzJohn
categories: 
---

Within the R project and contributed packages, how long do functions
tend to be?  In our experience, people seem to think that functions
are only needed when you need to use a piece of code multiple times,
or when you have a really large problem.  However, many functions are
actually very small.

<!-- more -->

R allows a lot of "computation on the language", simply meaning that
we can look inside objects easily.  Here is a function that returns
the number of lines in a function.

```r
function.length <- function(f) {
  if (is.character(f))
    f <- match.fun(f)
  length(deparse(f))
}
```

This works because `deparse` converts an object back into text (that
could in turn be parsed):

```r
writeLines(deparse(function.length))
```

```plain
function (f) 
{
    if (is.character(f)) 
        f <- match.fun(f)
    length(deparse(f))
}
```

so the `function.length` function is itself 6 lines long by this
measure.  Note that the formatting is actually a bit different, in
particular indentation, braces position and spacing is different,
following the likes of the R-core style guide.

Most packages consist mostly of functions: here is a function that
extracts all functions from a package:

```
package.functions <- function(package) {
  pkg <- sprintf("package:%s", package)
  object.names <- ls(name=pkg)
  objects <- lapply(object.names, get, pkg)
  names(objects) <- object.names
  objects[sapply(objects, is.function)]
}
```

Finally, we can get the lengths of all functions in a package:

```
package.function.lengths <- function(package)
  vapply(package.functions(package), function.length, integer(1))
```

Looking at the recommended package "boot"

```r
library(boot)
package.function.lengths("boot")
```

```plain
         abc.ci            boot      boot.array         boot.ci 
             54             126              56              80 
       censboot         control            corr            cum3 
            137              72               8               8 
         cv.glm     EEF.profile      EL.profile          empinf 
             42              16              27              79 
       envelope        exp.tilt      freq.array        glm.diag 
             56              49               7              19 
 glm.diag.plots     imp.moments        imp.prob    imp.quantile 
             69              37              34              39 
    imp.weights       inv.logit jack.after.boot       k3.linear 
             34               2              69              14 
         lik.CI   linear.approx           logit     nested.corr 
             36              34               2              28 
        norm.ci          saddle    saddle.distn         simplex 
             33             179             281              65 
       smooth.f       tilt.boot          tsboot      var.linear 
             36              57              97              14 
```

I have 138 packages installed on my computer (mostly through
dependencies -- small compared with the ~4000 on CRAN!).  We need to
load them all before we can access the functions within:

```r
library(utils)
packages <- rownames(installed.packages())
for (p in packages)
  library(p, character.only=TRUE)
```

Then we can apply the `package.function.lengths` to each package.

```r
lens <- lapply(packages, package.function.lengths)
```

The median function length is only 12 lines (and remember that
includes things like the function arguments)!

```r
median(unlist(lens))
```

```plain
[1] 12
```

The distribution of function lengths is strongly right skewed, with
most functions being very short.  Ignoring the 1% of functions that
are longer than 200 lines long, the distribution of function lengths
looks like this:

```
tmp <- unlist(lens)
hist(tmp[tmp <= 200], main="", xlab="Function length (lines)")
```

{% img /images/function-length-distribution.png %}

Then plot the distribution of the per-package median (that is, for
each package compute the median function length in terms of lines of
code and plot the distribution of those medians).

```
lens.median <- sapply(lens, median)
hist(lens.median, main="", xlab="Per-package median function length")
```

{% img /images/function-length-median.png %}

The median package has a median function length of 16 lines.  There
are handful of extremely long functions in most packages; over all
packages, the median "longest function" is 120 lines.
