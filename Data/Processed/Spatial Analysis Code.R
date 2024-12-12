#installing packages 
library(here)
library(mapview)
library(sf)
library(tidyverse)
library(lubridate)


PolarBearHair <- read.csv(
  file=here(
    "Data/Raw/polarBear_CNisotopesHair_beaufortChukchi_rode_1983_2017.csv"), stringsAsFactors = TRUE)

#cleaning data, taking out unnecessary columns and NAs, reformatting date
PolarBearHairCleaned <- PolarBearHair %>%
  select(-"SummerHabitatDuringHairGrowth", -"TypicalSummerHabitat") %>%
  mutate(Capture.Date=as.Date(Capture.Date, format = '%m/%d/%Y')) %>%
  na.omit()


#making spatial dataset, assigning values to Lat/Long and applying CRS
PolarBearSpatial <- st_as_sf(PolarBearHairCleaned, 
                             coords = c('Long', 'Lat'), crs=4269)
PolarBearSpatial$Year <- as.factor(PolarBearSpatial$Year)

#creating map of polar bears categorized by Year
mapView(PolarBearSpatial, zcol = "Year")

#creating map of polar bears categorized by sex 
mapView(PolarBearSpatial, zcol = "Sex")