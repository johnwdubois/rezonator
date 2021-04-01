/*
	Purpose: Remove the Chunk from it's chain, and delete the Chunk word
*/
function scr_deleteChunk(chunkID) {
	
	var chunkSubMap = global.nodeMap[? chunkID];
	
	if (!is_numeric(chunkSubMap)) exit;
	if (!ds_exists(chunkSubMap, ds_type_map)) exit;
	
	// remove the submap from the nodemap
	ds_map_delete(global.nodeMap, chunkID);
	
	// destroy the chunk's tokenList
	var tokenList = chunkSubMap[? "tokenList"];
	if (is_numeric(tokenList)) {
		if (ds_exists(tokenList, ds_type_list)){
			ds_list_destroy(tokenList);
		}
	}
	
	// destroy the chunk's inChainsList
	var inChainsList = chunkSubMap[? "inChainsList"];
	if (is_numeric(inChainsList)) {
		if (ds_exists(inChainsList, ds_type_list)){
			ds_list_destroy(inChainsList);
		}
	}
	
	// destroy the chunk's submap
	ds_map_destroy(chunkSubMap);
	
	obj_chain.currentFocusedChunkID = "";
}
