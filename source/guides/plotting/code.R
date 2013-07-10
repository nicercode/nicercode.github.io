## # Making publication quality graphics with R.

## Here are plots of petal and sepal length, using the `iris` data set
## included with R (see `?iris` for details).  What we want is two
## plots, side by side to compare different allometries.

plot(Sepal.Length ~ Sepal.Width, iris)
plot(Petal.Length ~ Petal.Width, iris)

## What needs doing:
##   1. Save the output to files
##   2. Open in Illustrator
##   3. Resize/reshape dimensions
##   4. Change font sizes
##   5. Paste together
##   6. Squidge text around to use space nicely
##   7. Add a legend

## Also, what about those ugly overplotted points?

## Starting from the beginning; this is the classic way you'll get
## told to join two plots together, with mfrow:
par(mfrow=c(1, 2))
plot(Sepal.Length ~ Sepal.Width, iris)
plot(Petal.Length ~ Petal.Width, iris)

## The only problem with that is, well, pretty much everything.  There
## is about as much whitespace as there is interesting text.

## Start with an aspect ratio and size you like:
dev.new(width=7, height=5.5)

## The graphics option "mar" controls how much space is around each
## plot (in units of lines of text).  It's quite a lot!
par("mar")

## So we can reduce the enormous and useless top and right margins with
mar <- par("mar")
mar[3:4] <- 0.5
par(mfrow=c(1, 2), mar=mar)
plot(Sepal.Length ~ Sepal.Width, iris)
plot(Petal.Length ~ Petal.Width, iris)

## The graphics option "oma" controls how much space is around the
## *set* of plots.  With just a single plot this is obviously the same
## thing.

## We can use that to pull the plots together and replace the y axis labels.
par(mfrow=c(1, 2), mar=c(4.1, 2.1, 1.5, 0.5),
    oma=c(0, 2, 0, 0))
plot(Sepal.Length ~ Sepal.Width, iris)
mtext("Sepal", 3, outer=FALSE, line=0.5)
plot(Petal.Length ~ Petal.Width, iris)
mtext("Petal", 3, outer=FALSE, line=0.5)
## Note that the new plot has removed *both* y axis labels.  This is
## because while there is space to draw the left hand label, that
## space is outside of the *plot* margin and into the *outer* margin.
## So by default it won't be drawn.  Add it manually with mtext() (in
## next section)


## We can use that to pull the plots together and replace the y axis labels.
par(mfrow=c(1, 2), mar=c(4.1, 2.1, 1.5, 0.5),
    oma=c(0, 2, 0, 0))
plot(Sepal.Length ~ Sepal.Width, iris)
mtext("Length of sepal or petal", 2, outer=FALSE, line=2.5, xpd=NA)
mtext("Sepal", 3, outer=FALSE, line=0.5)
plot(Petal.Length ~ Petal.Width, iris)
mtext("Petal", 3, outer=FALSE, line=0.5)

## By default, R draws the y axis labels so that they are parallel to
## the axis.  Many people, me included think that's ugly.  Change this
## with las=1
par(mfrow=c(1, 2), mar=c(4.1, 2.1, 1.5, 0.5),
    oma=c(0, 2, 0, 0))
plot(Sepal.Length ~ Sepal.Width, iris, las=1)
mtext("Length of sepal or petal", 2, outer=FALSE, line=2.5, xpd=NA)
mtext("Sepal", 3, outer=FALSE, line=0.5)
plot(Petal.Length ~ Petal.Width, iris, las=1)
mtext("Petal", 3, outer=FALSE, line=0.5)

## You'll notice that the X axis label is a bit too low now.  This can
## be tweaked by another mtext call or by using 'mgp'
par(mfrow=c(1, 2), mar=c(4.1, 2.1, 1.5, 0.5),
    oma=c(0, 2, 0, 0), mgp=c(2.25, 1, 0))
plot(Sepal.Length ~ Sepal.Width, iris, las=1)
mtext("Length of sepal or petal", 2, outer=FALSE, line=2.5, xpd=NA)
mtext("Sepal", 3, outer=FALSE, line=0.5)
plot(Petal.Length ~ Petal.Width, iris, las=1)
mtext("Petal", 3, outer=FALSE, line=0.5)

## What if we wanted to add a little 'a' and 'b' into the plots?
## These plots have different scales, so getting them in the same
## place is hard.
par(mfrow=c(1, 2), mar=c(4.1, 2.1, 1.5, 0.5),
    oma=c(0, 2, 0, 0), mgp=c(2.25, 1, 0))
plot(Sepal.Length ~ Sepal.Width, iris, las=1)

usr <- par("usr")
text(usr[1] + .05*(usr[2] - usr[1]),
     usr[3] + .95*(usr[4] - usr[3]),
     "a)", adj=c(0, 1))

## That's going to be a pain to tweak, so let's write a little
## function.
label <- function(px, py, lab, ..., adj=c(0, 1)) {
  usr <- par("usr")
  text(usr[1] + px*(usr[2] - usr[1]),
       usr[3] + py*(usr[4] - usr[3]),
       lab, adj=adj, ...)
}

