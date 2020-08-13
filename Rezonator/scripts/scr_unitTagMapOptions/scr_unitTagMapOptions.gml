var optionSelected = argument[0];

if (optionSelected == "Add new Tag") {


	obj_control.newCustomTagUnit = true;
	obj_control.dialogueBoxActive = true;

	if (!instance_exists(obj_dialogueBox)) {
		instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
	}
	
}
else {
	ds_grid_set(global.unitImportGrid, obj_control.unitImportColToChange, obj_control.unitImportRowToChange, optionSelected);
}

if (obj_control.unitView == obj_panelPane.selectedColUnit) {
	scr_toggleUnitMulti(global.unitImportGrid, obj_control.unitImportColToChange);
}