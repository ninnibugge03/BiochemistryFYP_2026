# R version: 4.5.2
# Raw melt curves and derivative plots for TSA Run 1 from Protocol

# ------------------------------------------------------------------
# Import Excel file with raw TSA data
# ------------------------------------------------------------------

# Load Excel file into R, select "Raw Data" sheet (skip first line to correct header formatting)
library(readxl)
TSA_raw <- read_excel("C:/Users/ninni/Desktop/TSA Results/7BiochemFYP_060226_run1_D.xlsx", 
                      sheet = "Sheet2", skip = 1)

png("TSA_figure8.png", width=2400, height=1050, res=450)

par(xpd = FALSE) # restrict plotting to inside plot lines

# ------------------------------------------------------------------
# extract information from my TSA strip
# ------------------------------------------------------------------

TSA_mine <- data.frame(Temp = TSA_raw$Temp., 
                       A1 = TSA_raw$A1, 
                       B1 = TSA_raw$B1,
                       C1 = TSA_raw$C1,
                       D1 = TSA_raw$D1,
                       E1 = TSA_raw$E1,
                       F1 = TSA_raw$F1,
                       G1 = TSA_raw$G1,
                       H1 = TSA_raw$H1)

# correct formatting (remove "UNK")
TSA_mine <- TSA_mine[TSA_mine$A1 != "UNK-1", ]

par(mfrow=c(1,2), mar=c(4,4,1,1), cex = 0.7)

# -----------------------------------------------------------------
# plot raw melt curve
# -----------------------------------------------------------------

# set variables
x <- TSA_mine$Temp
y1 <- TSA_mine$A1
y2 <- TSA_mine$B1
y3 <- TSA_mine$C1
y4 <- TSA_mine$D1
y5 <- TSA_mine$E1
y6 <- TSA_mine$F1
y7 <- TSA_mine$G1
y8 <- TSA_mine$H1

matplot(x, cbind(y1,y2,y3,y4,y5,y6,y7,y8),
        type = "l",
        lty = 1,
        lwd = 1,
        col = c("black","black","dodgerblue2","dodgerblue2","dodgerblue2","mediumvioletred","mediumvioletred","mediumvioletred"),
        xlab = expression("Temperature (" * degree * "C)"),
        ylab = "Fluorescence (RFU)",
        cex.lab = 0.85,
        xlim = c(27,88),
        ylim = c(150000,190000),
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

legend("topright",
       legend = c(expression(paste("Baseline (dH"[2]*"O)")),
                  "Solvent control (10% EtOH)", 
                  expression(paste("DAUDA (50.62"*mu*"M)"))),
       col = c("black","dodgerblue2","mediumvioletred"),
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
        col = c("black","black","dodgerblue2","dodgerblue2","dodgerblue2","mediumvioletred","mediumvioletred","mediumvioletred"),
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
                  expression("DAUDA (50.62"*mu*"M)")),
       col = c("black","dodgerblue2","mediumvioletred"),
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
Mean_Tm_DAUDA <- c(mean(Tm[6:8]))

# --------------------------------------------------------------------
# add arrows and labels for Tm values
# --------------------------------------------------------------------

arrows(70,1200, Mean_Tm_DAUDA-0.05, 1350, # x,y end and x,y start coordinates
       length = 0.025,
       angle = 30,
       code = 1,
       col = "mediumvioletred")

text(68.5, 1200, # numerical vector( x,y) for text placement
     pos = 4, # position of text to vector, 4 = to the right of
     labels = expression("Tm = 63.8"*degree*"C"),
     col = "mediumvioletred",
     cex = 0.57)


arrows(70,600, Mean_Tm_EtOH+0.5, 750,
       length = 0.025,
       angle = 30,
       code = 1,
       col = "dodgerblue2")

text(68.5, 600,
     pos = 4,
     labels = expression("Tm = 61.8"*degree*"C"),
     col = "dodgerblue2",
     cex = 0.57)

arrows(70,900, Mean_Tm_ctrl+0.5, 1100,
       length = 0.025,
       angle = 30,
       code = 1,
       col = "black")

text(68.5, 900,
     pos = 4,
     labels = expression("Tm = 62"*degree*"C"),
     col = "black",
     cex = 0.57)



dev.off() # mark end of plot figure
