library(dplyr)
library(lubridate)
# set up
base_dir <- paste0(getwd(), "/analyses/team04/poisson", sep="")
source(paste0(base_dir, "/functions.R", sep=""))

# get data
sep_events <- read.csv(paste0(base_dir,"/data/pp_sep_site_event.csv", sep=""))
sep_events$DATE <- as.Date(sep_events$DATE, format="%m/%d/%y")
sep_events$no_exchanging_for <- as.numeric(sep_events$no_exchanging_for)

# run estimate for all events
all_est <- sep_events_truncPoisson(sep_events)
# create plot to show relative distribution of those observed
all_count_freq <- all_est$grouped_data %>%
  group_by(visits) %>%
  summarise(relative_freq = n() / all_est$estimate_params["total"],
            num = n())
plot(all_count_freq$visits, all_count_freq$relative_freq, type="h", lwd=3, col="blue")
# adjust as if estimate were added in
est_df <- data.frame(visits=0, num=all_est$pop_estimate-all_est$estimate_params["total"])
est_df_rel_freq <- est_df$num / all_est$pop_estimate
est_df <- cbind(est_df, est_df_rel_freq)
all_count_freq_est <- all_est$grouped_data %>%
  group_by(visits) %>%
  summarise(num = n()) %>%
  union(est_df)
relative_freq <- all_count_freq_est$num / all_est$pop_estimate
all_count_freq_est <- cbind(all_count_freq_est, relative_freq)
plot(all_count_freq_est$visits, all_count_freq_est$relative_freq, type="h", lwd=3, col="blue")
frequency_plot <- ggplot(all_count_freq_est, aes(x=visits, y=0))
frequency_plot <- frequency_plot + geom_segment(aes(xend=visits, yend=relative_freq), color="#0A68FF", size=1.1)
frequency_plot <- frequency_plot +
  geom_segment(aes(x=visits, y=0, xend=visits, yend=est_df_rel_freq), data=est_df, color="#FF5C5C", size=1.1)

# to do: run estimate for varying time frames to observe how the estimate fluctuates
q1_est <- sep_events_truncPoisson(sep_events, start="2019-01-01", end="2019-03-31")
q2_est <- sep_events_truncPoisson(sep_events, start="2019-04-01", end="2019-06-30")
q3_est <- sep_events_truncPoisson(sep_events, start="2019-07-01", end="2019-09-30")
q4_est <- sep_events_truncPoisson(sep_events, start="2019-10-01", end="2019-12-31")
jan_est <- sep_events_truncPoisson(sep_events, start="2019-01-01", end="2019-01-31")
feb_est <- sep_events_truncPoisson(sep_events, start="2019-02-01", end="2019-02-28")
mar_est <- sep_events_truncPoisson(sep_events, start="2019-03-01", end="2019-03-31")
apr_est <- sep_events_truncPoisson(sep_events, start="2019-04-01", end="2019-04-30")
may_est <- sep_events_truncPoisson(sep_events, start="2019-05-01", end="2019-05-31")
jun_est <- sep_events_truncPoisson(sep_events, start="2019-06-01", end="2019-06-30")
jul_est <- sep_events_truncPoisson(sep_events, start="2019-07-01", end="2019-07-31")
aug_est <- sep_events_truncPoisson(sep_events, start="2019-08-01", end="2019-08-31")
sep_est <- sep_events_truncPoisson(sep_events, start="2019-09-01", end="2019-09-30")
oct_est <- sep_events_truncPoisson(sep_events, start="2019-10-01", end="2019-10-31")
nov_est <- sep_events_truncPoisson(sep_events, start="2019-11-01", end="2019-11-30")
dec_est <- sep_events_truncPoisson(sep_events, start="2019-12-01", end="2019-12-31")
results_to_print <- list(
  all_est,
  q1_est,
  q2_est,
  q3_est,
  q4_est,
  jan_est,
  feb_est,
  mar_est,
  apr_est,
  may_est,
  jun_est,
  jul_est,
  aug_est,
  sep_est,
  oct_est,
  nov_est,
  dec_est
)
month_est_list <- list(
  jan_est,
  feb_est,
  mar_est,
  apr_est,
  may_est,
  jun_est,
  jul_est,
  aug_est,
  sep_est,
  oct_est,
  nov_est,
  dec_est
)
month_est_vec <- sapply(month_est_list, function(i){i[["pop_estimate"]]})
month_low_vec <- sapply(month_est_list, function(i){i[["confidence_intervals"]][1]})
month_high_vec <- sapply(month_est_list, function(i){i[["confidence_intervals"]][2]})
month_names <- c("January", "February", "March", "April", "May","June","July","August","September","October","November","December")
month_names <- factor(month_names, levels=month_names)
month_ests <- data.frame(
  month_names = month_names,
  estimates = month_est_vec,
  low_ci = month_low_vec,
  high_ci = month_high_vec
)
# plot months showing confidence intervals
monthly_plot <- ggplot(month_ests, aes(month_names,
                                       estimates, ymin=low_ci, ymax=high_ci))
monthly_plot <- monthly_plot + geom_pointrange(size=0.75, color="#0A68FF")
monthly_plot <- monthly_plot + labs( x="Month of Visits Used in Estimate",
                                     y="Estimated Number of Intravenous Drug Users",
                                     title="Estimate of Intravenous Drug Users Based on Monthly Visists")
monthly_plot

# to do: run estimate for a random set of 5 days
# generate vector of possible dates
possible_dates <- c()
current_date <- ymd("20190101")
while (year(current_date) == 2019) {
  week_day <- wday(current_date)
  # only operate on week days
  if(week_day != 1 && week_day != 7) {
    possible_dates <- append(possible_dates, current_date)
  }
  current_date <- current_date + days(1)
}
# exclude days during which it appears the needle exchanage was not operating
zero_visits <- c()
zero_indexes <- c()
for(d in possible_dates) {
  d_index <- which(possible_dates == d)
  d <- as.Date(d, origin='1970-01-01')
  num_visits <- nrow(filter(sep_events, DATE == d))
  if(num_visits == 0) {
    zero_visits <- append(zero_visits, d)
    zero_indexes <- append(zero_indexes, d_index)
  }
}
possible_dates <- possible_dates[-zero_indexes]
# pick all 5 date intervals to test
possible_starts <- length(possible_dates) - 4
trials <- numeric(possible_starts)
for(trial in seq(1, possible_starts)) {
  est <- sep_events_truncPoisson(sep_events, start = possible_dates[trial], end = possible_dates[trial + 4], justEstimate = TRUE)
  trials[trial] = est
}
trials <- trials[ which(!is.infinite(trials) & !is.na(trials)) ]

# to do: bootstrap for any random 5 days of operation
sample_trials_num <- 10000
sample_trials <- numeric(sample_trials_num)
for(i in seq(1, sample_trials_num)) {
  sample_dates <- sample(possible_dates, 5)
  est <- sep_events_truncPoisson(sep_events, dates = sample_dates, justEstimate = TRUE)
  sample_trials[i] = est
}
sample_trials <- as.data.frame(sample_trials)
save(sample_trials, file=paste0(base_dir,"/simulated_5day_results.RData",sep=""))

# to do: consider creating a varied version of sep_events_truncPoisson that uses no_exchanging_for
# try with median, mean, and min

# to do: look at results for a single site

