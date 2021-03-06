---
layout: page
ti4tle: "Basic Graphing in R"
date: 2013-03-22 10:25
comments: true
sharing: true
footer: false
---





R is capable of producing publication-quality graphics.  During this session, we will  develop your R skills by introducing you to the basics of graphing. 

Typing `plot(1,1)` does a lot by default.  For example, the axes are automatically set to encapsulate the data, a box is drawn around the plotting space, and some basic labels are given as well.

Similarly, typing `hist(rnorm(100))` or `boxplot(rnorm(100))` does a lot of the work for you.

Plotting in R is about layering data and detail onto a canvas. So, let's start with a blank canvas:

```r
plot(5, 5, type="n", axes=FALSE, ann=FALSE, xlim=c(0, 10), ylim = c(0,10))
```

![plot of chunk unnamed-chunk-2](../images/intro/plotting-unnamed-chunk-2.png) 


We are simply calling a new plotting device (`plot` always initiates a new device), plotting the coordinates (5,5), which we can't see because of `type="n"`, and we're also telling R that we don't want any default axes or annotations (e.g., titles or axis labels).  Basically, we just want a blank slate.  Finally, we set the x- and y-axis ranges, so that we  have some space to work.

Let's add the default axis:

```r
plot(5, 5, type="n", axes=FALSE, ann=FALSE, xlim=c(0, 10), ylim = c(0,10))
axis(1)
```

![plot of chunk unnamed-chunk-3](../images/intro/plotting-unnamed-chunk-3.png) 


If you look at the helpfile for axis (`?axis`) you'll see that you can pretty much control any apsect of axis creation.  The only argument required for an axis is the side of the plot you want it on.  Here 1 and 2 correspond with x and y; 3 and 4 also correspond with x and y, but on the other side of the plot (e.g., for secondary axes).

Let's add the y-axis:

```r
plot(5, 5, type="n", axes=FALSE, ann=FALSE, xlim=c(0, 10), ylim = c(0,10))
axis(1)
axis(2)
```

![plot of chunk unnamed-chunk-4](../images/intro/plotting-unnamed-chunk-4.png) 


I prefer tick labels to align horizontally where possible.  Here we use the argument `las=2` ("label axis style"?).  A value of 2 means "always horizontal".

```r
plot(5, 5, type="n", axes=FALSE, ann=FALSE, xlim=c(0, 10), ylim = c(0,10))
axis(1)
axis(2, las=2)
```

![plot of chunk unnamed-chunk-5](../images/intro/plotting-unnamed-chunk-5.png) 


When plotting with R you are adding subsequent layers to your canvas.  If something needs redoing, you need to start again from stratch.  Therefore, it is very important to save a graph's provenance using a text editor.  If you change something, re-run all the lines of code to generate your graph.  Saving as text is also great for when you want re-use a particular graphic style that you've developed. Graphing is one part of the scientific process for which you have some creative freedom.

Next, add axis labels and a title:

```r
plot(5, 5, type="n", axes=FALSE, ann=FALSE, xlim=c(0, 10), ylim = c(0,10))
axis(1)
axis(2, las=2)
mtext("x-axis", side = 1, line = 3)
mtext("y-axis", side = 2, line = 3)
title("My progressive plot")
```

![plot of chunk unnamed-chunk-6](../images/intro/plotting-unnamed-chunk-6.png) 


`mtext` stands for margin text.  You need an argument for the text to be printed, one for the side of the plot (as for the `axis` function), and one saying how far from the axis you want to label is numbers of "lines".  Generally, the tick marks are at the zeroth line (`line=0`) and the tick labels in the first line.  The default for plot is `line=3`, which I generally leave as is.  You don't generally need titles for plots in manuscripts, but they can come in handy for presentations, blogs, etc.

There is also the figure `box()`, which I don't tend to use, but you may want to (?):

```r
plot(5, 5, type="n", axes=FALSE, ann=FALSE, xlim=c(0, 10), ylim = c(0,10))
axis(1)
axis(2, las=2)
mtext("x-axis", side = 1, line = 3)
mtext("y-axis", side = 2, line = 3)
title("My progressive plot")
box()
```

![plot of chunk unnamed-chunk-7](../images/intro/plotting-unnamed-chunk-7.png) 


