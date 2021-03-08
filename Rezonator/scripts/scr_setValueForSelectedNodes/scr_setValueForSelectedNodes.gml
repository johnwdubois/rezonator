// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_setValueForSelectedNodes(key, value){
	
	var selectedList = obj_control.selectedNodeList;
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