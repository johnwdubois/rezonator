function scr_verifyRezCheckDS(key, ds_type, nodeList = undefined){
	
	// check if the nodeMap contains this key
	var ds = global.nodeMap[? key];
	var dsExisted = true;
	
	// if the DS doesn't already exist, create a new ds and add that to the nodeMap
	if (ds_type == ds_type_list) {
		if (!scr_isNumericAndExists(ds, ds_type_list)) {
			dsExisted = false;
			ds = ds_list_create();
		}
	}
	else if (ds_type == ds_type_map) {
		if (!scr_isNumericAndExists(ds, ds_type_map)) {
			dsExisted = false;
			ds = ds_map_create();
			ds[? "type"] = "map";
			scr_addToListOnce(nodeList, key);
		}
	}
	
	// the DS should exist now, and let's guarantee that it's hooked up to the nodeMap correctly
	ds_map_delete(global.nodeMap, key);
	if (ds_type == ds_type_list) ds_map_add_list(global.nodeMap, key, ds);
	else if (ds_type == ds_type_map) ds_map_add_map(global.nodeMap, key, ds);
	
	// print whether ds existed or not
	if (dsExisted) show_debug_message("scr_verifyRezCheckDS: " + string(key) + " existed in this REZ file");
	else show_debug_message("scr_verifyRezCheckDS: " + string(key) + " did not exist in this REZ file but has now been created");
	
	return ds;

}