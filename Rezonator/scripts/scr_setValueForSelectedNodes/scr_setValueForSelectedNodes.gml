

function scr_setValueForSelectedNodes(type, key, value) {
	
	// determine which selected list to use
	var selectedList = -1;
	if (type == "resonance") selectedList = obj_control.selectedRezChainList;
	else if (type == "trail") selectedList = obj_control.selectedTrackChainList;
	else if (type == "stack") selectedList = obj_control.selectedStackChainList;
	
	if (!ds_exists(selectedList, ds_type_list)) {
		show_debug_message("scr_setValueForSelectedNodes() ... ERROR: could not find selected list. Exiting...");
		exit;
	}
	
	var selectedListSize = ds_list_size(selectedList);
	
	for (var i = 0; i < selectedListSize; i++) {
		
		// get current node and its submap
		var currentNode = ds_list_find_value(selectedList, i);
		var currentNodeSubMap = ds_map_find_value(global.nodeMap, currentNode);
		if (!scr_isNumericAndExists(currentNodeSubMap, ds_type_map)) continue;
		
		// set value in map
		show_debug_message("scr_setValueForSelectedNodes() ... currentNode: " + string(currentNode) + ", key: " + string(key) + ", value: " + string(value));
		currentNodeSubMap[? key] = value;
		
		// add to filteredLists
		if (key == "filter") {
			var currentNodeType = ds_map_find_value(currentNodeSubMap, "type");
			if (currentNodeType == "resonance") ds_list_add(obj_chain.filteredRezChainList, currentNode);
			else if (currentNodeType == "trail") ds_list_add(obj_chain.filteredTrackChainList, currentNode);
			else if (currentNodeType == "stack") ds_list_add(obj_chain.filteredStackChainList, currentNode);
		}
		
	}

}