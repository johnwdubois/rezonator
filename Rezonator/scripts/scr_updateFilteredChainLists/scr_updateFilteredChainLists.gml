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
	
	// reset selected lists
	ds_list_clear(obj_control.selectedRezChainList);
	ds_list_clear(obj_control.selectedTrackChainList);
	ds_list_clear(obj_control.selectedStackChainList);
	
	// reset hidden lists
	ds_list_clear(obj_control.hiddenRezChainList);
	ds_list_clear(obj_control.hiddenTrackChainList);
	ds_list_clear(obj_control.hiddenStackChainList);
	
	// update filteredChainLists for rez
	var rezChainListSize = ds_list_size(rezChainList);
	for (var i = 0; i < rezChainListSize; i++) {
		var currentChain = ds_list_find_value(rezChainList, i);
		var currentChainSubMap = ds_map_find_value(global.nodeMap, currentChain);
		if (!is_numeric(currentChainSubMap)) continue;
		if (!ds_exists(currentChainSubMap, ds_type_map)) continue;
		
		// add chain to filtered list if needed
		var inFilter = ds_map_find_value(currentChainSubMap, "filter");
		if (inFilter && ds_list_find_index(obj_chain.filteredRezChainList, currentChain) == -1) {
			ds_list_add(obj_chain.filteredRezChainList, currentChain);
		}
		
		// add chain to selected list if needed
		var isSelected = ds_map_find_value(currentChainSubMap, "selected");
		if (isSelected && ds_list_find_index(obj_control.selectedRezChainList, currentChain) == -1) {
			ds_list_add(obj_control.selectedRezChainList, currentChain);
		}
		
		// add chain to hidden list if needed
		var isVisible = ds_map_find_value(currentChainSubMap, "visible");
		if (!isVisible && ds_list_find_index(obj_control.hiddenRezChainList, currentChain) == -1) {
			ds_list_add(obj_control.hiddenRezChainList, currentChain);
		}
	}
	// update filteredChainLists for tracks
	var trackChainListSize = ds_list_size(trackChainList);
	for (var i = 0; i < trackChainListSize; i++) {
		var currentChain = ds_list_find_value(trackChainList, i);
		var currentChainSubMap = ds_map_find_value(global.nodeMap, currentChain);
		if (!is_numeric(currentChainSubMap)) continue;
		if (!ds_exists(currentChainSubMap, ds_type_map)) continue;
		
		// add chain to filtered list if needed
		var inFilter = ds_map_find_value(currentChainSubMap, "filter");
		if (inFilter && ds_list_find_index(obj_chain.filteredTrackChainList, currentChain) == -1) {
			ds_list_add(obj_chain.filteredTrackChainList, currentChain);
		}
		
		// add chain to selected list if needed
		var isSelected = ds_map_find_value(currentChainSubMap, "selected");
		if (isSelected && ds_list_find_index(obj_control.selectedTrackChainList, currentChain) == -1) {
			ds_list_add(obj_control.selectedTrackChainList, currentChain);
		}
		
		// add chain to hidden list if needed
		var isVisible = ds_map_find_value(currentChainSubMap, "visible");
		if (!isVisible && ds_list_find_index(obj_control.hiddenTrackChainList, currentChain) == -1) {
			ds_list_add(obj_control.hiddenTrackChainList, currentChain);
		}
	}
	// update filteredChainLists for stacks
	var stackChainListSize = ds_list_size(stackChainList);
	for (var i = 0; i < stackChainListSize; i++) {
		var currentChain = ds_list_find_value(stackChainList, i);
		var currentChainSubMap = ds_map_find_value(global.nodeMap, currentChain);
		if (!is_numeric(currentChainSubMap)) continue;
		if (!ds_exists(currentChainSubMap, ds_type_map)) continue;
		
		// add chain to filtered list if needed
		var inFilter = ds_map_find_value(currentChainSubMap, "filter");
		if (inFilter && ds_list_find_index(obj_chain.filteredStackChainList, currentChain) == -1) {
			ds_list_add(obj_chain.filteredStackChainList, currentChain);
		}
		
		// add chain to selected list if needed
		var isSelected = ds_map_find_value(currentChainSubMap, "selected");
		if (isSelected && ds_list_find_index(obj_control.selectedStackChainList, currentChain) == -1) {
			ds_list_add(obj_control.selectedStackChainList, currentChain);
		}
		
		// add chain to hidden list if needed
		var isVisible = ds_map_find_value(currentChainSubMap, "visible");
		if (!isVisible && ds_list_find_index(obj_control.hiddenStackChainList, currentChain) == -1) {
			ds_list_add(obj_control.hiddenStackChainList, currentChain);
		}
	}
	
}