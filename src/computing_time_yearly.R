# yearly data time to compute forecasts

# pkges
library(forecast)
library(forecTheta)
library(seer)
library(microbenchmark)
library(randomForest)

# data
load("dataThesis/yearly_subset.rda")


## rw
## using for loop
forrw_ts <- function(){
 for (i in 1:100){
    rw_fit <- rwf(yearly_subset[[i]]$x, drift=FALSE, h=6)
  }
}
microbenchmark(forrw_ts(), times=100)

## rwd
rwd_ts <- function(){
  for (i in 1:100){
    rwd_fit <- rwf(yearly_subset[[i]]$x, drift=TRUE, h=6)
  }
  
}
microbenchmark(rwd_ts(), times=100)

## wn
wn_ts <- function(){
  for (i in 1:100){
    wn_fit <- auto.arima(yearly_subset[[i]]$x, d=0, D=0, max.p=0, max.q=0, max.Q=0, max.P=0)
  }
  
}
microbenchmark(wn_ts(), times=100)

## theta
theta_ts <- function(){
  for (i in 1:100){
    theta_fit <- thetaf(yearly_subset[[i]]$x)
    forecastTHETA <- forecast(theta_fit, 6)
  }
  
}

microbenchmark(theta_ts(), times=100)

## nn
nn_ts <- function(){
  for (i in 1:100){
    nn_fit <- nnetar(yearly_subset[[i]]$x)
    forecastETS <- forecast(nn_fit, 6)
  }
  
}

microbenchmark(nn_ts(), times=100)

##  ets

ets_ts <- function(){
  for (i in 1:100){
    ets_fit <- ets(yearly_subset[[i]]$x)
    forecastETS <- forecast(ets_fit, 6)
  }
  
}

microbenchmark(ets_ts(), times=100)

## auto.arima
arima_ts <- function(){
  for (i in 1:100){
    arima_fit <- auto.arima(yearly_subset[[i]]$x)
    forecastETS <- forecast(arima_fit, 6)
  }
  
}

microbenchmark(arima_ts(), times=100)

## fforms - without forecasts
#load("phdproject2/rfu_m4yearly.rda")

#fforms_ts_noforecast <- function(){
#  featureCal <- cal_features(yearly_subset, database = "M4", h=6, highfreq = FALSE)
#  predModels <- predict(rf, featureCal)
  
#}

#microbenchmark(fforms_ts_noforecast(), times=100)

## fforms - with forecasts
#load("phdproject2/rfu_m4yearly.rda")

#fforms_ts <- function(){
#  featureCal <- cal_features(yearly_subset[1], database = "M4", h=6, highfreq = FALSE)
#  predModels <- predict(rf, featureCal)
#  forecastFFORMS <- rf_forecast(predictions = predModels, tslist = yearly_subset,
#                                database = "M4",
#                                function_name = "cal_MASE",
#                                h=6,
#                                accuracy = FALSE)
#
#}

#microbenchmark(fforms_ts(), times=100)
