# MGIDI and PCA Analysis in Brassica

This repository contains an R script for multi-trait genotype evaluation using the MGIDI (Multi-trait Genotype-Ideotype Distance Index) and Principal Component Analysis (PCA).

## Overview
The script is designed to analyze phenotypic trait data for Brassica genotypes. It performs:
- MGIDI index calculation for genotype selection
- Principal Component Analysis (PCA) for visualization
- Export of results to an Excel file

## Requirements
- R
- Packages:
  - metan
  - factoextra
  - ggrepel
  - openxlsx

## Input Data
- CSV file (`MGIDI.csv`)
- Format:
  - First column: Genotypes
  - Remaining columns: Trait values

## Output
- PCA biplot image (`.png`)
- Excel file containing:
  - MGIDI index values
  - Factor contributions
  - Selected genotypes
  - Selection differentials
  - PCA results
  - Factor loadings
  - Communalities

## Usage
1. Place the input CSV file in the working directory
2. Run the script in R
3. Outputs will be generated automatically

## Author
Pooja Garg
