library(dplyr)
# set up
base_dir <- paste0(getwd(), "/analyses/team04/poisson", sep="")
source(paste0(base_dir, "/functions.R", sep=""))

# get data
sep_events <- read.csv(paste0(base_dir,"/data/pp_sep_site_event.csv", sep=""))
sep_events$DATE <- as.Date(sep_events$DATE, format="%m/%d/%y")
sep_events$no_exchanging_for <- as.numeric(sep_events$no_exchanging_for)

# run estimate for all events
all_est <- sep_events_truncPoisson(sep_events)

# to do: run estiamte for varying time frames to observe how the estimate fluctuates

# to do: consider creating a varied version of sep_events_truncPoisson that uses no_exchanging_for