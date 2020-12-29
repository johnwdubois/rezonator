// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_addToNodeMap(type){
	
	// type variable should be a string that declares what "type" of Node this is
	// for example, "Chain", "Link", or "Unit"
	
	// generate a random number and turn it into a hex string
	var nodeKeyMin = 10000;
	var nodeKeyMax = 100000000000000;
	var nodeKey = irandom_range(nodeKeyMin, nodeKeyMax);
	nodeKey = scr_baseConvert(nodeKey, 10, 16);
	
	// continue generating random hex strings until we find one that is not
	// already a key in the NodeMap
	while (ds_map_exists(global.nodeMap, nodeKey)) {
		nodeKey = irandom_range(nodeKeyMin, nodeKeyMax);
		nodeKey = scr_baseConvert(nodeKey, 10, 16);
	}
	
	// now that we have the key for the Node, we need its value which
	// is another sub-map. this map will contain any attributes we want
	// to attach, for example the type
	var subMap = ds_map_create();
	
	// add type to subMap
	ds_map_add(subMap, "type", type);
	
	// add Node to NodeMap
	ds_map_add_map(global.nodeMap, nodeKey, subMap);
	
	// return unique ID as random hex string (nodeKey)
	return nodeKey;
	
}