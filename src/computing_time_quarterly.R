# quarterly data time to compute forecasts

# pkges
library(forecast)
library(forecTheta)
library(seer)
library(microbenchmark)
library(randomForest)

# data
load("dataThesis/quarterly_subset.rda")


## rw
rw_ts_q <- function(){
  lapply(quarterly_subset, function(temp){
    rw_fit <- rwf(temp$x, drift=FALSE, h=8)
  })
  
}
microbenchmark(rw_ts_q(), times=100)

## rwd
rwd_ts_q <- function(){
  lapply(quarterly_subset, function(temp){
    rwd_fit <- rwf(temp$x, drift=TRUE, h=8)
  })
  
}
microbenchmark(rwd_ts_q(), times=100)

## wn
wn_ts_q <- function(){
  lapply(quarterly_subset, function(temp){
    wn_fit <- auto.arima(temp$x, d=0, D=0, max.p=0, max.q=0, max.Q=0, max.P=0)
    forecastWN <- forecast(wn_fit, 8)
  })
  
}
microbenchmark(wn_ts_q(), times=100)

## theta
theta_ts_q <- function(){
  lapply(quarterly_subset, function(temp){
    theta_fit <- forecTheta::stheta(temp$x, h=8, s='additive')
    forecastTHETA <- forecast(theta_fit, 8)
  })
  
}

microbenchmark(theta_ts_q(), times=100)

## nn
nn_ts_q <- function(){
  lapply(quarterly_subset, function(temp){
    nn_fit <- nnetar(temp$x)
    forecastETS <- forecast(nn_fit, 8)
  })
  
}

microbenchmark(nn_ts_q(), times=100)

##  ets

ets_ts_q <- function(){
  lapply(quarterly_subset, function(temp){
    ets_fit <- ets(temp$x)
    forecastETS <- forecast(ets_fit, 8)
  })
  
}

microbenchmark(ets_ts_q(), times=100)

## auto.arima
arima_ts_q <- function(){
  lapply(quarterly_subset, function(temp){
    arima_fit <- auto.arima(temp$x)
    forecastETS <- forecast(arima_fit, 8)
  })
  
}

microbenchmark(arima_ts_q(), times=100)

## stlar
stlar_ts_q <- function(){
  lapply(quarterly_subset, function(temp){
    forecastSTLAR <- stlar(temp$x, 8)
  })
  
}

microbenchmark(stlar_ts_q(), times=100)

## tbats
tbats_ts_q <- function(){
  lapply(quarterly_subset, function(temp){
    fit_tbats <- tbats(temp$x)
    forecast_tbats <- forecast(fit_tbats, h=8)
  })
  
}

microbenchmark(tbats_ts_q(), times=100)

## snaive
snaive_ts_q <- function(){
  lapply(quarterly_subset, function(temp){
    forecastSTLAR <- snaive(temp$x, 8)
  })
  
}

microbenchmark(snaive_ts_q(), times=100)

## fforms - without forecasts
load("phdproject2/rfu_m4quarterly.rda")
fforms_ts_noforecast_q <- function(){
  featureCal <- cal_features(quarterly_subset, database = "M4", h=8, highfreq = FALSE)
  predModels <- predict(rf, featureCal)
  
}

microbenchmark(fforms_ts_noforecast_q(), times=100)

## fforms - with forecasts
load("phdproject2/rfu_m4quarterly.rda")
fforms_ts_q <- function(){
  featureCal <- cal_features(quarterly_subset, database = "M4", h=8, highfreq = FALSE)
  predModels <- predict(rf, featureCal)
  forecastFFORMS <- rf_forecast(predictions = predModels, tslist = yearly_subset,
                                database = "M4",
                                function_name = "cal_MASE",
                                h=8,
                                accuracy = FALSE)

}

microbenchmark(fforms_ts_q(), times=100)


