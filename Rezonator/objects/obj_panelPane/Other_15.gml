/// @description Seek Audio

if (currentFunction == functionAudio and file_exists(string(functionAudio_filename))) {
	aviz_seek(functionAudio_ogg, functionAudio_seekTo);
	functionAudio_lastSample = functionAudio_seekTo;
}