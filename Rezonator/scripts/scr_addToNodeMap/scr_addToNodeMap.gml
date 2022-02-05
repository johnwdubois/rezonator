

function scr_addToNodeMap(type){
	
	// type variable should be a string that declares what "type" of Node this is
	// for example, "Chain", "Link", "Unit", etc.
	
	var nodeKey = scr_generateRandomHex();
	
	// now that we have the key for the Node, we need its value which
	// is another sub-map. this map will contain any attributes we want
	// to attach, for example the type
	var subMap = ds_map_create();
	
	// add type to subMap
	ds_map_add(subMap, "type", type);
	
	// add Node to NodeMap
	ds_map_add_map(global.nodeMap, nodeKey, subMap);
	
	ds_list_add(global.nodeMap[?"nodeList"], nodeKey);
	
	// return unique ID as random hex string (nodeKey)
	return nodeKey;
	
}