

function scr_dialogueBoxNewCustomTagChain(){
	
	// get field and make sure it exists
	var fieldToChange = obj_control.chain1to1FieldToChange;
	var fieldSubMap = global.chainFieldMap[? fieldToChange];
	if (!scr_isNumericAndExists(fieldSubMap, ds_type_map)) exit;
	var newTag = string(obj_control.inputText);
	if (!is_string(newTag) || string_length(string(newTag)) < 1) {
		show_debug_message("new tag is invalid or blank string, exiting...");
		exit;
	}
	
	show_debug_message("scr_dialogueBoxNewCustomTagChain() ... fieldToChange: " + string(fieldToChange) + ", newTag: " + string(newTag));
	
	// get this field's tag set and make sure it exists
	var tagSet = ds_map_find_value(fieldSubMap, "tagSet");
	if (!scr_isNumericAndExists(tagSet, ds_type_list)) exit;
	
	// add the new tag to the tagSet
	scr_addToListOnce(tagSet, newTag);

	//add this to selected chain if not in tag pane
	if(obj_panelPane.functionChainList_currentTab != obj_panelPane.functionChainList_tabField){
		// get the chainToChange's submap, and that chain's tagmap
		var chainSubMap = global.nodeMap[? obj_control.chain1to1ChainToChange];
		if(scr_isNumericAndExists(chainSubMap, ds_type_map)){
			var chainTagMap = chainSubMap[? "tagMap"];
			// set the new value in this chain's tagmap
			chainTagMap[? obj_control.chain1to1FieldToChange] = newTag;
		}
		obj_control.chain1to1ChainToChange = "";
	}
	
}