## ---- packages6
library(tidyverse)
library(tsfeatures)
library(Mcomp)
library(seer)


## ---- example
source("src/pcaprojection.R")
data(M3)
yearly_m3 <- subset(M3, "yearly")
M3yearly_features <- seer::cal_features(yearly_m3, database="M3", h=6, highfreq = FALSE)
pca_ref_calc <- calculate_pca(M3yearly_features)
m3_pca <- pca_ref_calc$pca_components[1:2]
m3_pca$id <- rep("M3", 645)
targetX <- rep(-7:12, len=40)
targetY <- rep(-6.5:4.5, len=40)
targetData <- data.frame(PC1=rep(targetX, each=40), PC2=rep(targetY, times=40), id=rep("target", 1600))
ref_pca <- bind_rows(m3_pca, targetData, .id="id")
ref_pca <- ref_pca[-1]
ggplot(ref_pca, aes(x=PC1, y=PC2, color=id)) +
  geom_point()+ scale_color_brewer(palette="Dark2")+theme(legend.title = element_blank()) + theme(aspect.ratio=1)
