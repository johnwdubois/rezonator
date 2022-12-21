

function scr_setNavFieldListsFromSchemaPart(schemaFieldList, fullFieldList, navFieldList){
	
	show_debug_message("schemaFieldList: " + scr_getStringOfList(schemaFieldList));
	show_debug_message("fullFieldList: " + scr_getStringOfList(fullFieldList));
	show_debug_message("navFieldList: " + scr_getStringOfList(navFieldList));
	
	// make sure we got a schema field list
	if (scr_isNumericAndExists(schemaFieldList, ds_type_list)) {
		
		// loop over schema field list and set each one
		var schemaFieldListSize = ds_list_size(schemaFieldList);
		for (var i = 0; i < schemaFieldListSize; i++) {
			var currentField = schemaFieldList[| i];
			
			// make sure the field is an actual field in the full field list
			if (ds_list_find_index(fullFieldList, currentField) >= 0) {
				ds_list_set(navFieldList, i, currentField);
			}
		}
	}

}