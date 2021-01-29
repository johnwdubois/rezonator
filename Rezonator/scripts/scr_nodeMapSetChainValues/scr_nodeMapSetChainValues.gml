// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_nodeMapSetChainValues(nodeID, chainName, chainColor, chainSeq) {
	
	// find subMap for this chain
	var subMap = ds_map_find_value(global.nodeMap, nodeID);
	if (ds_exists(subMap, ds_type_map)) {
		
		// add chain values to subMap
		ds_map_add(subMap, "chainName", chainName);
		ds_map_add(subMap, "chainColor", chainColor);
		ds_map_add(subMap, "focused", "");
		ds_map_add(subMap, "filter", false);
		ds_map_add(subMap, "author", global.userName);
		ds_map_add(subMap, "chainSeq", chainSeq);
		
		// set alignment
		var type = ds_map_find_value(subMap, "type");
		if (type == "rezChain" || type == "trackChain") {
			ds_map_add(subMap, "alignChain", (type == "rezChain") ? true : false);
		}
		
		if (type == "stackChain") {
			ds_map_add(subMap, "caption", "");
		}
		
		// add setIDList, vizSetIDList, linkIDList, and tagList to subMap
		var setIDList = ds_list_create();
		ds_map_add_list(subMap, "setIDList", setIDList);
		var vizSetIDList = ds_list_create();
		ds_map_add_list(subMap, "vizSetIDList", vizSetIDList);
		var linkIDList = ds_list_create();
		ds_map_add_list(subMap, "linkIDList", linkIDList);
		var tagList = ds_list_create();
		ds_map_add_list(subMap, "tagList", tagList);
	}

}