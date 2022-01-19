function scr_deleteFromNodeMap(key){
	ds_map_delete(global.nodeMap,key);
	scr_deleteFromList(global.nodeMap[?"nodeList"], key);
}