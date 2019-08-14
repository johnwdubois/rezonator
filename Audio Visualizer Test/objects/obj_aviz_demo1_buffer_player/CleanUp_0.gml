event_user(EVENT_STOP);
aviz_destroy(ogg);
audio_free_play_queue(audio);

// free up all the buffers that may be left unplayed
for(var buff=ds_map_find_first(buffer_map); not is_undefined(buff); buff=ds_map_find_next(buffer_map, buff)) { 
	if (buffer_exists(buff)) {
		buffer_delete(buff);	
	}
}
ds_map_destroy(buffer_map);