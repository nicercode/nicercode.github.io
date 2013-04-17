## ---
## layout: page
## ti4tle: "Basic Graphing in R"
## date: 2013-03-22 10:25
## comments: true
## sharing: true
## footer: false
## ---

### Set options
##+ echo=FALSE,results=FALSE
source("global_options.R")
opts_chunk$set(tidy=FALSE, fig.height=5, comment="",
               fig.path="../images/intro/plotting-")


## R is capable of producing publication-quality graphics.  During this session, we will  develop your R skills by introducing you to the basics of graphing. 

## Typing `plot(1,1)` does a lot by default.  For example, the axes are automatically set to encapsulate the data, a box is drawn around the plotting space, and some basic labels are given as well.

## Similarly, typing `hist(rnorm(100))` or `boxplot(rnorm(100))` does a lot of the work for you.

## Plotting in R is about layering data and detail onto a canvas. So, let's start with a blank canvas:
plot(5, 5, type="n", axes=FALSE, ann=FALSE, xlim=c(0, 10), ylim = c(0,10))

## We are simply calling a new plotting device (`plot` always initiates a new device), plotting the coordinates (5,5), which we can't see because of `type="n"`, and we're also telling R that we don't want any default axes or annotations (e.g., titles or axis labels).  Basically, we just want a blank slate.  Finally, we set the x- and y-axis ranges, so that we  have some space to work.

## Let's add the default axis:
plot(5, 5, type="n", axes=FALSE, ann=FALSE, xlim=c(0, 10), ylim = c(0,10))
axis(1)

## If you look at the helpfile for axis (`?axis`) you'll see that you can pretty much control any apsect of axis creation.  The only argument required for an axis is the side of the plot you want it on.  Here 1 and 2 correspond with x and y; 3 and 4 also correspond with x and y, but on the other side of the plot (e.g., for secondary axes).

## Let's add the y-axis:
plot(5, 5, type="n", axes=FALSE, ann=FALSE, xlim=c(0, 10), ylim = c(0,10))
axis(1)
axis(2)

## I prefer tick labels to align horizontally where possible.  Here we use the argument `las=2` ("label axis style"?).  A value of 2 means "always horizontal".
plot(5, 5, type="n", axes=FALSE, ann=FALSE, xlim=c(0, 10), ylim = c(0,10))
axis(1)
axis(2, las=2)

## When plotting with R you are adding subsequent layers to your canvas.  If something needs redoing, you need to start again from stratch.  Therefore, it is very important to save a graph's provenance using a text editor.  If you change something, re-run all the lines of code to generate your graph.  Saving as text is also great for when you want re-use a particular graphic style that you've developed. Graphing is one part of the scientific process for which you have some creative freedom.

## Next, add axis labels and a title:
plot(5, 5, type="n", axes=FALSE, ann=FALSE, xlim=c(0, 10), ylim = c(0,10))
axis(1)
axis(2, las=2)
mtext("x-axis", side = 1, line = 3)
mtext("y-axis", side = 2, line = 3)
title("My progressive plot")

## `mtext` stands for margin text.  You need an argument for the text to be printed, one for the side of the plot (as for the `axis` function), and one saying how far from the axis you want to label is numbers of "lines".  Generally, the tick marks are at the zeroth line (`line=0`) and the tick labels in the first line.  The default for plot is `line=3`, which I generally leave as is.  You don't generally need titles for plots in manuscripts, but they can come in handy for presentations, blogs, etc.

## There is also the figure `box()`, which I don't tend to use, but you may want to (?):
plot(5, 5, type="n", axes=FALSE, ann=FALSE, xlim=c(0, 10), ylim = c(0,10))
axis(1)
axis(2, las=2)
mtext("x-axis", side = 1, line = 3)
mtext("y-axis", side = 2, line = 3)
title("My progressive plot")
box()

## Let's add some data.  A red point at (5,5):
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

# http://rgraphics.limnology.wisc.edu/images/miscellaneous/pch.png

## Now set your random number generator seed to 11, so that our plots all look the same.  We'll simulate some data.  First, some normally distribution "independent" values.  Then, some values that depend on these first set of values via a prescribed relationship and error distribution: 
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

