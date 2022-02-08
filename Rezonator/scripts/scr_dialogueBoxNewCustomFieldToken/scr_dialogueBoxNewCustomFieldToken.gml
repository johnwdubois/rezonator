function scr_dialogueBoxNewCustomFieldToken() {
	
	var newField = obj_control.inputText;
	if (!is_string(newField) || string_length(string(newField)) < 1) {
		show_debug_message("new field is invalid or blank string, exiting...");
		exit;
	}
	
	// add new field to the list of token fields
	if (!obj_control.selectFieldChunk) {
		if (ds_list_find_index(obj_control.tokenFieldList, newField) != -1) exit;
		scr_addToListOnce(obj_control.tokenFieldList, newField);
			scr_sortList(obj_control.tokenFieldList);
	}
	else {
		if (ds_list_find_index(obj_control.chunkFieldList, newField) != -1) exit;
	}
	scr_addToListOnce(obj_control.chunkFieldList, newField);
	scr_sortList(obj_control.chunkFieldList);
	//add to nav window list
	scr_addToListOnce(obj_control.navTokenFieldList, newField);
	scr_addToListOnce(obj_control.navChunkFieldList, newField);
	
	

	
	
	// create a new submap for this field
	var newFieldMap = ds_map_create();
	ds_map_add_list(newFieldMap, "tagSet", ds_list_create());
	var newFieldMapTypeList = ds_list_create();
	if (!obj_control.selectFieldChunk) {
		scr_addToListOnce(newFieldMapTypeList, "token");
	}
	scr_addToListOnce(newFieldMapTypeList, "chunk");
	ds_map_add_list(newFieldMap, "targetList", newFieldMapTypeList);
	
	// add our new field's submap to the tagMap
	var tagMap = global.nodeMap[? "tokenTagMap"];
	ds_map_add_map(tagMap, newField, newFieldMap);
	
	
	scr_addNewFieldToNodes("token", newField);
	
	


}
