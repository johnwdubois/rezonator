var optionSelected = argument[0];

if (optionSelected == "Add new Tag"){


	obj_control.newCustomTagToken = true;
	obj_control.dialogueBoxActive = true;

	if (!instance_exists(obj_dialogueBox)) {
		instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
	}
	
}
else {
	ds_grid_set(global.tokenImportGrid, obj_control.tokenImportColToChange, obj_control.tokenImportRowToChange, optionSelected);
}

if (obj_control.wordView == obj_panelPane.selectedColToken) {
	scr_toggleTranscriptionMulti(global.tokenImportGrid, obj_control.tokenImportColToChange);
}