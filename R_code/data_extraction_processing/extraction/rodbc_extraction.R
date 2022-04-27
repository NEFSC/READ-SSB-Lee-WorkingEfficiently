library(RODBC)
library(here)


#### Set things up
here::i_am("R_code/data_extraction_processing/extraction/rodbc_extraction.R")

my_projdir<-here()

#this reads in paths and libraries
source(file.path(my_projdir,"R_code","project_logistics","R_paths_libraries.R"))

# This reads in your R credentials from R_credentials.R, which you have constructed from R_credentials_sample.R, and also added to .gitignore so your passwords are on github. 
source(file.path(my_projdir,"R_code","project_logistics","R_credentials.R"))

o<-odbcConnect("sole", uid=id, pwd=solepw, believeNRows=FALSE)

out_1<-sqlQuery(o,"select * from cfdbs.cfspp")

close(o)
