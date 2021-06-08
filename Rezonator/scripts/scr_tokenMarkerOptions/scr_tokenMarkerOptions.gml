function scr_tokenMarkerOptions(optionSelected) {

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
	else if(optionSelected == "Set as Transcription"){
		
		show_debug_message("scr_tokenMarkerOptions ... Set Transcription")
		global.tokenImportTranscriptColName = ds_list_find_value(global.tokenImportColNameList, obj_control.tokenImportColToChange);
		ds_grid_set_grid_region(obj_control.wordGrid, global.tokenImportGrid, obj_control.tokenImportColToChange, 0 , obj_control.tokenImportColToChange, ds_grid_height(global.tokenImportGrid), obj_control.wordGrid_colWordTranscript, 0);
	
	}

}
