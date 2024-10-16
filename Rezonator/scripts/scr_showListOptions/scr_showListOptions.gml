function scr_showListOptions(optionSelected) {
	
	var selectedShow = obj_control.selectedChainID;
	var selectedShowSubMap = global.nodeMap[? selectedShow];
	if (!scr_isNumericAndExists(selectedShowSubMap, ds_type_map)) {
		show_debug_message("scr_showListOptions, show does not exist");
		exit;
	}
	
	switch (optionSelected) {
	case "help_label_rename":

		if (!obj_control.dialogueBoxActive) {
			keyboard_string = "";
			obj_control.rename = true;
			global.inputBoxDefStr = string(selectedShowSubMap[? "name"]);
		}

		obj_control.dialogueBoxActive = true;

		if (!instance_exists(obj_dialogueBox)) {
			instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
		}
		obj_dialogueBox.inputWindowActive = true;
		instance_destroy(obj_dropDown);
					
		break;
	case "help_label_delete_plain":

						
		if (!instance_exists(obj_dialogueBox)) {
			instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
			obj_dialogueBox.clearShow = true;
			obj_dialogueBox.questionWindowActive = true;
		}
		
		instance_destroy(obj_dropDown);

		break;
					
	}
					
}