
/* a small program that looks into the data folder to find the most recent vintage string*/
cap program drop vintage_lookup_and_reset
program vintage_lookup_and_reset

	/* Look through the data_main folder to see what data vintages are available */

	local data_vintage : dir "${data_main}" files "*.dta" 
	local data_vintage: subinstr local data_vintage ".dta" "", all
	
	/* look through all the files and pick out the unique vintages, which are in the last 10 characters */
	/* Use a regular expression, to only keep things that end in YYYY_MM_DD*/
	
	local stubs
	foreach var of local data_vintage {
	
		local stub = substr("`var'",length("`var'") - 9,10)
		if regexm("`stub'", "([0-9][0-9][0-9][0-9]_[0-9][0-9]_[0-9][0-9])") {
			loc stub = "`=regexs(1)'"
		local stubs `stubs' `stub'
		}
		
}

	local data_vintage: list uniq stubs
	local data_vintage: list sort data_vintage

	
	
	/* print out the current vintage string */
	di "The vintage_string global is currently set as: $vintage_string"
	
	/* tell the user what vintages are available and give the option to change the data vintage*/
	di "Data vintage(s) found in the data_main folder :" `"`data_vintage'"'.
	di "To manually set the data vintage, enter it now. Do not use double quotes.  Otherwise, press <Enter> to keep the current string" _request(_vintage_string_bypass)

	local bypass_length: strlen local vintage_string_bypass
		if `bypass_length'==0  {
			di "Keeping existing global vintage_string of $vintage_string"
		} 
		else{
			di "Existing vintage string of ${vintage_string} will be overwritten with user -specified data vintage of `vintage_string_bypass'"
			global vintage_string `vintage_string_bypass'
			di "Vintage string is now ${vintage_string}"

		}

end
