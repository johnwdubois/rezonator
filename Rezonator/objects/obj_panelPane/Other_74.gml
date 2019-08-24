if (currentFunction == functionAudio and file_exists(string(functionAudio_filename))) {
	
	if (async_load[? "queue_id"] == functionAudio_audio) {
		var buff = async_load[? "buffer_id"];
		if (ds_map_exists(functionAudio_bufferMap, buff)) {
			functionAudio_lastSample = functionAudio_bufferMap[? buff];
		}
	}
}