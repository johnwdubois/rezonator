// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_setValueForAllChains(chainType, key, value) {
	
	// find the list of chains to iterate over
	var listOfChains = -1;
	if (chainType == "rezChain") listOfChains = ds_map_find_value(global.nodeMap, "rezChainList");
	else if (chainType == "trackChain") listOfChains = ds_map_find_value(global.nodeMap, "trackChainList");
	else if (chainType == "stackChain") listOfChains = ds_map_find_value(global.nodeMap, "stackChainList");
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
			if (chainType == "rezChain") listOfFilteredChains = obj_chain.filteredRezChainList;
			else if (chainType == "trackChain") listOfFilteredChains = obj_chain.filteredTrackChainList;
			else if (chainType == "stackChain") listOfFilteredChains = obj_chain.filteredStackChainList;
			
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
			// determine which filter list to look at
			var listOfSelectedChains = -1;
			if (chainType == "rezChain") listOfSelectedChains = obj_control.selectedRezChainList;
			else if (chainType == "trackChain") listOfSelectedChains = obj_control.selectedTrackChainList;
			else if (chainType == "stackChain") listOfSelectedChains = obj_control.selectedStackChainList;
			
			// either add or remove this chain from the corresponding filter list
			if (value && ds_list_find_index(listOfSelectedChains, currentChain) == -1) {
				ds_list_add(listOfSelectedChains, currentChain);
			}
			else if (!value && ds_list_find_index(listOfSelectedChains, currentChain) >= 0) {
				scr_deleteFromList(listOfSelectedChains, currentChain);
			}
		}
		
	}
	
}