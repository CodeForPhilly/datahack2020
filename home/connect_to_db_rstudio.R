# install and load the needed libraries

list.of.packages <- c("dplyr", "tibble", "RPostgres")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

library(dplyr)
library(tibble)
library(RPostgres)

# configure the DB connection

con <- DBI::dbConnect(
  RPostgres::Postgres(),
  user = Sys.getenv("DATAHACK_DB_USER"),
  password = Sys.getenv("DATAHACK_DB_PASS"),
  port = 30001,
  host = "45.79.16.246",
  dbname = "postgres"
)

# extract the full table PhysicianLocator_Test from the database

df <- as.data.frame(tbl(con, 'PhysicianLocator_Test'))
head(df)
# check out RPostgres documentation here: https://cran.r-project.org/web/packages/RPostgres/RPostgres.pdf

# do the same for the other tables, and proceed with analyses as usual
