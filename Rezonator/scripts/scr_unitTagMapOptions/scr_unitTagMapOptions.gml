function scr_unitTagMapOptions(optionSelected) {
	
	with(obj_inputBox) {
		show_debug_message("destroying input box from unit dd select");
		instance_destroy();
	}
	
	// check if user is clearing tag
	var clearTag = (optionSelected == "menu_clear");

	if (optionSelected == "option_add-to-tag-set") {


		obj_control.newCustomTagUnit = true;
		obj_control.dialogueBoxActive = true;

		if (!instance_exists(obj_dialogueBox)) {
			instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
		}
		obj_dialogueBox.inputWindowActive = true;
	
	}
	else {
		
		show_debug_message("unitToChange:  " +  string(obj_control.unitToChange));
		// get the tokenToChange's submap, and that token's tagmap
		var unitSubMap = global.nodeMap[? obj_control.unitToChange];
		if (scr_isNumericAndExists(unitSubMap,ds_type_map)) {
			var unitTagMap = unitSubMap[? "tagMap"];
			show_debug_message("unitFieldToChange:  " +  string(obj_control.unitFieldToChange));
			// set the new value in this token's tagmap
			var newTagValue = clearTag ? "" : optionSelected;
			unitTagMap[? obj_control.unitFieldToChange] = newTagValue;
		}
		
		if (!clearTag) {
			with(obj_panelPane) {
				functionField_unitTagSelected = optionSelected;
				functionField_unitFieldSelected = obj_control.unitFieldToChange;
			}
		}
		
		obj_control.unitFieldToChange = "";
		obj_control.unitToChange = "";

	}
	with(obj_dropDown) {
		instance_destroy();
	}

}
