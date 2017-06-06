download.file(url = c("http://docs.google.com/spreadsheet/pub?key=phAwcNAVuyj0TAlJeCEzcGQ&output=xlsx", 
                      "http://docs.google.com/spreadsheet/pub?key=phAwcNAVuyj0NpF2PTov2Cw&output=xlsx"), 
              destfile = c("Data/indicator undata total_fertility.xlsx", 
                           "Data/indicator gapminder infant_mortality.xlsx"))

download.file(url = "http://docs.google.com/spreadsheet/pub?key=phAwcNAVuyj0TAlJeCEzcGQ&output=xlsx", 
              destfile = "Data/indicator undata total_fertility.xlsx")

download.file(url = "http://docs.google.com/spreadsheet/pub?key=phAwcNAVuyj0NpF2PTov2Cw&output=xlsx", 
              destfile = "Data/indicator gapminder infant_mortality.xlsx")

library("readxl")
library("tidyverse")
raw_fert <- read_excel(path = "Data/indicator undata total_fertility.xlsx", sheet = "Data")
raw_infantMort <- read_excel(path="Data/indicator gapminder infant_mortality.xlsx")

# Data are most often not provided in the correct format for being analysed. Tidyr can be used to tidy up the datasets
# Wide format: Each row is a site patient and multiple observations (how my geneexp-data are organised?? And also gapminder)
# Long format: One column for the observed data.

#Extracting countries as there are so many things we want to keep
fert <- raw_fert %>% 
  rename(country=`Total fertility rate`) %>% 
  gather (key=year, value = fert, -country) %>% 
  mutate(year=as.integer(year))
fert


