source("helper_functions.R")
source("get_spatial_dat.R")

# use helper functions to create spatial polygon data frames
## zip codes
zips_overlay_df <- create_overlay_dataFrame(outrigger_points, zips_raw, c("OBJECTID"))
zips_overlay_df <- zips_overlay_df %>%
  summarise(
    label = paste0(site_id, "; ", site_name, "; ", visit_month, collapse = " | "),
    syringes_dispensed = sum(syringes_dispensed),
    syringes_returned = sum(syringes_returned),
    no_exchanging_for = sum(no_exchanging_for),
    count_distinct_participants = sum(count_distinct_participants)
  )
zips_df <- zips_raw %>%
  left_join(zips_overlay_df, by=c("OBJECTID" = "OBJECTID"))
zips_df <- as.data.frame(zips_df)
row.names(zips_df) <- row.names(zips_raw@data)
zips_sp <- SpatialPolygonsDataFrame(zips_raw, as.data.frame(zips_df))

## census tracts
census_overlay_df <- create_overlay_dataFrame(outrigger_points, census_raw, c("OBJECTID"))
census_overlay_df <- census_overlay_df %>%
  summarise(
    label = paste0(site_id, "; ", site_name, "; ", visit_month, collapse = " | "),
    syringes_dispensed = sum(syringes_dispensed),
    syringes_returned = sum(syringes_returned),
    no_exchanging_for = sum(no_exchanging_for),
    count_distinct_participants = sum(count_distinct_participants)
  )
census_df <- census_raw %>%
  left_join(census_overlay_df, by=c("OBJECTID" = "OBJECTID"))
census_df <- as.data.frame(census_df)
row.names(census_df) <- row.names(census_raw@data)
census_sp <- SpatialPolygonsDataFrame(census_raw, as.data.frame(census_df))