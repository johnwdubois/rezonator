// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_combineChains(focusedChain, clickedChain){
	
	show_debug_message("scr_combineChains: " + string(focusedChain) + ", " + string(clickedChain));
	
	// get the submaps for our chains and make sure they exist
	var focusedChainSubMap = ds_map_find_value(global.nodeMap, focusedChain);
	var clickedChainSubMap = ds_map_find_value(global.nodeMap, clickedChain);
	if (!is_numeric(focusedChainSubMap)) exit;
	if (!ds_exists(focusedChainSubMap, ds_type_map)) exit;
	if (!is_numeric(clickedChainSubMap)) exit;
	if (!ds_exists(clickedChainSubMap, ds_type_map)) exit;
	
	// make sure the chains are the same type
	var focusedChainType = ds_map_find_value(focusedChainSubMap, "type");
	var clickedChainType = ds_map_find_value(clickedChainSubMap, "type");
	if (focusedChainType != clickedChainType) {
		show_debug_message("scr_combineChains() ... chains are not the same type!");
		exit;
	}
	
	// make a temporary list of the words/units in the clicked chain
	var tempList = ds_list_create();
	var clickedChainSetIDList = ds_map_find_value(clickedChainSubMap, "setIDList");
	var clickedChainSetIDListSize = ds_list_size(clickedChainSetIDList);
	for (var i = 0; i < clickedChainSetIDListSize; i++) {
		var currentEntry = ds_list_find_value(clickedChainSetIDList, i);
		var currentEntrySubMap = ds_map_find_value(global.nodeMap, currentEntry);
		var currentWordOrUnit = ds_map_find_value(currentEntrySubMap, (focusedChainType == "stackChain") ? "unit" : "word");
		if (ds_list_find_index(tempList, currentWordOrUnit) == -1) {
			ds_list_add(tempList, currentWordOrUnit);
		}
	}
	
	// delete the clicked chain
	scr_deleteChain(clickedChain);
	
	// add the words that were in the clicked chain to the focused chain
	show_debug_message("scr_combineChains() ... tempList: " + scr_getStringOfList(tempList));
	var tempListSize = ds_list_size(tempList);
	for (var i = 0; i < tempListSize; i++) {
		var currentWordOrUnit = ds_list_find_value(tempList, i);
		with (obj_chain) {
			currentFocusedChainID = focusedChain;
			
			// if this is a stack, let's get it's first wordID
			if (focusedChainType == "stackChain") {
				var wordIDList = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colWordIDList, currentWordOrUnit - 1);
				if (ds_list_size(wordIDList) > 0) {
					currentWordOrUnit = ds_list_find_value(wordIDList, 0);
				}
				else {
					continue;
				}
			}
			
			scr_newLink(currentWordOrUnit);
		}
	}
	
	
	ds_list_destroy(tempList);

}