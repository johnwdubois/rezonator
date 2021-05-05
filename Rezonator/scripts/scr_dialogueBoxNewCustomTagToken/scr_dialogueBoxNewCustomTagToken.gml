function scr_dialogueBoxNewCustomTagToken() {
	
	// get submap for this field
	var tokenTagMap = global.nodeMap[? "tokenTagMap"];
	var fieldSubMap = tokenTagMap[? obj_control.tokenFieldToChange];
	
	// get the tagset for this field
	var tagSet = fieldSubMap[? "tagSet"];
	if (!scr_isNumericAndExists(tagSet, ds_type_list)) {
		show_debug_message("scr_dialogueBoxNewCustomTagToken ... tagSet does not exist");
		exit;
	}
	
	// add new tag to this field's tagSet
	scr_addToListOnce(tagSet, obj_control.inputText);
	
	
	/*
	var mapKey = ds_list_find_value(global.tokenImportColNameList, obj_control.tokenImportColToChange);
	var tempList = ds_map_find_value(global.tokenImportTagMap, mapKey);
	if (is_numeric(tempList)) {
		if (ds_exists(tempList, ds_type_list)) {
			ds_list_add(tempList, obj_control.inputText);
		}
	}
	*/


}
