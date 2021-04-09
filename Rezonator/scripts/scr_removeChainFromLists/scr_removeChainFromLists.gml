// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_removeChainFromLists(chainID, chainType){
	
	// remove chain from filter/selected/visible list if necessary
	var listOfChains = -1;
	var filteredChainList = -1;
	var selectedChainList = -1;
	var hiddenChainList = -1;
	if (chainType == "rezChain") {
		listOfChains = ds_map_find_value(global.nodeMap, "rezChainList");
		filteredChainList = obj_chain.filteredRezChainList;
		selectedChainList = obj_control.selectedRezChainList;
		hiddenChainList = obj_control.hiddenRezChainList;
	}
	else if (chainType == "trackChain") {
		listOfChains = ds_map_find_value(global.nodeMap, "trackChainList");
		filteredChainList = obj_chain.filteredTrackChainList;
		selectedChainList = obj_control.selectedTrackChainList;
		hiddenChainList = obj_control.hiddenTrackChainList;
	}
	else if (chainType == "stackChain") {
		listOfChains = ds_map_find_value(global.nodeMap, "stackChainList");
		filteredChainList = obj_chain.filteredStackChainList;
		selectedChainList = obj_control.selectedStackChainList;
		hiddenChainList = obj_control.hiddenStackChainList;
	}
	
	scr_deleteFromList(listOfChains, chainID);
	scr_deleteFromList(filteredChainList, chainID);
	scr_deleteFromList(selectedChainList, chainID);
	scr_deleteFromList(hiddenChainList, chainID);
	
}