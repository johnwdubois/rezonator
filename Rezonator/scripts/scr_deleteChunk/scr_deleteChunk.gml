/*
	Purpose: Remove the Chunk from it's chain, and delete the Chunk word
*/
function scr_deleteChunk(chunkID) {
	
	show_debug_message("scr_deleteChunk, chunkID: " + string(chunkID));
	
	// get chunk's submap and make sure it exists
	var chunkSubMap = global.nodeMap[? chunkID];
	if (!scr_isNumericAndExists(chunkSubMap, ds_type_map)) exit;
	
	// remove this chunk from all chains that it is in, then destroy the inChainsList
	var inChainsList = chunkSubMap[?"inChainsList"];
	if (scr_isNumericAndExists(inChainsList, ds_type_list)) {
		while (ds_list_size(inChainsList) > 0) {
			var currentChain = inChainsList[| 0];
			obj_chain.currentFocusedChainID = currentChain;
			scr_refocusChainEntry(chunkID);
			scr_deleteFromChain(true);
			scr_deleteFromList(inChainsList, currentChain);
		}
		ds_list_destroy(inChainsList);
	}
	
	// delete from chunkList
	var chunkList = global.nodeMap[? "chunkList"];
	scr_deleteFromList(chunkList, chunkID);
	
	// remove the submap from the nodemap
	scr_deleteFromNodeMap(chunkID);
	
	// destroy the chunk's tokenList
	var tokenList = chunkSubMap[? "tokenList"];
	if (scr_isNumericAndExists(tokenList, ds_type_list)) {
		// go through the tokenList and remove this chunk from each token's inBoxList
		var tokenListSize = ds_list_size(tokenList);
		for (var i = 0; i < tokenListSize; i++) {
			var currentToken = tokenList[| i];
			var tokenSubMap = global.nodeMap[?currentToken];
			var currentTokenInBoxList = tokenSubMap[?"inChunkList"];
			if (scr_isNumericAndExists(currentTokenInBoxList, ds_type_list)) {
				scr_deleteFromList(currentTokenInBoxList, chunkID);
			}
		}
		ds_list_destroy(tokenList);
	}
	
	
	// destroy the chunk's submap
	ds_map_destroy(chunkSubMap);
	
	obj_chain.currentFocusedChunkID = "";
}
