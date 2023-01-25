function scr_dialogueBoxNewCustomTagLink() {
	
	show_debug_message("scr_dialogueBoxNewCustomTagLink ... tokenFieldToChange: "+ string(obj_control.tokenFieldToChange));
	
	// get submap for this field
	var linkTagMap = global.nodeMap[? "linkTagMap"];
	var fieldSubMap = linkTagMap[? obj_control.tokenFieldToChange];
	if (!scr_isNumericAndExists(fieldSubMap, ds_type_map)) {
		show_debug_message("scr_dialogueBoxNewCustomTagLink ... fieldSubMap does not exist");
		exit;
	}
	var newTag = string(obj_control.inputText);
	if (!is_string(newTag) || string_length(string(newTag)) < 1) {
		show_debug_message("new tag is invalid or blank string, exiting...");
		exit;
	}
	
	// get the tagset for this field
	var tagSet = fieldSubMap[? "tagSet"];
	if (!scr_isNumericAndExists(tagSet, ds_type_list)) {
		show_debug_message("scr_dialogueBoxNewCustomTagLink ... tagSet does not exist");
		exit;
	}
	
	// add new tag to this field's tagSet
	scr_addToListOnce(tagSet, newTag);
	scr_sortList(tagSet);
	
	
	//add this to selected unit if not in tag pane
	if (obj_panelPane.functionChainList_currentTab != obj_panelPane.functionChainList_tabField) {
		// get the unitToChange's submap, and that unit's tagmap
		var linkSubMap = global.treeMap[? obj_panelPane.functionTree_treeLinkSelected];
		if (scr_isNumericAndExists(linkSubMap, ds_type_map)) {
			var linkTagMap = linkSubMap[? "tagMap"];
			// set the new value in this unit's tagmap
			linkTagMap[? obj_control.tokenFieldToChange] = newTag;
		}
		with(obj_panelPane) { functionTree_treeLinkSelected = ""; }
		with(obj_panelPane) {
			functionField_linkFieldSelected = obj_control.tokenFieldToChange;
			functionField_linkTagSelected = newTag;
		}
		
	}
	
}
