## Script to add data to a geoJSON file. 
# The script adds properties to the Admin 3 
# regions from Colombia. But not to the Admin 2.
# The reason is that the Admin 3 regions come arleady coded.
# And the Admin 2 regions aren't coded. There is an importing
# issue happening in R due to the encoding of the location names
# which use 'special characters'.
# The action is to work wtih 

library(rjson)

# Loading the geographic data from a file.
admin2 <- fromJSON(file = 'data/geo/admin_2.geojson')  # admin2 will be processed later
admin3 <- fromJSON(file = 'data/geo/admin_3.geojson')
data <- read.csv('data/idp_map_data.csv')

# In GeoJSON files properties can be added
# those properties will be the properties that
# that contain that mapped data and alike.
for (i in 1:length(admin2$features)) {
  it = admin2$features[[i]]$properties$DEPARTAMEN  
  if (i == 1) listFromCOD <- it
  else listFromCOD <- c(listFromCOD, it)
}

# In admin2 both lists are the same. 
# However, there is a difference in
# encoding on the dataset file
listFromCOD <- tolower(listFromCOD)
listFromDataset <- unique(data$DEPTO_ORIGEN)

# Preparing the mapa that will be mapped.
names(data) <- c('pcode', 'value')

# Function to add properties to the GeoJSON based
# on the existing p-code.
addDatatoGeoJson <- function(df = NULL) {
  # tests
  if (!is.data.frame(df)) stop('We need a data.frame with the headers `pcode` and `value`')
  
  # iterating over each property
  cat('Storing data.frame in GeoJSON.\n')
  pb <- txtProgressBar(min = 0, max = length(admin3$features), style = 3, char = ".")
  for (i in 1:length(admin3$features)) {
    setTxtProgressBar(pb, i)
    
    # adding the idps figure to the geojson
    idp_data <- data[grep(admin3$features[[i]]$properties$CODANE, as.character(data$pcode)),2]
    idp_data = ifelse(length(idp_data) == 0, 0, as.numeric(idp_data))
    admin3$features[[i]]$properties$IDPSJULY2014 <- idp_data
  }
  
  # Returning data.frame
  cat('\nDone!')
  return(admin3)
}

# making the join
admin3 <- addDatatoGeoJson(data)



# Storign the resulting JSON
sink("data/geo/idp_map_data.geojson")
cat(toJSON(admin3))
sink()


# Loading the post-processed data
postData <- fromJSON(file = 'data/geo/idp_map_data.geojson')
