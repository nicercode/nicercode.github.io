## Adj:

plot(0, 0, xlim=c(-3, 3), ylim=c(-3, 3), type="n")

points(1, 1, pch=19, cex=.5)
text(1, 1, "adj=c(0, 0)", adj=c(0, 0))

points(-1, -1, pch=19, cex=.5)
text(-1, -1, "adj=c(1, 1)", adj=c(1, 1))

points(1, -1, pch=19, cex=.5)
text(1, -1, "adj=c(0, 1)", adj=c(0, 1))

points(-1, 1, pch=19, cex=.5)
text(-1, 1, "adj=c(1, 0)", adj=c(1, 0))

## Scientific notation in axes:
plot(1:10, xlab="")
mtext("Photosynthetic rate (u mol m^-2 s^-1)", 1, 3)

plot(1:10, xlab="")
xlab <- expression(paste("Photosynthetic rate (", mu, " mol m^-2 s^-1)"))
mtext(xlab, 1, 3)

plot(1:10, xlab="")
xlab <- expression(paste("Photosynthetic rate (", mu, " mol ", m^-2,
    s^-1, ")"))
mtext(xlab, 1, 3)

## All in italics:
mtext("Species name", side=3, .5, font=3)

## Part italics:
mtext(expression(paste("Common name (", italic("Species name"), ")")),
      side=3, 2)

## Sizing:
pdf("size-large.pdf", width=10, height=10)
plot(1:10)
dev.off()

pdf("size-small.pdf", width=4, height=4)
plot(1:10)
dev.off()

pdf("size-large2.pdf", width=10, height=10, pointsize=32)
plot(1:10)
dev.off()

## Margins:
plot(1:10)

png("pics/margins_single.png", width=500, height=400, pointsize=18)
plot(1:10, type="n", axes=FALSE, xlab="", ylab="")
usr <- par("usr")
rect(usr[1], usr[3], usr[2], usr[4], col="grey")
axis(1, usr[1:2], c("usr[1]", "usr[2]"))
axis(2, usr[3:4], c("usr[3]", "usr[4]"), las=1)

for ( side in 1:4 ) {
  n <- par("mar")[side]
  for ( i in seq_len(floor(n)) ) {
    axis(side, c(3, 8), tcl=0, line=i, label=FALSE, lty=2)
    mtext(paste("line", i), side, line=i-1)
  }
}
dev.off()
