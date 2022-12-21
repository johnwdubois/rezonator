function scr_checkForTagSet(fieldSubMap){
	
	// check whether this field has a tagSet
	var fieldHasTagSet = false;
	if (scr_isNumericAndExists(fieldSubMap, ds_type_map)) {						
		fieldHasTagSet = ds_map_exists(fieldSubMap, "tagSet");
	}
	return fieldHasTagSet;
}