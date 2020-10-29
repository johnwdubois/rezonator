with (obj_control) {
	if (ds_grid_height(unitGrid) < 1) {
		show_message(scr_get_translation("msg_warning_import_error"));
		audio_stop_all();
		room_goto(rm_openingScreen);
	}
	else {
		initialValidFileCheck = true;
	}
}