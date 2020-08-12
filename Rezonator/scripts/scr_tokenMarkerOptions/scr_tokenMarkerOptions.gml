var optionSelected = argument[0];

if (optionSelected == "Create Field") {

	// prompt user for name of new token marker

	obj_control.newCustomField = true;
	obj_control.dialogueBoxActive = true;

	if (!instance_exists(obj_dialogueBox)) {
		instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
	}
	
}