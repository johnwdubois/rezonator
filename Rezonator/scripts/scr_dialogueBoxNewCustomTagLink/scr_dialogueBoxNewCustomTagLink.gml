function scr_dialogueBoxNewCustomTagLink() {
	
	show_debug_message("scr_dialogueBoxNewCustomTagLink ... tokenFieldToChange: "+ string(obj_control.tokenFieldToChange));
	
	// get submap for this field
	var linkTagMap = global.nodeMap[? "linkTagMap"];
	var fieldSubMap = linkTagMap[? obj_control.tokenFieldToChange];
	if (!scr_isNumericAndExists(fieldSubMap, ds_type_map)) {
		show_debug_message("scr_dialogueBoxNewCustomTagLink ... fieldSubMap does not exist");
		exit;
	}
	
	// get the tagset for this field
	var tagSet = fieldSubMap[? "tagSet"];
	if (!scr_isNumericAndExists(tagSet, ds_type_list)) {
		show_debug_message("scr_dialogueBoxNewCustomTagLink ... tagSet does not exist");
		exit;
	}
	
	// add new tag to this field's tagSet
	scr_addToListOnce(tagSet, obj_control.inputText);
	
}
