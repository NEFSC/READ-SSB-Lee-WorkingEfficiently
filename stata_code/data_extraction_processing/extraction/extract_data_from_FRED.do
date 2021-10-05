

/* 
This is some code that shows how to extract data from STL FED with Stata's import fred. You will need to set an API key.
extract quarterly data from FRED 
series_id                     	industry_code	product_code	seasonal	base_date	series_title	footnote_codes	begin_year	begin_period	end_year	end_period	
PCU31171-31171-               	31171-	31171-	U	200312	PPI industry data for Seafood product preparation and packaging, not seasonally adjusted		2003	M12	2020	M06
PCU311710311710               	311710	311710	U	201112	PPI industry data for Seafood product preparation and packaging, not seasonally adjusted		2011	M12	2020	M06
PCU3117103117101              	311710	3117101	U	198412	PPI industry data for Seafood product preparation and packaging-Seafood canning, not seasonally adjusted		1984	M12	2020	M06
PCU3117103117102              	311710	3117102	U	198212	PPI industry data for Seafood product preparation and packaging-Fresh and frozen seafood processing, not seasonally adjusted		1982	M12	2020	M06
PCU31171031171022             	311710	31171022	U	198212	PPI industry data for Seafood product preparation and packaging-Prepared frozen fish, not seasonally adjusted		1975	M12	2020	M06
PCU31171031171023             	311710	31171023	U	199612	PPI industry data for Seafood product preparation and packaging-Prepared frozen shellfish, not seasonally adjusted		1996	M12	2020	M06
PCU31171031171024             	311710	31171024	U	199612	PPI industry data for Seafood product preparation and packaging-Other prepared fresh and frozen seafood, not seasonally adjusted		1996	M12	2020	M06
PCU311710311710M              	311710	311710M	U	198212	PPI industry data for Seafood product preparation and packaging-Miscellaneous receipts, not seasonally adjusted		1982	M12	2020	M06
PCU311710311710MM             	311710	311710MM	U	198212	PPI industry data for Seafood product preparation and packaging-Miscellaneous receipts, not seasonally adjusted		1982	M12	1996	M07
PCU311710311710P              	311710	311710P	U	201112	PPI industry data for Seafood product preparation and packaging-Primary products, not seasonally adjusted		2011	M12	2020	M06
PCU311710311710S              	311710	311710S	U	198212	PPI industry data for Seafood product preparation and packaging-Secondary products, not seasonally adjusted		1982	M12	2016	M04	
	

selected 
	
PCU3117--3117--               	3117--	3117--	U	200312	PPI industry group data for Seafood product preparation & packaging, not seasonally adjusted		2003	M12	2020	M06
PCU3117103117102              	311710	3117102	U	198212	PPI industry data for Seafood product preparation and packaging-Fresh and frozen seafood processing, not seasonally adjusted		1982	M12	2020	M06
PCU31171031171021             	311710	31171021	U	198212	PPI industry data for Seafood product preparation and packaging-Prepared fresh fish/seafood, inc. surimi/surimi-based products, not seasonally adjusted		1965	M01	2020	M06
WPU311                        	31	1	U	200906	PPI Commodity data for Services related to transportation activities-Services related to water transportation, not seasonally adjusted		2009	M06	2020	M06
GDPDEF  Gross Domestic Product: Implicit Price Deflator 
DDFUELNYH - diesel fuel in New York Harbor

PCU483483---	PPI industry data group for Water transportation



PCU31171031171021, DDFUELNYH are probably too volatile


GDPDEF, WPU311


Industry classification. A Producer Price Index for an industry is a measure of changes in prices received for the industry's output sold outside the industry (that is, its net output).
Commodity classification. The commodity classification structure of the PPI organizes products and services by similarity or material composition, regardless of the industry classification of the producing establishment. 
	This system is unique to the PPI and does not match any other standard coding structure. 
	In all, PPI publishes more than 3,700 commodity price indexes for goods and about 800 for services (seasonally adjusted and not seasonally adjusted), organized by product, service, and end use.



	*/
version 15.1
clear


/*annual GDP Deflator with a base period equal to basey */

local basey=2010

import fred GDPDEF WPU311 PCU31173117 PCU3117103117102 PCU31171031171021 DDFUELNYH PCU483483,  daterange(2001-01-01 .) aggregate(annual,avg) clear
gen year=yofd(daten)
drop daten datestr

notes: deflators extracted on $vintage_string;

foreach var of varlist  GDPDEF WPU311 PCU31173117 PCU3117103117102 PCU31171031171021 DDFUELNYH PCU483483{

gen base`var'=`var' if year==`basey'
sort base`var'
replace base`var'=base`var'[1] if base`var'==.

	gen f`var'_`basey'=`var'/base`var'
	notes f`var'_`basey': divide a nominal price or value by this factor to get real `basey' prices or values
	notes f`var'_`basey': multiply a real `basey' price or value by this factor to get nominal prices or values
	notes `var': raw index value
	drop base`var'

}
sort year 
order year f*`basey'

tsset year

save "$data_external/deflatorsY_${vintage_string}.dta", replace
drop fDDFUEL
tsline f* if year>=2009


/* which is your base period : 2016Q2 and 2018Q1
*/


local b1 "2010Q1"
local baseq=quarterly("`b1'","Yq")


import fred GDPDEF WPU311 PCU31173117 PCU3117103117102 PCU31171031171021 DDFUELNYH PCU483483,  daterange(2001-01-01 .) aggregate(quarterly,avg) clear
gen dateq=qofd(daten)
drop daten datestr
format dateq %tq
notes: deflators extracted on $vintage_string


foreach var of varlist  GDPDEF WPU311 PCU31173117 PCU3117103117102 PCU31171031171021 DDFUELNYH PCU483483{
	gen base`var'=`var' if dateq==`baseq'
	sort base`var'
	replace base`var'=base`var'[1] if base`var'==.
	gen f`var'_`b1'=`var'/base`var'
	notes f`var'_`b1': divide a nominal price or value by this factor to get real `basey' prices or values
	notes f`var'_`b1': multiply a real `basey' price or value by this factor to get nominal prices or values
	notes `var': raw index value
	drop base`var'
}
sort dateq 
order dateq f*`b1' 
tsset dateq

save "$data_external/deflatorsQ_${vintage_string}.dta", replace
drop fDDFUEL

tsline f* if year(dofq(dateq))>=2009
