

function scr_dialogueBoxNewCustomTagEntry() {
	
	// get field and make sure it exists
	var fieldToChange = obj_control.chain1toManyFieldToChange;
	var fieldSubMap = global.entryFieldMap[? fieldToChange];
	if (!scr_isNumericAndExists(fieldSubMap, ds_type_map)) exit;
	var newTag = string(obj_control.inputText);
	if (!is_string(newTag) || string_length(string(newTag)) < 1) {
		show_debug_message("new tag is invalid or blank string, exiting...");
		exit;
	}
	
	show_debug_message("scr_dialogueBoxNewCustomTagEntry() ... fieldToChange: " + string(fieldToChange) + ", newTag: " + string(newTag));
	
	// get this field's tag set and make sure it exists
	var tagSet = fieldSubMap[? "tagSet"];
	if (!scr_isNumericAndExists(tagSet, ds_type_list)) exit;
	
	// add the new tag to the tagSet
	scr_addToListOnce(tagSet, newTag);
	scr_sortList(tagSet);
	
		//add this to selected entry if not in tag pane
	if (obj_panelPane.functionChainList_currentTab != NAVTAB_TAG) {
		// get the entryToChange's submap, and that entry's tagmap
		var entrySubMap = global.nodeMap[? obj_control.chain1toManyEntryToChange];
		if (scr_isNumericAndExists(entrySubMap, ds_type_map)) {
			var entryTagMap = entrySubMap[? "tagMap"];
			// set the new value in this entry's tagmap
			entryTagMap[? obj_control.chain1toManyFieldToChange] = newTag;
		}
		obj_control.chain1toManyEntryToChange = "";
	}
}