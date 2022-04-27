# This is code that uses Roracle to connect to oracle databases. 
# installing the ROracle package is a little bit of a pain. 
# 1. You need to have an Instantclient installation.
# 2. You need to set the OCI_LIB64 system variable. You can do this with Sys.setenv(OCI_LIB64= "C:/instantclient_12_2") in your .Rprofile
# 3. You will need to compile the ROracle package from source. The easiest way to do this is installing Rtools. 

library(here)
library(ROracle)

#### Set things up
here::i_am("R_code/data_extraction_processing/extraction/r_oracle_connection.R")

my_projdir<-here()

#this reads in paths and libraries
source(file.path(my_projdir,"R_code","project_logistics","R_paths_libraries.R"))

# This reads in your R credentials from R_credentials.R, which you have constructed from R_credentials_sample.R, and also added to .gitignore so your passwords are on github. 
source(file.path(my_projdir,"R_code","project_logistics","R_credentials.R"))

 ############################################################################################
 #First, set up Oracle Connection
 ############################################################################################

START.YEAR= 2017
END.YEAR=2018

#First, pull in permits and tripids into a list.
permit_tripids<-list()
i<-1


for (years in START.YEAR:END.YEAR){
  sole_conn<-dbConnect(drv, id, password=solepw, dbname=sole.connect.string)
  querystring<-paste0("select permit, tripid from veslog",years,"t")
  permit_tripids[[i]]<-dbGetQuery(sole_conn, querystring)
  dbDisconnect(sole_conn)
  i<-i+1
}
#flatten the list into a dataframe

permit_tripids<-do.call(rbind.data.frame, permit_tripids)
colnames(permit_tripids)[which(names(permit_tripids) == "PERMIT")] <- "permit"



# Pull in gearcode data frame from sole
sole_conn<-dbConnect(drv, id, password=solepw, dbname=sole.connect.string)

querystring2<-paste0("select gearcode, negear, negear2, gearnm from vlgear")
VTRgear<-dbGetQuery(sole_conn, querystring2)

dbDisconnect(sole_conn)


















  
