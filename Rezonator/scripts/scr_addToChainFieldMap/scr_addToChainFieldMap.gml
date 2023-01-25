function scr_addToChainFieldMap(map, key, tagSet, rezTag, trackTag, stackTag) {
	// make sure field/key isn't in the map already
	if (ds_map_exists(map, key)) {
		show_debug_message("scr_addToChainFieldMap ... " + string(key) + " already exists in entryFieldMap");
		exit;
	}
	
	if (map == global.linkFieldMap) {
		// add this field to either the linkMap
		var fieldList = global.linkFieldList;
		scr_addToListOnce(fieldList, key);
	}
	else{
		// add this field to either the chainFieldMap or the entryFieldMap
		var fieldList = (map == global.chainFieldMap) ? global.chainFieldList : global.chainEntryFieldList;
		scr_addToListOnce(fieldList, key);
	}
	
	if (room == rm_mainScreen) {
	
		//add to nav window list if is right type and has space
		var sizeOfchainFieldList = (map == global.chainFieldMap) ? ds_list_size(obj_control.chain1to1ColFieldListRez): ds_list_size(obj_control.chain1toManyColFieldListRez);
		
		if (rezTag) {
			if (map == global.chainFieldMap) { 
				if (sizeOfchainFieldList < 6) {
					scr_addToListOnce(obj_control.chain1to1ColFieldListRez, key);
				}
			}
			else{
				if (sizeOfchainFieldList < 3) {
					scr_addToListOnce(obj_control.chain1toManyColFieldListRez, key);
				}
			}
			
		}
		sizeOfchainFieldList = (map == global.chainFieldMap) ? ds_list_size(obj_control.chain1to1ColFieldListTrack): ds_list_size(obj_control.chain1toManyColFieldListTrack);
		
		if (trackTag) {
			if (map == global.chainFieldMap) { 
				if (sizeOfchainFieldList < 6) {
					scr_addToListOnce(obj_control.chain1to1ColFieldListTrack, key);
				}
			}
			else{
				if (sizeOfchainFieldList < 3) {
					scr_addToListOnce(obj_control.chain1toManyColFieldListTrack, key);
				}
			}
			
		}
		sizeOfchainFieldList = (map == global.chainFieldMap) ? ds_list_size(obj_control.chain1to1ColFieldListStack): ds_list_size(obj_control.chain1toManyColFieldListStack);
		
		if (stackTag) {
				
			if (map == global.chainFieldMap) {
				if (sizeOfchainFieldList < 6) {
					scr_addToListOnce(obj_control.chain1to1ColFieldListStack, key);
				}
			}
			else{
				if (sizeOfchainFieldList < 3) {
					scr_addToListOnce(obj_control.chain1toManyColFieldListStack, key);
				}
			}
		}
	}
	
	
	// create a subMap for this field
	var subMap = ds_map_create();
	ds_map_add_map(map, key, subMap);
	
	// if a valid tagSet was provided, let's add it to this field's submap
	if (scr_isNumericAndExists(tagSet, ds_type_list)) {
		ds_map_add_list(subMap, "tagSet", tagSet);
	}
	
	if (map != global.linkFieldMap) {
	
		// set whether this tag can be applied to rez/track/stack
		// rezTag, trackTag, and stackTag should all be boolean values
		ds_map_add(subMap, "rez", rezTag);
		ds_map_add(subMap, "track", trackTag);
		ds_map_add(subMap, "card", stackTag);
	
	}
	
	ds_map_add(subMap, "locked", false);
	ds_map_add(subMap, "readOnly", false);
	
}