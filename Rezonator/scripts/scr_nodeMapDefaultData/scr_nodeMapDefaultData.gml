// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_nodeMapDefaultData(){
	// add chainLists to nodeMap
	ds_map_add_list(global.nodeMap, "resonanceList", ds_list_create());
	ds_map_add_list(global.nodeMap, "trailList", ds_list_create());
	ds_map_add_list(global.nodeMap, "stackList", ds_list_create());

	// add showList to nodeMap
	ds_map_add_list(global.nodeMap, "showList", ds_list_create());

	// add chunkList to nodeMap
	ds_map_add_list(global.nodeMap, "chunkList", ds_list_create());

	// add NodeList to nodeMap
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


	// create lists of nodes for these panes
	ds_map_add_list(global.nodeMap, "searchNodeList", ds_list_create());
	ds_map_add_list(global.nodeMap, "treeList", ds_list_create());

	// add map to nodeMap
	ds_map_add_map(global.nodeMap, "searchMap", global.searchMap);
	ds_map_add_map(global.nodeMap, "cliqueMap", global.cliqueMap);
	ds_map_add_map(global.nodeMap, "colorMap", global.colorMap);
	ds_map_add_map(global.nodeMap, "treeMap", global.treeMap);
	
	// add map to nodeList, so they're viewable in nodeMapViewer
	ds_list_add(global.nodeMap[? "nodeList"], "searchMap");
	ds_list_add(global.nodeMap[? "nodeList"], "cliqueMap");
	ds_list_add(global.nodeMap[? "nodeList"], "treeMap");
	ds_list_add(global.nodeMap[? "nodeList"], "colorMap");
}