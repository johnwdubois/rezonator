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
	
}
