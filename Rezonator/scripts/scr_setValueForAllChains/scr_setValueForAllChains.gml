// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_setValueForAllChains(chainType, key, value) {
	
	// find the list of chains to iterate over
	var listOfChains = -1;
	if (chainType == "resonance") listOfChains = ds_map_find_value(global.nodeMap, "resonanceList");
	else if (chainType == "trail") listOfChains = ds_map_find_value(global.nodeMap, "trailList");
	else if (chainType == "stack") listOfChains = ds_map_find_value(global.nodeMap, "stackList");
	else {
		show_debug_message("scr_setValueForAllChains() ... chainType: " + string(chainType) + " is invalid. Exiting...");
		exit;
	}
	
	// iterate over the list of chains
	var listOfChainsSize = ds_list_size(listOfChains);
	for (var i = 0; i < listOfChainsSize; i++) {
		var currentChain = ds_list_find_value(listOfChains, i);
		var currentChainSubMap = ds_map_find_value(global.nodeMap, currentChain);
		
		// make sure chain's submap exists
		if (!is_numeric(currentChainSubMap)) continue;
		if (!ds_exists(currentChainSubMap, ds_type_map)) continue;
		
		// add/replace the key-value pair
		scr_setMap(currentChainSubMap, key, value);
		
		// filter specific stuff (update filter list)
		if (key == "filter") {
			// determine which filter list to look at
			var listOfFilteredChains = -1;
			if (chainType == "resonance") listOfFilteredChains = obj_chain.filteredRezChainList;
			else if (chainType == "trail") listOfFilteredChains = obj_chain.filteredTrackChainList;
			else if (chainType == "stack") listOfFilteredChains = obj_chain.filteredStackChainList;
			
			// either add or remove this chain from the corresponding filter list
			if (value && ds_list_find_index(listOfFilteredChains, currentChain) == -1) {
				ds_list_add(listOfFilteredChains, currentChain);
			}
			else if (!value && ds_list_find_index(listOfFilteredChains, currentChain) >= 0) {
				scr_deleteFromList(listOfFilteredChains, currentChain);
			}
		}
		
		// selected specific stuff (update selected list)
		else if (key == "selected") {
			// determine which selected list to look at
			var listOfSelectedChains = -1;
			if (chainType == "resonance") listOfSelectedChains = obj_control.selectedRezChainList;
			else if (chainType == "trail") listOfSelectedChains = obj_control.selectedTrackChainList;
			else if (chainType == "stack") listOfSelectedChains = obj_control.selectedStackChainList;
			
			// either add or remove this chain from the corresponding selected list
			if (value && ds_list_find_index(listOfSelectedChains, currentChain) == -1) {
				ds_list_add(listOfSelectedChains, currentChain);
			}
			else if (!value && ds_list_find_index(listOfSelectedChains, currentChain) >= 0) {
				scr_deleteFromList(listOfSelectedChains, currentChain);
			}
		}
		
		// hidden specific stuff (update hidden list)
		else if (key == "visible") {
			// determine which hidden list to look at
			var listOfHiddenChains = -1;
			if (chainType == "resonance") listOfHiddenChains = obj_control.hiddenRezChainList;
			else if (chainType == "trail") listOfHiddenChains = obj_control.hiddenTrackChainList;
			else if (chainType == "stack") listOfHiddenChains = obj_control.hiddenStackChainList;
			
			// either add or remove this chain from the corresponding hidden list
			if (!value && ds_list_find_index(listOfHiddenChains, currentChain) == -1) {
				ds_list_add(listOfHiddenChains, currentChain);
			}
			else if (value && ds_list_find_index(listOfHiddenChains, currentChain) >= 0) {
				scr_deleteFromList(listOfHiddenChains, currentChain);
			}
		}
		
	}
	
}