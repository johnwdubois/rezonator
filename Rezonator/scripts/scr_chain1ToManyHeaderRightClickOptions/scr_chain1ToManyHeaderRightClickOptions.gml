

function scr_chain1ToManyHeaderRightClickOptions(optionSelected) {
	
	switch (optionSelected) {
		case "option_create-new-field":
			
			obj_control.newCustomFieldEntry = true;
			obj_control.dialogueBoxActive = true;

			if (!instance_exists(obj_dialogueBox)) {
				instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
			}
			obj_dialogueBox.inputWindowActive = true;
			exit;

			break;
		default:
			break;
	}
	
}