## Typing `?points` will give you the common options for the points function.  I have used `pch=21` (presumably "plotting character"?).  The character (a circle) is white and the character background is black.  I like this, because it helps distinguish points when they overlap.

## Fit a linear model and add the line of best-fit.
mod <- lm(y ~ x)
summary(mod)

## Add the regression line:
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

## You see that the model estimates reflect the parameters we used to generate the data (`lm` appears to be working).  Let's add some elements to our graph that highlight these fitted model results. Start by generating a sequence of numbers spanning the range of x:
x.seq <- seq(0, 10, 0.1)  # ss <- seq(min(x), max(x), 0.1)

## Using the best-fit model, we can now predict values for each of the values in the `x.seq` vector:
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

## `lty=2` (presumably "line type"?) makes a dashed line.  What's the difference between confidence intervals and prediction intervals?  Now, let's calculate confidence intervals and do something a little bit more exciting: a transparent, shaded confidence band:
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

## Text can also be added easily, using the coordinates of the current plot:
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

## Legends typically take a bit of trial and error, but can do most things.
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

## ## Saving your plot

## You can save your plot by simply using the "Export" functionality in the RStudio GUI.  In general, plots should be saved as vector graphics files (i.e., PDF), because these "scale" (i.e., don't lose resolution as you zoom in).  However, vector graphics files can get large and slow things down if they contain a lot of information, in which case you might want to save as a raster or image file (i.e., PNG).  PNGs work better on webpages and in presentations, because such software is not good at dealing with vector graphics. Do not save as a JPG.

## You can also save your plot from the command line.  Why would this be useful?

## To do so, you need to fire-up a graphics device (e.g., PDF or PNG), write the layers to the file, and then close the device off (you won't be able to open the file if you miss this last step).

##+ eval=FALSE
pdf("my_progressive_plot.pdf", width=5, height=5)
plot(x, y, pch=21, col="white", bg="black", xlim=c(0, 10), ylim=c(0,10), axes=FALSE, ylab="y-axis", xlab="x-axis", main="My progressive plot")
axis(1)
axis(2, las=2)
abline(mod)
polygon(c(x.seq, rev(x.seq)), c(y.conf[,"lwr"], rev(y.conf[,"upr"])), col = rgb(0,0,0,0.2), border = NA)
text(7, 1, expression(Y[i] == beta[0]+beta[1]*X[i1]+epsilon[i]))
dev.off()

## or to a png file
##+ eval=FALSE
png("my_progressive_plot.png", width=400, height=400)
plot(x, y, pch=21, col="white", bg="black", xlim=c(0, 10), ylim=c(0,10), axes=FALSE, ylab="y-axis", xlab="x-axis", main="My progressive plot")
axis(1)
axis(2, las=2)
abline(mod)
polygon(c(x.seq, rev(x.seq)), c(y.conf[,"lwr"], rev(y.conf[,"upr"])), col = rgb(0,0,0,0.2), border = NA)
text(7, 1, expression(Y[i] == beta[0]+beta[1]*X[i1]+epsilon[i]))
dev.off()

## You'll notice above that data, labels and titles are within the plot function, rather than layering up as demostrated earlier.

## ## Exercise 

## Analyse and graph the relationship between height and weight of plants in the herbivore dataset.  Attempt to reproduce the following graph.
data <- read.csv("data/seed_root_herbivores.csv")

data$lWeight <- log10(data$Weight)

mod <- lm(lWeight ~ Height, data)
summary(mod)

ss <- seq(min(data$Height), max(data$Height), 0.5)
ss.conf <- predict(mod, list(Height = ss), interval = "confidence")

plot(lWeight ~ Height, data, axes=FALSE, xlab=expression(paste("Height (", m^2, ")")), ylab="Weight (g), log-scale")
polygon(c(ss, rev(ss)), c(ss.conf[,"lwr"], rev(ss.conf[,"upr"])), col = rgb(0,0,0,0.2), border = NA)
lines(ss, ss.conf[,"fit"])

axis(2, at = log10(c(seq(0.3, 0.9, 0.1), seq(1, 9, 1), seq(10, 60, 10))), labels = FALSE, tck = -0.015)
axis(2, at = log10(c(0.3, 1, 3, 10, 30)), labels = c(0.3, 1, 3, 10, 30), las = 2)
axis(1)

## ## Plotting parameters

