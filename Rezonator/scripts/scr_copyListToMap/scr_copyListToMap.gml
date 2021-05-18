// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_copyListToMap(sourceList, map, key){
	
	var copyList = ds_list_create();
	if (scr_isNumericAndExists(sourceList, ds_type_list)) {
		ds_list_copy(copyList, sourceList);
	}
	ds_map_add_list(map, key, copyList);
	
	return copyList;

}