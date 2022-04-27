# SECTION 1: THIS IS NEEDED TO CONNECT WITH RODBC and ROracle
id<-"yourid"
solepw<-"yoursole_pwd"
novapw<-"yournova_pwd"
# END SECTION 1: THIS IS NEEDED TO CONNECT WITH RODBC and ROracle



# SECTION 2: THIS IS NEEDED TO CONNECT TO SOLE WITH ROracle

drv<-dbDriver("Oracle")
shost <- "sole.full.path.to.server.gov"
port <- port_number_here
ssid <- "ssid_here"

sole.connect.string<-paste(
  "(DESCRIPTION=",
  "(ADDRESS=(PROTOCOL=tcp)(HOST=", shost, ")(PORT=", port, "))",
  "(CONNECT_DATA=(SID=", ssid, ")))", sep="")

# END SECTION 2: THIS IS NEEDED TO CONNECT TO SOLE WITH ROracle


# SECTION 3: THIS IS NEEDED TO CONNECT TO NOVA WITH ROracle


nhost <- "nova.full.path.to.server.gov"
port <- port_number_here
ssid2 <- "nova"

nova.connect.string<-paste(
  "(DESCRIPTION=",
  "(ADDRESS=(PROTOCOL=tcp)(HOST=", nhost, ")(PORT=", port, "))",
  "(CONNECT_DATA=(SID=", ssid2, ")))", sep="")



# END SECTION 3: THIS IS NEEDED TO CONNECT TO NOVA WITH ROracle
