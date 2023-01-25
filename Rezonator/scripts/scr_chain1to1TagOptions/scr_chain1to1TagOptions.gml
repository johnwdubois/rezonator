function scr_chain1To1TagOptions(optionSelected) {
	
	// check if user is clearing tag
	var clearTag = (optionSelected == "menu_clear");
	
	// check to see if the user is trying to create a new tag
	if (optionSelected == "option_add-to-tag-set") {
		obj_control.newCustomTagChain = true;
		obj_control.dialogueBoxActive = true;

		if (!instance_exists(obj_dialogueBox)) {
			instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
		}
		obj_dialogueBox.inputWindowActive = true;
		exit;
	}
	
	// make sure chain exists in nodeMap and get its submap
	var chainToChange = obj_control.chain1to1ChainToChange;
	var fieldToChange = obj_control.chain1to1FieldToChange;
	show_debug_message("scr_chain1To1TagOptions() ... changing entry: " + string(chainToChange) + " field: " + string(fieldToChange) + " to option: " + string(optionSelected));
	var chainSubMap = ds_map_find_value(global.nodeMap, chainToChange);
	if (!scr_isNumericAndExists(chainSubMap, ds_type_map)) exit;
	
	// get this chain's tagmap
	var chainTagMap = ds_map_find_value(chainSubMap, "tagMap");
	if (!scr_isNumericAndExists(chainTagMap, ds_type_map)) exit;
	
	if (optionSelected == "option-remove-tag-set") {
		// if user selected "Remove from tag set" then we delete the tag from this chain's tagmap
		ds_map_delete(chainTagMap, fieldToChange);
	}
	else {
		var fieldSubMap = global.chainFieldMap[?fieldToChange];
		var readOnly =  fieldSubMap[? "readOnly"];
		if (readOnly) exit;
		// set the selected tag in this chain's tagmap
		var newTagValue = clearTag ? "" : optionSelected;
		scr_setMap(chainTagMap, fieldToChange, newTagValue);
		if (!clearTag) {
			with (obj_panelPane) {
				functionField_chainTagSelected = newTagValue;
				functionField_chainFieldSelected = fieldToChange;
			}
		}
	}
	
	if (obj_control.chain1toManyCustomSortColIndex != -1) obj_control.refreshCustomSort = true;
	

}