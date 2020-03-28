require(dplyr)
require(spdplyr)
require(sp)
# functions for helping manipulate spatial data frames of needle exchange data

filter_by_date <- function(dat, dateColumn, year, month=NA) {
  # return dat where the year of dateColumn is equal to year and month (if month is specified)
  # set date bounds
  if(is.na(month)) {
    lower_bnd_string <- paste0(c(year, "-01-01"), collapse="")
    upper_bnd_string <- paste0(c(year, "-12-31"), collapse="")
    lower_bnd <- as.Date(lower_bnd_string)
    upper_bnd <- as.Date(upper_bnd_string)
  } else {
    if(!any(month == c("01","02","03","04","05","06","07","08","09","10","11","12"))){
      stop("value specified for argument month must be two digit numeric month")
    }
    lower_bnd_string <- paste0(c(year, month, "01"), collapse="-")
    lower_bnd <- as.Date(lower_bnd_string)
    next_dates <- seq(lower_bnd, length=2, by="months") - 1
    upper_bnd <- next_dates[2]
  }
  
  ret <- dat %>%
    filter(between(dateColumn, lower_bnd, upper_bnd))
  return(ret)
}

create_overlay_dataFrame <- function(points, polygon, polygon_id) {
  # return a spatial polygon data frame overlaying points onto polygon
  # points is a SpatialPointsDataFrame object
  # polygon is a SpatialPolygon object
  # polygon_id is the column of polygon@data that serves as an identifier for each polygon
  # the object returned is grouped by polygon_id, but you need to summarise the data.frame returned
  
  over_list <- over(points, polygon, returnList=TRUE)
  points_list <- lapply(seq_along(over_list), function(ol, n, i){
    list(point=n[i], poly=as.character(ol[[i]][,polygon_id]))
  }, ol=over_list, n=names(over_list)
  )
  # iterate over list and get the points that should be retained
  point_names <- rownames(points@coords)
  new_coords <- points@coords[FALSE,]
  new_point_data <- points@data[FALSE,]
  new_poly <- character()
  for(pair in points_list) {
    which_point <- which(point_names == pair$point)
    new_point_data <- rbind(new_point_data, points@data[which_point,])
    new_poly <- c(new_poly, pair$poly)
  }
  ret_df <- new_point_data %>%
    mutate(!! polygon_id := new_poly) %>%
    group_by_at(c(polygon_id))
  
  return(ret_df)
}
