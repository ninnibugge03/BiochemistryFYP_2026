# R version: 4.5.2
# Raw melt curves and derivative plots for TSA Run 1 from Protocol

# ------------------------------------------------------------------
# Import Excel file with raw TSA data
# ------------------------------------------------------------------

# Load Excel file into R, select "Raw Data" sheet (skip first line to correct header formatting)
library(readxl)
TSA_raw <- read_excel("C:/Users/ninni/OneDrive - University of Bedfordshire/Documents/Year 3/BHS013-3 Biomedical Science Reserach Project/Lab Results/Thermal Shift Assay/TSA 1 Protocol/BiochemFYP_260126.xlsx", 
                       sheet = "Raw Data", skip = 1)

png("TSA_figure1.png", width=2400, height=1050, res=450)

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
        col = c("black","black","dodgerblue","dodgerblue","magenta","magenta","green3","green3"),
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
     cex.axis = 0.7,
     mgp = c(3, 0.7, 0))

# ------------------------------------------------------------------
# add plot legend
# ------------------------------------------------------------------

legend("topright",
       legend = c("ZAG : SYPRO 1:1 (Water)", "ZAG : SYPRO 1:1 (PBS)", 
                  "ZAG : SYPRO 2:5 (Water)", "ZAG : SYPRO 2:5 (PBS)"),
       col = c("black","dodgerblue","magenta","green3"),
       lty = c(1,1,1,1),
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
slope_smooth <- apply(slope, 2, function(x) stats::filter(x, rep(1/10,10), sides = 2))

# plot first derivative
matplot(temp_d, slope_smooth,
        type = "l",
        lty = 1,
        lwd = 1,
        col = c("black","black","dodgerblue","dodgerblue","magenta","magenta","green3","green3"),
        xlab = expression("Temperature (" * degree * "C)"),
        ylab = expression(Delta * "F/" * Delta * "T"),
        cex.lab = 0.85,
        xlim = c(29,86),
        ylim = c(-10000,7000),
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
       legend = c("ZAG : SYPRO 1:1 (Water)", "ZAG : SYPRO 1:1 (PBS)", 
                  "ZAG : SYPRO 2:5 (Water)", "ZAG : SYPRO 2:5 (PBS)"),
       col = c("black","dodgerblue","magenta","green3"),
       lty = c(1,1,1,1),
       lwd = 2,
       cex = 0.57,
       bty = "n")

# -------------------------------------------------------------------
# find the Tm
# -------------------------------------------------------------------

Tm_index <- apply(slope_smooth, 2, which.max)

Tm <- temp_d[Tm_index]
Tm

Tm_avg <- c(mean(Tm[1:2]),
            mean(Tm[3:4]),
            mean(Tm[5:6]),
            mean(Tm[7:8]))

Mean_Tm <- mean(Tm)

# --------------------------------------------------------------------
# add line and label for the average Tm
# --------------------------------------------------------------------

abline(v = Mean_Tm,
       lty = 2,
       col = "firebrick")


par(xpd = NA) # allow plotting outside plot frame

offset <- 0.03 * (usr[4] - usr[3])

text(Mean_Tm,
     usr[4] + offset,
     expression("Tm = 62" * degree * "C"),
     col = "firebrick",
     cex = 0.65)


dev.off() # mark end of plot figure
