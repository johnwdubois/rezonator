function scr_getStringOfList(list) {
	// Convert the data of a list into a readable string format
	if (!is_numeric(list)) return "non-numeric list";
	if (!ds_exists(list, ds_type_list)) return "list does not exist: " + string(list);
	
	var str = "[";

	if (!ds_list_empty(list)) {
		var listSize = ds_list_size(list);
		var listSizeMax = 90;
	
		for (var i = 0; i < min(listSizeMax, listSize); i++) {
			if (scr_isNumericAndExists(list[|i], ds_type_list) && ds_list_is_list(list, i)) {
				str += scr_getStringOfList(list[|i]);	
			}
			else{
				str += string(ds_list_find_value(list, i));
			}
			if (i < listSize - 1) {
				str += ", ";
			}
		}

	}

	str += "]";

	return str;


}
