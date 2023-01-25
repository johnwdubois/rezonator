function scr_loadListFromMap(map, key, list) {
	
	// get list, if supplied
	var listFromMap = map[? key];
	show_debug_message("scr_loadListFromMap, listFromMap: " + scr_getStringOfList(listFromMap));
	if (scr_isNumericAndExists(listFromMap, ds_type_list)) {
		if (scr_isNumericAndExists(list, ds_type_list)) {
			ds_list_destroy(list);
		}
		return listFromMap;
	}
	return list;

}