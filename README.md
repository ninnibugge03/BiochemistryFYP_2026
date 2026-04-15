# BSc (Hons) Biomedical Science Final Year Biochemistry Project
## Thermal Shift Assay Analysis & Gel-filtration Chromatogram

## Overview
This repository contains R scripts and raw data used for the analysis of thermal shift assay results and chromatographic protein purification results for my BSc (Hons) Biomedical Science final year project report in biochemistry at the University of Bedfordshire.

## Contents
### Data
- `data.raw/` → Raw Excel files from thermal shift assays.
- Raw CSV file from ÄKTA Start gel-filtration chromatography purification.

### R Scripts
`RScripts/` → Scripts used for data processing, analysis, and plotting.

### Script-Data Relationships
The following scripts corrspond to specific datasets and figures in the report:
- `Script_Chromatogram` + `2026_2300211_ZAG PURIFICATION 001` (Figure 3).
- `ScriptTSA_Baseline` + `BiochemFYP_260126`: TSA 1, Jan 26 → Baseline determination (Figure 5).
- `ScriptTSA_280126_NMB` + `1BiochemFYP_280126_NMB` → TSA 2, Jan 28: 100% EtOH, 727.32μM EPA (Figure A1).
- `ScriptTSA_300126_Run3` + `2BiochemFYP_300126_Run3` → TSA 3, Jan 30: 100% EtOH, 264.48μM EPA (Figure 6).
- `ScriptTSA_020226_run1` + `3BiochemFYP_020226_run1` → TSA 4, Feb 2: 10% EtOH, 26.45μM EPA (Figure A4, A-B).
- `ScriptTSA_020226_run2_1` + `4BiochemFYP_020226_Run2` → TSA 5, Feb 2: 10% EtOH, 39.67μM EPA (Figure A2).
- `ScriptTSA_020226_run2_2` + `4BiochemFYP_020226_Run2` → TSA 5, Feb 2: 10% EtOH, 52.90μM EPA (Figure A3, A-B).
- `ScriptTSA_040226_run1_1` + `5BiochemFYP_040226_run1` → TSA 6, Feb 4: 10% EtOH, 52.90μM EPA (Figure A3, C-D).
- `ScriptTSA_040226_run1_2` + `5BiochemFYP_040226_run1` → TSA 6, Feb 4: 10% EtOH, 33.73μM EPA (Figure A5).
- `ScriptTSA_040226_run3` + `6BiochemFYP_040226_run3` → TSA 7, Feb 4: 10% EtOH, 72.73μM EPA (Figure 8).
- `ScriptTSA_060226_run1_D` + `7BiochemFYP_060226_run1_D` → TSA 8, Feb 6: 10% EtOH, 50.62μM DAUDA (Figure A6).
- `ScriptTSA_060226_run2_D` + `8BiochemFYP_060226_run2_D` → TSA 9, Feb 6: 10% EtOH, 18.41μM DAUDA (Figure 9).
- `ScriptTSA_060226_run4_1` + `9BiochemFYP_060226_run4` → TSA 10, Feb 6: 10% EtOH, 26.45μM EPA (Figure A4, C-D).
- `ScriptTSA_060226_run4_2` + `9BiochemFYP_060226_run4` → TSA 10, Feb 6: 10% EtOH, 26.45μM EPA (Figure A4, E-F).
- `Script_MeanEPA` + `10BiochemFYP_meanEPA` → mean EPA plot with XμM EPA (Figure 7).
- `Script_PoolingTm` → Calculation of mean TM, SD, and ΔTm (Table 1).
- `26uM_EPA_t.test_script` + `10BiochemFYP_meanEPA` → statistical analysis of 26.45μM EPA for summary results (Table 1).
- `other_t.tests.script` + `5BiochemFYP_040226_run1` + `6BiochemFYP_040226_run3` + `7BiochemFYP_060226_run1_D` + `8BiochemFYP_060226_run2_D` → statistical analyses of two EPA and DAUDA concentrations for summary results (Table 1).

## Methods Summary
ÄKTA Start gel-filtration chromatography was used to purify recombinant zinc-α2-glycoprotein (ZAG), and thermal shift assays were performed to assess ZAG binding to eicosapentaenoic acid (EPA) and DAUDA.
Data was collected in Excel spreadsheets and analysed using R (version 4.5.2).

## Running the Analyses
### Software Requirements
- R (v4.5.2) and RStudio (recommended)

### R Packages Requirements
- readxl → Read Excel (.xlsx) files.
- dplyr → Enable dataframe manipulation.

### Analysis Workflow
To reproduce results, open the relevant R scripts in the RScripts folder and run them in RStudio, ensuring that the working directory is set to where the raw data Excel files are downloaded, so that the file paths are correctly recognised.

## Notes
- No raw data files have been modified.
- `10BiochemFYP_meanEPA` consists of collated raw data from `3BiochemFYP_020226_run1` and `9BiochemFYP_060226_run4`. However, no raw data values have been modified.
- R scripts are intended for reproduction of the analysis in the project report.

## Awknowledgement
This project was conducted at the University of Bedfordshire for the academic year 2025-2026 final year project in biochemistry for my BSc (Hons) Biomedical Science degree. This project was supervised by Dr. Lindsay McDermott and Dr. Robin Maytum.

## Author
Ninni Mangerøy Bugge
