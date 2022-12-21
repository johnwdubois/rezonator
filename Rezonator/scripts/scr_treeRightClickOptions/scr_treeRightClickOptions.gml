

function scr_treeRightClickOptions(optionSelected){
	
	var selectedTree = obj_panelPane.functionTree_treeSelected;
	var selectedTreeSubMap = global.treeMap[? selectedTree];
	
	if (optionSelected == "help_label_rename") {
		
		
		if (!obj_control.dialogueBoxActive) {
			keyboard_string = "";
			obj_control.renameTree = true;
			global.inputBoxDefStr = string(selectedTreeSubMap[? "name"]);
			show_debug_message("global.inputBoxDefStr: " + string(global.inputBoxDefStr));
		}
		obj_control.dialogueBoxActive = true;

		if (!instance_exists(obj_dialogueBox)) {
			instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
		}
		obj_dialogueBox.inputWindowActive = true;
		with (obj_dropDown) instance_destroy();
		
	}
	else if (optionSelected == "help_label_delete_plain") {
		
		if (!instance_exists(obj_dialogueBox)) {
			instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
			obj_dialogueBox.removeTree = true
			obj_dialogueBox.questionWindowActive = true;
			obj_dialogueBox.stringToBeRemoved = selectedTree;
		}
		with (obj_dropDown) instance_destroy();
		
	}

}