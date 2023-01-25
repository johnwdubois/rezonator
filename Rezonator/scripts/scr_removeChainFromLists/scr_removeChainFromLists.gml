

function scr_removeChainFromLists(chainID, chainType) {
	
	// remove chain from filter/selected/visible list if necessary
	var listOfChains = -1;
	var filteredChainList = -1;
	var selectedChainList = -1;
	var hiddenChainList = -1;
	if (chainType == "resonance") {
		listOfChains = ds_map_find_value(global.nodeMap, "resonanceList");
		filteredChainList = obj_chain.filteredRezChainList;
		selectedChainList = obj_control.selectedRezChainList;
		hiddenChainList = obj_control.hiddenRezChainList;
	}
	else if (chainType == "trail") {
		listOfChains = ds_map_find_value(global.nodeMap, "trailList");
		filteredChainList = obj_chain.filteredTrackChainList;
		selectedChainList = obj_control.selectedTrackChainList;
		hiddenChainList = obj_control.hiddenTrackChainList;
	}
	else if (chainType == "stack") {
		listOfChains = ds_map_find_value(global.nodeMap, "stackList");
		filteredChainList = obj_chain.filteredStackChainList;
		selectedChainList = obj_control.selectedStackChainList;
		hiddenChainList = obj_control.hiddenStackChainList;
	}
	
	scr_deleteFromList(listOfChains, chainID);
	scr_deleteFromList(filteredChainList, chainID);
	scr_deleteFromList(selectedChainList, chainID);
	scr_deleteFromList(hiddenChainList, chainID);
	
}