## Each device has a set of graphical parameters that can be set up before you start plotting.  Most of these parameters control the "look and feel" of the plotting device.  Take a look at the `par` helpfile for the vast array of options:
##+ eval=FALSE
?par

## For example, you can control the portion of your canvas taken up by each of the margins around your plot using `mar` (i.e., "lines" in the margin).  The default is:
par(mar=c(5, 4, 4, 2) + 0.1)
hist(x)

## Widen the right axis.
op <- par(mar=c(5, 4, 4, 5) + 0.1)
hist(x)
axis(side=4)
mtext("y-axis on this side", side=4, line=3)

par()
par("mar")
par(op) # Resets changes to default
hist(x)

## A graphics device can have many panels.  `mfrow` allows you to add multiple frames by row - so each time you call a plot, it will be added to the next panel by rows first
op <- par(mfrow=c(2,2))
hist(x, xlim=c(0,10))
text(1, 25, "A")
hist(y, xlim=c(0,10))
text(1, 25, "B")

h <- hist(x, plot=FALSE)
h

plot(h$mids, h$counts, col="red", type="l", xlim=c(0,10))
points(h$mids, h$counts, pch=20)
text(1, 25, "C")

plot(h$mids, h$density, col="green", type="l", xlim=c(0,10))
points(h$mids, h$density, pch=20)
text(1, .25, "D")
abline(v=h$breaks, col="grey")

par(op)

## Panels may have the same information and axes don't need to be repeated.

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

par(op)

## ## Barplots

## Barplots are commonly used in biology, but are not as straightword as you might hope in R.  Make sure the herbivore data is loaded:
data <- read.csv("data/seed_root_herbivores.csv")

## Using what you've learned so far, make a new column containing "Both", "Root only", "Seed only" and "None" based on the four possible combinations of root and seed herbivores in the dataset. This column needs to be a `factor` for the analysis we will be conducting and graphing.
data$Herbivory[data$Root.herbivore & data$Seed.herbivore] <- "Both"
data$Herbivory[data$Root.herbivore & !data$Seed.herbivore] <- "Root only"
data$Herbivory[!data$Root.herbivore & data$Seed.herbivore] <- "Seed only"
data$Herbivory[!data$Root.herbivore & !data$Seed.herbivore] <- "None"
data$Herbivory <- factor(data$Herbivory)

## Let's run an ANOVA.  First, let's look at the linear model: 
mod.lm <- lm(Height ~ Herbivory, data = data)
summary(mod.lm)

## Now an analysis of variance of that linear model:
mod.aov <- aov(mod.lm)
summary(mod.aov)

## Okay, so there are significant differences among the treatments.  A Tukey Honest Significance Differences test will suggest where these differences occur:
tuk <- TukeyHSD(mod.aov)
tuk
plot(tuk)
plot(tuk, las=2)
op <- par(mar=c(5, 9, 4, 4))
plot(tuk, las=2)
par(op)

## Now let's summarise the data for plotting means and standard errors.
data.sum <- aggregate(Height ~ Herbivory, FUN = mean, data=data)
data.sum$sd <- aggregate(Height ~ Herbivory, sd, data=data)$Height
data.sum$n <- aggregate(Height ~ Herbivory, length, data=data)$Height
data.sum$se <- data.sum$sd/sqrt(data.sum$n)

## Order the data frame by `Height`:
data.sum <- data.sum[order(data.sum$Height),]

## Make the barplot, while assigning the barplot object to a variable (why?).
bp <- barplot(data.sum$Height, ylab="Height (cm)", names.arg=data.sum$Herbivory, las = 2, ylim=c(0, 80))

## Now, use the anchor points from `bp` to add standard error bars:
bp <- barplot(data.sum$Height, ylab="Height (cm)", names.arg=data.sum$Herbivory, las = 2, ylim=c(0, 80))
segments(bp, data.sum$Height + data.sum$se, bp, data.sum$Height - data.sum$se)

## If you want to get fancy, you can add line segments to the error bars like this
bp <- barplot(data.sum$Height, ylab="Height (cm)", names.arg=data.sum$Herbivory, las = 2, ylim=c(0, 80))
segments(bp, data.sum$Height + data.sum$se, bp, data.sum$Height - data.sum$se)
os <- 0.1  # some kind of "offset"
segments(bp-os, data.sum$Height + data.sum$se, bp+os, data.sum$Height + data.sum$se)
segments(bp-os, data.sum$Height - data.sum$se, bp+os, data.sum$Height - data.sum$se)
title("Barplots are a pain...")

