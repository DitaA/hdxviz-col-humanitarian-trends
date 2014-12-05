## Script for checking the pcodes of
## admin3s. 

# Checking for unique locations
muniques <- data.frame(original = unique(data$MPIO_ORIGEN))
muniques$pcode <- gsub(".*-", "", muniques$original)