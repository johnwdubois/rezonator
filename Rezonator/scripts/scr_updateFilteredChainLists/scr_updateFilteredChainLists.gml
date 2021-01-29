// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_updateFilteredChainLists(){
	
	var rezChainList = ds_map_find_value(global.nodeMap, "rezChainList");
	var trackChainList = ds_map_find_value(global.nodeMap, "trackChainList");
	var stackChainList = ds_map_find_value(global.nodeMap, "stackChainList");
	
	// reset filter lists
	ds_list_clear(obj_chain.filteredRezChainList);
	ds_list_clear(obj_chain.filteredTrackChainList);
	ds_list_clear(obj_chain.filteredStackChainList);
	
	
	// update filteredChainLists for rez
	var rezChainListSize = ds_list_size(rezChainList);
	for (var i = 0; i < rezChainListSize; i++) {
		var currentChain = ds_list_find_value(rezChainList, i);
		var currentChainSubMap = ds_map_find_value(global.nodeMap, currentChain);
		if (!is_numeric(currentChainSubMap)) continue;
		if (!ds_exists(currentChainSubMap, ds_type_map)) continue;
		
		// add or remove chain from filtered chains list as needed
		var inFilter = ds_map_find_value(currentChainSubMap, "filter");
		if (inFilter && ds_list_find_index(obj_chain.filteredRezChainList, currentChain) == -1) {
			ds_list_add(obj_chain.filteredRezChainList, currentChain);
		}
	}
	// update filteredChainLists for tracks
	var trackChainListSize = ds_list_size(trackChainList);
	for (var i = 0; i < trackChainListSize; i++) {
		var currentChain = ds_list_find_value(trackChainList, i);
		var currentChainSubMap = ds_map_find_value(global.nodeMap, currentChain);
		if (!is_numeric(currentChainSubMap)) continue;
		if (!ds_exists(currentChainSubMap, ds_type_map)) continue;
		
		// add or remove chain from filtered chains list as needed
		var inFilter = ds_map_find_value(currentChainSubMap, "filter");
		if (inFilter && ds_list_find_index(obj_chain.filteredTrackChainList, currentChain) == -1) {
			ds_list_add(obj_chain.filteredTrackChainList, currentChain);
		}
	}
	// update filteredChainLists for stacks
	var stackChainListSize = ds_list_size(stackChainList);
	for (var i = 0; i < stackChainListSize; i++) {
		var currentChain = ds_list_find_value(stackChainList, i);
		var currentChainSubMap = ds_map_find_value(global.nodeMap, currentChain);
		if (!is_numeric(currentChainSubMap)) continue;
		if (!ds_exists(currentChainSubMap, ds_type_map)) continue;
		
		// add or remove chain from filtered chains list as needed
		var inFilter = ds_map_find_value(currentChainSubMap, "filter");
		if (inFilter && ds_list_find_index(obj_chain.filteredStackChainList, currentChain) == -1) {
			ds_list_add(obj_chain.filteredStackChainList, currentChain);
		}
	}
	
}