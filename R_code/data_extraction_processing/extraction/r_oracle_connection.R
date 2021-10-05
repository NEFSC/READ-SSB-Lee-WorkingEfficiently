# This is code that uses Roracle to connect to oracle databases. I have previously used it, however, I cannot use it now because DMS hasn't set up a properly functioning Oracle Client on my laptop.


if(!require(ROracle)) {  
  install.packages("ROracle")
  require(ROracle)}


#### Set things up
my_projdir<-"C:/Users/Min-Yang.Lee/Documents/project_templates"

#this reads in paths and libraries
source(file.path(my_projdir,"R_code","project_logistics","R_paths_libraries.R"))

# This reads in your R credentials from R_credentials.R, which you have constructed from R_credentials_sample.R, and also added to .gitignore so your passwords are on github. 
source(file.path(my_projdir,"R_code","project_logistics","R_credentials.R"))

 ############################################################################################
 #First, set up Oracle Connection
 ############################################################################################

 START.YEAR= 2015
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


















  
