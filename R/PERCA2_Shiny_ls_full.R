# File or Package Name: PERCA2_Shiny_ls_full.R
# Title: Filtering an AD Listing and write CSV file
# Description: Script for  filtering list from ./data 
#             where a listing from AD output is processed and export in .ouput
# Version: 1.0.0
# Author: Patrice Tardif
# Maintainer: Patrice Tardif
# License: MIT
# Date: 2019-11-14


# Paramaters for data location and output in the project
PATH_AD <-  "./data"
PATH_OUT <- "./output"
fNameIn <- file.path(PATH_AD, "Shiny_AD_full.txt") 
if (!file.exists(fNameIn)) {
  fNameIn <- file.path(PATH_AD, "Shiny_AD_dummy.txt") 
}
if (!dir.exists(PATH_OUT)) {
  dir.create(PATH_OUT)
}
fNameOut <- file.path(PATH_OUT, paste(sep="","Shiny_ls_full",".csv"))
  

# Load, Extract, Tansform  (ETL) the AD file list
Shiny_AD <- read.csv(fNameIn, encoding="UTF-8", header=FALSE, stringsAsFactors=FALSE)
Shiny_ls_full <- Shiny_AD[stringr::str_detect(Shiny_AD[,5],"Utilisateurs"), c(1,2,4)]
names(Shiny_ls_full) <-  c("Nom","Prenom_(Region)","Centre")
Shiny_ls_full[,"Centre"] <- unlist(lapply(stringr::str_split(Shiny_ls_full[,"Centre"],"="), '[',2))
Shiny_ls_full[,"Nom"] <- unlist(lapply(stringr::str_split(Shiny_ls_full[,"Nom"], "=|[\\\\]|[^[:print:]]"), '[',2))


# Export also the dataframe in CSV format
write.csv(Shiny_ls_full, fNameOut, row.names = F)


