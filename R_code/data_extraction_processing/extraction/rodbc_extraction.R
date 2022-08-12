# Before you can use RODBC to extract data from the Oracle servers, you will need
# 1.  An Oracle InstantClient Installation.
# 2.  An Oracle ODBC driver installation. 
# 3.  A copy of tnsnames.ora that should reside inside your ORACLE_HOME/network/admin folder.  Your ORACLE_HOME will probably be something like C:\instantclient_VV_Y
# 4.  Properly configured User or System DSNs (through the ODBC Data Source Administrator.)
# IT helpdesk will do parts 1, 2,3.

library(RODBC)
library(here)


#### Set things up
here::i_am("R_code/data_extraction_processing/extraction/rodbc_extraction.R")

my_projdir<-here()

#set the id and solepw variables somewhere that is not stored on github. I suggest your .Rprofile or .Renviron file.

o<-odbcConnect("sole", uid=id, pwd=solepw, believeNRows=FALSE)

out_1<-sqlQuery(o,"select * from cfdbs.cfspp")

close(o)
