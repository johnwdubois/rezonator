// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_deleteChain(chainID){
	

	if (!ds_map_exists(global.nodeMap,chainID)) {
		show_debug_message("scr_deleteChain()... chainID does not exists in nodeMap, exiting...");
		exit;
	}
	
	// focus the chain we want to delete
	obj_chain.currentFocusedChainID = chainID;
	
	// get chain's submap
	var chainSubMap = ds_map_find_value(global.nodeMap, chainID);
	var chainType = ds_map_find_value(chainSubMap, "type");
	
	// get list of chains
	var listOfChains = -1;
	if (chainType == "rezChainList") listOfChains = ds_map_find_value(global.nodeMap, "rezChainList");
	else if (chainType == "trackChain") listOfChains = ds_map_find_value(global.nodeMap, "trackChainList");
	else if (chainType == "stackChain") listOfChains = ds_map_find_value(global.nodeMap, "stackChainList");
	
	// get setIDList
	var setIDList = -1;
	if (is_numeric(chainSubMap)) {
		if (ds_exists(chainSubMap, ds_type_map)) {
			setIDList = ds_map_find_value(chainSubMap, "setIDList");
			if (!is_numeric(setIDList)) exit;
			if (!ds_exists(setIDList, ds_type_list)) exit;
		}
	}
	
	// remove every entry from this chain
	var sizeOfEntryList = ds_list_size(setIDList);
	while (sizeOfEntryList > 0) {
		var currentEntry = ds_list_find_value(setIDList, 0);
		ds_map_replace(chainSubMap, "focused", currentEntry);
		scr_deleteFromChain();
		
		if (ds_exists(setIDList, ds_type_list)) {
			sizeOfEntryList = ds_list_size(setIDList);
		}
		else {
			sizeOfEntryList = 0;
		}
	}
	
	// delete this chain from the list of chains
	scr_deleteFromList(listOfChains, chainID);
	
	// remove chain from filter list if necessary
	var filteredChainList = obj_chain.filteredRezChainList;
	if (chainType == "trackChain") filteredChainList = obj_chain.filteredTrackChainList;
	else if (chainType == "stackChain") filteredChainList = obj_chain.filteredStackChainList;
	scr_deleteFromList(filteredChainList, chainID);
	
	// unfocus chain
	obj_chain.currentFocusedChainID = "";
	
}