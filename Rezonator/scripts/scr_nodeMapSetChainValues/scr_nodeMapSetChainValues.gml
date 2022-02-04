

function scr_nodeMapSetChainValues(nodeID, chainName, chainColor, chainSeq) {
	
	// find subMap for this chain
	var subMap = ds_map_find_value(global.nodeMap, nodeID);
	if (ds_exists(subMap, ds_type_map)) {
		
		// add chain values to subMap
		ds_map_add(subMap, "name", chainName);
		ds_map_add(subMap, "chainColor", chainColor);
		ds_map_add(subMap, "focused", "");
		ds_map_add(subMap, "filter", false);
		ds_map_add(subMap, "author", global.userName);
		ds_map_add(subMap, "chainCreateSeq", chainSeq);
		ds_map_add(subMap, "visible", true);
		ds_map_add(subMap, "selected", false);
		
		// set alignment
		var type = ds_map_find_value(subMap, "type");
		if (type == "resonance" || type == "trail") {
			ds_map_add(subMap, "alignChain", (type == "resonance"));
		}
		
		if (type == "stack") {
			ds_map_add(subMap, "caption", "");
		}
		
		// add setIDList, vizSetIDList, linkIDList, and tagList to subMap
		var setIDList = ds_list_create();
		ds_map_add_list(subMap, "setIDList", setIDList);
		var vizSetIDList = ds_list_create();
		ds_map_add_list(subMap, "vizSetIDList", vizSetIDList);
		var customSetIDList = ds_list_create();
		ds_map_add_list(subMap, "customSetIDList", customSetIDList);
		var linkIDList = ds_list_create();
		ds_map_add_list(subMap, "linkIDList", linkIDList);
		
		// add 1-1 chain tagMap for this chain
		var tagMap = ds_map_create();
		ds_map_add_map(subMap, "tagMap", tagMap);
	}

}