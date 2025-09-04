function scr_importAudio(_audioFilename){
	
	show_debug_message("scr_importAudio: " + string(_audioFilename));
	
	with (obj_audioUI) {
		audio_stop_all();
		audioStream = -1;
		audioSound = -1;
		audioLength = 0;
		audioPos = 0;
		audioPaused = true;
				
		if (global.steamAPI) {
			if (!steam_get_achievement("SA_play-audio")) {
				steam_set_achievement("SA_play-audio");
			}
		}
		audioFile = _audioFilename;
		global.previousAudioDirectory = filename_path(audioFile);
		audioStream = audio_create_stream(audioFile);
		audioSound = audio_play_sound(audioStream, 100, false);
		visible = true;
	}

}