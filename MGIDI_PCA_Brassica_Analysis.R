# MGIDI and PCA Analysis in R
# Author: Pooja Garg
# Description: Performs MGIDI index analysis and PCA visualization for multi-trait genotype evaluation
# Requirements: metan, factoextra, ggrepel, openxlsx
# Input file: CSV with genotypes in the first column ("Genotypes") and trait values in remaining columns

# Load metan package
library(metan)

# Read the dataset
data <- read.csv("MGIDI.csv")

# Ensure Genotypes is treated as a factor
data$Genotypes <- as.factor(data$Genotypes)

# Set Genotypes as row names (older metan expects genotypes as row names)
rownames(data) <- data$Genotypes

# Drop the Genotypes column so only traits remain
trait_data <- data[, -which(names(data) == "Genotypes")]

# Define ideotype (make sure the length matches the number of traits)
ideotype <- c("h", "l", "l", "l", "h", "m", "m", "l", "h", "m", "h", "h", "h", "h")

# Run MGIDI analysis
mgidi_result <- mgidi(trait_data,
                      ideotype = ideotype,
                      SI = 15,
                      use_data = "pheno",
                      verbose = TRUE)

# View MGIDI index values
head(mgidi_result$MGIDI)

# Optional: View rankings
head(mgidi_result$MGIDI[order(mgidi_result$MGIDI$MGIDI), ])

###To check the components of mgidi_result####
str(mgidi_result, max.level = 2)

####### For PCA Plot with Genotype Labels ########

# PCA using the same trait data
pca_res <- prcomp(trait_data, scale. = TRUE)

# Load libraries (if not already loaded)
library(factoextra)
library(ggrepel)

# Extract genotype names and scores
pca_scores <- as.data.frame(pca_res$x)
pca_scores$Genotype <- rownames(pca_scores)  # These should match rownames from earlier

# Base biplot
pca_plot <- fviz_pca_biplot(pca_res,
                            geom = "point",
                            repel = FALSE,
                            col.var = "black",
                            col.ind = "indianred4",
                            ggtheme = theme_minimal()) +
  geom_text_repel(data = pca_scores,
                  aes(x = PC1, y = PC2, label = Genotype),
                  size = 2.5,
                  color = "indianred4",
                  max.overlaps = 100)

# Show plot
print(pca_plot)

# Save plot to file
ggsave("PCA_Biplot_MGIDI_With_Genotypes.png", plot = pca_plot, width = 9, height = 7, dpi = 300)


# Install if needed
if (!require(openxlsx)) install.packages("openxlsx")
library(openxlsx)

# Create workbook
wb <- createWorkbook()

# Add all relevant sheets
addWorksheet(wb, "MGIDI_Index")
writeData(wb, "MGIDI_Index", mgidi_result$MGIDI)

addWorksheet(wb, "Factor_Contribution")
writeData(wb, "Factor_Contribution", mgidi_result$contri_fac)

addWorksheet(wb, "Selected_Genotypes")
writeData(wb, "Selected_Genotypes", data.frame(Genotype = mgidi_result$sel_gen))

addWorksheet(wb, "Selection_Differential")
writeData(wb, "Selection_Differential", mgidi_result$sel_dif)

addWorksheet(wb, "PCA")
writeData(wb, "PCA", mgidi_result$PCA)

addWorksheet(wb, "Factor_Loadings")
writeData(wb, "Factor_Loadings", mgidi_result$FA)

addWorksheet(wb, "Communalities")
comm_df <- data.frame(Variable = names(mgidi_result$communalities),
                      Communality = mgidi_result$communalities)
writeData(wb, "Communalities", comm_df)

# Save Excel file
saveWorkbook(wb, "MGIDI_Complete_Results.xlsx", overwrite = TRUE)

