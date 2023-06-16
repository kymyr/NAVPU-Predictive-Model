#install.packages("prophet")
#install.packages("tidyverse")
library(prophet)
library(tidyverse)

# Load uitf dataset from csv
# Source: https://www.uitf.com.ph/daily_navpu_details.php?fund_id=271&bank_id=31
# Date range: September 1, 2021 - April 30, 2022
# y = NAVPU  in PHP, ds = Date
uitf <- read.csv(file.choose())
head(uitf)

# using prophet function to fit uitf model
model <- prophet(uitf)
# model used to fit navpu forecast for the rest of 2022 
# May 1, 2022 - December 31, 2022 = 245 days
navpu <- make_future_dataframe(model, periods = 245)
# show latest data 
tail(navpu)

# predict function
navpu_forecast <- predict(model, navpu)
# show latest data
tail(navpu_forecast[c('ds', 'yhat', 'yhat_lower', 'yhat_upper')])

# plotting forecast model
dyplot.prophet(model, navpu_forecast)
# trend graphs
prophet_plot_components(model, navpu_forecast, uncertainty=TRUE, plot_cap = TRUE, render_plot = TRUE)
     
# Additional infos:
# ATRAM Philippine Equity Smart Index Fund
# https://www.atram.com.ph/funds/uitf/ATRPHSE
# measured quantity - NAVPU or Net Asset Value Per Unit
# prophet library documentation - https://facebook.github.io/prophet/docs/quick_start.html

