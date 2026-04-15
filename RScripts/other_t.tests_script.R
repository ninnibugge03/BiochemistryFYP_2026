# R version: 4.5.2
# Statistical analysis of Tm for summary table

# --------------------------------------------------------------------
# Import Excel files with raw TSA data
# --------------------------------------------------------------------

library(readxl)

EPA52_raw <- read_excel("C:/Users/ninni/Desktop/TSA Results/5BiochemFYP_040226_run1.xlsx", 
                         sheet = "Sheet2", skip = 1)

EPA72_raw <- read_excel("C:/Users/ninni/Desktop/TSA Results/6BiochemFYP_040226_run3.xlsx", 
                        sheet = "sheet2", skip = 1)

DAUDA18_raw <- read_excel("C:/Users/ninni/Desktop/TSA Results/8BiochemFYP_060226_run2_D.xlsx", 
                          sheet = "Sheet2", skip = 1)

DAUDA50_raw <- read_excel("C:/Users/ninni/Desktop/TSA Results/7BiochemFYP_060226_run1_D.xlsx", 
                          sheet = "Sheet2", skip = 1)

# --------------------------------------------------------------------
# create tables with my data from each of the 4 different TSA runs
# --------------------------------------------------------------------

EPA52 <- data.frame("temp" = EPA52_raw$Temp.,
                    "A" = EPA52_raw$A2,
                    "B" = EPA52_raw$B2,
                    "C" = EPA52_raw$C2,
                    "D" = EPA52_raw$D2,
                    "E" = EPA52_raw$E2,
                    "F" = EPA52_raw$F2,
                    "G" = EPA52_raw$G2,
                    "H" = EPA52_raw$H2)
EPA52 <- EPA52[EPA52$A != "UNK-5", ] # correct formatting (remove "UNK")

EPA72 <- data.frame("temp" = EPA72_raw$Temp.,
                    "A" = EPA72_raw$A10,
                    "B" = EPA72_raw$B10,
                    "C" = EPA72_raw$C10,
                    "D" = EPA72_raw$D10,
                    "E" = EPA72_raw$E10,
                    "F" = EPA72_raw$F10,
                    "G" = EPA72_raw$G10,
                    "H" = EPA72_raw$H10)
EPA72 <- EPA72[EPA72$A != "UNK-37", ]

DAUDA18 <- data.frame("temp" = DAUDA18_raw$Temp.,
                      "A" = DAUDA18_raw$A3,
                      "B" = DAUDA18_raw$B3,
                      "C" = DAUDA18_raw$C3,
                      "D" = DAUDA18_raw$D3,
                      "E" = DAUDA18_raw$E3,
                      "F" = DAUDA18_raw$F3,
                      "G" = DAUDA18_raw$G3,
                      "H" = DAUDA18_raw$H3)
DAUDA18 <- DAUDA18[DAUDA18$A != "UNK-9", ]

DAUDA50 <- data.frame("temp" = DAUDA50_raw$Temp.,
                      "A" = DAUDA50_raw$A1,
                      "B" = DAUDA50_raw$B1,
                      "C" = DAUDA50_raw$C1,
                      "D" = DAUDA50_raw$D1,
                      "E" = DAUDA50_raw$E1,
                      "F" = DAUDA50_raw$F1,
                      "G" = DAUDA50_raw$G1,
                      "H" = DAUDA50_raw$H1)
DAUDA50 <- DAUDA50[DAUDA50$A != "UNK-1", ]

# --------------------------------------------------------------------
# make all dataframe values numeric
# --------------------------------------------------------------------

EPA52[] <- lapply(EPA52, function(x) as.numeric(as.character(x)))

EPA72[] <- lapply(EPA72, function(x) as.numeric(as.character(x)))

DAUDA18[] <- lapply(DAUDA18, function(x) as.numeric(as.character(x)))

DAUDA50[] <- lapply(DAUDA50, function(x) as.numeric(as.character(x)))

# --------------------------------------------------------------------
# calculate Tms of each condition for each TSA run
# --------------------------------------------------------------------

get_Tm <- function(temp, signal) {
  dF <- diff(signal) / diff(temp)
  temp[which.max(dF)]
  }

EPA52_Tm <- c(get_Tm(EPA52$temp, EPA52$F),
              get_Tm(EPA52$temp, EPA52$G),
              get_Tm(EPA52$temp, EPA52$H))

EPA72_Tm <- c(get_Tm(EPA72$temp, EPA72$F),
              get_Tm(EPA72$temp, EPA72$G),
              get_Tm(EPA72$temp, EPA72$H))

DAUDA18_Tm <- c(get_Tm(DAUDA18$temp, DAUDA18$F),
                get_Tm(DAUDA18$temp, DAUDA18$G),
                get_Tm(DAUDA18$temp, DAUDA18$H))

DAUDA50_Tm <- c(get_Tm(DAUDA50$temp, DAUDA50$F),
                get_Tm(DAUDA50$temp, DAUDA50$G),
                get_Tm(DAUDA50$temp, DAUDA50$H))


EPA52_ctrl_Tm <- c(get_Tm(EPA52$temp, EPA52$A),
             get_Tm(EPA52$temp, EPA52$B))
             
EPA72_ctrl_Tm <- c(get_Tm(EPA72$temp, EPA72$A),
                   get_Tm(EPA72$temp, EPA72$B))
             
DAUDA18_ctrl_Tm <- c(get_Tm(DAUDA18$temp, DAUDA18$A),
                     get_Tm(DAUDA18$temp, DAUDA18$B))
             
DAUDA50_ctrl_Tm <- c(get_Tm(DAUDA50$temp, DAUDA50$A),
                     get_Tm(DAUDA50$temp, DAUDA50$B))


EPA52_etoh_Tm <- c(get_Tm(EPA52$temp, EPA52$C),
             get_Tm(EPA52$temp, EPA52$D),
             get_Tm(EPA52$temp, EPA52$E))
             
EPA72_etoh_Tm <- c(get_Tm(EPA72$temp, EPA72$C),
                   get_Tm(EPA72$temp, EPA72$D),
                   get_Tm(EPA72$temp, EPA72$E))
             
DAUDA18_etoh_Tm <- c(get_Tm(DAUDA18$temp, DAUDA18$C),
                     get_Tm(DAUDA18$temp, DAUDA18$D),
                     get_Tm(DAUDA18$temp, DAUDA18$E))
             
DAUDA50_etoh_Tm <- c(get_Tm(DAUDA50$temp, DAUDA50$C),
                     get_Tm(DAUDA50$temp, DAUDA50$D),
                     get_Tm(DAUDA50$temp, DAUDA50$E))

# --------------------------------------------------------------------
# perform t-tests for lipid concentrations
# --------------------------------------------------------------------

t1 <- t.test(EPA52_Tm, EPA52_etoh_Tm)

t2 <- t.test(EPA72_Tm, EPA72_etoh_Tm)

t3 <- t.test(DAUDA18_Tm, DAUDA18_etoh_Tm)

t4 <- t.test(DAUDA50_Tm, DAUDA50_etoh_Tm)

p_values <- c(t1$p.value, t2$p.value, t3$p.value, t4$p.value) # extract p-values
names(p_values) <- c("EPA52", "EPA72", "DAUDA18", "DAUDA50")
p_values

p_adjusted <- p.adjust(p_values, method = "holm") # Bonferroni correction

names(p_adjusted) <- c("EPA52", "EPA72", "DAUDA18", "DAUDA50")
p_adjusted

                 