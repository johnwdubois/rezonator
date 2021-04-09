// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_isChunk(chunkID){
	
	var isChunk = false;
	
	if (ds_map_exists(global.nodeMap, chunkID)) {
		var chunkSubMap = global.nodeMap[? chunkID];
		if (chunkSubMap[? "type"] == "chunk") {
			return true;
		}
	}
	
	return isChunk;
	
}