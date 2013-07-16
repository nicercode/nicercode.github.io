fig.sci <- function() {
  plot(1:10, xlab="", ylab="")
  xlab <- expression(paste("Photosynthetic rate (", mu, " mol ", m^-2,
      s^-1, ")"))
  ylab <- "Photosynthetic rate (u mol m^-2 s^-1)"
  mtext(xlab, 1, 3)
  mtext(ylab, 2, 3)
  title(main="Doesn't the x axis label look nice?")
}

png("pics/sci.png", height=450, width=450, pointsize=18)
fig.sci()
dev.off()
