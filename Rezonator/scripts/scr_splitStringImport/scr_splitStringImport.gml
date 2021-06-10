function scr_splitStringImport(str) {
	/*
	var listUntrimmed = scr_splitString(str, " ");
	var listTrimmed = ds_list_create();
	
	var listUntrimmedSize = ds_list_size(listUntrimmed);
	for (var j = 0; j < listUntrimmedSize; j++) {
		if (global.importType != global.importType_CSV) {
			if (string_length(string(ds_list_find_value(listUntrimmed, j))) > 0) {
				ds_list_add(listTrimmed, string(ds_list_find_value(listUntrimmed, j)));
			}
		}
		else {
			ds_list_add(listTrimmed, string(ds_list_find_value(listUntrimmed, j)));
		}
	}
	
	ds_list_destroy(listUntrimmed);

show_debug_message(scr_getStringOfList(listTrimmed) + string(current_time));
	return listTrimmed;
	*/
	
	var list = ds_list_create();
	

	var partIndex = 1;
	var firstCopyComplete = false;
	
	var strLen = string_length(str);
	for (var i = 1; i <= strLen; i++) {
		if (string_char_at(str, i) == " " && i - partIndex > 0) {
			ds_list_add(list, string_copy(str, firstCopyComplete ? partIndex + 1 : partIndex, firstCopyComplete ? i - partIndex - 1 : i - partIndex));
			partIndex = i;
			firstCopyComplete = true;
		}
	}
	if (partIndex < strLen) {
		ds_list_add(list, string_copy(str, partIndex, strLen - partIndex));
	}
	
	//show_debug_message("scr_splitStringImport: " + scr_getStringOfList(list));
	
	return list;
	


}
