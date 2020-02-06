# install and load the needed libraries

install.packages("dplyr")
install.packages("tibble")
install.packages("RPostgres")

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

# extract table mtcars from the database

df <- tbl(con, 'mtcars')