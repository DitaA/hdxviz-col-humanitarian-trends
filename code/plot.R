## Script to quickly plot the data from Colombia
## into beautiful plots
library(ggplot2)

totalPerDate <- read.csv("data/totalPerDate.csv")
names(totalPerDate) <- c('date', 'total_idps')
totalPerDate$date <- as.Date(totalPerDate$date)

# writing clean output
write.csv(totalPerDate, 'data/totalPerDate.csv', row.names = F)


## plotting
# timeseries -- nice looking line!
ggplot(totalPerDate) + theme_bw() +
  geom_line(aes(date, total_idps), stat = 'identity', size = 1.3, color = '#404040')
