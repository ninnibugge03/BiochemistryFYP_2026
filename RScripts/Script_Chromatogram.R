# R version used: 4.5.2

# R script used to generate gel-filtration chroatogram (figure X)
# and determine elution volumes of aggregated and monomeric ZAG

# ----------------------------------------------------------------
# Import CSv file with chromatogram data
# ----------------------------------------------------------------

# Load CSV file into R (skip first 2 lines to correct header formatting)
ZAG_CHROM <- read.csv("C:/Users/ninni/Desktop/2026_2300211_ZAG PURIFICATION 001.csv",
                      skip = 2)

par(xpd = FALSE) # prevent plotting outside plot frame

# ---------------------------------------------------------------
# Exctract fraction information
# ---------------------------------------------------------------

# plot all fraction events (excluding NA)
frac_events <- ZAG_CHROM[!is.na(ZAG_CHROM$ml.1), ]

# find first occurrance of each fraction
frac_start <- frac_events[!duplicated(frac_events$Fraction), ]

# restrict fractions to relevant elution range
frac_start <- frac_start[
  frac_start$ml >= 4.5 & frac_start$ml <= 80,
  ]

# determine fraction start points
frac_start <- aggregate(
  ml.1 ~ Fraction,
  data = frac_events,
  FUN = min
  )

colnames(frac_start)[2] <- "start_ml"

frac_start <- frac_start[order(frac_start$start_ml), ]

frac_start$end_ml <- c(
  frac_start$start_ml[-1],
  max(frac_events$ml.1, na.rm = TRUE)
  )

# remove last waste fraction
frac_events <- frac_events[frac_events$Fraction != "Waste", ]

# --------------------------------------------------------------------
# correct elution volume for UV detector offset
# --------------------------------------------------------------------

uv_offset_ml <- 22.0059

ZAG_CHROM$ml_abs <- ZAG_CHROM$ml + uv_offset_ml

# -------------------------------------------------------------------
# create chromatogram plot
# -------------------------------------------------------------------

plot(ZAG_CHROM$ml_abs,ZAG_CHROM$mAU,
     type = "l",
     col = "firebrick",
     ylab = "Absorbance at 280nm (mAU)",
     xlab = "Elution Volume (mL)",
     cex.lab = 0.8,
     lwd = 2,
     xlim = c(25, 102.65),
     xaxt = "n",
     yaxt = "n",
     )

usr <- par("usr")

# -------------------------------------------------------------------
# create axes
# -------------------------------------------------------------------

# x-axis
axis(side = 1,
     at = c(0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100,105),
     labels = c(0,NA,10,NA,20,NA,30,NA,40,NA,50,NA,60,NA,70,NA,80,NA,90,NA,100,NA),
     lwd = 1,
     cex.axis = 0.8,
     mgp = c(3, 0.5, 0),
     )

# y-axis
axis(side = 2,
     at = c(0,2,4,6,8,10,12,14,16,18),
     las = 1, # 0 is standard, 1 is horizontal, 2 perpendicular to axis
     cex.axis = 0.8,
     mgp = c(3, 0.7, 0),
     )

# ---------------------------------------------------------------------
# create fraction bars
# ---------------------------------------------------------------------

rect(
  xleft  = frac_start$start_ml,
  xright = frac_start$end_ml,
  ybottom = usr[3],
  ytop    = usr[3] + 0.4,
  col = "lightblue",
  border = "darkgreen"
  )

# --------------------------------------------------------------------
# add plot legend
# --------------------------------------------------------------------

legend("topleft",
       legend = c("UV", "Fractions"),
       col = c("firebrick", NA),
       lwd = c(2,1),
       lty = c(1,NA), #symbol or line, 1 is solid line, goes up to however many
       bty = "n", #removes box around legend
       cex = 0.7
       )

#add rectangle as fraction symbol in legend
rect(
  xleft = 23.7,
  xright = 27.5,
  ybottom = 15.2,
  ytop = 15.7,
  col="lightblue", border="darkgreen")

# ---------------------------------------------------------------------
# finding the elution volumes for the peaks
# ---------------------------------------------------------------------

peaks <- which(diff(sign(diff(ZAG_CHROM$mAU))) == -2) + 1

peak_positions <- ZAG_CHROM$ml[peaks]
peak_heights <- ZAG_CHROM$mAU[peaks]

peak_data <- data.frame(position = peak_positions,
                        height = peak_heights
                        )

# -----------------------------------------------------------------
# determine aggregate and monomer peaks
# -----------------------------------------------------------------

monomer_peak <- peak_data[order(-peak_data$height), ][4, ]
mon_peak <- monomer_peak$position + uv_offset_ml

abline(v = mon_peak,
       col = "darkblue",
       lty = 2,
       lwd = 1
       )

aggregate_peak <- peak_data[order(-peak_data$height), ][3, ]
agg_peak <- aggregate_peak$position + uv_offset_ml

abline(v = agg_peak,
       col = "mediumvioletred",
       lty = 2,
       lwd = 1
       )

# -------------------------------------------------------------------
# add peak labels
# -------------------------------------------------------------------

par(xpd = NA) # allow plotting outside plot frame

offset <- 0.05 * (usr[4] - usr[3])

text(mon_peak,
     usr[4] + offset,
     expression("Monomeric " * italic(V)[e]),
     col = "darkblue",
     cex = 0.7)

text(agg_peak,
     usr[4] + offset,
     expression("Aggregate " * italic(V)[e]),
     col = "mediumvioletred",
     cex = 0.7)

# ------------------------------------------------------------------
# add fraction labels
# ------------------------------------------------------------------

text(
  x = (frac_start$start_ml + frac_start$end_ml) / 2,
  y = usr[3] + 0.6,
  labels = frac_start$Fraction,
  cex = 0.55, # change the size of the text (1 is standard)
  adj = c(0.5, 0),
  col = "darkgreen",
  lwd = 1.7
  )
