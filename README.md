## Repository Structure

- `phenotypic_analysis/` – MGIDI and PCA-based multi-trait analysis
- `genomic_analysis/` – SNP filtering and VCF preprocessing# MGIDI and Genomic Data Analysis in Brassica

This repository contains R scripts for integrative analysis of phenotypic and genomic data in Brassica. The workflows focus on multi-trait genotype evaluation and SNP data preprocessing, supporting downstream breeding and genomics studies.

## Overview

The repository includes two main analytical workflows:

### 1. Multi-Trait Genotype Evaluation (MGIDI + PCA)
- Computes the Multi-trait Genotype-Ideotype Distance Index (MGIDI) for genotype selection
- Performs Principal Component Analysis (PCA) for visualization of trait variation
- Generates publication-quality plots
- Exports comprehensive results (MGIDI index, factor contributions, PCA outputs) to Excel

### 2. SNP Filtering and Quality Control (VCF Processing)
- Reads and processes Variant Call Format (VCF) files
- Ensures unique SNP identifiers
- Filters markers based on minor allele frequency (MAF)
- Removes SNPs and individuals with high missing data
- Exports filtered VCF files for downstream tools (e.g., PLINK)

## Requirements

- R
- Packages:
  - metan
  - factoextra
  - ggrepel
  - openxlsx
  - vcfR
  - adegenet

## Input Data

### Phenotypic Data
- CSV file (e.g., `MGIDI.csv`)
- Format:
  - First column: Genotypes
  - Remaining columns: Trait values

### Genomic Data
- VCF file containing SNP data

## Output

### From MGIDI Analysis
- PCA biplot image (`.png`)
- Excel file with:
  - MGIDI index values
  - Factor contributions
  - Selected genotypes
  - Selection differentials
  - PCA results
  - Factor loadings
  - Communalities

### From VCF Processing
- Filtered VCF file suitable for downstream analysis (e.g., PLINK)

## Reproducibility

All scripts are designed to be reproducible and modular. Users can adapt file paths and parameters (e.g., MAF thresholds, missingness filters) according to their dataset and research objectives.

## Applications

These workflows are applicable to:
- Plant breeding and genotype selection
- Population genomics and diversity analysis
- Multi-trait evaluation studies
- Preprocessing of genomic variation data

## Author

Pooja Garg
