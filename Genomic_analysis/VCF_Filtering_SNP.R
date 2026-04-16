# VCF Filtering and SNP Quality Control in R
# Author: Pooja Garg
# Description: Script for filtering SNP data from VCF files based on MAF and missingness, and preparing filtered data for downstream analysis (e.g., PLINK).
# Requirements: vcfR, adegenet
# Input file: VCF file containing SNP data

install.packages("vcfR")
install.packages("adegenet")

###########Load and parse the VCF########
library(vcfR)
vcf <- read.vcfR("snp_conv_fixed2.vcf")

##############Filter by MAF and missingness###########

# Force unique SNP IDs: CHROM_POS
vcf@fix[, "ID"] <- paste(vcf@fix[, "CHROM"], vcf@fix[, "POS"], sep = "_")

any(duplicated(vcf@fix[, "ID"]))  # Should return FALSE

# Use make.unique to force uniqueness
vcf@fix[, "ID"] <- make.unique(paste(vcf@fix[, "CHROM"], vcf@fix[, "POS"], sep = "_"))

# Recheck
any(duplicated(vcf@fix[, "ID"]))  # Should now return FALSE

gl <- vcfR2genlight(vcf)
head(vcf@fix[, "ID"])  # Make sure they look like "A01_3534", "A01_30346", etc.

# Calculate MAF
maf_vals <- glMean(gl)
gl <- gl[, maf_vals >= 0.05 & maf_vals <= 0.95]

# Filter SNPs with missing >20%
missing_per_snp <- apply(is.na(as.matrix(gl)), 2, mean)
gl <- gl[, missing_per_snp < 0.2]

# Filter individuals with missing >20%
missing_per_ind <- apply(is.na(as.matrix(gl)), 1, mean)
gl <- gl[missing_per_ind < 0.2, ]


# Let's match SNPs in gl to the original VCF
vcf_filtered <- vcf[vcf@fix[, "ID"] %in% locNames(gl), ]

# Save filtered VCF to disk for plink
write.vcf(vcf_filtered, file = "filtered_for_plink.vcf")

