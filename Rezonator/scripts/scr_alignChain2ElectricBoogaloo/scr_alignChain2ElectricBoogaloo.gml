// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_alignChain2ElectricBoogaloo(chainID){
	
	show_debug_message("scr_alignChain2() ... chainID: " + string(chainID));
	
	// get chain map
	var chainSubMap = ds_map_find_value(global.nodeMap, chainID);
	if (!is_numeric(chainSubMap)) exit;
	if (!ds_exists(chainSubMap, ds_type_map)) exit;
	var chainType = ds_map_find_value(chainSubMap, "type");
	if (chainType != "rezChain") exit;
	
	
	// first, find the word with furthest display col in chain
	var furthestDisplayCol = -1;
	var setIDList = ds_map_find_value(chainSubMap, "setIDList");
	var setIDListSize = ds_list_size(setIDList);
	for (var i = 0; i < setIDListSize; i++) {
		var currentEntry = ds_list_find_value(setIDList, i);
		var currentEntrySubMap = ds_map_find_value(global.nodeMap, currentEntry);
		if (!is_numeric(currentEntrySubMap)) continue;
		if (!ds_exists(currentEntrySubMap, ds_type_map)) continue;
		
		var currentWordID = ds_map_find_value(currentEntrySubMap, "word");
		var currentDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 1);
		if (!is_numeric(currentDisplayCol)) continue;
		if (currentDisplayCol > furthestDisplayCol) furthestDisplayCol = currentDisplayCol;
	}
	
	show_debug_message("furthestDisplayCol: " + string(furthestDisplayCol));
	
	
	
	
	
	
	
	
	
	// set all words to have display col as furthest word
	for (var i = 0; i < setIDListSize; i++) {
		var currentEntry = ds_list_find_value(setIDList, i);
		var currentEntrySubMap = ds_map_find_value(global.nodeMap, currentEntry);
		if (!is_numeric(currentEntrySubMap)) continue;
		if (!ds_exists(currentEntrySubMap, ds_type_map)) continue;
		
		var currentWordID = ds_map_find_value(currentEntrySubMap, "word");
		ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 1, furthestDisplayCol);

	}
	

}