Let's add some data.  A red point at (5,5):

```r
plot(5, 5, type="n", axes=FALSE, ann=FALSE, xlim=c(0, 10), ylim = c(0,10))
axis(1)
axis(2, las=2)
mtext("x-axis", side = 1, line = 3)
mtext("y-axis", side = 2, line = 3)
title("My progressive plot")
box()
points(5, 5, col="red")
points(5, 7, col="orange", pch=3, cex=2)
points(c(0, 0, 1), c(2, 4, 6), col="green", pch=4)
```

![plot of chunk unnamed-chunk-8](../images/intro/plotting-unnamed-chunk-8.png) 

```r

# http://rgraphics.limnology.wisc.edu/images/miscellaneous/pch.png
```


Now set your random number generator seed to 11, so that our plots all look the same.  We'll simulate some data.  First, some normally distribution "independent" values.  Then, some values that depend on these first set of values via a prescribed relationship and error distribution: 

```r
plot(5, 5, type="n", axes=FALSE, ann=FALSE, xlim=c(0, 10), ylim = c(0,10))
axis(1)
axis(2, las=2)
mtext("x-axis", side = 1, line = 3)
mtext("y-axis", side = 2, line = 3)
title("My progressive plot")
box()
points(5, 5, col="red")
points(5, 7, col="orange", pch=3, cex=2)
points(c(0, 0, 1), c(2, 4, 6), col="green", pch=4)
set.seed(11)
x <- rnorm(100, 5, 1.5)
y <- rnorm(100, 2 + 0.66*x)
points(x, y, pch=21, col="white", bg="black")
```

![plot of chunk unnamed-chunk-9](../images/intro/plotting-unnamed-chunk-9.png) 


Typing `?points` will give you the common options for the points function.  I have used `pch=21` (presumably "plotting character"?).  The character (a circle) is white and the character background is black.  I like this, because it helps distinguish points when they overlap.

Fit a linear model and add the line of best-fit.

```r
mod <- lm(y ~ x)
summary(mod)
```

```plain

Call:
lm(formula = y ~ x)

Residuals:
    Min      1Q  Median      3Q     Max 
-2.4229 -0.5412 -0.0208  0.5534  2.6547 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)
(Intercept)   2.0414     0.3616    5.65  1.6e-07
x             0.6768     0.0723    9.37  2.9e-15

Residual standard error: 0.986 on 98 degrees of freedom
Multiple R-squared: 0.472,	Adjusted R-squared: 0.467 
F-statistic: 87.7 on 1 and 98 DF,  p-value: 2.86e-15 
```


Add the regression line:

```r
plot(5, 5, type="n", axes=FALSE, ann=FALSE, xlim=c(0, 10), ylim = c(0,10))
axis(1)
axis(2, las=2)
mtext("x-axis", side = 1, line = 3)
mtext("y-axis", side = 2, line = 3)
title("My progressive plot")
box()
points(5, 5, col="red")
points(5, 7, col="orange", pch=3, cex=2)
points(c(0, 0, 1), c(2, 4, 6), col="green", pch=4)
set.seed(11)
x <- rnorm(100, 5, 1.5)
y <- rnorm(100, 2 + 0.66*x)
points(x, y, pch=21, col="white", bg="black")
abline(mod)
```

![plot of chunk unnamed-chunk-11](../images/intro/plotting-unnamed-chunk-11.png) 


You see that the model estimates reflect the parameters we used to generate the data (`lm` appears to be working).  Let's add some elements to our graph that highlight these fitted model results. Start by generating a sequence of numbers spanning the range of x:

```r
x.seq <- seq(0, 10, 0.1)  # ss <- seq(min(x), max(x), 0.1)
```


Using the best-fit model, we can now predict values for each of the values in the `x.seq` vector:

```r
y.fit <- predict(mod, list(x = x.seq))

# This is essentially what `abline(mod)` has done, and so there is no point plotting these again.  However, using the `interval` argument, we can extract prediction and confidence intervals:
y.pred <- predict(mod, list(x = x.seq), interval = "prediction")

plot(5, 5, type="n", axes=FALSE, ann=FALSE, xlim=c(0, 10), ylim = c(0,10))
axis(1)
axis(2, las=2)
mtext("x-axis", side = 1, line = 3)
mtext("y-axis", side = 2, line = 3)
title("My progressive plot")
box()
points(5, 5, col="red")
points(5, 7, col="orange", pch=3, cex=2)
points(c(0, 0, 1), c(2, 4, 6), col="green", pch=4)
points(x, y, pch=21, col="white", bg="black")
abline(mod)
lines(x.seq, y.pred[,"lwr"], lty = 2)
lines(x.seq, y.pred[,"upr"], lty = 2)
```

