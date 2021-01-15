function scr_unFocusAllChains() {
	/*
		scr_unfocusAllChains();
	
		Last Updated: 2018-09-11
	
		Called from: any object
	
		Purpose: flag every chain in chainGrids as unfocused
	
		Mechanism: loop through every chainGrid until there are no chains marked as focused
	
		Author: Terry DuBois, Georgio Klironomos
	*/
	
	// unfocus the current focused chain (if there is one)
	obj_chain.currentFocusedChainID = "";
	
	// get all of the chainLists
	var rezChainList = ds_map_find_value(global.nodeMap, "rezChainList");
	var trackChainList = ds_map_find_value(global.nodeMap, "trackChainList");
	var stackChainList = ds_map_find_value(global.nodeMap, "stackChainList");
	var rezChainListSize = ds_list_size(rezChainList);
	var trackChainListSize = ds_list_size(trackChainList);
	var stackChainListSize = ds_list_size(stackChainList);
	
	// loop through the chainLists and make sure none of them have any focused entries
	for (var i = 0; i < rezChainListSize; i++) {
		var currentChain = ds_list_find_value(rezChainList, i);
		var currentChainSubMap = ds_map_find_value(global.nodeMap, currentChain);
		if (ds_exists(currentChainSubMap, ds_type_map)) {
			ds_map_replace(currentChainSubMap, "focused", "");	
		}	
	}
	for (var i = 0; i < trackChainListSize; i++) {
		var currentChain = ds_list_find_value(trackChainList, i);
		var currentChainSubMap = ds_map_find_value(global.nodeMap, currentChain);
		if (ds_exists(currentChainSubMap, ds_type_map)) {
			ds_map_replace(currentChainSubMap, "focused", "");	
		}	
	}
	for (var i = 0; i < stackChainListSize; i++) {
		var currentChain = ds_list_find_value(stackChainList, i);
		var currentChainSubMap = ds_map_find_value(global.nodeMap, currentChain);
		if (ds_exists(currentChainSubMap, ds_type_map)) {
			ds_map_replace(currentChainSubMap, "focused", "");	
		}	
	}
	

}
