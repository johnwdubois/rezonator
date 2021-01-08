// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_nodeMapSetChainValues(nodeID, wordIDList, chainName, chainColor) {
	
	// find subMap for this chain
	var subMap = ds_map_find_value(global.nodeMap, nodeID);
	if (ds_exists(subMap, ds_type_map)) {
		
		// add chain values to subMap
		//ds_map_add_list(subMap, "wordIDList", wordIDList);
		ds_map_add(subMap, "chainName", chainName);
		ds_map_add(subMap, "chainColor", chainColor);
		ds_map_add(subMap, "focused", "");
		
		// add setIDList, linkIDList, and tagList to subMap
		var setIDList = ds_list_create();
		ds_map_add_list(subMap, "setIDList", setIDList);
		var linkIDList = ds_list_create();
		ds_map_add_list(subMap, "linkIDList", linkIDList);
		var tagList = ds_list_create();
		ds_map_add_list(subMap, "tagList", tagList);
	}

}