![plot of chunk unnamed-chunk-13](../images/intro/plotting-unnamed-chunk-13.png) 


`lty=2` (presumably "line type"?) makes a dashed line.  What's the difference between confidence intervals and prediction intervals?  Now, let's calculate confidence intervals and do something a little bit more exciting: a transparent, shaded confidence band:

```r
y.conf <- predict(mod, list(x = x.seq), interval = "confidence")

plot(5, 5, type="n", axes=FALSE, ann=FALSE, xlim=c(0, 10), ylim = c(0,10))
axis(1)
axis(2, las=2)
mtext("x-axis", side = 1, line = 3)
mtext("y-axis", side = 2, line = 3)
title("My progressive plot")
box()
points(5, 5, col="red")
points(5, 7, col="orange", pch=3, cex=2)
points(c(0, 0, 1), c(2, 4, 6), col="green", pch=4)
points(x, y, pch=21, col="white", bg="black")
lines(x.seq, y.pred[,"lwr"], lty = 2)
lines(x.seq, y.pred[,"upr"], lty = 2)
polygon(c(x.seq, rev(x.seq)), c(y.conf[,"lwr"], rev(y.conf[,"upr"])), col = rgb(0,0,0,0.2), border = NA)
```

![plot of chunk unnamed-chunk-14](../images/intro/plotting-unnamed-chunk-14.png) 


Text can also be added easily, using the coordinates of the current plot:

```r
plot(5, 5, type="n", axes=FALSE, ann=FALSE, xlim=c(0, 10), ylim = c(0,10))
axis(1)
axis(2, las=2)
mtext("x-axis", side = 1, line = 3)
mtext("y-axis", side = 2, line = 3)
title("My progressive plot")
box()
points(5, 5, col="red")
points(5, 7, col="orange", pch=3, cex=2)
points(c(0, 0, 1), c(2, 4, 6), col="green", pch=4)
points(x, y, pch=21, col="white", bg="black")
abline(mod)
lines(x.seq, y.pred[,"lwr"], lty = 2)
lines(x.seq, y.pred[,"upr"], lty = 2)
polygon(c(x.seq, rev(x.seq)), c(y.conf[,"lwr"], rev(y.conf[,"upr"])), col = rgb(0,0,0,0.2), border = NA)
text(1, 10, "A", cex=1.5)
mtext("A", side=3, adj=0, cex=1.5)
text(3, 8.5, expression(Y[i] == beta[0]+beta[1]*X[i1]+epsilon[i]))  # see demo(plotmath) for more examples
```

![plot of chunk unnamed-chunk-15](../images/intro/plotting-unnamed-chunk-15.png) 


Legends typically take a bit of trial and error, but can do most things.

```r
plot(5, 5, type="n", axes=FALSE, ann=FALSE, xlim=c(0, 10), ylim = c(0,10))
axis(1)
axis(2, las=2)
mtext("x-axis", side = 1, line = 3)
mtext("y-axis", side = 2, line = 3)
title("My progressive plot")
box()
points(5, 5, col="red")
points(5, 7, col="orange", pch=3, cex=2)
points(c(0, 0, 1), c(2, 4, 6), col="green", pch=4)
points(x, y, pch=21, col="white", bg="black")
abline(mod)
lines(x.seq, y.pred[,"lwr"], lty = 2)
lines(x.seq, y.pred[,"upr"], lty = 2)
polygon(c(x.seq, rev(x.seq)), c(y.conf[,"lwr"], rev(y.conf[,"upr"])), col = rgb(0,0,0,0.2), border = NA)
text(1, 10, "A", cex=1.5)
mtext("A", side=3, adj=0, cex=1.5)
text(3, 8.5, expression(Y[i] == beta[0]+beta[1]*X[i1]+epsilon[i]))  # see demo(plotmath) for more examples
legend("bottomright", c("green data", "random data", "orange point"), pch=c(4, 20, 3), col=c("green", "black", "orange"), pt.cex=c(1, 1, 2), bty="n")
```

