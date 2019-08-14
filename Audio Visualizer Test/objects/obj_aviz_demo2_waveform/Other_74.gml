if (async_load[? "queue_id"] == audio) {
	// which buffer was just played?
	var buff = async_load[? "buffer_id"];
	
	// check which sample that was
	if (ds_map_exists(buffer_map, buff)) {
		last_sample = buffer_map[? buff];
	}
}