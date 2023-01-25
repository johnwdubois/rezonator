

function scr_deleteFieldFromNavWindowList(navWindowFieldList, fieldList, fieldName) {
	
	if (!scr_isNumericAndExists(navWindowFieldList, ds_type_list)) {
		show_debug_message("scr_deleteFieldFromNavWindowList ... navWindowFieldList does not exist");
		exit;
	}
	if (!scr_isNumericAndExists(fieldList, ds_type_list)) {
		show_debug_message("scr_deleteFieldFromNavWindowList ... fieldList does not exist");
		exit;
	}
	var fieldListSize = ds_list_size(fieldList);
	
	
	var placeInNavList = ds_list_find_index(navWindowFieldList, fieldName);
	if (placeInNavList != -1) {
		var i = 0;
		var isInNavList = (ds_list_find_index(navWindowFieldList, fieldList[|i]) == -1);
		while (!isInNavList and i < fieldListSize - 1) {
			i++;
			isInNavList = (ds_list_find_index(navWindowFieldList, fieldList[|i]) == -1);
	
		}
		if (fieldList[|i] != undefined) {
			ds_list_replace(navWindowFieldList,placeInNavList, fieldList[|i]);
		}
		else {
			ds_list_delete(navWindowFieldList,placeInNavList);
		}
	}
	
}