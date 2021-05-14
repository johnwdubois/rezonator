// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_setValueForAllNodesInList(nodeList, key, value){
	
	// this function goes through all the nodes in the given nodeList
	// and sets the given key/value pair
	
	var nodeListSize = ds_list_size(nodeList);
	for (var i = 0; i < nodeListSize; i++) {
		
		var currentNode = nodeList[| i];
		var currentNodeSubMap = global.nodeMap[? currentNode];
		if (scr_isNumericAndExists(currentNodeSubMap, ds_type_map)) {
			currentNodeSubMap[? key] = value;
		}
	}

}