# BSc (Hons) Biomedical Science Final Year Biochemistry Project - Thermal Shift Assay Analysis & Chromatographic Purification

## OVERVIEW
This repository contains R scripts and raw data used for the analysis of thermal shift assay results and chromatographic protein purification results for my BSc (Hons) Biomedical Science final year project report in biochemistry at the University of Bedfordshire.

## CONTENTS
### Data
`data.raw/` => Raw Excel files from thermal shift assays and raw CSV file from ÄKTA Start gel-filtration chromatography purification.

### R Scripts
`RScripts/` => Scripts used for plotting and data processing and analysis.

### Contents Overview
The following scripts and raw data files are corresponding to each other:
- Script_Chromatogram + 2026_2300211_ZAG PURIFICATION 001 (Figure 3 in report).
- ScriptTSA_Baseline + BiochemFYP_260126: TSA 1, Jan 26 => Baseline determination (Figure 5 in report).
- ScriptTSA_280126_NMB + 1BiochemFYP_280126_NMB => TSA 2, Jan 28: 100% EtOH, 727.32μM EPA (Figure A1 in report).
- ScriptTSA_300126_Run3 + 2BiochemFYP_300126_Run3 => TSA 3, Jan 30: 100% EtOH, 264.48μM EPA (Figure 6 in report).
- ScriptTSA_020226_run1 + 3BiochemFYP_020226_run1 => TSA 4, Feb 2: 10% EtOH, 26.45μM EPA (Figure A4 (A,B) in report).
- ScriptTSA_020226_run2_1 + 4BiochemFYP_020226_Run2 => TSA 5, Feb 2: 10% EtOH, 39.67μM EPA (Figure A2 in report).
- ScriptTSA_020226_run2_2 + 4BiochemFYP_020226_Run2 => TSA 6, Feb 2: 10% EtOH, 52.90μM EPA (Figure A3 (A,B) in report).
- ScriptTSA_040226_run1_1 + 5BiochemFYP_040226_run1 => TSA 7, Feb 4: 10% EtOH, 52.90μM EPA (Figure A3 (B,C) in report).
- ScriptTSA_040226_run1_2 + 5BiochemFYP_040226_run1 => TSA 5, Feb 4: 10% EtOH, 33.73μM EPA (Figure A5 in report).
- ScriptTSA_040226_run3 + 6BiochemFYP_040226_run3 => TSA 5, Feb 4: 10% EtOH, 72.73μM EPA (Figure 8 in report).
- ScriptTSA_060226_run1_D + 7BiochemFYP_060226_run1_D => TSA 5, Feb 6: 10% EtOH, 50.62μM DAUDA (Figure A6 in report).
- ScriptTSA_060226_run2_D + 8BiochemFYP_060226_run2_D => TSA 5, Feb 6: 10% EtOH, 18.41μM DAUDA (Figure 9 in report).
- ScriptTSA_060226_run4_1 + 9BiochemFYP_060226_run4 => TSA 5, Feb 6: 10% EtOH, 26.45μM EPA (Figure A4 (C,D) in report).
- ScriptTSA_060226_run4_2 + 9BiochemFYP_060226_run4 => TSA 5, Feb 6: 10% EtOH, 26.45μM EPA (Figure A4 (E,F) in report).
- Script_MeanEPA + 10BiochemFYP_meanEPA => mean EPA plot with XμM EPA (Figure 7 in report).
- Script_PoolingTm => Find mean Tm values, calculate SD, calculate differences in Tm (ΔTm).
- t.tests_script => perform t.tests (for summary results table (Table 1)).

## METHODS SUMMARY
ÄKTA Start gel-filtration chromatography was used to purify recombinant zinc-α2-glycoprotein (ZAG), and thermal shift assays were performed to assess ZAG binding to eicosapentaenoic acid (EPA).
Data was collected in Excel spreadsheets and analysed using R version 4.5.2.

## NOTES
- No raw data files have been modified, with the exception of 10BiochemFYP_meanEPA which was created using the raw data from 3BiochemFYP_020226_run1 + 9BiochemFYP_060226_run4.
- R scripts are intended for reproduction of the analysis in the project report.

## AUTHOR
Ninni Mangerøy Bugge
