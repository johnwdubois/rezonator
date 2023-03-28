function scr_iniOverwriteList(map, key, list){
	
	// create a new list, and if list exists, copy from list
	var tempList = ds_list_create();
	if (scr_isNumericAndExists(list, ds_type_list)) {
		ds_list_copy(tempList, list);
	}
	
	// add/replace the new list to the map
	if (ds_map_exists(map, key)) {
		ds_map_replace_list(map, key, tempList);
	}
	else {
		ds_map_add_list(map, key, tempList);
	}

}