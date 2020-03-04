# functions used for helping estimate
sep_events_truncPoisson <- function(dat, start = NA, end = NA) {
  # assumes that there is a column in dat that is a unique identifier for the person named id_encode
  # assumes that there is a column in dat that is a class of DATE; used if start and end are defined
  require(dplyr)
  # set up sample_dat based on args
  if( !is.na(start) && !is.na(end) ) {
    # filter dat based on start and end date
    if(class(start) != "Date") start <- as.Date(start)
    if(class(end) != "Date") end <- as.Date(end)
    sample_dat <- dat %>% filter(DATE >= start && DATE <= end)
  } else if(is.na(start) && !is.na(end)) {
    if(class(end) != "Date") end <- as.Date(end)
    sample_dat <- dat %>% filter(DATE <= end)
  } else if (!is.na(start) && is.na(end)) {
    if(class(start) != "Date") start <- as.Date(start)
    sample_dat <- dat %>% filter(DATE >= start)
  } else {
    sample_dat <- dat
  }
  if( !is.factor(sample_dat$id_encode) ) sample_dat$id_encode <- as.factor(sample_dat$id_encode)
  
  # get counts needed for zelterman estimate
  grouped_dat <- sample_dat %>%
    group_by(id_encode) %>%
    summarise(
      visits = n_distinct(DATE),
      no_exchange = max(no_exchanging_for)
    )
  f1 <- nrow(filter(grouped_dat, visits == 1))
  f2 <- nrow(filter(grouped_dat, visits == 2))
  total <- nrow(grouped_dat)
  
  # get estimate
  estimate <- zeltermanEstimate(f1, f2, total)
  
  # set up list to return
  ret <- list(pop_estimate = estimate,
              estimate_params = c(f1=f1, f2=f2, total=total),
              dateParams = c(start=start, end=end),
              grouped_data = grouped_dat
              )
  return(ret)
}

zeltermanEstimate <- function(f1, f2, total) {
  return(total / ( 1 - exp(-2 * f2 / f1) ) )
}