with (obj_fpsTracker) {
	scr_fpsTrackerFile();
}

scr_userSettingsIniFile();



if (!allSaved and ds_grid_height(obj_control.unitGrid) >= global.totalUnitAmount) {
	if (show_question("Would you like to save before exiting?")) {
		with (obj_fileLoader) {
			scr_saveREZ(false);
		}
	}
}