library(jsonlite)
library(data.table)


limit <- 10000
offset <- 0
i <- 1
l <- list()

while(T){
  url <- paste0('https://data.cdc.gov/resource/',resourceID,'.json?$limit=',limit,'&$offset=',offset)
  print(url)
  d <- fromJSON(url)
  l[[i]] <- d
  
  if(nrow(d)<limit) break
  
  offset <- offset + limit
  i <- i + 1
} 

rb <- rbindlist(
  l = l,
  fill = T
)
