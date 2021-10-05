
id<-"<yourid>"
solepw<-"<yoursole_pwd>"
novapw<-"<yournova_pwd"



drv<-dbDriver("Oracle")
shost <- "<sole.full.path.to.server.gov>"
port <- port_number_here
ssid <- "<ssid_here>"

sole.connect.string<-paste(
  "(DESCRIPTION=",
  "(ADDRESS=(PROTOCOL=tcp)(HOST=", shost, ")(PORT=", port, "))",
  "(CONNECT_DATA=(SID=", ssid, ")))", sep="")


# Don't run this here.  You should put it in where you make the query and then close it when you are done with dbDisconnect(sole_conn)
# sole_conn<-dbConnect(drv, id, password=solepw, dbname=sole.connect.string)



nhost <- "nova.full.path.to.server.gov"
port <- port_number_here
ssid2 <- "<nova"

nova.connect.string<-paste(
  "(DESCRIPTION=",
  "(ADDRESS=(PROTOCOL=tcp)(HOST=", nhost, ")(PORT=", port, "))",
  "(CONNECT_DATA=(SID=", ssid2, ")))", sep="")

# Don't run this here.  You should put it in where you make the query and then close it when you are done with dbDisconnect(nova_conn)
# nova_conn<-dbConnect(drv, id, password=novapw, dbname=nova.connect.string)
