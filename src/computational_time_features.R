## Computational time 

## ---- pkg
library(forecast)
library(seer)
library(tsfeatures)
library(microbenchmark)

## ---- randomly select features
data(M4)
## yearly
yearly_m4 <- subset(M4, "yearly")
yearly_sn <- sapply(yearly_m4, function(temp){temp$st})
set.seed("2592019")
index_yearly_sub_sn <- sample(yearly_sn, 100)
yearly_subset <- yearly_m4[names(yearly_m4) %in% index_yearly_sub_sn]
length(yearly_subset) # ans-100
save(yearly_subset, file="data/yearly_subset.rda")

## quarterly
quarterly_m4 <- subset(M4, "quarterly")
quarterly_sn <- sapply(quarterly_m4, function(temp){temp$st})
set.seed("2592019")
index_quarterly_sub_sn <- sample(quarterly_sn, 100)
quarterly_subset <- quarterly_m4[names(quarterly_m4) %in% index_quarterly_sub_sn]
length(quarterly_subset) # ans-100
save(quarterly_subset, file="data/quarterly_subset.rda")

## ---- individual feature computing time
load("data/quarterly_subset.rda")
qs_values <- lapply(quarterly_subset, function(temp){temp$x})

## running time of the feature length
length_time <- lapply(qs_values, function(temp){length(temp)})
length_runningTime <- microbenchmark(length_time, times=100)
save(length_runningTime, file="data/length_runningTime.txt")
# e_acf1 = lmres_acf1
tsfeatures_features <- c("acf_features", "arch_stat", "crossing_points", "entropy",
                         "flat_spots", "holt_parameters", "hw_parameters", "hurst", "lumpiness",
                         "nonlinearity", "pacf_features", "stability", "stl_features", "unitroot_kpss",
                         "unitroot_pp", "e_acf1")

ff <- function(temp){tsfeatures(qs_values, temp)}
feature_time <- list()
n <- length(tsfeatures_features)
for (i in 1:n)
{
  feature_time[[i]] <- microbenchmark(ff(tsfeatures_features[i]), times=100)
}
save(feature_time, file="data/feature_time.rda")


