# R version: 4.5.2
# Raw melt curves and derivative plots for TSA Run 1 from Protocol

# ------------------------------------------------------------------
# Import Excel file with raw TSA data
# ------------------------------------------------------------------

# Load Excel file into R, select "Raw Data" sheet (skip first line to correct header formatting)
library(readxl)
TSA_raw <- read_excel("C:/Users/ninni/Desktop/TSA Results/5BiochemFYP_040226_run1.xlsx", 
                      sheet = "Sheet2", skip = 1)

png("TSA_figure6.1.png", width=2400, height=1050, res=450)

par(xpd = FALSE) # restrict plotting to inside plot lines

# ------------------------------------------------------------------
# extract information from my TSA strip
# ------------------------------------------------------------------

TSA_mine <- data.frame(Temp = TSA_raw$Temp., 
                       A2 = TSA_raw$A2, 
                       B2 = TSA_raw$B2,
                       C2 = TSA_raw$C2,
                       D2 = TSA_raw$D2,
                       E2 = TSA_raw$E2,
                       F2 = TSA_raw$F2,
                       G2 = TSA_raw$G2,
                       H2 = TSA_raw$H2)

# correct formatting (remove "UNK")
TSA_mine <- TSA_mine[TSA_mine$A2 != "UNK-5", ]

par(mfrow=c(1,2), mar=c(4,4,1,1), cex = 0.7)

# -----------------------------------------------------------------
# plot raw melt curve
# -----------------------------------------------------------------

# set variables
x <- TSA_mine$Temp
y1 <- TSA_mine$A2
y2 <- TSA_mine$B2
y3 <- TSA_mine$C2
y4 <- TSA_mine$D2
y5 <- TSA_mine$E2
y6 <- TSA_mine$F2
y7 <- TSA_mine$G2
y8 <- TSA_mine$H2

matplot(x, cbind(y1,y2,y3,y4,y5,y6,y7,y8),
        type = "l",
        lty = 1,
        lwd = 1,
        col = c("black","black","dodgerblue","dodgerblue","dodgerblue","magenta","magenta","magenta"),
        xlab = expression("Temperature (" * degree * "C)"),
        ylab = "Fluorescence (RFU)",
        cex.lab = 0.85,
        xlim = c(27,88),
        ylim = c(150000,205000),
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
                  expression(paste("EPA (52.90"*mu*"M)"))),
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
slope_smooth <- apply(slope, 2, function(x) stats::filter(x, rep(1/13,13), sides = 2))

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
        ylim = c(-1700,1700),
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
                  expression("EPA (52.90"*mu*"M)")),
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

arrows(70,905, Mean_Tm_EPA, 905, # x,y end and x,y start coordinates
       length = 0.025,
       angle = 30,
       code = 1,
       col = "magenta")

text(68.5, 905, # numerical vector( x,y) for text placement
     pos = 4, # position of text to vector, 4 = to the right of
     labels = expression("Tm = 61.7"*degree*"C"),
     col = "magenta",
     cex = 0.57)

arrows(70,600, Mean_Tm_EtOH, 600,
       length = 0.025,
       angle = 30,
       code = 1,
       col = "dodgerblue")

text(68.5, 600,
     pos = 4,
     labels = expression("Tm = 61.5"*degree*"C"),
     col = "dodgerblue",
     cex = 0.57)

arrows(70,1427, Mean_Tm_ctrl, 1427,
       length = 0.025,
       angle = 30,
       code = 1,
       col = "black")

text(68.5, 1427,
     pos = 4,
     labels = expression("Tm = 62.7"*degree*"C"),
     col = "black",
     cex = 0.57)

dev.off() # mark end of plot figure
