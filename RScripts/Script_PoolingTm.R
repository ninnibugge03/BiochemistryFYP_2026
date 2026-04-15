# R version 4.5.2
# Pooling Tms for all TSA runs

# --------------------------------------------------------------------
# Collecting means from all TSA runs
# --------------------------------------------------------------------

Tms_ctrl <- c(61.49,62.99,62.49,84.49,60.99,61.49,59.99,61.99,61.99,
              62.49,61.49,61.99,61.99,62.49,62.49,62.99,61.99,61.49,
              62.49,61.49,62.49,62.49) # baseline control

Tms_etoh <- c(62.99,62.49,57.99,63.49,62.49,61.49,25.00,60.99,61.99,
              64.49,62.99,61.99,62.99,60.99,60.49,60.49,60.99,60.49,
              61.99,60.49,62.99,61.99,62.49,62.99) # 10% EtOH

Tms_epa1 <- c(55.49,61.49,61.99,63.99,62.49,61.99,63.49,61.99,61.49) # 26.45 uM EPA
Tms_epa2 <- c(61.49,59.99,63.49) # 39.67uM EPA
Tms_epa3 <- c(61.49,61.49,61.99) # 52.9 uM EPA
Tms_epa4 <- c(61.99,61.49,60.49) # 72.73 uM EPA

Tms_DAUDA1 <- c(64.99,63.49,62.99) # 50.62 uM DAUDA
TMs_DAUDA2 <- c(63.99,63.49,63.99) # 18.41 uM DAUDA

# -----------------------------------------------------------------------
# Find the mean Tm for each condition
# -----------------------------------------------------------------------

CTRL_Tm <- mean(Tms_ctrl)
EtOH_Tm <- mean(Tms_etoh)

EPA1_Tm <- mean(Tms_epa1)
EPA2_Tm <- mean(Tms_epa2)
EPA3_Tm <- mean(Tms_epa3)
EPA4_Tm <- mean(Tms_epa4)

DAUDA1_Tm <- mean(Tms_DAUDA1)
DAUDA2_Tm <- mean(TMs_DAUDA2)

# -----------------------------------------------------------------------
# State the mean and SD
# -----------------------------------------------------------------------

CTRL_Tm; sd(Tms_ctrl)
EtOH_Tm; sd(Tms_etoh)

EPA1_Tm; sd(Tms_epa1)
EPA2_Tm; sd(Tms_epa2)
EPA3_Tm; sd(Tms_epa3)
EPA4_Tm; sd(Tms_epa4)

DAUDA1_Tm; sd(Tms_DAUDA1)
DAUDA2_Tm; sd(TMs_DAUDA2)

# -----------------------------------------------------------------------
# Calculate the change in Tm
# -----------------------------------------------------------------------

(-CTRL_Tm) + EtOH_Tm

(-EtOH_Tm) + EPA1_Tm # 22.45
(-EtOH_Tm) + EPA2_Tm
(-EtOH_Tm) + EPA3_Tm # 52.9
(-EtOH_Tm) + EPA4_Tm # 72.73

(-EtOH_Tm) + DAUDA1_Tm
(-EtOH_Tm) + DAUDA2_Tm

# -----------------------------------------------------------------------
# Perform a t-test to compare baseline control VS. ethanol control
# -----------------------------------------------------------------------

t.test(Tms_ctrl, Tms_etoh)
