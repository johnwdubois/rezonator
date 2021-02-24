// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_addToChainFieldMap(map, key, tagSet, shortcutSet, rezTag, trackTag, stackTag){
	
	// make sure field/key isn't in the map already
	if (ds_map_exists(map, key)) {
		show_debug_message("scr_addToEntryFieldMap() ... " + string(key) + " already exists in entryFieldMap");
		exit;
	}
	
	// add this field to either the chainFieldMap or the entryFieldMap
	var fieldList = (map == global.chainFieldMap) ? global.chainFieldList : global.chainEntryFieldList;
	ds_list_add(fieldList, key);
	
	// create a subMap for this field
	var subMap = ds_map_create();
	ds_map_add_map(map, key, subMap);
	
	// if a valid tagSet was provided, let's add it to this field's submap
	if (is_numeric(tagSet)) {
		if (ds_exists(tagSet, ds_type_list)) {
			show_debug_message("scr_addToChainFieldMap() ... tagSet: " + scr_getStringOfList(tagSet));
			ds_list_add(tagSet, "Add to tag set", "Remove tag");
			ds_map_add_list(subMap, "tagSet", tagSet);
		}
	}
	
	// if a valid shortcutSet was provided, let's add it to this field's submap
	if (is_numeric(shortcutSet)) {
		if (ds_exists(shortcutSet, ds_type_list)) {
			show_debug_message("scr_addToChainFieldMap() ... shortcutSet: " + scr_getStringOfList(shortcutSet));
			ds_map_add_list(subMap, "shortcutSet", shortcutSet);
		}
	}
	
	// set whether this tag can be applied to rez/track/stack
	// rezTag, trackTag, and stackTag should all be boolean values
	ds_map_add(subMap, "rez", rezTag);
	ds_map_add(subMap, "track", trackTag);
	ds_map_add(subMap, "stack", stackTag);

}