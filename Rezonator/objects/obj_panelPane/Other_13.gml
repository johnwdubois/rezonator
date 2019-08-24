/// @description Pause Audio

if (currentFunction == functionAudio and file_exists(string(functionAudio_filename))) {
	audio_pause_sound(functionAudio_audio);
	functionAudio_isPaused = true;
	functionAudio_isPlaying = false;
}