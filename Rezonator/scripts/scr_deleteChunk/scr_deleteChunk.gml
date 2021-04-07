/*
	Purpose: Remove the Chunk from it's chain, and delete the Chunk word
*/
function scr_deleteChunk(chunkID) {
	
	// delete from chunkList
	var chunkList = global.nodeMap[? "chunkList"];
	scr_deleteFromList(chunkList, chunkID);
	
	// get chunk's submap and make sure it exists
	var chunkSubMap = global.nodeMap[? chunkID];
	if (!is_numeric(chunkSubMap)) exit;
	if (!ds_exists(chunkSubMap, ds_type_map)) exit;
	
	// remove the submap from the nodemap
	ds_map_delete(global.nodeMap, chunkID);
	
	// destroy the chunk's tokenList
	var tokenList = chunkSubMap[? "tokenList"];
	if (is_numeric(tokenList)) {
		if (ds_exists(tokenList, ds_type_list)) {
			// go through the tokenList and remove this chunk from each token's inBoxList
			var tokenListSize = ds_list_size(tokenList);
			for (var i = 0; i < tokenListSize; i++) {
				var currentToken = tokenList[| i];
				var currentTokenInBoxList = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInBoxList, currentToken - 1);
				if (is_numeric(currentTokenInBoxList)) {
					if (ds_exists(currentTokenInBoxList, ds_type_list)) {
						scr_deleteFromList(currentTokenInBoxList, chunkID);
					}
				}
			}
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
