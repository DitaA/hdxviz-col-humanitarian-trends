## Script to ingest UARIV data into an HDX friendly format.

# dependencies
library(lubridate)

# this dataset has around 4 million records
# take care when loading / handling it
data <- read.table('data/source/140812_UARIV_RNI_CONSULTA_EDADES.txt', 
                   header = T, 
                   sep = ';')
                   # fileEncoding = "UTF-8")  # error when trying encoding

# working with a sample
x <- head(data)

# transforming dates
data$FECHA <- paste0(data$FECHA, '01')  # adding 01 to make it easier for parsing
data$FECHA <- ymd(data$FECHA)  # converting to a date object with lubridate

# adding pcodes
data$pcode_adm3_origen <- gsub(".*-", "", data$MPIO_ORIGEN)
data$pcode_adm3_llegada <- gsub(".*-", "", data$MPIO_LLEGADA)

# cleaning the ,00
data$TOTAL <- gsub(",00", "", data$TOTAL)
data$EDAD_HECHO <- gsub(",00", "", data$EDAD_HECHO)

# preparing for graphics
totalPerDate <- tapply(as.numeric(data$TOTAL), data$FECHA, sum)
write.csv(totalPerDate, 'data/totalPerDate.csv', row.names = T)

# selecting only data more recent than 2013-01-01
latestData <- data[as.Date(data$FECHA) > as.Date('2013-01-01'),]


# perform sum of all of
# the idps that come from the 
# same location
total2014perDept <- tapply(as.numeric(latestData$TOTAL), latestData$DEPTO_ORIGEN, sum)
total2014perMun <- tapply(as.numeric(latestData$TOTAL), latestData$MPIO_ORIGEN, sum)
total2014perPcode <- tapply(as.numeric(latestData$TOTAL), latestData$pcode_adm3_origen, sum)


# writing output
write.csv(total2014perPcode, 'data/idp_map_data.csv', row.names = T)
