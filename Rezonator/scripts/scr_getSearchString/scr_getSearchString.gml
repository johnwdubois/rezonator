function scr_getSearchString(list, reversed) {
	// Convert the data of a list into a readable string format
	if (!is_numeric(list)) return "non-numeric list";
	if (!ds_exists(list, ds_type_list)) return "list does not exist: " + string(list);
	
	var str = "";
	if (!ds_list_empty(list)) {
		var listSize = ds_list_size(list);
		
		if (reversed) {
			for (var i = listSize; i > 0; i--) {
				str += string(ds_list_find_value(list, i-1));
	
				if (i > 1) {
					str += " ";
				}
			}
		}
		else{
			for (var i = 0; i < listSize; i++) {
				str += string(ds_list_find_value(list, i));
	
				if (i < listSize) {
					str += " ";
				}
			}
		}
		
	}

	return str;


}
