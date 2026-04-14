# R version: 4.5.2
# Mean melt curves and derivative of 26.45 uM EPA

# ------------------------------------------------------------------
# Import Excel file with raw TSA data from all 26.45uM EPA TSA runs
# ------------------------------------------------------------------

# Load Excel file into R, select "Sheet1" datasheet
EPA_raw <- read_excel("C:/Users/ninni/Desktop/TSA Results/10BiochemFYP_meanEPA.xlsx", 
                      sheet = "Sheet1")

png("meanEPA_figure.png", width=2400, height=1050, res=450)

par(xpd = FALSE) # restrict plotting to inside plot lines

# --------------------------------------------------------------------
# create tables with the data from each of the 3 TSA runs
# -------------------------------------------------------------------

EPA1 <- data.frame("A" = EPA_raw$A1,
                   "B" = EPA_raw$B1,
                   "C" = EPA_raw$C1,
                   "D" = EPA_raw$D1,
                   "E" = EPA_raw$E1,
                   "F" = EPA_raw$F1,
                   "G" = EPA_raw$G1,
                   "H" = EPA_raw$H1)

EPA2 <- data.frame("A" = EPA_raw$A2,
                   "B" = EPA_raw$B2,
                   "C" = EPA_raw$C2,
                   "D" = EPA_raw$D2,
                   "E" = EPA_raw$E2,
                   "F" = EPA_raw$F2,
                   "G" = EPA_raw$G2,
                   "H" = EPA_raw$H2)

EPA3 <- data.frame("A" = EPA_raw$A3,
                   "B" = EPA_raw$B3,
                   "C" = EPA_raw$C3,
                   "D" = EPA_raw$D3,
                   "E" = EPA_raw$E3,
                   "F" = EPA_raw$F3,
                   "G" = EPA_raw$G3,
                   "H" = EPA_raw$H3)

# -------------------------------------------------------------------
# take the mean of corresponding raw melt curves
# -------------------------------------------------------------------

meanA <- c(rowMeans(cbind(EPA1$A, EPA2$A, EPA3$A), na.rm = TRUE))
meanB <- c(rowMeans(cbind(EPA1$B, EPA2$B, EPA3$B), na.rm = TRUE))
meanC <- c(rowMeans(cbind(EPA1$C, EPA2$C, EPA3$C), na.rm = TRUE))
meanD <- c(rowMeans(cbind(EPA1$D, EPA2$D, EPA3$D), na.rm = TRUE))
meanE <- c(rowMeans(cbind(EPA1$E, EPA2$E, EPA3$E), na.rm = TRUE))
meanF <- c(rowMeans(cbind(EPA1$F, EPA2$F, EPA3$F), na.rm = TRUE))
meanG <- c(rowMeans(cbind(EPA1$G, EPA2$G, EPA3$G), na.rm = TRUE))
meanH <- c(rowMeans(cbind(EPA1$H, EPA2$H, EPA3$H), na.rm = TRUE))

# ------------------------------------------------------------------
# create new dataset table with the mean raw melt curve values
# ------------------------------------------------------------------

meanEPA <- data.frame("Temp" = EPA_raw$Temp., 
                      "A" = meanA,
                      "B" = meanB,
                      "C" = meanC,
                      "D" = meanD,
                      "E" = meanE,
                      "F" = meanF,
                      "G" = meanG,
                      "H" = meanH)

par(mfrow=c(1,2), mar=c(4,4,1,1), cex = 0.7)

# -----------------------------------------------------------------
# plot mean raw melt curve
# -----------------------------------------------------------------

# set variables
x <- meanEPA$Temp
y1 <- meanEPA$A
y2 <- meanEPA$B
y3 <- meanEPA$C
y4 <- meanEPA$D
y5 <- meanEPA$E
y6 <- meanEPA$F
y7 <- meanEPA$G
y8 <- meanEPA$H

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
temp <- as.numeric(meanEPA[ ,1])
fluor <- as.data.frame(lapply(meanEPA[ ,-1], as.numeric))

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
        xlim = c(29,86.5),
        ylim = c(-3500,4750),
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

arrows(70,4150, Mean_Tm_EPA+0.4, 4150, # x,y end and x,y start coordinates
       length = 0.025,
       angle = 30,
       code = 1,
       col = "magenta")

text(68.5, 4150, # numerical vector( x,y) for text placement
     pos = 4, # position of text to vector, 4 = to the right of
     labels = expression("Tm = 62.3"*degree*"C"),
     col = "magenta",
     cex = 0.57)


arrows(70,3100, Mean_Tm_EtOH, 3400,
       length = 0.025,
       angle = 30,
       code = 1,
       col = "dodgerblue")

text(68.5, 3100,
     pos = 4,
     labels = expression("Tm = 62.2"*degree*"C"),
     col = "dodgerblue",
     cex = 0.57)

arrows(70,3650, Mean_Tm_ctrl-0.2, 3600,
       length = 0.025,
       angle = 30,
       code = 1,
       col = "black")

text(68.5, 3650,
     pos = 4,
     labels = expression("Tm = 62.2"*degree*"C"),
     col = "black",
     cex = 0.57)



dev.off() # mark end of plot figure




