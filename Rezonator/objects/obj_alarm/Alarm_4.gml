with (obj_control) {
	if (ds_grid_height(unitGrid) < 1) {
		show_debug_message(scr_get_translation("msg_warning_import_error"));
		audio_stop_all();
		show_debug_message("Going to openingScreen, obj_alarm Alarm 4");
		room_goto(rm_openingScreen);
	}
	else {
		initialValidFileCheck = true;
	}
}