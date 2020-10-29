function scr_unitMarkerOptions() {
	var optionSelected = argument[0];

	if (optionSelected == "Create Field") {

		// prompt user for name of new unit field/marker

		obj_control.newCustomFieldUnit = true;
		obj_control.dialogueBoxActive = true;

		if (!instance_exists(obj_dialogueBox)) {
			instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
		}
	
	}
	else if (optionSelected == "Add new Tag") {
		scr_unitTagMapOptions("Add new Tag");
	}
	else if(optionSelected == "Set as Translation"){
		global.unitImportTranslationColName = ds_list_find_value(global.tokenImportColNameList, obj_control.unitImportColToChange);
	}


}
