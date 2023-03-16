function scr_removeChainFromLists(chainID, chainType) {
	
	// remove chain from nav/filter/selected/visible list if necessary
	var chainList = -1;
	var chainNavList = -1;
	var filteredChainList = -1;
	var selectedChainList = -1;
	var hiddenChainList = -1;
	
	if (chainType == "resonance") {
		chainList = global.nodeMap[? "resonanceList"];
		chainNavList = global.nodeMap[? "resonanceNavList"];
		filteredChainList = obj_chain.filteredRezChainList;
		selectedChainList = obj_control.selectedRezChainList;
		hiddenChainList = obj_control.hiddenRezChainList;
	}
	else if (chainType == "trail") {
		chainList = global.nodeMap[? "trailList"];
		chainNavList = global.nodeMap[? "trailNavList"];
		filteredChainList = obj_chain.filteredTrackChainList;
		selectedChainList = obj_control.selectedTrackChainList;
		hiddenChainList = obj_control.hiddenTrackChainList;
	}
	else if (chainType == "stack") {
		chainList = global.nodeMap[? "stackList"];
		chainNavList = global.nodeMap[? "stackNavList"];
		filteredChainList = obj_chain.filteredStackChainList;
		selectedChainList = obj_control.selectedStackChainList;
		hiddenChainList = obj_control.hiddenStackChainList;
	}
	
	scr_deleteFromList(chainList, chainID);
	scr_deleteFromList(chainNavList, chainID);
	scr_deleteFromList(filteredChainList, chainID);
	scr_deleteFromList(selectedChainList, chainID);
	scr_deleteFromList(hiddenChainList, chainID);
	
}