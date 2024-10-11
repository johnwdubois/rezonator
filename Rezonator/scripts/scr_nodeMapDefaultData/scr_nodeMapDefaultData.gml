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
	
	// create the clique_inactiveLayers MAP
	global.cliqueMap_inactiveLayers = ds_map_create();
	ds_map_add(global.cliqueMap_inactiveLayers, "type", "map");
	
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
	
	// create the trailLayer map
	global.trailLayerMap = ds_map_create();
	ds_map_add(global.trailLayerMap, "type", "map");
	var defaultTrailLayerSubMap = ds_map_create();
	defaultTrailLayerSubMap[? "name"] = "Default";
	ds_map_add_map(global.trailLayerMap, "Default", defaultTrailLayerSubMap);
	
	// create the resonanceLayer map
	global.resonanceLayerMap = ds_map_create();
	ds_map_add(global.resonanceLayerMap, "type", "map");
	var defaultResonanceLayerSubMap = ds_map_create();
	defaultResonanceLayerSubMap[? "name"] = "Default";
	ds_map_add_map(global.resonanceLayerMap, "Default", defaultResonanceLayerSubMap);

	// create lists of nodes for these panes
	ds_map_add_list(global.nodeMap, "searchNodeList", ds_list_create());
	ds_map_add_list(global.nodeMap, "treeList", ds_list_create());
	
	// making stackingList with default value
	var _stackingList = ds_list_create();
	ds_list_add(_stackingList, "Default");
	ds_map_add_list(global.nodeMap, "stackingList", _stackingList);
	
	// making trailLayerList with default value
	var _trailLayerList = ds_list_create();
	ds_list_add(_trailLayerList, "Default");
	ds_map_add_list(global.nodeMap, "trailLayerList", _trailLayerList);
	
	// making resonanceLayerList with default value
	var _resonanceLayerList = ds_list_create();
	ds_list_add(_resonanceLayerList, "Default");
	ds_map_add_list(global.nodeMap, "resonanceLayerList", _resonanceLayerList);

	// add map to nodeMap
	ds_map_add_map(global.nodeMap, "searchMap", global.searchMap);
	ds_map_add_map(global.nodeMap, "cliqueMap", global.cliqueMap);
	ds_map_add_map(global.nodeMap, "cliqueMap_inactiveLayers", global.cliqueMap_inactiveLayers);
	ds_map_add_map(global.nodeMap, "colorMap", global.colorMap);
	ds_map_add_map(global.nodeMap, "treeMap", global.treeMap);
	ds_map_add_map(global.nodeMap, "participantMap", global.participantMap);
	ds_map_add_map(global.nodeMap, "stackingMap", global.stackingMap);
	ds_map_add_map(global.nodeMap, "trailLayerMap", global.trailLayerMap);
	ds_map_add_map(global.nodeMap, "resonanceLayerMap", global.resonanceLayerMap);
	
	// add map to nodeList, so they're viewable in nodeMapViewer
	var _nodeList = global.nodeMap[? "nodeList"];
	ds_list_add(_nodeList, "searchMap");
	ds_list_add(_nodeList, "cliqueMap");
	ds_list_add(_nodeList, "cliqueMap_inactiveLayers");
	ds_list_add(_nodeList, "treeMap");
	ds_list_add(_nodeList, "colorMap");
	ds_list_add(_nodeList, "participantMap");
	ds_list_add(_nodeList, "chainShowMap");
	ds_list_add(_nodeList, "chunkShowMap");
	ds_list_add(_nodeList, "stackingMap");
	ds_list_add(_nodeList, "trailLayerMap");
	ds_list_add(_nodeList, "resonanceLayerMap");
	
}