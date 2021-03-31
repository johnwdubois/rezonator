/*
	Purpose: Remove the Chunk from it's chain, and delete the Chunk word
*/
function scr_deleteChunk(chunkID) {
	show_debug_message("BUH");

	var chunkSubMap = global.nodeMap[?chunkID];
	
	if(!is_numeric(chunkSubMap)){exit;}
	if(!ds_exists(chunkSubMap, ds_type_map)){exit;}
	
	ds_map_delete(global.nodeMap,chunkID);
	
	var chunkSubMapTokenList = chunkSubMap[?"tokenList"];
	if(is_numeric(chunkSubMapTokenList)){
		if(ds_exists(chunkSubMapTokenList, ds_type_list)){
			ds_list_destroy(chunkSubMapTokenList);
		}
	}
	ds_map_destroy(chunkSubMap);
	
	obj_chain.currentFocusedChunkID = "";
}
