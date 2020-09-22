if (obj_control.gridView) {
	audioPaused = true;
}

windowWidth = camera_get_view_width(camera_get_active()) - global.scrollBarWidth;
x = 0;
y = camera_get_view_height(camera_get_active()) - windowHeight;


if (keyboard_check(vk_alt) and keyboard_check(vk_shift) and keyboard_check_pressed(ord("A"))) {
	var getAudioFile = get_open_filename_ext("ogg file|*.ogg", "", working_directory, "Open a discourse ogg OGG file");
	if (getAudioFile != "" and file_exists(getAudioFile)) {
		audioFile = getAudioFile;
		audioStream = audio_create_stream(audioFile);
		audioSound = audio_play_sound(audioStream, 100, false);
		visible = true;
	}
}


if (visible and file_exists(audioFile) and audioSound != -1) {
	scr_audioStep();
}