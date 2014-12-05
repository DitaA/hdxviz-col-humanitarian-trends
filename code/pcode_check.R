## Script for checking the pcodes of
## admin3s. 

# Load original data.
data <- read.table('data/source/140812_UARIV_RNI_CONSULTA_EDADES.txt', 
                   header = T, 
                   sep = ';')

# Load updated pcode data.
pcodes <- read.csv('data/col_admin3_dane.csv')

# Checking for unique locations
muniques <- data.frame(original = unique(data$MPIO_ORIGEN))
muniques$pcode <- gsub(".*-", "", muniques$original)


# Checking
summary(muniques$pcode %in% pcodes$admin3)  # 4 FALSE

other <- muniques[!(muniques$pcode %in% pcodes$admin3), ]
