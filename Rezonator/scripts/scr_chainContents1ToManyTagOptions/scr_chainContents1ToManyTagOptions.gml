// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_chainContents1ToManyTagOptions(optionSelected){
	
	// make sure entry exists in nodeMap and get its submap
	var entryToChange = obj_control.chain1toManyEntryToChange;
	var fieldToChange = obj_control.chain1toManyFieldToChange;
	show_debug_message("scr_chainContents1ToManyTagOptions() ... changing entry: " + string(entryToChange) + " field: " + string(fieldToChange) + " to option: " + string(optionSelected));
	var entrySubMap = ds_map_find_value(global.nodeMap, entryToChange);
	if (!is_numeric(entrySubMap)) exit;
	if (!ds_exists(entrySubMap, ds_type_map)) exit;
	
	// get this entry's tagmap
	var entryTagMap = ds_map_find_value(entrySubMap, "tagMap");
	if (!is_numeric(entryTagMap)) exit;
	if (!ds_exists(entryTagMap, ds_type_map)) exit;
	
	// set the selected tag in this entry's tagmap
	scr_setMap(entryTagMap, fieldToChange, optionSelected);
	
}