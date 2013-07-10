# Original code in ~/Documents/Talks/graphics

fig.example <- function() {
  set.seed(10)
  plot(runif(100), runif(100), col=rev(rainbow(100)))
}

pdf("example.pdf", height=5, width=5)
fig.example()
dev.off()

png("example.png", height=500, width=500, pointsize=16)
fig.example()
dev.off()

jpeg("example.jpeg", height=500, width=500, quality=50, pointsize=16)
fig.example()
dev.off()
