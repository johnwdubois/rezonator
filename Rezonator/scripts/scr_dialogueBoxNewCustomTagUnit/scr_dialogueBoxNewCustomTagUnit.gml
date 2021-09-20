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

	//add this to selected unit if not in tag pane
	if(obj_panelPane.functionChainList_currentTab != obj_panelPane.functionChainList_tabField){
		// get the unitToChange's submap, and that unit's tagmap
		var unitSubMap = global.nodeMap[? obj_control.unitToChange];
		if(scr_isNumericAndExists(unitSubMap, ds_type_map)){
			var unitTagMap = unitSubMap[? "tagMap"];
			// set the new value in this unit's tagmap
			unitTagMap[? obj_control.unitFieldToChange] = obj_control.inputText;
		}
		obj_control.unitToChange = "";
	}
}
