// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_deleteChain(chainID){
	

	if(!ds_map_exists(global.nodeMap,chainID)) {
		show_debug_message("scr_deleteChain()... chainID does not exists in nodeMap, exiting...");
		exit;
	}
	var listOfRezChains = ds_map_find_value(global.nodeMap, "rezChainList");
	var listOfTrackChains = ds_map_find_value(global.nodeMap, "trackChainList");
	var listOfStackChains = ds_map_find_value(global.nodeMap, "stackChainList");
	
	
	var IDList = ds_list_create();
	
	var chainSubMap = ds_map_find_value(global.nodeMap, chainID);
	
	if (is_numeric(chainSubMap)) {
		if (ds_exists(chainSubMap, ds_type_map)) {
			var entryIDList = ds_map_find_value(chainSubMap, "setIDList");
			var chainType = ds_map_find_value(chainSubMap, "type");
			if(!is_numeric(entryIDList)){ exit; }
			if(!ds_exists(entryIDList, ds_type_list)){ exit; }
		}
	}
	
	var sizeOfEntryList = ds_list_size(entryIDList);
	
	for(var i = 0; i < sizeOfEntryList; i++){
			scr_deleteFromChain();
	}


	scr_deleteFromList(listOfTrackChains, chainID);
	scr_deleteFromList(listOfStackChains, chainID);
	scr_deleteFromList(listOfRezChains, chainID);
	obj_chain.currentFocusedChainID = "";
	
}