with (obj_fpsTracker) {
	scr_fpsTrackerFile();
}

scr_userSettingsIniFile();



if (!allSaved and ds_grid_height(obj_control.unitGrid) >= global.totalUnitAmount) {

/*
		while(obj_dialogueBox.questionWindowActive){

			obj_dialogueBox.questionWindowActive = true;
			if (!instance_exists(obj_dialogueBox)) {
				instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
			}

		}
*/		
	if (os_type == os_macosx) {

		with (obj_fileLoader) {
			scr_saveREZ(false);
		}
		
	}
	else {
		if (show_question("Would you like to save before exiting?")) {
			with (obj_fileLoader) {
				scr_saveREZ(false);
			}
		}
	}
		
}