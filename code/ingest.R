## Script to ingest UARIV data into an HDX friendly format.

# dependencies
library(lubridate)

# this dataset has around 4 million records
# take care when loading / handling it
<<<<<<< HEAD
data <- read.table('data/source/140812_UARIV_RNI_CONSULTA_EDADES.txt', 
                   header = T, 
                   sep = ';')
                   # fileEncoding = "UTF-8")  # error when trying encoding

# working with a sample
# x <- head(data)
=======
data <- read.table('data/source/140812_UARIV_RNI_CONSULTA_EDADES.txt', header = T, sep = ';')

# working with a sample
x <- head(data)
>>>>>>> f7eeede415e796ffc84192520d5eacde7d88095e

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
<<<<<<< HEAD
write.csv(totalPerDate, 'data/totalPerDate2.csv', row.names = T)
meanTotal <- mean(totalPerDate); meanTotal

# selecting only data between 2013-01-01 and 2013-12-31
dataFrom2013 <- data[as.Date(data$FECHA) < as.Date('2013-12-31') & 
                       as.Date(data$FECHA) > as.Date('2013-01-01'),]

totalFrom2013 <- tapply(as.numeric(dataFrom2013$TOTAL), dataFrom2013$FECHA, sum)
meanFrom2013 <- mean(totalFrom2013); meanFrom2013
=======
write.csv(totalPerDate, 'data/totalPerDate.csv', row.names = T)

# selecting only data more recent than 2013-01-01
latestData <- data[as.Date(data$FECHA) > as.Date('2013-01-01'),]

>>>>>>> f7eeede415e796ffc84192520d5eacde7d88095e

# perform sum of all of
# the idps that come from the 
# same location
<<<<<<< HEAD
# total2014perDept <- tapply(as.numeric(dataFrom2013$TOTAL), dataFrom2013$DEPTO_ORIGEN, sum)
# total2014perMun <- tapply(as.numeric(dataFrom2013$TOTAL), dataFrom2013$MPIO_ORIGEN, sum)
total2013perPcode <- tapply(as.numeric(dataFrom2013$TOTAL), dataFrom2013$pcode_adm3_origen, sum)

# calcultating the numbers per 100.000 inhabitants
total2013perPcode <- data.frame(pcode = row.names(total2013perPcode), 
                                value = total2013perPcode)

# Working with population data from DANE.
popData <- read.csv("data/source/municipal_population_data.csv")
popDataSelect <- popData[popData$category == 'Total' & popData$year == '2013', ]
colnames(popDataSelect)[3] <- 'pcode'
popDataMerge <- data.frame(pcode = popDataSelect$pcode, population = popDataSelect$value)

# Merging.
total2013 <- merge(total2013perPcode, popDataMerge)
total2013$ratio <- round(((total2013$value / total2013$population) * 100000), 2)

# writing output
write.csv(total2013, 'data/idp_map_data.csv', row.names = F)
=======
total2014perDept <- tapply(as.numeric(latestData$TOTAL), latestData$DEPTO_ORIGEN, sum)
total2014perMun <- tapply(as.numeric(latestData$TOTAL), latestData$MPIO_ORIGEN, sum)
total2014perPcode <- tapply(as.numeric(latestData$TOTAL), latestData$pcode_adm3, sum)

# writing output
write.csv(total2014perPcode, 'data/idp_map_data.csv', row.names = T)


## performing joins with the geojson data
library(jsonlite)
admin_3 <- fromJSON('data/geo/admin_3.geojson')
>>>>>>> f7eeede415e796ffc84192520d5eacde7d88095e
