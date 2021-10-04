// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_getChainTempList(chainID, sorted){
	
	// get chain submap and make sure it exists
	var chainSubMap = ds_map_find_value(global.nodeMap, chainID);
	if (!is_numeric(chainSubMap)) {
		show_debug_message("scr_getChainTempList() ... chainSubMap is non-numeric. Exiting...");
		exit;
	}
	if (!ds_exists(chainSubMap, ds_type_map)) {
		show_debug_message("scr_getChainTempList() ... chainSubMap does not exist. Exiting...");
		exit;
	}
	
	// make a temp word list
	var tempWordList = ds_list_create();
	
	// get the chain's setIDList and make sure it exists
	var currentSetIDList = ds_map_find_value(chainSubMap, (sorted) ? "vizSetIDList" : "setIDList");
	if (!is_numeric(currentSetIDList)) {
		show_debug_message("scr_getChainTempList() ... currentSetIDList is non-numeric. Exiting...");
		exit;
	}
	if (!ds_exists(currentSetIDList, ds_type_list)) {
		show_debug_message("scr_getChainTempList() ... currentSetIDList does not exist. Exiting...");
		exit;
	}
	
	var currentType = ds_map_find_value(chainSubMap, "type");
	
	// fill up the temp word list
	var currentSetIDListSize = ds_list_size(currentSetIDList);
	for (var j = 0; j < currentSetIDListSize; j++) {
		var currentEntry = ds_list_find_value(currentSetIDList, j);
		var currentEntrySubMap = ds_map_find_value(global.nodeMap, currentEntry);
		
		var currentWord = ds_map_find_value(currentEntrySubMap, (currentType == "stack") ? "unit" : "token");
		if (ds_list_find_index(tempWordList, currentWord) == -1 && !is_undefined(currentWord)) {
			ds_list_add(tempWordList, currentWord);
		}
	}
	
	//show_debug_message("scr_getChainTempList() ... tempWordList: " + scr_getStringOfList(tempWordList));
	return tempWordList;

}