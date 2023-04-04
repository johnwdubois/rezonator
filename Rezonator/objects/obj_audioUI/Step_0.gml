if (obj_control.gridView) {
	audioPaused = true;
}

audioFileExists = file_exists(audioFile);

windowWidth = camera_get_view_width(camera_get_active()) - global.scrollBarWidth;
x = 0;
y = camera_get_view_height(camera_get_active()) - windowHeight;


if (keyboard_check(vk_alt) and keyboard_check(vk_shift) and keyboard_check_pressed(ord("A"))) {
	var fileFolder = (directory_exists(string(global.previousAudioDirectory)) && global.previousAudioDirectory != "") ? global.previousAudioDirectory : working_directory;
	var getAudioFile = get_open_filename_ext("ogg file|*.ogg", "", fileFolder, scr_get_translation("msg_file_audio"));
	if (getAudioFile != "" and file_exists(getAudioFile)) {
		if (STEAMAPI) {
			if (!steam_get_achievement("SA_play-audio")) {
				steam_set_achievement("SA_play-audio");
			}
		}
		audioFile = getAudioFile;
		global.previousAudioDirectory = filename_path(audioFile);
		audioStream = audio_create_stream(audioFile);
		audioSound = audio_play_sound(audioStream, 100, false);
		visible = true;
	}
}


if (visible and file_exists(audioFile) and audioSound != -1) {
	scr_audioStep();
	
}