// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_nodeMapDefaultData(){
	
	// add chainLists to nodeMap
	ds_map_add_list(global.nodeMap, "rezChainList", ds_list_create());
	ds_map_add_list(global.nodeMap, "trackChainList", ds_list_create());
	ds_map_add_list(global.nodeMap, "stackChainList", ds_list_create());

	// add showList to nodeMap
	ds_map_add_list(global.nodeMap, "showList", ds_list_create());

	// add chunkList to nodeMap
	ds_map_add_list(global.nodeMap, "chunkList", ds_list_create());

	// add NodeList to nodeMap
	if (!ds_map_exists(global.nodeMap, "nodeList")) {
		ds_map_add_list(global.nodeMap, "nodeList", ds_list_create());
	}

}