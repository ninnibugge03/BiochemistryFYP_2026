# R version: 4.5.2
# Statistical analysis of 26.45 uM EPA Tm for summary table

# --------------------------------------------------------------------
# Import Excel file with raw TSA data
# --------------------------------------------------------------------

library(readxl)
EPA_raw <- read_excel("C:/Users/ninni/Desktop/TSA Results/10BiochemFYP_meanEPA.xlsx", 
                      sheet = "Sheet1")

# --------------------------------------------------------------------
# create tables with my data from each of the 4 different TSA runs
# --------------------------------------------------------------------

EPA1 <- data.frame(temp = EPA_raw$Temp.,
                   "A" = EPA_raw$A1,
                   "B" = EPA_raw$B1,
                   "C" = EPA_raw$C1,
                   "D" = EPA_raw$D1,
                   "E" = EPA_raw$E1,
                   "F" = EPA_raw$F1,
                   "G" = EPA_raw$G1,
                   "H" = EPA_raw$H1)

EPA2 <- data.frame(temp = EPA_raw$Temp.,
                   "A" = EPA_raw$A2,
                   "B" = EPA_raw$B2,
                   "C" = EPA_raw$C2,
                   "D" = EPA_raw$D2,
                   "E" = EPA_raw$E2,
                   "F" = EPA_raw$F2,
                   "G" = EPA_raw$G2,
                   "H" = EPA_raw$H2)

EPA3 <- data.frame(temp = EPA_raw$Temp.,
                   "A" = EPA_raw$A3,
                   "B" = EPA_raw$B3,
                   "C" = EPA_raw$C3,
                   "D" = EPA_raw$D3,
                   "E" = EPA_raw$E3,
                   "F" = EPA_raw$F3,
                   "G" = EPA_raw$G3,
                   "H" = EPA_raw$H3)

# --------------------------------------------------------------------
# make all dataframe values numeric
# --------------------------------------------------------------------

EPA1[] <- lapply(EPA1, function(x) as.numeric(as.character(x)))

EPA2[] <- lapply(EPA2, function(x) as.numeric(as.character(x)))

EPA3[] <- lapply(EPA3, function(x) as.numeric(as.character(x)))

# --------------------------------------------------------------------
# calculate Tms
# --------------------------------------------------------------------

get_Tm <- function(temp, signal) {
  dF <- diff(signal) / diff(temp)
  temp[which.max(dF)]
}

EPA1_Tm <- c(get_Tm(EPA1$temp, EPA1$F),
             get_Tm(EPA1$temp, EPA1$G),
             get_Tm(EPA1$temp, EPA1$H))

EPA2_Tm <- c(get_Tm(EPA2$temp, EPA2$F),
             get_Tm(EPA2$temp, EPA2$G),
             get_Tm(EPA2$temp, EPA2$H))

EPA3_Tm <- c(get_Tm(EPA3$temp, EPA3$F),
             get_Tm(EPA3$temp, EPA3$G),
             get_Tm(EPA3$temp, EPA3$H))


EPA1_ctrl_Tm <- c(get_Tm(EPA1$temp, EPA1$A),
                  get_Tm(EPA1$temp, EPA1$B))

EPA2_ctrl_Tm <- c(get_Tm(EPA2$temp, EPA2$A),
                  get_Tm(EPA2$temp, EPA2$B))

EPA3_ctrl_Tm <- c(get_Tm(EPA3$temp, EPA3$A),
                  get_Tm(EPA3$temp, EPA3$B))


EPA1_etoh_Tm <- c(get_Tm(EPA1$temp, EPA1$C),
                  get_Tm(EPA1$temp, EPA1$D),
                  get_Tm(EPA1$temp, EPA1$E))

EPA2_etoh_Tm <- c(get_Tm(EPA2$temp, EPA2$C),
                  get_Tm(EPA2$temp, EPA2$D),
                  get_Tm(EPA2$temp, EPA2$E))

EPA3_etoh_Tm <- c(get_Tm(EPA3$temp, EPA3$C),
                  get_Tm(EPA3$temp, EPA3$D),
                  get_Tm(EPA3$temp, EPA3$E))

# --------------------------------------------------------------------
# perform t-tests for EPA VS. control for individual TSA runs
# --------------------------------------------------------------------

t1 <- t.test(EPA1_Tm, EPA1_etoh_Tm)

t2 <- t.test(EPA2_Tm, EPA2_etoh_Tm)

t3 <- t.test(EPA3_Tm, EPA3_etoh_Tm)

p_values <- c(t1$p.value, t2$p.value, t3$p.value) # extract p-values
names(p_values) <- c("EPA1", "EPA2", "EPA3")
p_values

p_adjusted <- p.adjust(p_values, method = "holm") # Holm correction

names(p_adjusted) <- c("EPA1", "EPA2", "EPA3")
p_adjusted


# --------------------------------------------------------------------
# perform one-way ANOVA for EPA VS. ethanol control
# --------------------------------------------------------------------

EtOH_Tm <- c(EPA1_etoh_Tm,EPA2_etoh_Tm,EPA3_etoh_Tm)

EPA_Tm <- c(EPA1_Tm,EPA2_Tm,EPA3_Tm)

Control_df <- data.frame(Tm = c(EPA_Tm, EtOH_Tm),
                         condition = c(rep("EPA", length(EPA_Tm)),
                                        rep("ethanol", length(EtOH_Tm))),
                         run = c(rep("run1", length(EPA1_Tm) + length(EPA1_etoh_Tm)),
                                 rep("run2", length(EPA2_Tm) + length(EPA2_etoh_Tm)),
                                 rep("run3", length(EPA3_Tm) + length(EPA3_etoh_Tm)))
                         )

model <- lm(Tm ~ condition + run, data = Control_df)
anova(model)

