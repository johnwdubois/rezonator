function scr_tokenMarkerOptions(optionSelected) {

	if (optionSelected == "option_create-new-field") {

		// prompt user for name of new token field/marker

		obj_control.newCustomFieldToken = true;
		obj_control.dialogueBoxActive = true;

		if (!instance_exists(obj_dialogueBox)) {
			instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
		}
		obj_dialogueBox.inputWindowActive = true;
	
	}
	else if (optionSelected == "option_add-to-tag-set") {
		scr_tokenTagMapOptions("option_add-to-tag-set");
	}
	else if (optionSelected == "Set as Transcription") {
		
		show_debug_message("scr_tokenMarkerOptions ... Set Transcription")
		global.tokenImportTranscriptColName = ds_list_find_value(global.tokenImportColNameList, obj_control.tokenImportColToChange);
		
	
	}
	else if (optionSelected == "Remove Column") {
		
	}
	else if (optionSelected == "Add Column") {
		
	}

}
