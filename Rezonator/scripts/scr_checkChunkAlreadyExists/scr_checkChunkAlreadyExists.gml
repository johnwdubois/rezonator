function scr_checkChunkAlreadyExists(chunkID, tokenList){
	
	var chunkList = global.nodeMap[? "chunkList"];
	if (scr_isNumericAndExists(chunkList, ds_type_list)) {
		var chunkListSize = ds_list_size(chunkList);
		
		for (var i = 0; i < chunkListSize; i++) {
			var currentChunk = chunkList[| i];
			if (is_string(chunkID) && currentChunk == chunkID) continue;
			
			var currentChunkSubMap = global.nodeMap[? currentChunk];
			var currentChunkTokenList = currentChunkSubMap[? "tokenList"];
			if (scr_compareLists(tokenList, currentChunkTokenList)) {
				return true;
			}
		}
	}
	
	return false;

}