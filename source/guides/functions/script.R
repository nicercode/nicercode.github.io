load.data <- function() {
  url <-
    "http://esapubs.org/archive/ecol/E090/184/PanTHERIA_1-0_WR93_Aug2008.txt"
  if ( !file.exists("pantheria.txt") )
    download.file(url, "pantheria.txt")
  data.all <- read.table("pantheria.txt", as.is=TRUE,
                         header=TRUE, sep="\t", check.names=FALSE,
                         na.strings="-999")
  
  ## Subset interesting columns and rename
  cols <- c(Order="MSW93_Order",
            Family="MSW93_Family",
            Genus="MSW93_Genus",
            Species="MSW93_Species",
            Mass="5-1_AdultBodyMass_g",
            Length="13-1_AdultHeadBodyLen_mm",
            Longevity="17-1_MaxLongevity_m")
  data <- data.all[cols]
  names(data) <- names(cols)

  ## Convert longevity in months to years
  data$Longevity <- data$Longevity / 12
  
  data
}

plot.longevity <- function(data, focus,
                           col.bg=make.transparent("grey", .5),
                           col.focus=make.transparent("blue", .2),
                           pch=19) {
  plot(Longevity ~ Mass, data, log="xy", type="n", 
       xlab="Body mass (g)", ylab="Longevity (years)", las=1)
  add.bg.points(data, col.bg, pch)
  add.order(data, focus, col.focus, pch)

  title(main=focus, line=1)
}

## Nice log-10 axis labels
axis.log <- function(side, ...) {
  usr <- par("usr")
  r <- round(if (side %in% c(1, 3)) usr[1:2] else usr[3:4])
  at <- seq(r[1], r[2])
  lab <- do.call(expression, lapply(at, function(i) bquote(10^.(i))))
  axis(1, at=10^at, lab, ...)
}

## Semitransparent colours
make.transparent <- function(col, transparency=0.5) {
  tmp <- col2rgb(col)/255
  rgb(tmp[1,], tmp[2,], tmp[3,], alpha=1-transparency)
}

## Add points and fit for one order of data.  If order is NULL, do
## *all* orders.
add.order <- function(data, order, col, pch=19) {
  if ( is.null(order) )
    data.order <- data
  else
    data.order <- data[data$Order == order,]

  ## Note: we use log10 here because that's what the plot uses (not
  ## natural logs)
  fit <- lm(log10(Longevity) ~ log10(Mass), data.order)

  points(Longevity ~ Mass, data.order, pch=pch, col=col)
  abline(fit, col=col)
}

add.bg.points <- function(data, col, pch=19)
  add.order(data, NULL, col, pch)

## Actual script:
data <- load.data()

plot.longevity(data, "Carnivora")
plot.longevity(data, "Chiroptera")

## Reusing primatives:
cols <- c(Carnivora="#eaab00",
          Chiroptera="#803d0d",
          Artiodactyla="#cc0033",
          Rodentia="#5c705e",
          Diprotodontia="#56364d")
plot(Longevity ~ Mass, data, log="xy", type="n",
     xlab="Body mass (g)", ylab="Longevity (years)", las=1)
add.bg.points(data, "grey")
for ( order in names(cols) )
  add.order(data, order, make.transparent(cols[[order]]))
legend("bottomright", names(cols), fill=make.transparent(cols), bty="n")
