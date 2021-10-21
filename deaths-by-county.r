library(dplyr)

resourceID <- 'kn79-hsxy'
source('download-cdc-api-data/download.r')

rb$formattedupdatedate <- as.Date(rb$data_as_of)
rb$countyformatted <- gsub(
  pattern = ' County',
  replacement = '',
  x = rb$county_name
)

rb$covid_death <- as.numeric(rb$covid_death)


o <- 'output'
dir.create(o)

write.csv(
  x = rb,
  file = paste0(o,'/provisional-covid19-deaths-county.csv'),
  na = '',
  row.names = F
)

fl <- filter(
  .data = rb,
  state_name == 'FL',
  !is.na(covid_death)
) 

flpop <- read.csv(
  file = 'fl-counties-2020-pop.csv',
  colClasses = c('X2010.GeoID'='character')
)

m <- merge(
  x = fl,
  y = flpop,
  by.x = 'county_fips_code',
  by.y = 'X2010.GeoID'
)


m$deathsper100k <- m$covid_death / m$X2020.Total.Population * 100000

write.csv(
  x = m,
  file = paste0(o,'/provisional-covid19-fl-deaths-county.csv'),
  na = '',
  row.names = F
)
