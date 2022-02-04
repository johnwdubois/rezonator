

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