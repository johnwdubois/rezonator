function scr_removeTokensInChunkFromChain(chunkID, chainID) {
	
	show_debug_message("scr_removeTokensInChunkFromChain, chunkID: " + string(chunkID) + ", chainID: " + string(chainID));
	
	// make sure we get IDs
	if (!is_string(chainID) || chainID == "") exit;
	if (!is_string(chunkID) || chunkID == "") exit;
	
	// make sure this is a valid chunk
	var chunkSubMap = global.nodeMap[? chunkID];
	if (!scr_isNumericAndExists(chunkSubMap, ds_type_map)) exit;
	var tokenList = chunkSubMap[? "tokenList"];
	if (!scr_isNumericAndExists(tokenList, ds_type_list)) exit;
	
	var tokenListSize = ds_list_size(tokenList);
	for (var i = 0; i < tokenListSize; i++) {
		var currentToken = tokenList[| i];
		var currentTokenSubMap = global.nodeMap[? currentToken];
		if (!scr_isNumericAndExists(currentTokenSubMap, ds_type_map)) continue;
		
		var currentTokenInEntryList = currentTokenSubMap[? "inEntryList"];
		if (!scr_isNumericAndExists(currentTokenInEntryList, ds_type_list)) continue;
		
		var currentTokenInEntryListSize = ds_list_size(currentTokenInEntryList);
		for (var j = 0; j < currentTokenInEntryListSize; j++) {
			var currentEntry = currentTokenInEntryList[| j];
			var currentEntrySubMap = global.nodeMap[? currentEntry];
			if (!scr_isNumericAndExists(currentEntrySubMap, ds_type_map)) continue;
			
			// if we find an entry that is in the given chain, we focus that entry so it can be deleted
			var currentChain = currentEntrySubMap[? "chain"];
			if (currentChain == chainID) {
				var currentChainSubMap = global.nodeMap[? currentChain];
				currentChainSubMap[? "focused"] = currentEntry;
				obj_chain.currentFocusedChainID = currentChain;
				scr_deleteFromChain(true);
			}
		}
	}

}