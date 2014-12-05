## Fixing pcodes

# loading data
data <- read.csv('data/relative_2013_per_pcode.csv')

# pass a df and a character
fixAntioquia <- function(df = NULL, c = NULL) {
  df[df$DEPARTAMEN == 'ANTIOQUIA' & nchar(df$pcode) == 4,]$pcode <- paste0(c,df[df$DEPARTAMEN == 'ANTIOQUIA' & nchar(df$pcode) == 4, ]$pcode)
  
  return(df)
}

# writing data
data <- fixAntioquia(data, 0)
write.csv(data, 'data/relative_2013_per_pcode_2.csv', row.names = F)