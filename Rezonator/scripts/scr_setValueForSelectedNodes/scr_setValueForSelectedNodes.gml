// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_setValueForSelectedNodes(type, key, value){
	
	// determine which selected list to use
	var selectedList = -1;
	if (type == "rezChain") selectedList = obj_control.selectedRezChainList;
	else if (type == "trackChain") selectedList = obj_control.selectedTrackChainList;
	else if (type == "stackChain") selectedList = obj_control.selectedStackChainList;
	
	if (!ds_exists(selectedList, ds_type_list)) {
		show_debug_message("scr_setValueForSelectedNodes() ... ERROR: could not find selected list. Exiting...");
		exit;
	}
	
	var selectedListSize = ds_list_size(selectedList);
	
	for (var i = 0; i < selectedListSize; i++) {
		
		// get current node and its submap
		var currentNode = ds_list_find_value(selectedList, i);
		var currentNodeSubMap = ds_map_find_value(global.nodeMap, currentNode);
		if (!is_numeric(currentNodeSubMap)) continue;
		if (!ds_exists(currentNodeSubMap, ds_type_map)) continue;
		
		// set value in map
		show_debug_message("scr_setValueForSelectedNodes() ... currentNode: " + string(currentNode) + ", key: " + string(key) + ", value: " + string(value));
		scr_setMap(currentNodeSubMap, key, value);
		
		// add to filteredLists
		if (key == "filter") {
			var currentNodeType = ds_map_find_value(currentNodeSubMap, "type");
			if (currentNodeType == "rezChain") ds_list_add(obj_chain.filteredRezChainList, currentNode);
			else if (currentNodeType == "trackChain") ds_list_add(obj_chain.filteredTrackChainList, currentNode);
			else if (currentNodeType == "stackChain") ds_list_add(obj_chain.filteredStackChainList, currentNode);
		}
		
	}

}