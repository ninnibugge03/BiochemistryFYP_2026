# R version: 4.5.2
# Raw melt curves and derivative plots for TSA Run 1 from Protocol

# ------------------------------------------------------------------
# Import Excel file with raw TSA data
# ------------------------------------------------------------------

# Load Excel file into R, select "Raw Data" sheet (skip first line to correct header formatting)
library(readxl)
TSA_raw <- read_excel("C:/Users/ninni/Desktop/TSA Results/3BiochemFYP_020226_run1.xlsx", 
                      sheet = "Sheet2", skip = 1)

png("TSA_figure4.png", width=2400, height=1050, res=450)

par(xpd = FALSE) # restrict plotting to inside plot lines

# ------------------------------------------------------------------
# extract information from my TSA strip
# ------------------------------------------------------------------

TSA_mine <- data.frame(Temp = TSA_raw$Temp., 
                       A3 = TSA_raw$A3, 
                       B3 = TSA_raw$B3,
                       C3 = TSA_raw$C3,
                       D3 = TSA_raw$D3,
                       E3 = TSA_raw$E3,
                       F3 = TSA_raw$F3,
                       G3 = TSA_raw$G3,
                       H3 = TSA_raw$H3)

# correct formatting (remove "UNK")
TSA_mine <- TSA_mine[TSA_mine$A3 != "UNK-9", ]

par(mfrow=c(1,2), mar=c(4,4,1,1), cex = 0.7)

# -----------------------------------------------------------------
# plot raw melt curve
# -----------------------------------------------------------------

# set variables
x <- TSA_mine$Temp
y1 <- TSA_mine$A3
y2 <- TSA_mine$B3
y3 <- TSA_mine$C3
y4 <- TSA_mine$D3
y5 <- TSA_mine$E3
y6 <- TSA_mine$F3
y7 <- TSA_mine$G3
y8 <- TSA_mine$H3

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
     at = c(pretty(cbind(y1,y2,y3,y4,y5,y6,y7,y8))),
     las = 1,
     cex.axis = 0.6,
     mgp = c(3, 0.7, 0))

# ------------------------------------------------------------------
# add plot legend
# ------------------------------------------------------------------

legend("topleft",
       legend = c(expression(paste("Baseline (dH"[2]*"O)")),
                  "Solvent control (10% EtOH)", 
                  expression(paste("EPA (26.45"*mu*"M)"))),
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
slope_smooth <- apply(slope, 2, function(x) stats::filter(x, rep(1/9,9), sides = 2))

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
                  "Solvent control (10% EtOH)",
                  expression("EPA (26.45"*mu*"M)")),
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
Tm

Mean_Tm_ctrl <- c(mean(Tm[1:2]))
Mean_Tm_EtOH <- c(mean(Tm[3:5]))
Mean_Tm_EPA <- c(mean(Tm[6:8]))

# --------------------------------------------------------------------
# add arrows and labels for Tm values
# --------------------------------------------------------------------

arrows(68,3400, Mean_Tm_EPA+0.5, 3400, # x,y end and x,y start coordinates
       length = 0.025,
       angle = 30,
       code = 1,
       col = "magenta")

text(66.5, 3400, # numerical vector( x,y) for text placement
     pos = 4, # position of text to vector, 4 = to the right of
     labels = expression("Tm = 61"*degree*"C"),
     col = "magenta",
     cex = 0.57)


arrows(69,2850, Mean_Tm_EtOH+0.5, 3000,
       length = 0.025,
       angle = 30,
       code = 1,
       col = "dodgerblue")

text(67.5, 2850,
     pos = 4,
     labels = expression("Tm = 61"*degree*"C"),
     col = "dodgerblue",
     cex = 0.57)

arrows(70,2350, Mean_Tm_ctrl+0.5, 2600,
       length = 0.025,
       angle = 30,
       code = 1,
       col = "black")

text(68.5, 2350,
     pos = 4,
     labels = expression("Tm = 61.5"*degree*"C"),
     col = "black",
     cex = 0.57)


dev.off() # mark end of plot figure
