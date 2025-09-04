function scr_getKeyListFromMap(map){
	
	// loop through map and collect every key within it, adding each one to a list
	var list = ds_list_create();
	var key = ds_map_find_first(map);
	while (!is_undefined(key)) {
		ds_list_add(list, key);
		key = ds_map_find_next(map, key);
	}
	
	return list;

}