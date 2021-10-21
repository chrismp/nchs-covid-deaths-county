library(dplyr)

resourceID <- 'kn79-hsxy'
source('download-cdc-api-data/download.r')

rb$formattedupdatedate <- as.Date(rb$data_as_of)

o <- 'output'
dir.create(o)

write.csv(
  x = rb,
  file = paste0(o,'/provisional-covid19-deaths-county.csv'),
  na = '',
  row.names = F
)

write.csv(
  x = filter(
    .data = rb,
    state_name == 'FL'
  ),
  file = paste0(o,'/provisional-covid19-fl-deaths-county.csv'),
  na = '',
  row.names = F
)
