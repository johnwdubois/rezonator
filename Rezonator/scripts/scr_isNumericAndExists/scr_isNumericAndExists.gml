

function scr_isNumericAndExists(ds, ds_type) {
	
	// quick safety check to see if a data structure is valid
	// all data structures should be numeric and exist as their specific ds type!

	if (is_numeric(ds)) {
		if (ds_exists(ds, ds_type)) {
			return true;
		}
	}
	return false;

}