function scr_loadListFromMap(map, key, list) {
	
	// get list, if supplied
	var listFromMap = map[? key];
	show_debug_message("scr_loadListFromMap, listFromMap: " + scr_getStringOfList(listFromMap));
	if (scr_isNumericAndExists(listFromMap, ds_type_list)) {
		// if we found the list in the map, let's destroy the list that was passed in here
		if (scr_isNumericAndExists(list, ds_type_list)) {
			ds_list_destroy(list);
		}
		return listFromMap;
	}
	else if (!scr_isNumericAndExists(list, ds_type_list)) {
		// if we can't find the list in the map, and the list passed in didn't exist either
		// we will just create a new list here
		list = ds_list_create();
	}
	
	return list;

}