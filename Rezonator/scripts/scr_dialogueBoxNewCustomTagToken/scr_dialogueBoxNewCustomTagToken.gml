function scr_dialogueBoxNewCustomTagToken() {
	
	show_debug_message("scr_dialogueBoxNewCustomTagToken ... tokenFieldToChange: "+ string(obj_control.tokenFieldToChange));
	
	// get submap for this field
	var tokenTagMap = global.nodeMap[? "tokenTagMap"];
	var fieldSubMap = tokenTagMap[? obj_control.tokenFieldToChange];
	if (!scr_isNumericAndExists(fieldSubMap, ds_type_map)) {
		show_debug_message("scr_dialogueBoxNewCustomTagToken ... fieldSubMap does not exist");
		exit;
	}
	
	// get the tagset for this field
	var tagSet = fieldSubMap[? "tagSet"];
	if (!scr_isNumericAndExists(tagSet, ds_type_list)) {
		show_debug_message("scr_dialogueBoxNewCustomTagToken ... tagSet does not exist");
		exit;
	}
	
	// add new tag to this field's tagSet
	scr_addToListOnce(tagSet, obj_control.inputText);
	
}
