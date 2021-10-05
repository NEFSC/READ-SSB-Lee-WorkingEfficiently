
if(!require(RODBC)) {  
  install.packages("RODBC")
  require(RODBC)}

o<-odbcConnect("sole", uid=id, pwd=solepw, believeNRows=FALSE)

out_1<-sqlQuery(o,"select * from cfdbs.cfspp")

close(o)
