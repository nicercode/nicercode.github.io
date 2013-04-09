---
layout: post
title: "Figure functions"
date: 2013-04-05 16:41
comments: true
categories: R plotting
author: Rich FitzJohn
published: false
---

Transitioning from an interactive plot in R to a publication-ready
plot can create a messy script file with lots of statements and use of
global variables.  This post outlines an approach that I have used to
simplify the process and keeps code readable.

The usual way of plotting to a file is to open a plotting device (such
as `pdf` or `png`) run a series of commands that generate plotting
output, and then close the device with `dev.off()`.  However, the way
that most plots are developed is purely interactively.  So you start
with:

```r
set.seed(10)
x <- runif(100)
y <- rnorm(100, x)
par(mar=c(4.1, 4.1, .5, .5))
plot(y ~ x, las=1)
fit <- lm(y ~ x)
abline(fit, col="red")
legend("topleft", c("Data", "Trend"),
       pch=c(1, NA), lty=c(NA, 1), col=c("black", "red"), bty="n")
```

Then to convert this into a figure for publication we copy and paste
this between the device commands:

```
pdf("my-plot.pdf", width=6, height=4)
  # ...pasted commands from before
dev.off()
```

<!-- more -->

This leads to bits of code that often look like this:

```
# pdf("my-plot.pdf", width=6, height=4) # uncomment to make plot
set.seed(10)
x <- runif(100)
y <- rnorm(100, x)
par(mar=c(4.1, 4.1, .5, .5))
plot(y ~ x, las=1)
fit <- lm(y ~ x)
abline(fit, col="red")
legend("topleft", c("Data", "Trend"),
       pch=c(1, NA), lty=c(NA, 1), col=c("black", "red"), bty="n")
# dev.off() # uncomment to make plot
```

which is all pretty ugly.  On top of that, we're often making a bunch
of variables that are global but are really only useful in the context
of the figure (in this case the `fit` object that contains the trend
line).  An arguably worse solution would be simply to duplicate the
plotting bits of code.

## A partial solution:

The solution that I usually use is to make a function that generates
the figure.

```
fig.trend <- function() {
  set.seed(10)
  x <- runif(100)
  y <- rnorm(100, x)
  par(mar=c(4.1, 4.1, .5, .5))
  plot(y ~ x, las=1)
  fit <- lm(y ~ x)
  abline(fit, col="red")
  legend("topleft", c("Data", "Trend"),
         pch=c(1, NA), lty=c(NA, 1), col=c("black", "red"), bty="n")
}
```

Then you can easily see the figure

```
fig.trend() # generates figure
```

or

```
source("R/figures.R") # refresh file that defines fig.trend
fig.trend()
```

and you can easily generate plots:

```
pdf("figs/trend.pdf", width=6, height=8)
fig.trend()
dev.off()
```

However, this still gets a bit unweildly when you have a large number
of figures to make (especially for talks where you might make 20 or 30
figures).

```
pdf("figs/trend.pdf", width=6, height=4)
fig.trend()
dev.off()
 
pdf("figs/other.pdf", width=6, height=4)
fig.other()
dev.off()
```

## A full solution

The solution I use here is a little function called `to.pdf`:

```
to.pdf <- function(expr, filename, ..., verbose=TRUE) {
  if ( verbose )
    cat(sprintf("Creating %s\n", filename))
  pdf(filename, ...)
  on.exit(dev.off())
  eval.parent(substitute(expr))
}
```

Which can be used like so:

```
to.pdf(fig.trend(), "figs/trend.pdf", width=6, height=4)
to.pdf(fig.other(), "figs/other.pdf", width=6, height=4)
```

A couple of nice things about this approach:

* It becomes much easier to read and compare the parameters to the
  plotting device (width, height, etc).
* We're reduced things from 6 repetitive lines to 2 that capture our
  intent better.
* Using functions, rather than statements in the global environment,
  discourages dependency on global variables.  This in turn helps
  identify reusable chunks of code.
* Arguments are all passed to `pdf` via `...`, so we don't need to
  duplicate `pdf`'s argument list in our function.
* The `on.exit` call ensures that the device is always closed, even if
  the figure function fails.

For talks, I often build up figures piece-by-piece.  This can be done
like so (for a two-part figure)

```
fig.progressive <- function(with.trend=FALSE) {
  set.seed(10)
  x <- runif(100)
  y <- rnorm(100, x)
  par(mar=c(4.1, 4.1, .5, .5))
  plot(y ~ x, las=1)
  if ( with.trend ) {
    fit <- lm(y ~ x)
    abline(fit, col="red")
    legend("topleft", c("Data", "Trend"),
           pch=c(1, NA), lty=c(NA, 1), col=c("black", "red"), bty="n")
  }
}
```

Now -- if run with as

```
fig.progressive(FALSE)
```

just the data are plotted, and if run as 

```
fig.progressive(TRUE)
```

the trend line and legend are included.  Then with the `to.pdf`
function, we can do:

```
to.pdf(fig.progressive(TRUE),  "figs/progressive-1.pdf", width=6, height=4)
to.pdf(fig.progressive(FALSE), "figs/progressive-2.pdf", width=6, height=4)
```

which will generate the two figures.

The general idea can be expanded to more devices:

```
to.dev <- function(expr, dev, filename, ..., verbose=TRUE) {
  if ( verbose )
    cat(sprintf("Creating %s\n", filename))
  dev(filename, ...)
  on.exit(dev.off())
  eval.parent(substitute(expr))
}
```

where we would do:

```
to.dev(fig.progressive(TRUE),  pdf, "figs/progressive-1.pdf", width=6, height=4)
to.dev(fig.progressive(FALSE), pdf, "figs/progressive-2.pdf", width=6, height=4)
```

Note that with this `to.dev` function we can rewrite the `to.pdf`
function more compactly:

```
to.pdf <- function(expr, filename, ...)
  to.dev(expr, pdf, filename, ...)
```

Or write a similar function for the `png` device:

```
to.png_function(expr, filename, ...)
  to.dev(expr, png, filename)
```

(As an alternative, the `dev.copy2pdf` function can be useful for
copying the current contents of an interactive plotting window to a
pdf).
