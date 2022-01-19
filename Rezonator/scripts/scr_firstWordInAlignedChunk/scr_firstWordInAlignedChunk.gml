

function scr_firstWordInAlignedChunk(tokenID){
	
	// if this word is the first word in an aligned chunk,
	// then return the chainID for the aligned chain on that chunk
	// otherwise return ""
	
	var alignedChunkChainID = "";
	var tokenSubMap =  global.nodeMap[?tokenID];
	
	if (scr_isNumericAndExists(tokenSubMap, ds_type_map)) {
		var tokenInChunkList = tokenSubMap[?"inChunkList"];
		if (scr_isNumericAndExists(tokenInChunkList, ds_type_list)) {
			var tokenInChunkListSize = ds_list_size(tokenInChunkList);
			for (var i = 0; i < tokenInChunkListSize; i++) {
				var currentChunk = tokenInChunkList[| i];
				var currentChunkSubMap = global.nodeMap[? currentChunk];
				if (scr_isNumericAndExists(currentChunkSubMap, ds_type_map)) {
					var currentChunkInChainsList = currentChunkSubMap[? "inChainsList"];
					if (scr_isNumericAndExists(currentChunkInChainsList, ds_type_list)) {
						if (scr_getFirstWordOfChunk(currentChunk) == tokenID) {
							var currentChunkInChainsListSize = ds_list_size(currentChunkInChainsList);
							for (var j = 0; j < currentChunkInChainsListSize; j++) {
								var currentChunkInChain = currentChunkInChainsList[| j];
								var currentChunkInChainSubMap = global.nodeMap[? currentChunkInChain];
								if (scr_isNumericAndExists(currentChunkInChainSubMap, ds_type_map)) {
									if (currentChunkInChainSubMap[? "alignChain"]) alignedChunkChainID = currentChunkInChain;
								}
							}
						}
					}
				}
			}
		}
	}
	
	return alignedChunkChainID;

}