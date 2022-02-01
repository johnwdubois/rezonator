function scr_checkForTagSet(fieldSubMap){
	var fieldHasTagSet = false;

	if (scr_isNumericAndExists(fieldSubMap, ds_type_map)) {						
		// check whether this field has a tagSet
		fieldHasTagSet = ds_map_exists(fieldSubMap, "tagSet");
	}
	return fieldHasTagSet;
}