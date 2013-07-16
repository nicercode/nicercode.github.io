f <- function(x, y, adj) {
  points(x, y, pch=19, cex=.5, col="red")
  text(x, y, sprintf("adj=c(%s)", paste(adj, collapse=", ")), adj=adj)
}

fig.adj <- function() {
  op <- par(mar=rep(.5, 4))
  on.exit(par(op))
  plot(0, 0, xlim=c(-2, 2), ylim=c(-2, 2), type="n", axes=FALSE,
       xlab="", ylab="")
  box()
  f( 1,  1, c(0, 0))
  f(-1, -1, c(1, 1))
  f(-1,  1, c(1, 0))
  f( 1, -1, c(0, 1))
  f( 0,  0, c(.5, .5))
  f( 0,  1, c(.5, 0))
  f( 0, -1, c(.5, 1))
  f( 1,  0, c(0, .5))
  f(-1,  0, c(1, .5))
}

png("pics/adj.png", height=450, width=450, pointsize=18)
fig.adj()
dev.off()