## Or use `arrows`
bp <- barplot(data.sum$Height, ylab="Height (cm)", names.arg=data.sum$Herbivory, las = 2, ylim=c(0, 80))
arrows(bp, data.sum$Height + data.sum$se, bp, data.sum$Height - data.sum$se, code=3, angle=90, length=0.03)

## And, finally, some kind of visual reference as to where the statistical differences among treatments lie (very ad hoc):
bp <- barplot(data.sum$Height, ylab="Height (cm)", names.arg=data.sum$Herbivory, las = 2, ylim=c(0, 80))
arrows(bp, data.sum$Height + data.sum$se, bp, data.sum$Height - data.sum$se, code=3, angle=90)
segments(bp[1], 70, bp[3], 70, lwd=2) # lwd "line width"
segments(bp[3], 75, bp[4], 75, lwd=2)

## ## Exercise

data <- read.csv("data/seed_root_herbivores.csv")
data$lWeight <- log10(data$Weight)

## Panel A

op <- par(mfrow=c(2, 1))

mod <- lm(lWeight ~ Height, data)
summary(mod)

ss <- seq(min(data$Height), max(data$Height), 0.5)
ss.conf <- predict(mod, list(Height = ss), interval = "confidence")

plot(lWeight ~ Height, data, axes=FALSE, xlab=expression(paste("Height (", m^2, ")")), ylab="Weight (g), log-scale")
polygon(c(ss, rev(ss)), c(ss.conf[,"lwr"], rev(ss.conf[,"upr"])), col = rgb(0,0,0,0.2), border = NA)
lines(ss, ss.conf[,"fit"])

axis(2, at = log10(c(seq(0.3, 0.9, 0.1), seq(1, 9, 1), seq(10, 60, 10))), labels = FALSE, tck = -0.015)
axis(2, at = log10(c(0.3, 1, 3, 10, 30)), labels = c(0.3, 1, 3, 10, 30), las = 2)
axis(1)

mtext("A", side=3, adj=0, cex=1.5)

## Panel B

bp <- barplot(data.sum$Height, ylab="Height (cm)", names.arg=data.sum$Herbivory, las = 2, ylim=c(0, 80))
segments(bp, data.sum$Height + data.sum$se, bp, data.sum$Height - data.sum$se)

segments(bp-os, data.sum$Height + data.sum$se, bp+os, data.sum$Height + data.sum$se)
segments(bp-os, data.sum$Height - data.sum$se, bp+os, data.sum$Height - data.sum$se)
segments(bp[1], 70, bp[3], 70, lwd=2) # lwd "line width"
segments(bp[3], 75, bp[4], 75, lwd=2)

mtext("B", side=3, adj=0, cex=1.5)

par(op)

## ## Other useful examples

## Contour or image plots can be used to visualise 3d, matrix or spatial data.  Use the builtin dataset "volcano":  
contour(volcano)
title("Auckland's Maunga Whau Volcano")

rand.scape <- matrix(rnorm(10000), 100, 100)
contour(rand.scape)
image(rand.scape)

image(volcano, col = rev(heat.colors(12)))
image(volcano, col = terrain.colors(12))
image(volcano, col = grey(seq(0, 1, 0.1)))

filled.contour(volcano, color.palette = terrain.colors, asp = 1)

## The R package "ggplot" has become popular.  However, you need to learn a syntax that is somewhat different to standard R syntax (hence the reason we did not cover it here).

## The R package "lattice" is great for multivariate data. Here's the volcano again using `wireframe()`:
##+ eval=FALSE
library(lattice)
wireframe(volcano, shade = TRUE, aspect = c(61/87, 0.4), light.source = c(10,0,10))
demo(lattice)

## If you want to get visually fancy, then take a look at the R package "rgl".  Rstudio doesn't seem to handle rgl objects very well.
##+ eval=FALSE
library(rgl)
rgl.points(rnorm(1000), rnorm(1000), rnorm(1000), color=heat.colors(1000))
demo(lsystem)
example(surface3d)


