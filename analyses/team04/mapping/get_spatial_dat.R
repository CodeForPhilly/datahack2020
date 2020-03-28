# used to load spatial data frames for further analysis
require(rgdal)
require(sp)
require(spdplyr)
# do what you need to in order to set the working directory to mapping
# setwd(".\\analyses\\team04\\mapping")
source("helper_functions.R")

# read spatial polygon data
zips_raw <- readOGR("data/philly_zip_shape/Zipcodes_Poly.shp")
census_raw <- readOGR("data/philly_census_shape/Census_Tracts_2010.shp")

# the following block is used to create a spatial points df with the needle exchange and site data
# read geolocated needle exchange sites
outrigger_raw <- read.csv("data/sep_site_outrigger_geo.csv")
outrigger_raw$site_location <- as.character(outrigger_raw$site_location)
outrigger_raw$site_name <- as.character(outrigger_raw$site_name)
outrigger_raw$site_description <- as.character(outrigger_raw$description)
outrigger_raw$address <- as.character(outrigger_raw$address)
# link outrigger_raw with site-related data
pp_sep_site_exchanges = read.csv("../../../data/data/pp_sep_site_exchanges.csv")
pp_sep_site_exchanges$visit_month = as.Date(pp_sep_site_exchanges$visit_month)
pp_sep_site_participants = read.csv("../../../data/data/pp_sep_site_participants.csv")
pp_sep_site_participants$visit_month = as.Date(pp_sep_site_participants$visit_month)
outrigger_final <- outrigger_raw %>%
  inner_join(pp_sep_site_exchanges, by="site_id") %>%
  inner_join(pp_sep_site_participants, by=c("site_id" = "site_id", "visit_month" = "visit_month"))
# create a spatial points data frame
# filter to only include site locations with geocoded points
# use the same projection as the polygons object that it will be plotted and joined with
# note that the final SpatialPointsDataFrame contains 
column_names_included <- c(
  "site_id",
  "site_name",
  "visit_month",
  "syringes_dispensed",
  "syringes_returned",
  "no_exchanging_for",
  "count_distinct_participants"
)
outrigger_points <- SpatialPointsDataFrame(outrigger_final[!is.na(outrigger_final[,"lng"]),c("lng", "lat")],
                                           data=outrigger_final[!is.na(outrigger_final[,"lng"]),column_names_included],
                                           proj4string=CRS(proj4string(zips_raw)))
