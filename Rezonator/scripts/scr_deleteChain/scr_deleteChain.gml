// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_deleteChain(chainID){
	

	if (!ds_map_exists(global.nodeMap,chainID)) {
		show_debug_message("scr_deleteChain()... chainID does not exists in nodeMap, exiting...");
		exit;
	}
	
	obj_chain.currentFocusedChainID = chainID;
	
	
	
	
	var IDList = ds_list_create();
	
	var chainSubMap = ds_map_find_value(global.nodeMap, chainID);
	var chainType = ds_map_find_value(chainSubMap, "type");
	var listOfChains = -1;
	if (chainType == "rezChainList") listOfChains = ds_map_find_value(global.nodeMap, "rezChainList");
	else if (chainType == "trackChain") listOfChains = ds_map_find_value(global.nodeMap, "trackChainList");
	else if (chainType == "stackChain") listOfChains = ds_map_find_value(global.nodeMap, "stackChainList");
	
	
	if (is_numeric(chainSubMap)) {
		if (ds_exists(chainSubMap, ds_type_map)) {
			var entryIDList = ds_map_find_value(chainSubMap, "setIDList");
			var chainType = ds_map_find_value(chainSubMap, "type");
			if (!is_numeric(entryIDList)) exit;
			if (!ds_exists(entryIDList, ds_type_list)) exit;
		}
	}
	
	/*
	var sizeOfEntryList = ds_list_size(entryIDList);
	for (var i = 0; i < sizeOfEntryList; i++) {
		var currentEntry = ds_list_find_value(currentEntry, i);
		scr_deleteFromChain();
	}
	*/
	
	var sizeOfEntryList = ds_list_size(entryIDList);
	while (sizeOfEntryList > 0) {
		var currentEntry = ds_list_find_value(entryIDList, 0);
		ds_map_replace(chainSubMap, "focused", currentEntry);
		scr_deleteFromChain();
		
		if (ds_exists(entryIDList, ds_type_list)) {
			sizeOfEntryList = ds_list_size(entryIDList);
		}
		else {
			sizeOfEntryList = 0;
		}
	}
	
	


	scr_deleteFromList(listOfChains, chainID);
	obj_chain.currentFocusedChainID = "";
	
}