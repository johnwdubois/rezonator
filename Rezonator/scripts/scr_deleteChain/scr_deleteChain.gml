// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_deleteChain(chainID){
	obj_chain.quickLinkDeleted = true;

	if (!ds_map_exists(global.nodeMap,chainID)) {
		show_debug_message("scr_deleteChain()... chainID does not exists in nodeMap, exiting...");
		exit;
	}
	
	// focus the chain we want to delete
	obj_chain.currentFocusedChainID = chainID;
	
	// get chain's submap
	var chainSubMap = ds_map_find_value(global.nodeMap, chainID);
	var chainType = ds_map_find_value(chainSubMap, "type");
	
	
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
	while (sizeOfEntryList > 0 and scr_isNumericAndExists(chainSubMap, ds_type_map)) {
		if(sizeOfEntryList == 1){
			obj_chain.quickLinkDeleted = false;
		} 
		var currentEntry = ds_list_find_value(setIDList, 0);

		ds_map_replace(chainSubMap, "focused", currentEntry);

		show_debug_message("sizeOfEntryList: " + string(sizeOfEntryList));
		scr_deleteFromChain(false);
		
		if (ds_exists(setIDList, ds_type_list)) {
			sizeOfEntryList = ds_list_size(setIDList);
		}
		else {
			sizeOfEntryList = 0;
		}
	}
	
	
	scr_removeChainFromLists(chainID, chainType);
	
	
	var showList = global.nodeMap[?"showList"];
	var totalShows = ds_list_size(showList);
	for(var i = 0; i < totalShows; i++){
		var showID = showList[|i];
		var showSubMap = global.nodeMap[?showID];
		var setIDList = showSubMap[?"setIDList"];
		scr_deleteFromList(setIDList, chainID);
	}
	
	// unfocus chain
	obj_chain.currentFocusedChainID = "";
	
}