par(mfrow=c(1, 2), mar=c(4.1, 2.1, 1.5, 0.5),
    oma=c(0, 2, 0, 0), mgp=c(2.25, 1, 0))
plot(Sepal.Length ~ Sepal.Width, iris, las=1)
label(.04, .96, "a)")
mtext("Length of sepal or petal", 2, outer=FALSE, line=2.5, xpd=NA)
mtext("Sepal", 3, outer=FALSE, line=0.5)
plot(Petal.Length ~ Petal.Width, iris, las=1)
label(.04, .96, "b)")
mtext("Petal", 3, outer=FALSE, line=0.5)

## However, things might look better if we had the same x and y axes
## extents.  This is easy to do:
xlim <- range(iris$Sepal.Width, iris$Petal.Width)
ylim <- range(iris$Sepal.Length, iris$Petal.Length)

par(mfrow=c(1, 2), mar=c(4.1, 2.1, 1.5, 0.5),
    oma=c(0, 2, 0, 0), mgp=c(2.25, 1, 0))
plot(Sepal.Length ~ Sepal.Width, iris, las=1, xlim=xlim, ylim=ylim)
label(.04, .96, "a)")
mtext("Length of sepal or petal", 2, outer=FALSE, line=2.5, xpd=NA)
mtext("Sepal", 3, outer=FALSE, line=0.5)
plot(Petal.Length ~ Petal.Width, iris, las=1, xlim=xlim, ylim=ylim)
label(.04, .96, "b)")
mtext("Petal", 3, outer=FALSE, line=0.5)

## (notice how the labels stayed put)

## If we opted to keep this, we might drop the y labels from plot b)
## but keep the ticks.  To do this, we increase oma[2], decrease
## mar[2], and pass labels=FALSE when making the y axis for the second
## plot.
par(mfrow=c(1, 2), mar=c(4.1, 0.6, 1.5, 0.5),
    oma=c(0, 3, 0, 0), mgp=c(2.25, 1, 0))
plot(Sepal.Length ~ Sepal.Width, iris, las=1, xlim=xlim, ylim=ylim)
label(.04, .96, "a)")
mtext("Length of sepal or petal", 2, outer=FALSE, line=2.5, xpd=NA)
mtext("Sepal", 3, outer=FALSE, line=0.5)
plot(Petal.Length ~ Petal.Width, iris, las=1, xlim=xlim, ylim=ylim,
     yaxt="n")
axis(2, labels=FALSE)
label(.04, .96, "b)")
mtext("Petal", 3, outer=FALSE, line=0.5)

## Let's go back to the version that had independent axis labels.
par(mfrow=c(1, 2), mar=c(4.1, 2.1, 1.5, 0.5),
    oma=c(0, 2, 0, 0), mgp=c(2.25, 1, 0))
plot(Sepal.Length ~ Sepal.Width, iris, las=1)
label(.04, .96, "a)")
mtext("Length of sepal or petal", 2, outer=FALSE, line=2.5, xpd=NA)
mtext("Sepal", 3, outer=FALSE, line=0.5)
plot(Petal.Length ~ Petal.Width, iris, las=1)
label(.04, .96, "b)")
mtext("Petal", 3, outer=FALSE, line=0.5)

## We can add colours by species easily.  There are three species,
## corresponding in this case to three levels of a factor:
str(iris$Species)
levels(iris$Species)

## So if we had a vector of length 3
cols <- c("red", "blue", "green")
## then doing this:
cols[iris$Species]
## means that we have a vector of colours the same length as the data
## where 'setosa' is in red, 'versicolor' is in blue and 'virginica'
## is in green.

## If the labels were not factors, you could do it this way instead:
cols2 <- c(setosa="red", versicolor="blue", virginica="green")
cols2[as.character(iris$Species)]
## this is just a matter of taste.

## (or we can have slightly less ugly colours)
cols <- c("#e37222", "#162274", "#618e02")

par(mfrow=c(1, 2), mar=c(4.1, 2.1, 1.5, 0.5),
    oma=c(0, 2, 0, 0), mgp=c(2.25, 1, 0))
plot(Sepal.Length ~ Sepal.Width, iris, las=1, col=cols[Species])
label(.04, .96, "a)")
mtext("Length of sepal or petal", 2, outer=FALSE, line=2.5, xpd=NA)
mtext("Sepal", 3, outer=FALSE, line=0.5)
plot(Petal.Length ~ Petal.Width, iris, las=1, col=cols[Species])
label(.04, .96, "b)")
mtext("Petal", 3, outer=FALSE, line=0.5)

## (because I'm using the formula-based plotting interface I can use
## Species, not iris$Species).

## Which is starting to look better.  We can use shape so that
## colour-deficient people or black+white printed versions are more
## clear, too:
shape <- c(15, 17, 19)
## See example(points) for possible shapes.

par(mfrow=c(1, 2), mar=c(4.1, 2.1, 1.5, 0.5),
    oma=c(0, 2, 0, 0), mgp=c(2.25, 1, 0))
plot(Sepal.Length ~ Sepal.Width, iris, las=1,
     col=cols[Species], pch=shape[Species])
