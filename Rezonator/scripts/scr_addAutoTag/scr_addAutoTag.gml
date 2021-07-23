// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_addAutoTag(field, tag, fieldmap){
	
	// add auto-tags for first 50 values for this field
	var currentFieldSubMap = fieldmap[? field];
	var currentFieldTagSet = currentFieldSubMap[? "tagSet"];
	if (scr_isNumericAndExists(currentFieldTagSet, ds_type_list)) {
		if (ds_list_size(currentFieldTagSet) < 50 && tag != "") {
			scr_addToListOnce(currentFieldTagSet, tag);
		}
	}

}