# This is code that uses Roracle to connect to oracle databases. 
# installing the ROracle package is a little bit of a pain. 
# 1. You need to have an Instantclient installation and sdk.  
# 2. You need to set the OCI_LIB64 system variable. 
  # You can do this temporarily with Sys.setenv(OCI_LIB64= "C:/instantclient_21_3") in your .Rprofile.
  # A better way is just to have the environment variable set by ITD. 
# 3. You may need to compile the ROracle package from source. The easiest way to do this is installing Rtools. 
# I don't have  the sdk and so I cannot test this fully.

library(here)
library(ROracle)

#### Set things up
here::i_am("R_code/data_extraction_processing/extraction/r_oracle_connection.R")

my_projdir<-here()

 ############################################################################################
 #First, set up Oracle Connection
 ############################################################################################

# set these variables somewhere that is not stored on github. I suggest your .Rprofile or .Renviron file.
id<- yourid
solepw<- yoursolepassword
drv<-dbDriver("Oracle")
shost <- "sole.full.path.to.server.gov"
port <- port_number_here
ssid <- "ssid_here"
# You may need to use SERVICE_NAME instead of ssid.

sole.connect.string<-paste(
  "(DESCRIPTION=",
  "(ADDRESS=(PROTOCOL=tcp)(HOST=", shost, ")(PORT=", port, "))",
  "(CONNECT_DATA=(SID=", ssid, ")))", sep="")





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



# Pull in gearcode data frame from sole
sole_conn<-dbConnect(drv, id, password=solepw, dbname=sole.connect.string)

querystring2<-paste0("select gearcode, negear, negear2, gearnm from vlgear")
VTRgear<-dbGetQuery(sole_conn, querystring2)

dbDisconnect(sole_conn)


