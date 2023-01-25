// Makes outer chunks bigger when nested chunks are created

function scr_expandChunk(chunkID) {

	var chunkSubMap = global.nodeMap[? chunkID];
	if (!scr_isNumericAndExists(chunkSubMap, ds_type_map)) {exit;}
	if (ds_list_find_index(obj_chain.encounteredChunkList, chunkID) >= 0) {exit;}
	ds_list_add(obj_chain.encounteredChunkList, chunkID);
	
	var chunkNest = chunkSubMap[? "nest"];
	chunkSubMap[? "nest"] = chunkNest + 1;
	
	show_debug_message("scr_expandChunk, chunkID: " + string(chunkID));
	
	// list of tokens inside the chunk
	var tokenList = chunkSubMap[? "tokenList"];
	var tokenListSize = ds_list_size(tokenList);
	
	// for each token in the list, iterate through how many chunks it's in
	for (var i = 0; i < tokenListSize; i++) {
	
		var currentToken = tokenList[|i];
		var currentTokenSubMap = global.nodeMap[? currentToken];
		var tokenInChunkList = currentTokenSubMap[? "inChunkList"];
		
		var chunkListSize = ds_list_size(tokenInChunkList);
		for (var j = 0; j < chunkListSize; j++) {
			// access all chunks the token is in
			var currentChunk = tokenInChunkList[|j];
			var currentChunkSubMap = global.nodeMap[? currentChunk];
			var currentChunkNest = currentChunkSubMap[? "nest"];
			// if there is a larger chunk in the token list, call expand chunk recursively on it
			if (currentChunkNest >= chunkNest) scr_expandChunk(currentChunk);
		}
	}

}