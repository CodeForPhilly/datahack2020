# functions used for helping estimate
sep_events_truncPoisson <- function(dat, start = NA, end = NA, dates = NA, justEstimate = FALSE) {
  # returns the estimate of the total population size using a truncated poisson estimator
  # assumes that there is a column in dat that is a unique identifier for the person named id_encode
  # assumes that there is a column in dat that is a class of DATE; used if start and end are defined
  require(dplyr)
  # set up sample_dat based on args
  if( !is.na(start) & !is.na(end) ) {
    # filter dat based on start and end date
    if(class(start) != "Date") start <- as.Date(start)
    if(class(end) != "Date") end <- as.Date(end)
    sample_dat <- dat %>% filter(DATE >= start & DATE <= end)
  } else if(is.na(start) & !is.na(end)) {
    if(class(end) != "Date") end <- as.Date(end)
    sample_dat <- dat %>% filter(DATE <= end)
  } else if(!is.na(start) & is.na(end)) {
    if(class(start) != "Date") start <- as.Date(start)
    sample_dat <- dat %>% filter(DATE >= start)
  } else if(length(dates) >= 1 && !is.na(dates)) {
    sample_dat <- dat[FALSE,]
    for(d in dates) {
      if(class(d) != "Date") {
        if(class(d) == "numeric") {
          d <- as.Date(d, origin="1970-01-01")}
        else {
          d <- as.Date(d)
        }
      }
      temp_dat <- filter(dat, DATE == d)
      sample_dat <- rbind(sample_dat, temp_dat)
    }
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
  if(justEstimate) {
    ret <- estimate
  } else {
    conf_ints <- zeltermanConfInt(f1, f2, total, as.numeric(grouped_dat$visits))
    ret <- list(pop_estimate = estimate,
                estimate_params = c(f1=f1, f2=f2, total=total),
                dateParams = c(start=start, end=end),
                confidence_intervals = conf_ints,
                grouped_data = grouped_dat
                )
  }
  return(ret)
}

zeltermanEstimate <- function(f1, f2, total) {
  return(floor (total / ( 1 - exp(-2 * f2 / f1) ) ) )
}

zeltermanStandardDev <- function(f1, f2, total, occurrences) {
  poisson_fit <- fitdistr(occurrences, "poisson")
  theta_hat <- poisson_fit$estimate["lambda"]
  var_relative_freq <- (exp(-theta_hat)*(1-exp(-theta_hat))*(theta_hat + 2)) / total
  return( sqrt(var_relative_freq) )
}

zeltermanConfInt <- function(f1, f2, total, occurrences) {
  std_dev <- zeltermanStandardDev(f1, f2, total, occurrences)
  q1_est <- exp(-2 * (f2 / f1))
  ret <- total / (1 - (q1_est + (c(-1,1) * 1.96 * std_dev)) )
  return(ret)
}

sep_getByID <- function(id, dat=sep_events) {
  # just for investigative purposes
  return(filter(dat, id_encode == id))
}
