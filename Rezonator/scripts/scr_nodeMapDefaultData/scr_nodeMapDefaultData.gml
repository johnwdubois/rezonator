function scr_nodeMapDefaultData() {
	
	// add chainLists to nodeMap
	ds_map_add_list(global.nodeMap, "resonanceList", ds_list_create());
	ds_map_add_list(global.nodeMap, "trailList", ds_list_create());
	ds_map_add_list(global.nodeMap, "stackList", ds_list_create());
	
	// add left nav window lists to nodeMap
	ds_map_add_list(global.nodeMap, "resonanceNavList", ds_list_create());
	ds_map_add_list(global.nodeMap, "trailNavList", ds_list_create());
	ds_map_add_list(global.nodeMap, "stackNavList", ds_list_create());

	// add showList to nodeMap
	ds_map_add_list(global.nodeMap, "showList", ds_list_create());

	// add chunkList to nodeMap
	ds_map_add_list(global.nodeMap, "chunkList", ds_list_create());

	// add nodeList to nodeMap
	if (!ds_map_exists(global.nodeMap, "nodeList")) {
		ds_map_add_list(global.nodeMap, "nodeList", ds_list_create());
	}
	
	
	var tokenTagMap = ds_map_create();
	var unitTagMap = ds_map_create();
	ds_map_add(tokenTagMap, "type", "map");
	ds_map_add(unitTagMap, "type", "map");
	
	ds_map_add_map(global.nodeMap, "tokenTagMap", tokenTagMap);
	ds_map_add_map(global.nodeMap, "unitTagMap", unitTagMap);
	
	ds_list_add(global.nodeMap[? "nodeList"], "tokenTagMap");
	ds_list_add(global.nodeMap[? "nodeList"], "unitTagMap");
	
	
	
	// create the SEARCH MAP
	global.searchMap = ds_map_create();
	ds_map_add(global.searchMap, "type", "map");
	
	// create the Clique MAP
	global.cliqueMap = ds_map_create();
	ds_map_add(global.cliqueMap, "type", "map");
	
	// create the color MAP
	global.colorMap = ds_map_create();
	ds_map_add(global.colorMap, "type", "map");
	
	// create the color MAP
	global.treeMap = ds_map_create();
	ds_map_add(global.treeMap, "type", "map");
	
	// create the participant map
	global.participantMap = ds_map_create();
	ds_map_add(global.participantMap, "type", "map");
	
	// create the stacking map
	global.stackingMap = ds_map_create();
	ds_map_add(global.stackingMap, "type", "map");
	var defaultStackingSubMap = ds_map_create();
	defaultStackingSubMap[? "name"] = "Default";
	ds_map_add_map(global.stackingMap, "Default", defaultStackingSubMap);

	// create lists of nodes for these panes
	ds_map_add_list(global.nodeMap, "searchNodeList", ds_list_create());
	ds_map_add_list(global.nodeMap, "treeList", ds_list_create());
	
	// making stackingList with default value
	var _stackingList = ds_list_create();
	ds_list_add(_stackingList, "Default");
	ds_map_add_list(global.nodeMap, "stackingList", _stackingList);

	// add map to nodeMap
	ds_map_add_map(global.nodeMap, "searchMap", global.searchMap);
	ds_map_add_map(global.nodeMap, "cliqueMap", global.cliqueMap);
	ds_map_add_map(global.nodeMap, "colorMap", global.colorMap);
	ds_map_add_map(global.nodeMap, "treeMap", global.treeMap);
	ds_map_add_map(global.nodeMap, "participantMap", global.participantMap);
	ds_map_add_map(global.nodeMap, "stackingMap", global.stackingMap);
	
	// add map to nodeList, so they're viewable in nodeMapViewer
	var _nodeList = global.nodeMap[? "nodeList"];
	ds_list_add(_nodeList, "searchMap");
	ds_list_add(_nodeList, "cliqueMap");
	ds_list_add(_nodeList, "treeMap");
	ds_list_add(_nodeList, "colorMap");
	ds_list_add(_nodeList, "participantMap");
	ds_list_add(_nodeList, "chainShowMap");
	ds_list_add(_nodeList, "chunkShowMap");
	ds_list_add(_nodeList, "stackingMap");
}