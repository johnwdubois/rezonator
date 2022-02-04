function scr_checkLockedField(field){

	var fieldTagMap = scr_getFieldMap();
	var currentFieldSubMap = fieldTagMap[?field];
	var isLockedField = false;
	var tagSet = "";
	if (scr_isNumericAndExists(currentFieldSubMap,ds_type_map)) {
		isLockedField = currentFieldSubMap[?"locked"];
	}
	return isLockedField;

}