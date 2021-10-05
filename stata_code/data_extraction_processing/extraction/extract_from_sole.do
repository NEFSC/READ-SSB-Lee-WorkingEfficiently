/* here is a piece of code that shows how to extract data from sole */
#delimit;

clear;
odbc load,  exec("select * from cfspp;") $mysole_conn;
save $data_internal/cfspp_test_$vintage_string.dta, replace;