![plot of chunk unnamed-chunk-16](../images/intro/plotting-unnamed-chunk-16.png) 


## Saving your plot

You can save your plot by simply using the "Export" functionality in the RStudio GUI.  In general, plots should be saved as vector graphics files (i.e., PDF), because these "scale" (i.e., don't lose resolution as you zoom in).  However, vector graphics files can get large and slow things down if they contain a lot of information, in which case you might want to save as a raster or image file (i.e., PNG).  PNGs work better on webpages and in presentations, because such software is not good at dealing with vector graphics. Do not save as a JPG.

You can also save your plot from the command line.  Why would this be useful?

To do so, you need to fire-up a graphics device (e.g., PDF or PNG), write the layers to the file, and then close the device off (you won't be able to open the file if you miss this last step).


```r
pdf("my_progressive_plot.pdf", width=5, height=5)
plot(x, y, pch=21, col="white", bg="black", xlim=c(0, 10), ylim=c(0,10), axes=FALSE, ylab="y-axis", xlab="x-axis", main="My progressive plot")
axis(1)
axis(2, las=2)
abline(mod)
polygon(c(x.seq, rev(x.seq)), c(y.conf[,"lwr"], rev(y.conf[,"upr"])), col = rgb(0,0,0,0.2), border = NA)
text(7, 1, expression(Y[i] == beta[0]+beta[1]*X[i1]+epsilon[i]))
dev.off()
```


or to a png file

```r
png("my_progressive_plot.png", width=400, height=400)
plot(x, y, pch=21, col="white", bg="black", xlim=c(0, 10), ylim=c(0,10), axes=FALSE, ylab="y-axis", xlab="x-axis", main="My progressive plot")
axis(1)
axis(2, las=2)
abline(mod)
polygon(c(x.seq, rev(x.seq)), c(y.conf[,"lwr"], rev(y.conf[,"upr"])), col = rgb(0,0,0,0.2), border = NA)
text(7, 1, expression(Y[i] == beta[0]+beta[1]*X[i1]+epsilon[i]))
dev.off()
```


You'll notice above that data, labels and titles are within the plot function, rather than layering up as demostrated earlier.

## Exercise 

Analyse and graph the relationship between height and weight of plants in the herbivore dataset.  Attempt to reproduce the following graph.

```r
data <- read.csv("data/seed_root_herbivores.csv")

data$lWeight <- log10(data$Weight)

mod <- lm(lWeight ~ Height, data)
summary(mod)
```

```plain

Call:
lm(formula = lWeight ~ Height, data = data)

Residuals:
   Min     1Q Median     3Q    Max 
-0.765 -0.125  0.030  0.140  0.579 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)
(Intercept) -0.18527    0.06669   -2.78   0.0061
Height       0.01945    0.00116   16.84   <2e-16

Residual standard error: 0.237 on 167 degrees of freedom
Multiple R-squared: 0.629,	Adjusted R-squared: 0.627 
F-statistic:  284 on 1 and 167 DF,  p-value: <2e-16 
```

```r

ss <- seq(min(data$Height), max(data$Height), 0.5)
ss.conf <- predict(mod, list(Height = ss), interval = "confidence")

plot(lWeight ~ Height, data, axes=FALSE, xlab=expression(paste("Height (", m^2, ")")), ylab="Weight (g), log-scale")
polygon(c(ss, rev(ss)), c(ss.conf[,"lwr"], rev(ss.conf[,"upr"])), col = rgb(0,0,0,0.2), border = NA)
lines(ss, ss.conf[,"fit"])

axis(2, at = log10(c(seq(0.3, 0.9, 0.1), seq(1, 9, 1), seq(10, 60, 10))), labels = FALSE, tck = -0.015)
axis(2, at = log10(c(0.3, 1, 3, 10, 30)), labels = c(0.3, 1, 3, 10, 30), las = 2)
axis(1)
```

![plot of chunk unnamed-chunk-19](../images/intro/plotting-unnamed-chunk-19.png) 


## Plotting parameters

Each device has a set of graphical parameters that can be set up before you start plotting.  Most of these parameters control the "look and feel" of the plotting device.  Take a look at the `par` helpfile for the vast array of options:

```r
?par
```


For example, you can control the portion of your canvas taken up by each of the margins around your plot using `mar` (i.e., "lines" in the margin).  The default is:

```r
par(mar=c(5, 4, 4, 2) + 0.1)
hist(x)
```

![plot of chunk unnamed-chunk-21](../images/intro/plotting-unnamed-chunk-21.png) 


Widen the right axis.

```r
op <- par(mar=c(5, 4, 4, 5) + 0.1)
hist(x)
axis(side=4)
mtext("y-axis on this side", side=4, line=3)
```

![plot of chunk unnamed-chunk-22](../images/intro/plotting-unnamed-chunk-221.png) 

```r

par()
```

```plain
$xlog
[1] FALSE

$ylog
[1] FALSE

$adj
[1] 0.5

$ann
[1] TRUE

$ask
[1] FALSE

$bg
[1] "transparent"

$bty
[1] "o"

$cex
[1] 1

$cex.axis
[1] 1

$cex.lab
[1] 1

$cex.main
[1] 1.2

$cex.sub
[1] 1

$cin
[1] 0.15 0.20

$col
[1] "black"

$col.axis
[1] "black"

$col.lab
[1] "black"

$col.main
[1] "black"

$col.sub
[1] "black"

$cra
[1] 10.8 14.4

$crt
[1] 0

$csi
[1] 0.2

$cxy
[1] 0.2512 1.7772

$din
[1] 7 5

$err
[1] 0

$family
[1] ""

$fg
[1] "black"

$fig
[1] 0 1 0 1

$fin
[1] 7 5

$font
[1] 1

$font.axis
[1] 1

$font.lab
[1] 1

$font.main
[1] 2

$font.sub
[1] 1

$lab
[1] 5 5 7

$las
[1] 0

$lend
[1] "round"

$lheight
[1] 1

$ljoin
[1] "round"

$lmitre
[1] 10

$lty
[1] "solid"

$lwd
[1] 1

$mai
[1] 1.02 0.82 0.82 1.02

$mar
[1] 5.1 4.1 4.1 5.1

$mex
[1] 1

$mfcol
[1] 1 1

$mfg
[1] 1 1 1 1

$mfrow
[1] 1 1

$mgp
[1] 3 1 0

$mkh
[1] 0.001

$new
[1] FALSE

$oma
[1] 0 0 0 0

$omd
[1] 0 1 0 1

$omi
[1] 0 0 0 0

$pch
[1] 1

$pin
[1] 5.16 3.16

$plt
[1] 0.1171 0.8543 0.2040 0.8360

$ps
[1] 12

$pty
[1] "m"

$smo
[1] 1

$srt
[1] 0

$tck
[1] NA

$tcl
[1] -0.5

$usr
[1]  0.68  9.32 -1.04 27.04

$xaxp
[1] 2 8 3

$xaxs
[1] "r"

$xaxt
[1] "s"

$xpd
[1] FALSE

$yaxp
[1]  0 25  5

$yaxs
[1] "r"

$yaxt
[1] "s"

$ylbias
[1] 0.2
```

```r
par("mar")
```

```plain
[1] 5.1 4.1 4.1 5.1
```

```r
par(op) # Resets changes to default
hist(x)
```

![plot of chunk unnamed-chunk-22](../images/intro/plotting-unnamed-chunk-222.png) 


A graphics device can have many panels.  `mfrow` allows you to add multiple frames by row - so each time you call a plot, it will be added to the next panel by rows first

```r
op <- par(mfrow=c(2,2))
hist(x, xlim=c(0,10))
text(1, 25, "A")
hist(y, xlim=c(0,10))
text(1, 25, "B")

h <- hist(x, plot=FALSE)
h
```

```plain
$breaks
[1] 1 2 3 4 5 6 7 8 9

$counts
[1]  1  7 23 26 23 14  4  2

$intensities
[1] 0.01 0.07 0.23 0.26 0.23 0.14 0.04 0.02

$density
[1] 0.01 0.07 0.23 0.26 0.23 0.14 0.04 0.02

$mids
[1] 1.5 2.5 3.5 4.5 5.5 6.5 7.5 8.5

$xname
[1] "x"

$equidist
[1] TRUE

attr(,"class")
[1] "histogram"
```

```r

plot(h$mids, h$counts, col="red", type="l", xlim=c(0,10))
points(h$mids, h$counts, pch=20)
text(1, 25, "C")

plot(h$mids, h$density, col="green", type="l", xlim=c(0,10))
points(h$mids, h$density, pch=20)
text(1, .25, "D")
abline(v=h$breaks, col="grey")
```

![plot of chunk unnamed-chunk-23](../images/intro/plotting-unnamed-chunk-23.png) 

```r

par(op)
```


Panels may have the same information and axes don't need to be repeated.


```r
op <- par(mfrow=c(2, 2), mar=c(1, 1, 1, 1), oma=c(4, 3, 4, 2), ann=FALSE)

plot(x, y, axes=FALSE)
axis(1, labels=FALSE)
axis(2)
mtext("A", side=3, adj = 0)

plot(x, y, col=rainbow(10), axes=FALSE)
axis(1, labels=FALSE)
axis(2, labels=FALSE)
mtext("B", side=3, adj = 0)

plot(x, y, axes=FALSE)
axis(1)
axis(2)
mtext("C", side=3, adj = 0)

plot(x, y, axes=FALSE)
axis(1)
axis(2, labels=FALSE)
mtext("D", side=3, adj = 0)

mtext("x-axis", side=1, outer=TRUE, line=2)
mtext("y-axis", side=2, outer=TRUE, line=2)
mtext("title", side=3, outer=TRUE, line=1, cex=1.5)
```

![plot of chunk unnamed-chunk-24](../images/intro/plotting-unnamed-chunk-24.png) 

```r

par(op)
```


## Barplots

Barplots are commonly used in biology, but are not as straightword as you might hope in R.  Make sure the herbivore data is loaded:

```r
data <- read.csv("data/seed_root_herbivores.csv")
```


Using what you've learned so far, make a new column containing "Both", "Root only", "Seed only" and "None" based on the four possible combinations of root and seed herbivores in the dataset. This column needs to be a `factor` for the analysis we will be conducting and graphing.

```r
data$Herbivory[data$Root.herbivore & data$Seed.herbivore] <- "Both"
data$Herbivory[data$Root.herbivore & !data$Seed.herbivore] <- "Root only"
data$Herbivory[!data$Root.herbivore & data$Seed.herbivore] <- "Seed only"
data$Herbivory[!data$Root.herbivore & !data$Seed.herbivore] <- "None"
data$Herbivory <- factor(data$Herbivory)
```


Let's run an ANOVA.  First, let's look at the linear model: 

```r
mod.lm <- lm(Height ~ Herbivory, data = data)
summary(mod.lm)
```

```plain

Call:
lm(formula = Height ~ Herbivory, data = data)

Residuals:
   Min     1Q Median     3Q    Max 
-36.20 -11.20  -0.14   8.86  38.86 

Coefficients:
                   Estimate Std. Error t value Pr(>|t|)
(Intercept)           50.14       2.03   24.67   <2e-16
HerbivoryNone         18.13       3.34    5.43    2e-07
HerbivoryRoot only     2.06       2.76    0.75    0.457
HerbivorySeed only     8.79       3.41    2.57    0.011

Residual standard error: 14.5 on 165 degrees of freedom
Multiple R-squared: 0.174,	Adjusted R-squared: 0.159 
F-statistic: 11.6 on 3 and 165 DF,  p-value: 6.08e-07 
```


Now an analysis of variance of that linear model:

```r
mod.aov <- aov(mod.lm)
summary(mod.aov)
```

```plain
             Df Sum Sq Mean Sq F value  Pr(>F)
Herbivory     3   7339    2446    11.6 6.1e-07
Residuals   165  34769     211                
```


Okay, so there are significant differences among the treatments.  A Tukey Honest Significance Differences test will suggest where these differences occur:

```r
tuk <- TukeyHSD(mod.aov)
tuk
```

```plain
  Tukey multiple comparisons of means
    95% family-wise confidence level

Fit: aov(formula = mod.lm)

$Herbivory
                       diff       lwr     upr  p adj
None-Both            18.129   9.46062 26.7982 0.0000
Root only-Both        2.063  -5.11292  9.2384 0.8782
Seed only-Both        8.791  -0.07026 17.6529 0.0527
Root only-None      -16.067 -24.49121 -7.6421 0.0000
Seed only-None       -9.338 -19.23811  0.5619 0.0722
Seed only-Root only   6.729  -1.89423 15.3514 0.1829
```

```r
plot(tuk)
```

![plot of chunk unnamed-chunk-29](../images/intro/plotting-unnamed-chunk-291.png) 

```r
plot(tuk, las=2)
```

![plot of chunk unnamed-chunk-29](../images/intro/plotting-unnamed-chunk-292.png) 

```r
op <- par(mar=c(5, 9, 4, 4))
plot(tuk, las=2)
par(op)
```


Now let's summarise the data for plotting means and standard errors.

```r
data.sum <- aggregate(Height ~ Herbivory, FUN = mean, data=data)
data.sum$sd <- aggregate(Height ~ Herbivory, sd, data=data)$Height
data.sum$n <- aggregate(Height ~ Herbivory, length, data=data)$Height
data.sum$se <- data.sum$sd/sqrt(data.sum$n)
```


Order the data frame by `Height`:

```r
data.sum <- data.sum[order(data.sum$Height),]
```


Make the barplot, while assigning the barplot object to a variable (why?).

```r
bp <- barplot(data.sum$Height, ylab="Height (cm)", names.arg=data.sum$Herbivory, las = 2, ylim=c(0, 80))
```

![plot of chunk unnamed-chunk-32](../images/intro/plotting-unnamed-chunk-32.png) 


Now, use the anchor points from `bp` to add standard error bars:

```r
bp <- barplot(data.sum$Height, ylab="Height (cm)", names.arg=data.sum$Herbivory, las = 2, ylim=c(0, 80))
segments(bp, data.sum$Height + data.sum$se, bp, data.sum$Height - data.sum$se)
```

![plot of chunk unnamed-chunk-33](../images/intro/plotting-unnamed-chunk-33.png) 


If you want to get fancy, you can add line segments to the error bars like this

```r
bp <- barplot(data.sum$Height, ylab="Height (cm)", names.arg=data.sum$Herbivory, las = 2, ylim=c(0, 80))
segments(bp, data.sum$Height + data.sum$se, bp, data.sum$Height - data.sum$se)
os <- 0.1  # some kind of "offset"
segments(bp-os, data.sum$Height + data.sum$se, bp+os, data.sum$Height + data.sum$se)
segments(bp-os, data.sum$Height - data.sum$se, bp+os, data.sum$Height - data.sum$se)
title("Barplots are a pain...")
```

![plot of chunk unnamed-chunk-34](../images/intro/plotting-unnamed-chunk-34.png) 


Or use `arrows`

```r
bp <- barplot(data.sum$Height, ylab="Height (cm)", names.arg=data.sum$Herbivory, las = 2, ylim=c(0, 80))
arrows(bp, data.sum$Height + data.sum$se, bp, data.sum$Height - data.sum$se, code=3, angle=90, length=0.03)
```

![plot of chunk unnamed-chunk-35](../images/intro/plotting-unnamed-chunk-35.png) 


And, finally, some kind of visual reference as to where the statistical differences among treatments lie (very ad hoc):

```r
bp <- barplot(data.sum$Height, ylab="Height (cm)", names.arg=data.sum$Herbivory, las = 2, ylim=c(0, 80))
arrows(bp, data.sum$Height + data.sum$se, bp, data.sum$Height - data.sum$se, code=3, angle=90)
segments(bp[1], 70, bp[3], 70, lwd=2) # lwd "line width"
segments(bp[3], 75, bp[4], 75, lwd=2)
```

![plot of chunk unnamed-chunk-36](../images/intro/plotting-unnamed-chunk-36.png) 


## Exercise


```r
data <- read.csv("data/seed_root_herbivores.csv")
data$lWeight <- log10(data$Weight)
```


Panel A


```r
op <- par(mfrow=c(2, 1))

mod <- lm(lWeight ~ Height, data)
summary(mod)
```

```plain

Call:
lm(formula = lWeight ~ Height, data = data)

Residuals:
   Min     1Q Median     3Q    Max 
-0.765 -0.125  0.030  0.140  0.579 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)
(Intercept) -0.18527    0.06669   -2.78   0.0061
Height       0.01945    0.00116   16.84   <2e-16

Residual standard error: 0.237 on 167 degrees of freedom
Multiple R-squared: 0.629,	Adjusted R-squared: 0.627 
F-statistic:  284 on 1 and 167 DF,  p-value: <2e-16 
```

```r

ss <- seq(min(data$Height), max(data$Height), 0.5)
ss.conf <- predict(mod, list(Height = ss), interval = "confidence")

plot(lWeight ~ Height, data, axes=FALSE, xlab=expression(paste("Height (", m^2, ")")), ylab="Weight (g), log-scale")
polygon(c(ss, rev(ss)), c(ss.conf[,"lwr"], rev(ss.conf[,"upr"])), col = rgb(0,0,0,0.2), border = NA)
lines(ss, ss.conf[,"fit"])

axis(2, at = log10(c(seq(0.3, 0.9, 0.1), seq(1, 9, 1), seq(10, 60, 10))), labels = FALSE, tck = -0.015)
axis(2, at = log10(c(0.3, 1, 3, 10, 30)), labels = c(0.3, 1, 3, 10, 30), las = 2)
axis(1)

mtext("A", side=3, adj=0, cex=1.5)
```

![plot of chunk unnamed-chunk-38](../images/intro/plotting-unnamed-chunk-38.png) 


Panel B


```r
bp <- barplot(data.sum$Height, ylab="Height (cm)", names.arg=data.sum$Herbivory, las = 2, ylim=c(0, 80))
segments(bp, data.sum$Height + data.sum$se, bp, data.sum$Height - data.sum$se)

segments(bp-os, data.sum$Height + data.sum$se, bp+os, data.sum$Height + data.sum$se)
segments(bp-os, data.sum$Height - data.sum$se, bp+os, data.sum$Height - data.sum$se)
segments(bp[1], 70, bp[3], 70, lwd=2) # lwd "line width"
segments(bp[3], 75, bp[4], 75, lwd=2)

mtext("B", side=3, adj=0, cex=1.5)
```

![plot of chunk unnamed-chunk-39](../images/intro/plotting-unnamed-chunk-39.png) 

```r

par(op)
```


## Other useful examples

Contour or image plots can be used to visualise 3d, matrix or spatial data.  Use the builtin dataset "volcano":  

```r
contour(volcano)
title("Auckland's Maunga Whau Volcano")
```

![plot of chunk unnamed-chunk-40](../images/intro/plotting-unnamed-chunk-401.png) 

```r

rand.scape <- matrix(rnorm(10000), 100, 100)
contour(rand.scape)
```

![plot of chunk unnamed-chunk-40](../images/intro/plotting-unnamed-chunk-402.png) 

```r
image(rand.scape)
```

![plot of chunk unnamed-chunk-40](../images/intro/plotting-unnamed-chunk-403.png) 

```r

image(volcano, col = rev(heat.colors(12)))
```

![plot of chunk unnamed-chunk-40](../images/intro/plotting-unnamed-chunk-404.png) 

```r
image(volcano, col = terrain.colors(12))
```

![plot of chunk unnamed-chunk-40](../images/intro/plotting-unnamed-chunk-405.png) 

```r
image(volcano, col = grey(seq(0, 1, 0.1)))
```

![plot of chunk unnamed-chunk-40](../images/intro/plotting-unnamed-chunk-406.png) 

```r

filled.contour(volcano, color.palette = terrain.colors, asp = 1)
```

![plot of chunk unnamed-chunk-40](../images/intro/plotting-unnamed-chunk-407.png) 


The R package "ggplot" has become popular.  However, you need to learn a syntax that is somewhat different to standard R syntax (hence the reason we did not cover it here).

The R package "lattice" is great for multivariate data. Here's the volcano again using `wireframe()`:

```r
library(lattice)
wireframe(volcano, shade = TRUE, aspect = c(61/87, 0.4), light.source = c(10,0,10))
demo(lattice)
```


If you want to get visually fancy, then take a look at the R package "rgl".  Rstudio doesn't seem to handle rgl objects very well.

```r
library(rgl)
rgl.points(rnorm(1000), rnorm(1000), rnorm(1000), color=heat.colors(1000))
demo(lsystem)
example(surface3d)
```



