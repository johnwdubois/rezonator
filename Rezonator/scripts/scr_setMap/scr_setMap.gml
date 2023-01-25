

function scr_setMap(map, key, value) {
	
	// if the key is not in the map, add it with the given value
	// if the key is already in the map, replace its value with the new value
	if (ds_map_exists(map, key)) {
		ds_map_replace(map, key, value);
	}
	else {
		ds_map_add(map, key, value);
	}
}