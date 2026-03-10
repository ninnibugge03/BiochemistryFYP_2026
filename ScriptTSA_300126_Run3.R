# R version: 4.5.2
# Raw melt curves and derivative plots for TSA Run 1 from Protocol

# ------------------------------------------------------------------
# Import Excel file with raw TSA data
# ------------------------------------------------------------------

# Load Excel file into R, select "Raw Data" sheet (skip first line to correct header formatting)
TSA_raw <- read_excel("C:/Users/ninni/Desktop/TSA Results/2BiochemFYP_300126.xlsx", 
                      sheet = "Sheet2", skip = 1)

png("TSA_figure3.png", width=2400, height=1050, res=450)

par(xpd = FALSE) # restrict plotting to inside plot lines

# ------------------------------------------------------------------
# extract information from my TSA strip
# ------------------------------------------------------------------

TSA_mine <- data.frame(Temp = TSA_raw$Temp., 
                       A5 = TSA_raw$A5, 
                       B5 = TSA_raw$B5,
                       C5 = TSA_raw$C5,
                       D5 = TSA_raw$D5,
                       E5 = TSA_raw$E5,
                       F5 = TSA_raw$F5,
                       G5 = TSA_raw$G5,
                       H5 = TSA_raw$H5)

# correct formatting (remove "UNK")
TSA_mine <- TSA_mine[TSA_mine$A5 != "UNK-17", ]

par(mfrow=c(1,2), mar=c(4,4,1,1), cex = 0.7)

# -----------------------------------------------------------------
# plot raw melt curve
# -----------------------------------------------------------------

# set variables
x <- TSA_mine$Temp
y1 <- TSA_mine$A5
y2 <- TSA_mine$B5
y3 <- TSA_mine$C5
y4 <- TSA_mine$D5
y5 <- TSA_mine$E5
y6 <- TSA_mine$F5
y7 <- TSA_mine$G5
y8 <- TSA_mine$H5

matplot(x, cbind(y1,y2,y3,y4,y5,y6,y7,y8),
        type = "l",
        lty = 1,
        lwd = 1,
        col = c("black","black","dodgerblue","dodgerblue","dodgerblue","magenta","magenta","magenta"),
        xlab = expression("Temperature (" * degree * "C)"),
        ylab = "Fluorescence (RFU)",
        cex.lab = 0.85,
        xlim = c(27,88),
        xaxt = "n",
        yaxt = "n")

# ------------------------------------------------------------------
# create axes
# ------------------------------------------------------------------

# x-axis
axis(side = 1,
     at = c(pretty(x)),
     cex.axis = 0.8,
     mgp = c(3, 0.5, 0))

# y-axis
axis(side = 2,
     at = c(pretty(y6)),
     las = 1,
     cex.axis = 0.6,
     mgp = c(3, 0.7, 0))

# ------------------------------------------------------------------
# add plot legend
# ------------------------------------------------------------------

legend("topleft",
       legend = c(expression(paste("Baseline (dH"[2]*"O)")),
                  "Solvent Control (100% EtOH)", 
                  expression(paste("EPA (264.48"*mu*"M)"))),
       col = c("black","dodgerblue","magenta"),
       lty = c(1,1,1),
       lwd = 2,
       cex = 0.57,
       bty = "n")

# -------------------------------------------------------------------
# create first derivative graph
# -------------------------------------------------------------------

# set temperature and fluorescence as numerical variables
temp <- as.numeric(TSA_mine[ ,1])
fluor <- as.data.frame(lapply(TSA_mine[ ,-1], as.numeric))

# create the first derivative
slope <- apply(fluor, 2, diff) / diff(temp)

temp_d <- temp[-1] # adjust temperature (diff() command shortens it)

# adjust graph smoothness by controlling size of moving average (rep(1/average, average))
slope_smooth <- apply(slope, 2, function(x) stats::filter(x, rep(1/15,15), sides = 2))

# plot first derivative
matplot(temp_d, slope_smooth,
        type = "l",
        lty = 1,
        lwd = 1,
        col = c("black","black","dodgerblue","dodgerblue","dodgerblue","magenta","magenta","magenta"),
        xlab = expression("Temperature (" * degree * "C)"),
        ylab = expression(Delta * "F/" * Delta * "T"),
        cex.lab = 0.85,
        xlim = c(29,86),
        ylim = c(-4000,4000),
        xaxt = "n",
        yaxt = "n")

usr <- par("usr")

# ----------------------------------------------------------------
# create axes
# ----------------------------------------------------------------

axis(side = 1,
     at = c(pretty(temp_d)),
     cex.axis = 0.8,
     mgp = c(3, 0.5, 0))

axis(side = 2,
     at = c(pretty(slope_smooth)),
     las = 1,
     cex.axis = 0.7,
     mgp = c(3, 0.7, 0))

# --------------------------------------------------------------------
# create legend
# --------------------------------------------------------------------

legend("topleft",
       legend = c(expression("Baseline (dH"[2]*"O)"),
                  "Solvent Control (100% EtOH)",
                  expression("EPA (264.48"*mu*"M)")),
       col = c("black","dodgerblue","magenta"),
       lty = c(1,1,1),
       lwd = 2,
       cex = 0.57,
       bty = "n")

# -------------------------------------------------------------------
# find the Tm
# -------------------------------------------------------------------

Tm_index <- apply(slope_smooth, 2, which.max)

Tm <- temp_d[Tm_index]

Mean_Tm_ctrl <- c(mean(Tm[1:2]))
Mean_Tm_EtOH <- c(mean(Tm[3:5]))
Mean_Tm_EPA <- c(mean(Tm[6:8]))

# --------------------------------------------------------------------
# add line 
# --------------------------------------------------------------------

abline(v = Mean_Tm_ctrl,
       lty = 2,
       col = "black")

par(xpd = NA) # allow plotting outside plot frame

offset <- 0.03 * (usr[4] - usr[3])

text(Mean_Tm_ctrl,
     usr[4] + offset,
     expression("Tm = 62" * degree * "C"),
     col = "black",
     cex = 0.65)


dev.off() # mark end of plot figure
