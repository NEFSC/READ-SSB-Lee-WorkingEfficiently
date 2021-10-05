# R script to create folders
# If you make a project from the template, all these folders will the there, so you will not have to run it.


# This line is the only line you should have to change to get it to run.
my_projdir<-"C:/Users/Min-Yang.Lee/Documents/project_templates"

# Setup directories

dir.create(my_projdir, showWarnings=FALSE )
Rcodedir<-file.path(my_projdir,"R_code")
dir.create(Rcodedir, showWarnings=FALSE )

#Folders to store Rcode that extracts and processes data
dep_code<-file.path(Rcodedir,"data_extraction_processing")
dir.create(dep_code, showWarnings=FALSE )

extraction_code<-file.path(Rcodedir,"data_extraction_processing","extraction")
dir.create(extraction_code, showWarnings=FALSE )

processing_code<-file.path(Rcodedir,"data_extraction_processing","processing")
dir.create(processing_code, showWarnings=FALSE )


# Folders that store code that does analysis

analysis_code <-file.path(Rcodedir, "analysis")
dir.create(Rcodedir, showWarnings=FALSE )


#Folders to store stata_code that extracts and processes data
stata_codedir<-file.path(my_projdir,"stata_code")
dir.create(stata_codedir, showWarnings=FALSE )


dep_code<-file.path(stata_codedir,"data_extraction_processing")
dir.create(dep_code, showWarnings=FALSE )

extraction_code<-file.path(stata_codedir,"data_extraction_processing","extraction")
dir.create(extraction_code, showWarnings=FALSE )

processing_code<-file.path(stata_codedir,"data_extraction_processing","processing")
dir.create(processing_code, showWarnings=FALSE )


# Folders that store code that does analysis

analysis_code <-file.path(stata_codedir, "analysis")
dir.create(stata_codedir, showWarnings=FALSE )





# setup data folder
my_datadir <-file.path(my_projdir, "data_folder")
data_internal <-file.path(my_datadir, "internal")
data_external<-file.path(my_datadir, "external")
data_main <-file.path(my_datadir, "main")
data_intermediate <-file.path(my_datadir, "intermediate")

dir.create(data_internal, showWarnings=FALSE, recursive=TRUE )
dir.create(data_external, showWarnings=FALSE )
dir.create(data_intermediate, showWarnings=FALSE)
dir.create(data_master, showWarnings=FALSE )

# setup results folders 
my_results <-file.path(my_projdir, "results")
dir.create(my_results, showWarnings=FALSE )

# setup images folders 

my_images <-file.path(my_projdir, "images")
dir.create(my_images, showWarnings=FALSE )


my_tables <-file.path(my_projdir, "tables")
dir.create(my_tables, showWarnings=FALSE )
