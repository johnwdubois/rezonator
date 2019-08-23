/// @description Stop Audio

if (currentFunction == functionAudio and file_exists(string(functionAudio_filename))) {
	audio_stop_sound(functionAudio_audio);
	functionAudio_isPlaying = false;
	functionAudio_isPaused = false;
}