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
		
		// get the unitToChange's submap, and that unit's tagmap
		var unitSubMap = global.nodeMap[? obj_control.unitToChange];
		var unitTagMap = unitSubMap[? "tagMap"];
		
		// set the new value in this unit's tagmap
		unitTagMap[? obj_control.unitFieldToChange] = optionSelected;
		
	}


}
