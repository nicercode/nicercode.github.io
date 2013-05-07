rm(list=ls(all=TRUE)) #start with empty workspace

## Load the data
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
          Longevity="17-1_MaxLongevity_m", 
          Metabolic.rate = "5-2_BasalMetRateMass_g",
          Gestation.length= "9-1_GestationLen_d",
          HomeRange = "22-1_HomeRange_km2",
          OffspringSize="5-3_NeonateBodyMass_g",   
          PopulationDensity="21-1_PopulationDensity_n/km2",       
          AgeAtMaturation="23-1_SexualMaturityAge_d")

data <- data.all[cols]
names(data) <- names(cols)

## Convert longevity in months to years
data$Longevity <- data$Longevity / 12

plot(Longevity ~ Mass, data, log="xy", col="#66666666", pch=19,
     xlab="Body mass (g)", ylab="Longevity (years)", las=1)

## Add nice log-10 labels to the plot
usr <- par("usr")
r <- round(usr[1:2])
at <- seq(r[1], r[2])
lab <- do.call(expression, lapply(at, function(i) bquote(10^.(i))))
axis(1, at=10^at, lab)

## Note: we use log10 here because that's what the plot uses (not
## natural logs)
fit <- lm(log10(Longevity) ~ log10(Mass), data)
abline(fit, col="#66666666")

## Add focus group of points for Carnivora
data.order <- data[data$Order == "Carnivora",]
fit <- lm(log10(Longevity) ~ log10(Mass), data.order)
points(Longevity ~ Mass, data.order, pch=19, col="#ff000066")
abline(fit, col="#ff000066")

title(main="Carnivora", line=1)

plot(Longevity ~ Mass, data, log="xy", col="#66666666", pch=19,
     xlab="Body mass (g)", ylab="Longevity (years)", las=1)

## Add nice log-10 labels to the plot
usr <- par("usr")
r <- round(usr[1:2])
at <- seq(r[1], r[2])
lab <- do.call(expression, lapply(at, function(i) bquote(10^.(i))))
axis(1, at=10^at, lab)

## Note: we use log10 here because that's what the plot uses (not
## natural logs)
fit <- lm(log10(Longevity) ~ log10(Mass), data)
abline(fit, col="#66666666")

## Add focus group of points for Chiroptera
data.order <- data[data$Order == "Chiroptera",]
fit <- lm(log10(Longevity) ~ log10(Mass), data.order)
points(Longevity ~ Mass, data.order, pch=19, col="#ff000066")
abline(fit, col="#ff000066")

title(main="Chiroptera", line=1)


## Repeat for another variable pair

plot(Gestation.length ~ Mass, data, log="xy", col="#66666666", pch=19,
     xlab="Body mass (g)", ylab="Gestation.length (d)", las=1)

## Add nice log-10 labels to the plot
usr <- par("usr")
r <- round(usr[1:2])
at <- seq(r[1], r[2])
lab <- do.call(expression, lapply(at, function(i) bquote(10^.(i))))
axis(1, at=10^at, lab)

## Note: we use log10 here because that's what the plot uses (not
## natural logs)
fit <- lm(log10(Gestation.length) ~ log10(Mass), data)
abline(fit, col="#66666666")

## Add focus group of points for Carnivora
data.order <- data[data$Order == "Carnivora",]
fit <- lm(log10(Gestation.length) ~ log10(Mass), data.order)
points(Gestation.length ~ Mass, data.order, pch=19, col="#ff000066")
abline(fit, col="#ff000066")

title(main="Carnivora", line=1)

plot(Gestation.length ~ Mass, data, log="xy", col="#66666666", pch=19,
     xlab="Body mass (g)", ylab="Gestation.length (d)", las=1)

## Add nice log-10 labels to the plot
usr <- par("usr")
r <- round(usr[1:2])
at <- seq(r[1], r[2])
lab <- do.call(expression, lapply(at, function(i) bquote(10^.(i))))
axis(1, at=10^at, lab)

## Note: we use log10 here because that's what the plot uses (not
## natural logs)
fit <- lm(log10(Gestation.length) ~ log10(Mass), data)
abline(fit, col="#66666666")

## Add focus group of points for Chiroptera
data.order <- data[data$Order == "Chiroptera",]
fit <- lm(log10(Gestation.length) ~ log10(Mass), data.order)
points(Gestation.length ~ Mass, data.order, pch=19, col="#ff000066")
abline(fit, col="#ff000066")

title(main="Chiroptera", line=1)


## And another variable pair

plot(OffspringSize ~ Mass, data, log="xy", col="#66666666", pch=19,
     xlab="Body mass (g)", ylab="Offspring size (g)", las=1)

## Add nice log-10 labels to the plot
usr <- par("usr")
r <- round(usr[1:2])
at <- seq(r[1], r[2])
lab <- do.call(expression, lapply(at, function(i) bquote(10^.(i))))
axis(1, at=10^at, lab)

## Note: we use log10 here because that's what the plot uses (not
## natural logs)
fit <- lm(log10(OffspringSize) ~ log10(Mass), data)
abline(fit, col="#66666666")

## Add focus group of points for Carnivora
data.order <- data[data$Order == "Carnivora",]
fit <- lm(log10(OffspringSize) ~ log10(Mass), data.order)
points(OffspringSize ~ Mass, data.order, pch=19, col="#ff000066")
abline(fit, col="#ff000066")

title(main="Carnivora", line=1)

plot(OffspringSize ~ Mass, data, log="xy", col="#66666666", pch=19,
     xlab="Body mass (g)", ylab="Offspring size (g)", las=1)

## Add nice log-10 labels to the plot
usr <- par("usr")
r <- round(usr[1:2])
at <- seq(r[1], r[2])
lab <- do.call(expression, lapply(at, function(i) bquote(10^.(i))))
axis(1, at=10^at, lab)

## Note: we use log10 here because that's what the plot uses (not
## natural logs)
fit <- lm(log10(OffspringSize) ~ log10(Mass), data)
abline(fit, col="#66666666")

## Add focus group of points for Chiroptera
data.order <- data[data$Order == "Chiroptera",]
fit <- lm(log10(OffspringSize) ~ log10(Mass), data.order)
points(OffspringSize ~ Mass, data.order, pch=19, col="#ff000066")
abline(fit, col="#ff000066")

title(main="Chiroptera", line=1)
