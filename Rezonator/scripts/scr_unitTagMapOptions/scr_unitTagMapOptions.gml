function scr_unitTagMapOptions() {
	var optionSelected = argument[0];

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
		if(scr_isNumericAndExists(unitSubMap,ds_type_map)){
			var unitTagMap = unitSubMap[? "tagMap"];
			show_debug_message("unitFieldToChange:  " +  string(obj_control.unitFieldToChange));
			// set the new value in this token's tagmap
			unitTagMap[? obj_control.unitFieldToChange] = optionSelected;
		}
		
		with(obj_panelPane){
			functionField_unitTagSelected = optionSelected;
			functionField_unitFieldSelected = obj_control.unitFieldToChange;
		}
		
		obj_control.unitFieldToChange = "";
		obj_control.unitToChange = "";

	}
	with(obj_dropDown){
		instance_destroy();
	}

}
