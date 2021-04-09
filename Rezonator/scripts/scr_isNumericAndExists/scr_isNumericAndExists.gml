// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_isNumericAndExists(ds, ds_type){
	
	// quick safety check to see if a data structure is valid
	// all data structures should be numeric and exist as their specific ds type!
	var numericAndExists = false;
	if (is_numeric(ds)) {
		if (ds_exists(ds, ds_type)) {
			numericAndExists = true;
		}
	}
	return numericAndExists;

}