function scr_mapDeepDestroy(map) {
	
	// clears map, and also destroys and data structures that were in the map
	while (ds_map_size(map) > 0) {
		var key = ds_map_find_first(map);
		if (ds_map_is_list(map, key)) {
			ds_list_destroy(map[? key]);
		}
		else if (ds_map_is_map(map, key)) {
			ds_map_destroy(map[? key]);
		}
		ds_map_delete(map, key);
	}
	ds_map_destroy(map);

}