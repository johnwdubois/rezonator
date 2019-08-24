/// @description Audio Tick

if (currentFunction == functionAudio and file_exists(string(functionAudio_filename))) {
	var buff = buffer_create(functionAudio_buffSize, buffer_fixed, 1);
	var renderedSample = aviz_tick(functionAudio_ogg, buffer_get_address(buff), 0, functionAudio_tickSize);
	
	if (renderedSample < 0) {
		buffer_delete(buff);
		exit;
	}

	audio_queue_sound(functionAudio_audio, buff, 0, functionAudio_buffSize);
	ds_map_add(functionAudio_bufferMap, buff, renderedSample);
}