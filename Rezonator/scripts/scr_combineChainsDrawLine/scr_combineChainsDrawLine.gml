// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_combineChainsDrawLine(inChainsList){
	
	// make sure that the focused chain is not in the inChainsList
	if (ds_list_find_index(inChainsList, obj_chain.currentFocusedChainID) >= 0) {
		show_debug_message("scr_combineChainsDrawLine() ... hoverWord is in focused chain. Exiting...");
		exit;
	}
	
	// get inChainsListSize and submap of focusedChain
	var inChainsListSize = ds_list_size(inChainsList);
	var focusedChainSubMap = ds_map_find_value(global.nodeMap, obj_chain.currentFocusedChainID);
	
	// make sure focusedChain exists
	if (!is_numeric(focusedChainSubMap)) exit;
	if (!ds_exists(focusedChainSubMap, ds_type_map)) exit;
	
	// next, we need to see if the hoverWord has a chain of the same type as the currently focused chain
	var focusedChainType = ds_map_find_value(focusedChainSubMap, "type");
	var chainToCombine = "";
	var selectedChainEntryListSize = 0;
	for (var i = 0; i < inChainsListSize; i++) {
		var currentChain = ds_list_find_value(inChainsList, i);
		var currentChainSubMap = ds_map_find_value(global.nodeMap, currentChain);
		var currentChainType = ds_map_find_value(currentChainSubMap, "type");
		if (currentChainType == focusedChainType) {
			chainToCombine = currentChain;
			var entryList = ds_map_find_value(currentChainSubMap, "setIDList");
			selectedChainEntryListSize = ds_list_size(entryList);
			break;
		}
	}
	
	if (chainToCombine == "" || !ds_map_exists(global.nodeMap, chainToCombine)) {
		show_debug_message("scr_combineChainsDrawLine() ... chainToCombine was not found or does not exist. Exiting...");
		exit;
	}
	
	// if the selected chain just has 1 entry, we will combine it with no questions asked...
	// but if the selected chain is longer than 1 entry, we will ask before combining
	if (selectedChainEntryListSize == 1) {
		scr_combineChains(obj_chain.currentFocusedChainID, chainToCombine);
	}
	else if (selectedChainEntryListSize > 1) {
		// set variables in obj_control so that we can keep the information while the question box is showing
		with (obj_control) {
			combineChainsFocused = obj_chain.currentFocusedChainID;
			combineChainsSelected = chainToCombine;
		}
		
		// call alarm to show question box
		with(obj_alarm){
			alarm[9] = 3;
		}
	}
	
	
}