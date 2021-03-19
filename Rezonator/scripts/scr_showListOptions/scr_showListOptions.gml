function scr_showListOptions(optionSelected){
	
	switch (optionSelected) {
	case "Rename":

		if (!obj_control.dialogueBoxActive) {
			keyboard_string = "";
			obj_control.rename = true;
		}

		obj_control.dialogueBoxActive = true;

		if (!instance_exists(obj_dialogueBox)) {
			instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
		}
		instance_destroy(obj_dropDown);
					
		break;
	case "Delete":

						
		if (!instance_exists(obj_dialogueBox)) {
			instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
			obj_dialogueBox.clearShow = true;
			obj_dialogueBox.questionWindowActive = true;
		}
		
		instance_destroy(obj_dropDown);

		break;
					
	}
					
}