# I am not sure which of these things you need need to connect to using DBI
# 1.  An Oracle InstantClient Installation.
# 2.  An Oracle ODBC driver installation. 
# 3.  A copy of tnsnames.ora that should reside inside your ORACLE_HOME/network/admin folder.  Your ORACLE_HOME will probably be something like C:\instantclient_VV_Y
# 4.  Properly configured User or System DSNs (through the ODBC Data Source Administrator.)
# IT helpdesk will do parts 1, 2,3.

# You must set.
# id - "your user id" 
# pw1 - "your password"
# mysdn1 - "a connection corresponding to an entry in tnsnames.ora"
# mydsn2 - "a  connection corresponding to a different entry in tnsnames.ora"


library(tidyverse)
library(DBI)
library(dbplyr)


# simple query from kristin.precoda@noaa.gov
conn <- dbConnect(odbc::odbc(), dsn=mydsn1, uid=id, pwd=pw1, believeNRows=F)
query <- "(select nespp4_obs, drflag_code, catdisp_code, nespp4_output, comname, nespp3, cf_rptqty_lndlb, cf_lndlb_livlb from OBSPECCONV);"
dataout <- dbGetQuery(conn, query)
dbDisconnect(conn)


# The same query, but with an interactive popup to ask the user for the user name and password from brian.smith@noaa.gov
con <- DBI::dbConnect(odbc::odbc(),
                      dsn=mydsn1,
                      UID    = rstudioapi::askForPassword("Database user"),
                      PWD    = rstudioapi::askForPassword("Database password"), 
                      believeNRows=F)

dataout2 <- dbGetQuery(con, query)
dbDisconnect(con)



# a more complicated set of queries from kiersten.curti@noaa.gov

flatfish_dbi <- DBI::dbConnect(odbc::odbc(), 
                               dsn=mydsn2, 
                               UID = id, 
                               PWD = pw1)







####### DBI

UNION_FSCS_SVSTA <- tbl(flatfish_dbi, in_schema("SVDBS", "UNION_FSCS_SVSTA"))
SVDBS_CRUISES <- tbl(flatfish_dbi, in_schema("SVDBS", "SVDBS_CRUISES"))
UNION_FSCS_SVCAT <- tbl(flatfish_dbi, in_schema("SVDBS", "UNION_FSCS_SVCAT"))
UNION_FSCS_SVLEN <- tbl(flatfish_dbi, in_schema("SVDBS", "UNION_FSCS_SVLEN"))


season <- 'FALL'
svspp <- '141'

fyr <- 1980
lyr <- 2021

stratum.vec <- c('01010','01020','01030','01040','01050','01060','01070','01080','01090','01100','01110','01120','01130','01140','01150','01160','01170',
                   '01180','01190','01200','01210','01220','01230','01240','01250','01260','01270','01280','01290','01300','01310','01320','01330','01340',
                   '01350','01351','01352','01360','01370','01380','01390','01400','01410','01420','01490','01610','01620','01630','01640','01650','01660',
                   '01670','01680','01690','01700','01710','01720','01730','01740','01750','01760','01990','03010','03020','03030','03040','03050','03060',
                   '03070','03080','03090','03100','03110','03120','03130','03140','03150','03160','03170','03180','03190','03200','03210','03220','03230',
                   '03240','03250','03260','03270','03280','03290','03300','03310','03320','03330','03340','03350','03360','03370','03380','03390','03400',
                   '03410','03420','03430','03440','03450','03460','03470','03480','03490','03500','03510','03520','03530','03540','03550','03560','03570',
                   '03580','03590','03600','03610','03620','03630','03640','03650','03660','03670','03680','03690','03700','03710','03720','03730','03740','03750',
                   '03760','03770','03780','03790','03800','03810','03820','03830','03840','03850','03860','03870','03880','03890','03900','03910','03920')


alb <- UNION_FSCS_SVSTA %>%
  inner_join(SVDBS_CRUISES) %>%
  filter(
    SEASON == season, 
    PURPOSE_CODE=='10', 
    STATUS_CODE == '10',
    SHG <= 123,
    STRATUM %in% stratum.vec,
    EST_YEAR %in% c(fyr:2008)
  ) %>%
  select(CRUISE6, SEASON, STRATUM, TOW, STATION, SHG, SVVESSEL, STATUS_CODE, EST_YEAR, EST_MONTH, EST_DAY, AVGDEPTH, BOTTEMP, BEGLAT, BEGLON) %>%
  collect()

big <- UNION_FSCS_SVSTA %>%
  inner_join(SVDBS_CRUISES) %>%
  filter(
    SEASON == season, 
    PURPOSE_CODE=='10', 
    STATUS_CODE == '10',
    STRATUM %in% stratum.vec,
    EST_YEAR %in% c(2009:lyr),
    TYPE_CODE <= 1,
    OPERATION_CODE <= 3,
    GEAR_CODE <= 2
  ) %>%
  select(CRUISE6, SEASON, STRATUM, TOW, STATION, SVVESSEL, STATUS_CODE, EST_YEAR, EST_MONTH, EST_DAY, AVGDEPTH, BOTTEMP, BEGLAT, BEGLON, TYPE_CODE, OPERATION_CODE, GEAR_CODE) %>%
  collect() 

stn <- bind_rows(alb, big)

    
catch <- UNION_FSCS_SVCAT %>%
  inner_join(SVDBS_CRUISES) %>%
  filter(
    SEASON == season, 
    PURPOSE_CODE=='10', 
    STATUS_CODE == '10',
    STRATUM %in% stratum.vec,
    YEAR %in% c(fyr:lyr),
    SVSPP == svspp
  ) %>%
  select(CRUISE6, SEASON, YEAR, STRATUM, TOW, STATION, SVSPP, CATCHSEX, EXPCATCHNUM) %>%
  collect() 


len <- UNION_FSCS_SVLEN %>%
  inner_join(SVDBS_CRUISES) %>%
  filter(
    SEASON == season, 
    PURPOSE_CODE=='10', 
    STATUS_CODE == '10',
    STRATUM %in% stratum.vec,
    YEAR %in% c(fyr:lyr),
    SVSPP == svspp
  ) %>%
  select(CRUISE6, SEASON, YEAR, STRATUM, TOW, STATION, SVSPP, CATCHSEX, LENGTH, EXPNUMLEN) %>%
  collect() 


dbDisconnect(flatfish_dbi)


# ask the user for their user/pass  




