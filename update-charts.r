library(DatawRappr)

source('deaths-by-county.r')

print("Starting chart updater")

updateDateFormat <- gsub(
  pattern = " 0",
  replacement = ' ',
  x = format(
    x = max(rb$formattedupdatedate),
    format = "%B %d, %Y"
  )
)

chartIDs <- c(
  'SE3YD'
)

apikey <- Sys.getenv("DATAWRAPPER_API")

for (id in chartIDs) {
  dw_edit_chart(
    chart_id = id,
    api_key = apikey,
    annotate = paste0("Updated ",updateDateFormat,'. The federal government does not report death tolls for counties with one to nine fatalities.')
  )
  print("Publishing chart")  
  dw_publish_chart(
    chart_id = id,
    api_key = apikey,
    return_urls = TRUE
  )  
}



