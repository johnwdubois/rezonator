/// @description Play Audio

if (currentFunction == functionAudio and file_exists(string(functionAudio_filename))) {
	audio_play_sound(functionAudio_audio, 0, 0);
	functionAudio_isPlaying = true;
	functionAudio_isPaused = false;
}