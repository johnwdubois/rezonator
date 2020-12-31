function scr_dialogueBoxNewCustomTagToken() {
	var mapKey = ds_list_find_value(global.tokenImportColNameList, obj_control.tokenImportColToChange);
	var tempList = ds_map_find_value(global.tokenImportTagMap, mapKey);
	if (is_numeric(tempList)) {
		if (ds_exists(tempList, ds_type_list)) {
			ds_list_add(tempList, obj_control.inputText);
		}
	}


}