label(.04, .96, "a)")
mtext("Length of sepal or petal", 2, outer=FALSE, line=2.5, xpd=NA)
mtext("Sepal", 3, outer=FALSE, line=0.5)
plot(Petal.Length ~ Petal.Width, iris, las=1,
     col=cols[Species], pch=shape[Species])
label(.04, .96, "b)")
mtext("Petal", 3, outer=FALSE, line=0.5)

## The points are on top of each other, which can be solved with a bit
## of jittering:
iris$Sepal.Length <- jitter(iris$Sepal.Length)
iris$Petal.Length <- jitter(iris$Petal.Length)
iris$Sepal.Width <- jitter(iris$Sepal.Width)
iris$Petal.Width <- jitter(iris$Petal.Width)

par(mfrow=c(1, 2), mar=c(4.1, 2.1, 1.5, 0.5),
    oma=c(0, 2, 0, 0), mgp=c(2.25, 1, 0))
plot(Sepal.Length ~ Sepal.Width, iris, las=1,
     col=cols[Species], pch=shape[Species])
label(.04, .96, "a)")
mtext("Length of sepal or petal", 2, outer=FALSE, line=2.5, xpd=NA)
mtext("Sepal", 3, outer=FALSE, line=0.5)
plot(Petal.Length ~ Petal.Width, iris, las=1,
     col=cols[Species], pch=shape[Species])
label(.04, .96, "b)")
mtext("Petal", 3, outer=FALSE, line=0.5)

## The points are still a bit on top of each other and hard to tell
## where multiple points occur.  If the points were semitransparent,
## this would be less of a problem.

## Here is a function always in my toolkit, for making colours
## semitransparent:
make.transparent <- function(col, opacity=0.5) {
  if (length(opacity) > 1 && any(is.na(opacity))) {
    n <- max(length(col), length(opacity))
    opacity <- rep(opacity, length.out=n)
    col <- rep(col, length.out=n)
    ok <- !is.na(opacity)
    ret <- rep(NA, length(col))
    ret[ok] <- Recall(col[ok], opacity[ok])
    ret
  } else {
    tmp <- col2rgb(col)/255
    rgb(tmp[1,], tmp[2,], tmp[3,], alpha=opacity)
  }
}

cols.tr <- make.transparent(cols, .75)

par(mfrow=c(1, 2), mar=c(4.1, 2.1, 1.5, 0.5),
    oma=c(0, 2, 0, 0), mgp=c(2.25, 1, 0))
plot(Sepal.Length ~ Sepal.Width, iris, las=1,
     col=cols.tr[Species], pch=shape[Species])
label(.04, .96, "a)")
mtext("Length of sepal or petal", 2, outer=FALSE, line=2.5, xpd=NA)
mtext("Sepal", 3, outer=FALSE, line=0.5)
plot(Petal.Length ~ Petal.Width, iris, las=1,
     col=cols.tr[Species], pch=shape[Species])
label(.04, .96, "b)")
mtext("Petal", 3, outer=FALSE, line=0.5)

## Finally, add a legend:
par(mfrow=c(1, 2), mar=c(4.1, 2.1, 1.5, 0.5),
    oma=c(0, 2, 0, 0), mgp=c(2.25, 1, 0))
plot(Sepal.Length ~ Sepal.Width, iris, las=1,
     col=cols.tr[Species], pch=shape[Species])
label(.04, .96, "a)")
mtext("Length of sepal or petal", 2, outer=FALSE, line=2.5, xpd=NA)
mtext("Sepal", 3, outer=FALSE, line=0.5)
plot(Petal.Length ~ Petal.Width, iris, las=1,
     col=cols.tr[Species], pch=shape[Species])
label(.04, .96, "b)")
mtext("Petal", 3, outer=FALSE, line=0.5)

legend.lab <- paste("Iris", levels(iris$Species))
legend("bottomright", legend.lab, pch=shape, col=cols)
       
## Legends can be tweaked too, to make them a bit less ugly, along
## with some other general tweaking.
par(mfrow=c(1, 2), mar=c(4.1, 2.1, 1.5, 0.5),
    oma=c(0, 1.5, 0, 0), mgp=c(2.25, .75, 0), bty="l", tcl=-0.3)
plot(Sepal.Length ~ Sepal.Width, iris, las=1,
     col=cols.tr[Species], pch=shape[Species], xlab="Sepal width")
label(.04, .96, "a)")
mtext("Length of sepal or petal", 2, outer=FALSE, line=1.8, xpd=NA)
mtext("Sepal", 3, outer=FALSE, line=0.5)
plot(Petal.Length ~ Petal.Width, iris, las=1,
     col=cols.tr[Species], pch=shape[Species], xlab="Petal width")
label(.04, .96, "b)")
mtext("Petal", 3, outer=FALSE, line=0.5)

legend.lab <- paste("Iris", levels(iris$Species))
legend("bottomright", legend.lab, pch=shape, col=cols,
       cex=.8, text.font=3, bty="n")

## Here was our contrast:
par(mfrow=c(1, 2))
plot(Sepal.Length ~ Sepal.Width, iris)
plot(Petal.Length ~ Petal.Width, iris)
