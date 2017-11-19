### Secret Squirrel
library(plyr)
library(dplyr)
library(tidyr)
library(readr)
library(ggplot2)
library(ggmap)
library(fields)

df0 <- read_csv("B:\\Misc Projects\\AZ_Misc_Files\\One-Offs\\Secret Squirrel Doc 11-6-17.csv")

can_abbs <- c("AB", "BC", "MB", "NB", "NL", "NT", "NS", "NU", "ON", "PE", "QC", "SK", "YT")
us_coords <- df0[!(df0$State %in% can_abbs), c("Longitude", "Latitude")]

### Let's make a function that takes a df of long-lat coords and makes a vector of zipcodes.

get_zips <- function(df){
  #' This function takes a df with long and lat coords
  #' in that order, and outputs their zip codes.
  zips <- c()
  for(i in 1:nrow(df)){
    loc_info <- revgeocode(as.numeric(df[i,]), output = "more")
    zips <- append(zips, as.numeric(as.character(loc_info$postal_code)))
  }
  return(zips)
}

zips <- get_zips(us_coords)
length(zips)
### Great, now let's put these in the same data table, so we can use the income by zip
### table in SQL Server. Then we'll have estimated income for each respondent.




