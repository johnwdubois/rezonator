function scr_dialogueBoxNewCustomTagUnit() {
	
	var mapKey = ds_list_find_value(global.unitImportColNameList, obj_control.unitImportColToChange);
	var tempList = ds_map_find_value(global.unitImportTagMap, mapKey);
	
	show_debug_message("scr_dialogueBoxNewCustomTagUnit() ... unitImportColToChange: " + string(obj_control.unitImportColToChange));
	show_debug_message("scr_dialogueBoxNewCustomTagUnit() ... mapKey: " + string(mapKey));
	
	if (is_numeric(tempList)) {
		if (ds_exists(tempList, ds_type_list)) {
			ds_list_add(tempList, obj_control.inputText);
		}
	}

}
