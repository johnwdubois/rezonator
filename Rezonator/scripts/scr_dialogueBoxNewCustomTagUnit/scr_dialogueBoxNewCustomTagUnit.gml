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
	
	var newTag = string(obj_control.inputText);
	if (!is_string(newTag) || string_length(string(newTag)) < 1) {
		show_debug_message("new tag is invalid or blank string, exiting...");
		exit;
	}
	
	// add new tag to this field's tagSet
	scr_addToListOnce(tagSet, newTag);

	//add this to selected unit if not in tag pane
	if(obj_panelPane.functionChainList_currentTab != obj_panelPane.functionChainList_tabField){
		// get the unitToChange's submap, and that unit's tagmap
		var unitSubMap = global.nodeMap[? obj_control.unitToChange];
		if(scr_isNumericAndExists(unitSubMap, ds_type_map)){
			var unitTagMap = unitSubMap[? "tagMap"];
			// set the new value in this unit's tagmap
			unitTagMap[? obj_control.unitFieldToChange] = newTag;
		}
		obj_control.unitToChange = "";
	}
}
