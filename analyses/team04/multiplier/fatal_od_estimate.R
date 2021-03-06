library(dplyr)
library(ggplot2)
# this file is meant to apply the multiplier method using overdose death counts
od_incidents <- read.csv("data/data/dph_od_incident_counts.csv")

od_incidents_18 <- od_incidents[,c("ZIPCODE","X2018Q1","X2018Q2","X2018Q3","X2018Q4") ]
# convert factors to low, medium, and high estimates for the <6 values; 1, 3, and 5 used as numeric representation
q1_levels <- levels(od_incidents_18$X2018Q1)
q2_levels <- levels(od_incidents_18$X2018Q2)
q3_levels <- levels(od_incidents_18$X2018Q3)
q4_levels <- levels(od_incidents_18$X2018Q4)
od_incidents_18_num <- od_incidents_18 %>%
  mutate(
    NUM2018Q1LOW = if_else(as.character(X2018Q1)=="<6", "1", q1_levels[as.numeric(X2018Q1)] ),
    NUM2018Q2LOW = if_else(as.character(X2018Q2)=="<6", "1", q2_levels[as.numeric(X2018Q2)] ),
    NUM2018Q3LOW = if_else(as.character(X2018Q3)=="<6", "1", q3_levels[as.numeric(X2018Q3)] ),
    NUM2018Q4LOW = if_else(as.character(X2018Q4)=="<6", "1", q4_levels[as.numeric(X2018Q4)] ),
    NUM2018Q1MID = if_else(as.character(X2018Q1)=="<6", "3", q1_levels[as.numeric(X2018Q1)] ),
    NUM2018Q2MID = if_else(as.character(X2018Q2)=="<6", "3", q2_levels[as.numeric(X2018Q2)] ),
    NUM2018Q3MID = if_else(as.character(X2018Q3)=="<6", "3", q3_levels[as.numeric(X2018Q3)] ),
    NUM2018Q4MID = if_else(as.character(X2018Q4)=="<6", "3", q4_levels[as.numeric(X2018Q4)] ),
    NUM2018Q1HIGH = if_else(as.character(X2018Q1)=="<6", "5", q1_levels[as.numeric(X2018Q1)] ),
    NUM2018Q2HIGH = if_else(as.character(X2018Q2)=="<6", "5", q2_levels[as.numeric(X2018Q2)] ),
    NUM2018Q3HIGH = if_else(as.character(X2018Q3)=="<6", "5", q3_levels[as.numeric(X2018Q3)] ),
    NUM2018Q4HIGH = if_else(as.character(X2018Q4)=="<6", "5", q4_levels[as.numeric(X2018Q4)] )
  ) %>%
  mutate(
    NUM2018Q1LOW = as.numeric(NUM2018Q1LOW),
    NUM2018Q2LOW = as.numeric(NUM2018Q2LOW),
    NUM2018Q3LOW = as.numeric(NUM2018Q3LOW),
    NUM2018Q4LOW = as.numeric(NUM2018Q4LOW),
    NUM2018Q1MID = as.numeric(NUM2018Q1MID),
    NUM2018Q2MID = as.numeric(NUM2018Q2MID),
    NUM2018Q3MID = as.numeric(NUM2018Q3MID),
    NUM2018Q4MID = as.numeric(NUM2018Q4MID),
    NUM2018Q1HIGH = as.numeric(NUM2018Q1HIGH),
    NUM2018Q2HIGH = as.numeric(NUM2018Q2HIGH),
    NUM2018Q3HIGH = as.numeric(NUM2018Q3HIGH),
    NUM2018Q4HIGH = as.numeric(NUM2018Q4HIGH)
  )

# get observed counts
observed_low <- sum(od_incidents_18_num$NUM2018Q1LOW) +
  sum(od_incidents_18_num$NUM2018Q2LOW) +
  sum(od_incidents_18_num$NUM2018Q3LOW) +
  sum(od_incidents_18_num$NUM2018Q4LOW)
observed_mid <- sum(od_incidents_18_num$NUM2018Q1MID) +
  sum(od_incidents_18_num$NUM2018Q2MID) +
  sum(od_incidents_18_num$NUM2018Q3MID) +
  sum(od_incidents_18_num$NUM2018Q4MID)
observed_high <- sum(od_incidents_18_num$NUM2018Q1HIGH) +
  sum(od_incidents_18_num$NUM2018Q2HIGH) +
  sum(od_incidents_18_num$NUM2018Q3HIGH) +
  sum(od_incidents_18_num$NUM2018Q4HIGH)

# use beta distribution to account for standard error of multiplier
estBetaParams <- function(mu, var) {
  alpha <- ((1 - mu) / var - 1 / mu) * mu ^ 2
  beta <- alpha * (1 / mu - 1)
  return(params = list(alpha = alpha, beta = beta))
}
# 7.182% of users 
fatal_mu <- .07182
# std error of 0.533%
fatal_se <- 0.00533
# get the distribution's parameters for simulations
fatal_parameters <- estBetaParams(fatal_mu, fatal_se^2)
fatal_sims <- rbeta(10000, fatal_parameters$alpha, fatal_parameters$beta)
# use simulated multipliers to get estiamted counts with the observed 996 fatal overdoses
fatal_estimates_low <- observed_low / fatal_sims
fatal_estimates_mid <- observed_mid / fatal_sims
fatal_estimates_high <- observed_high / fatal_sims

# set up some items for plotting
low_df <- data.frame(type=c("low"), estimate=fatal_estimates_low)
mid_df <- data.frame(type=c("mid"), estimate=fatal_estimates_mid)
high_df <- data.frame(type=c("high"), estimate=fatal_estimates_high)
estimates_df <- rbind(low_df, mid_df, high_df)
estimates_box <- ggplot(estimates_df, aes(x=type, y=estimate))
estimates_box <- estimates_box + geom_boxplot()
estimates_box
