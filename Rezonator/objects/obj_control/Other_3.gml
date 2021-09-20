with (obj_fpsTracker) {
	scr_fpsTrackerFile();
}


scr_saveINI();



if (!allSaved) {

	
	if (os_type == os_macosx) {
		with (obj_fileLoader) {
			scr_saveREZ(false);
		}
	}
	/*
	else {
		if (show_question(scr_get_translation("msg_warning_save-prompt"))) {
			with (obj_fileLoader) {
				scr_saveREZ(false);
			}
		}
	}
	*/
		
}