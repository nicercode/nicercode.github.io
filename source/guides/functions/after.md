---
layout: page
title: "A script using functions"
date: 2013-05-07 11:10
comments: true
sharing: true
categories: 
---

The main script

```r
source("script-fun.R")

data <- load.data()

## Plot Mass against Longevity for Carnivora and for Chiroptera
plot.pair(data, "Mass", "Longevity", "Carnivora")
plot.pair(data, "Mass", "Longevity", "Chiroptera")

## Construct a new plot by reusing primatives
cols <- c(Carnivora="#eaab00",
          Chiroptera="#803d0d",
          Artiodactyla="#cc0033",
          Rodentia="#5c705e",
          Diprotodontia="#56364d")
plot(Longevity ~ Mass, data, log="xy", type="n",
     xlab="Body mass (g)", ylab="Longevity (years)", las=1)
add.bg.points(data, "Mass", "Longevity", "grey")
for ( order in names(cols) )
  add.order(data, "Mass", "Longevity", order, make.transparent(cols[[order]]))
legend("bottomright", names(cols), fill=make.transparent(cols), bty="n")


## Define new functions to combine plots,
## e.g. create a matrix of plots

## Plots a matrix of bivariate plots, highlighting a given order 
plotMatrix<-function(data, vars, order, 
                     col.focus=make.transparent("blue", .2), 
                     mar=c(5, 5, 0.5, 0.5), 
                     oma=c(0.5, 0.5, 0.5, 0.5)) {
  par(mfrow=c(length(vars), length(vars)), mar=mar, oma=oma)
  for (i in vars) {
    for (j in vars) {
      if (i != j)
        plot.pair(data, i, j, order, col.focus=col.focus)               
      else
        plot.new()
    }
  }    
}

pdf("Matrix.plot.pdf", height =12, width=12)
plotMatrix(data, vars[6:10], "Carnivora")
dev.off()

## Scale up - repeat for all orders.
for (order in names(cols)) {
  pdf(paste0("Matrix.plot-", order,".pdf"), height =12, width=12)
  plotMatrix(data, vars[6:10], order, col.focus = make.transparent(cols[[order]]))
  dev.off()  
}
```

The functions file, loaded using `source` in the main script.

```r
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
            Longevity="17-1_MaxLongevity_m", 
            Metabolic.rate = "5-2_BasalMetRateMass_g",
            Gestation.length= "9-1_GestationLen_d",
            HomeRange = "22-1_HomeRange_km2",
            OffspringSize="5-3_NeonateBodyMass_g",   
            PopulationDensity="21-1_PopulationDensity_n/km2",       
            AgeAtMaturation="23-1_SexualMaturityAge_d"     
  )
  data <- data.all[cols]
  
  names(data) <- names(cols)
  
  ## Convert longevity in months to years
  data$Longevity <- data$Longevity / 12
  
  data
}

plot.pair <- function(data, xvar, yvar, focus,
                      col.bg=make.transparent("grey", .5),
                      col.focus=make.transparent("blue", .2),
                      pch=19) {
  plot(data[[xvar]], data[[yvar]], log="xy", type="n", 
       xlab=xvar, ylab=yvar, las=1)
  add.bg.points(data, xvar, yvar, col.bg, pch)
  add.order(data, xvar, yvar, focus, col.focus, pch)
  
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
add.order <- function(data, xvar, yvar, order, col, pch=19) {
  if ( is.null(order) )
    data.order <- data
  else
    data.order <- data[data$Order == order,]
  
  ## Note: we use log10 here because that's what the plot uses (not
  ## natural logs)
  points(data.order[[xvar]], data.order[[yvar]], pch=pch, col=col)
  
  if (sum(!is.na(data.order[[yvar]]) && !is.na(data.order[[xvar]])) >3) {
    fit <- lm(log10(data.order[[yvar]]) ~ log10(data.order[[xvar]]))
    abline(fit, col=col)    
  }
}

add.bg.points <- function(data, xvar, yvar, col, pch=19)
  add.order(data, xvar, yvar, NULL, col, pch)
```

Download these files: [main script](script.R) and the
[function definitions](script-fun.R).
