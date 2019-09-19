with (obj_control) {
	if (ds_grid_height(unitGrid) < 1) {
		show_message("Error in importing file.");
		audio_stop_all();
		room_goto(rm_openingScreen);
	}
	else {
		initialValidFileCheck = true;
	}
}