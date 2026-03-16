# R version: 4.5.2
# Statistical analysis of Tm for mean EPA plot

# ------------------------------------------------------------------
# Import Excel file with raw TSA data from all 26.45uM EPA TSA runs
# ------------------------------------------------------------------

# Load Excel file into R, select "Sheet1" datasheet
library(readxl)
EPA_raw <- read_excel("C:/Users/ninni/Desktop/TSA Results/10BiochemFYP_meanEPA.xlsx", 
                      sheet = "Sheet1")

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

meanCTRL <- rowMeans(cbind(EPA1$A, EPA2$A, EPA3$A, EPA1$B, EPA2$B, EPA3$B))
meanEtOH <- rowMeans(cbind(EPA1$C, EPA2$C, EPA3$C, EPA1$D, EPA2$D, EPA3$D, EPA1$E, EPA2$E, EPA3$E))
EPAmean <- rowMeans(cbind(EPA1$F, EPA2$F, EPA3$F, EPA1$G, EPA2$G, EPA3$G, EPA1$H, EPA2$H, EPA3$H))

mean_cond <- data.frame(Temperature = meanEPA$Temp,
                        Control = meanCTRL,
                        Ethanol = meanEtOH,
                        EPA = EPAmean)


library(dplyr)

Tm_A1 <- EPA_raw$Temp.[which.max(diff(EPA_raw$A1))] # Tm of A1 (n=1 baseline)

replicates <- EPA_raw[ ,2:ncol(EPA_raw)] # set "replicates" as all columns but not temp.

Tm <- sapply(replicates, function(x) EPA_raw$Temp.[which.max(diff(x))])
Tm

Tm_CTRL <- Tm[c("A1","A2","A3","B1","B2","B3")]
Tm_EtOH <- Tm[c("C1","C2","C3","D1","D2","D3","E1","E2","E3")]
Tm_EPA <- Tm[c("F1","F2","F3","G1","G2","G3","H1","H2","H3")]

condition <- c(
  rep("CTRL", length(Tm_CTRL)),  # 6
  rep("EtOH", length(Tm_EtOH)),  # 9
  rep("EPA", length(Tm_EPA))   # 9
)

Tm_table <- data.frame(Tm = Tm, condition = condition)

pairwise.t.test(Tm_table$Tm, Tm_table$condition, p.adjust.method = "bonferroni", paired = FALSE)

mean(Tm_CTRL); sd(Tm_CTRL)
mean(Tm_EtOH); sd(Tm_EtOH)
mean(Tm_EPA); sd(Tm_EPA)

