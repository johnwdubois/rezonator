function scr_dialogueBoxNewCustomTagUnit() {
	
	// get submap for this field
	var unitTagMap = global.nodeMap[? "unitTagMap"];
	var fieldSubMap = unitTagMap[? obj_control.unitFieldToChange];
	
	// get the tagset for this field
	var tagSet = fieldSubMap[? "tagSet"];
	if (!scr_isNumericAndExists(tagSet, ds_type_list)) {
		show_debug_message("scr_dialogueBoxNewCustomTagUnit ... tagSet does not exist");
		exit;
	}
	
	// add new tag to this field's tagSet
	scr_addToListOnce(tagSet, obj_control.inputText);


}
