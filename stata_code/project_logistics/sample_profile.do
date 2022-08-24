/*this do file does two important things.
1. It sets a username into $user. This will be referenced later
2. It sets up globals that hold a folder_setup do file. 
This should be renamed profile.do and placed somewhere that your stata install can find. A good place is in "PERSONAL."  Find this folder using stata's sysdir. 
*/
global user minyangWin


global mobility "C:\Users\Min-Yang.Lee\Documents\incomemobility\stata_code\project_logistics\folder_setup_globals.do"
global aceprice "C:\Users\Min-Yang.Lee\Documents\aceprice\stata_code\project_logistics\folder_setup_globals.do"
global RFAdataset "C:\Users\Min-Yang.Lee\Documents\RFAdataset\stata_code\project_logistics\folder_setup_globals.do"



/*oracle connections
Your profile.do is a good place to store your oracle username, password, and the details about how to connect to databases. In this case, we are setting up the details to connect to three databases*/

global myuid "your_user_id"
global mypwd "your_pass"
global mysole_conn "dsn(sole) user($myuid) password($mypwd)"
global mynova_conn "dsn(nova) user($myuid) password($mypwd)"
global myNEFSC_USERS_conn "dsn(NEFSC_USERS) user($myuid) password($mypwd)"
