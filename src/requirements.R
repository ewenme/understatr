
# packages ----------------------------------------------------------------

# check for installs
list.of.packages <- c("rvest", "jsonlite", "tidyverse", "stringi", "qdapRegex")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)
rm(list.of.packages, new.packages)
