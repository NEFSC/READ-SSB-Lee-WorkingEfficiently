#Install packages if necessary
if(!require(RODBC)) {  
  install.packages("RODBC")
  require(RODBC)}
if(!require(DBI)) {  
  install.packages("DBI")
  require(DBI)}
 # if(!require(ROracle)) {  
 #   install.packages("ROracle")
 #   require(ROracle)}

# Setup directories

Rcodedir<-file.path(my_projdir,"R_code")

#Folders to store Rcode that extracts and processes data
Rdep_code<-file.path(Rcodedir,"data_extraction_processing")
Rextraction_code<-file.path(Rcodedir,"data_extraction_processing","extraction")
Rprocessing_code<-file.path(Rcodedir,"data_extraction_processing","processing")
# Folders that store code that does analysis

Ranalysis_code <-file.path(Rcodedir, "analysis")


#Folders to store stata_code that extracts and processes data
stata_codedir<-file.path(my_projdir,"stata_code")
stata_extraction_code<-file.path(stata_codedir,"data_extraction_processing","extraction")
stata_processing_code<-file.path(stata_codedir,"data_extraction_processing","processing")


# Folders that store code that does analysis
stata_analysis_code <-file.path(stata_codedir, "analysis")





# setup data folder
my_datadir <-file.path(my_projdir, "data_folder")
data_internal <-file.path(my_datadir, "internal")
data_external<-file.path(my_datadir, "external")
data_main <-file.path(my_datadir, "main")
data_intermediate <-file.path(my_datadir, "intermediate")

# setup results folders 
my_results <-file.path(my_projdir, "results")

# setup images folders 

my_images <-file.path(my_projdir, "images")
my_tables <-file.path(my_projdir, "tables")



# Find the stata executable if you want to run stata from within R

# https://github.com/Hemken/Statamarkdown/blob/master/R/find_stata.r
# Search through places that stata is usually installed.
# I think it searches smallest to highest, which means if you have StataIC and stataMP-64, it will stop at StataIC
# and not pick up StataMP-64 



stataexe <- ""

for (d in c("C:/Program Files","C:/Program Files (x86)")) {
  if (stataexe=="" & dir.exists(d)) {
    for (v in seq(16,11,-1)) {
      dv <- paste(d,paste0("Stata",v), sep="/")
      if (dir.exists(dv)) {
        for (f in c("Stata", "StataIC", "StataSE", "StataMP",
                    "Stata-64", "StataIC-64", "StataSE-64", "StataMP-64")) {
          dvf <- paste(paste(dv, f, sep="/"), "exe", sep=".")
          if (file.exists(dvf)) {
            stataexe <- dvf
          }
          if (stataexe != "") break
        }
      }
      if (stataexe != "") break
    }
  }
  if (stataexe != "") break
}
