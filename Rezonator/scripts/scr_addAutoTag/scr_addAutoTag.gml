function scr_addAutoTag(field, tag, fieldmap){	
	// add auto-tags for first 50 values for this field
	var currentFieldSubMap = fieldmap[? field];
	var currentFieldTagSet = currentFieldSubMap[? "tagSet"];
	if (scr_isNumericAndExists(currentFieldTagSet, ds_type_list)) {
		if (ds_list_size(currentFieldTagSet) < 50 && tag != "") {
			if(ds_list_find_index(global.importFieldTagList,field) != -1){
				scr_addToListOnce(currentFieldTagSet, tag);
			}
		}
	}

}