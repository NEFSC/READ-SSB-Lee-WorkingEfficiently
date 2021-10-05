/* here is a piece of code that shows how to extract data from sole */
#delimit;
clear;
use "$data_internal/cfspp_test_$vintage_string.dta", replace;

keep if _n<=10;
save "$data_intermeidate/cfspp_subset_$vintage_string.dta", replace


