/// @description Resume Audio

if (currentFunction == functionAudio and file_exists(string(functionAudio_filename))) {
	audio_resume_sound(functionAudio_audio);
	functionAudio_isPaused = false;
	functionAudio_isPlaying = true;
}