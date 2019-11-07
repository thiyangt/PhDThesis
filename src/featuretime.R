## Feature calculation run on cluster
library(tsfeatures)
library(microbenchmark)

## ---- individual feature computing time
load("dataThesis/quarterly_subset.rda")
qs_values <- lapply(quarterly_subset, function(temp){temp$x})

## running time of the feature length
length_time <- lapply(qs_values, function(temp){length(temp)})
length_runningTime <- microbenchmark(length_time, times=100)
length_runningTime
# e_acf1 = lmres_acf1
tsfeatures_features <- c("acf_features", "arch_stat", "crossing_points", "entropy",
                         "flat_spots", "holt_parameters", "hw_parameters", "hurst", "lumpiness",
                         "nonlinearity", "pacf_features", "stability", "stl_features", "unitroot_kpss",
                         "unitroot_pp", "heterogeneity")

ff <- function(temp){tsfeatures(qs_values, temp)}
feature_time <- list()
n <- length(tsfeatures_features)
for (i in 1:n)
{
  feature_time[[i]] <- microbenchmark(ff(tsfeatures_features[i]), times=100)
}
feature_time
