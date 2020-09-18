function scr_tokenMarkerOptions() {
	var optionSelected = argument[0];

	if (optionSelected == "Create Field") {

		// prompt user for name of new token field/marker

		obj_control.newCustomFieldToken = true;
		obj_control.dialogueBoxActive = true;

		if (!instance_exists(obj_dialogueBox)) {
			instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
		}
	
	}
	else if (optionSelected == "Add new Tag") {
		scr_tokenTagMapOptions("Add new Tag");
	}


}
