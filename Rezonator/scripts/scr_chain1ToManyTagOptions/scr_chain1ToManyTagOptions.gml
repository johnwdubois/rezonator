

function scr_chain1ToManyTagOptions(optionSelected){
	
	// check to see if the user is trying to create a new tag
	if (optionSelected == "option_add-to-tag-set") {
		obj_control.newCustomTagEntry = true;
		obj_control.dialogueBoxActive = true;

		if (!instance_exists(obj_dialogueBox)) {
			instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
		}
		obj_dialogueBox.inputWindowActive = true;
		exit;
	}
	
	// check if user is clearing tag
	var clearTag = (optionSelected == "menu_clear");
	
	// make sure entry exists in nodeMap and get its submap
	var entryToChange = obj_control.chain1toManyEntryToChange;
	var fieldToChange = obj_control.chain1toManyFieldToChange;
	show_debug_message("scr_chain1ToManyTagOptions() ... changing entry: " + string(entryToChange) + " field: " + string(fieldToChange) + " to option: " + string(optionSelected));
	var entrySubMap = ds_map_find_value(global.nodeMap, entryToChange);
	if (!scr_isNumericAndExists(entrySubMap, ds_type_map)) exit;
	
	// get this entry's tagmap
	var entryTagMap = ds_map_find_value(entrySubMap, "tagMap");
	if (!scr_isNumericAndExists(entryTagMap, ds_type_map)) exit;
	
	if (optionSelected == "option-remove-tag-set") {
		// if user selected "Remove from tag set" then we delete the tag from this entry's tagmap
		ds_map_delete(entryTagMap, fieldToChange);
	}
	else {
		// set the selected tag in this entry's tagmap
		var newTagValue = clearTag ? "" : optionSelected;
		scr_setMap(entryTagMap, fieldToChange, newTagValue);
		if (!clearTag) {
			with(obj_panelPane){
				functionField_entryTagSelected = optionSelected;
				functionField_entryFieldSelected = fieldToChange;
			}
		}
	}
	
	if (obj_control.chain1toManyCustomSortColIndex != -1) obj_control.refreshCustomSort = true;
	
}