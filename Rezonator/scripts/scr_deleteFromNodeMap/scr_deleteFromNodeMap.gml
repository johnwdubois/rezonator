// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_deleteFromNodeMap(key){
	ds_map_delete(global.nodeMap,key);
	scr_deleteFromList(global.nodeMap[?"nodeList"], key);
}