/* Prerequisites: 
Before you can extract data from the Oracle servers, you will need
1.  An Oracle InstantClient Installation.
2.  An Oracle ODBC driver installation. 
3.  A copy of tnsnames.ora that should reside inside your ORACLE_HOME/network/admin folder.  Your ORACLE_HOME will probably be something like C:\instantclient_VV_Y
4.  Properly configured User or System DSNs (through the ODBC Data Source Administrator.)
IT helpdesk will do parts 1, 2,3.
*/

/* here is a piece of code that shows how to extract data from sole */

/* set these globals in a places that is not stored on github. I suggest your profile.do in PERSONAL. you can find this by typing sysdir into stata.*/
global myuid "your_uid"
global mypwd "your_pwd_here"
global mysole_conn "dsn(yoursoleconnection) user($myuid) password($mypwd)"


#delimit;

clear;
odbc load,  exec("select * from cfspp;") $mysole_conn;
save $data_internal/cfspp_test_$vintage_string.dta, replace;



