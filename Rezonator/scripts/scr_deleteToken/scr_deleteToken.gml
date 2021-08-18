// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_deleteToken(tokenID){
	
	// get token submap and make sure it exists
	show_debug_message("scr_deleteToken ... tokenID: " + string(tokenID));
	var tokenSubMap = global.nodeMap[? tokenID];
	if (!scr_isNumericAndExists(tokenSubMap, ds_type_map)) exit;
	
	
	// get the unit for this token, and find what index this token is in that unit's entry list
	var unitID = tokenSubMap[? "unit"];
	var unitSubMap = global.nodeMap[? unitID];
	var entryListIndex = -1;
	var entryList = unitSubMap[? "entryList"];
	var entryListSize = ds_list_size(entryList);
	for (var i = 0; i < entryListSize; i++) {
		var currentEntry = entryList[| i];
		var currentEntrySubMap = global.nodeMap[? currentEntry];
		var currentToken = currentEntrySubMap[? "token"];
		if (currentToken == tokenID) {
			entryListIndex = i;
		}
	}
	
	// update tokenSeq values
	var tokenSeq = tokenSubMap[? "tokenSeq"];
	var discourseSubMap = global.nodeMap[? global.discourseNode];
	var discourseTokenList = discourseSubMap[? "tokenList"];
	var discourseTokenListSize = ds_list_size(discourseTokenList);
	var tokenListIndex = ds_list_find_index(discourseTokenList, tokenID);
	for (var i = tokenListIndex + 1; i < discourseTokenListSize; i++) {
		var currentToken = discourseTokenList[| i];
		var currentTokenSubMap = global.nodeMap[? currentToken];
		var currentUnit = currentTokenSubMap[? "unit"];
		
		// if this token is in the same unit as our deleted token, let's decrement its tokenSeq
		if (currentUnit == unitID) {
			currentTokenSubMap[? "tokenSeq"]--;
		}
		
		// always decrement discourseTokenSeq
		currentTokenSubMap[? "discourseTokenSeq"]--;
	}
	
	// remove this token from all chains that it is in
	var inChainsList = tokenSubMap[?"inChainsList"];
	if (scr_isNumericAndExists(inChainsList, ds_type_list)) {
		while (ds_list_size(inChainsList) > 0) {
			scr_deleteFromChain(true);
		}
	}
	
	// remove this token from all chunks it is in
	var inChunkList = tokenSubMap[? "inChunkList"];
	if (scr_isNumericAndExists(inChunkList, ds_type_list)) {
		while (ds_list_size(inChunkList) > 0) {
			var currentChunk = inChunkList[| 0];
			var currentChunkSubMap = global.nodeMap[? currentChunk];
			if (scr_isNumericAndExists(currentChunkSubMap, ds_type_map)) {
				var currentChunkTokenList = currentChunkSubMap[? "tokenList"];
				if (scr_isNumericAndExists(currentChunkTokenList, ds_type_list)) {
					var realignChunk = (currentChunkTokenList[| 0] == tokenID);
					scr_deleteFromList(currentChunkTokenList, tokenID);
					if (ds_list_size(currentChunkTokenList) <= 0) {
						scr_deleteChunk(currentChunk);
					}
					else if (realignChunk) {
						// if we are deleting a token that was the first token in a chunk, we need to see if that chunk was in any chains and if so realign them
						var currentChunkInChainsList = currentChunkSubMap[? "inChainsList"];
						if (scr_isNumericAndExists(currentChunkInChainsList, ds_type_list)) {
							var currentChunkInChainsListSize = ds_list_size(currentChunkInChainsList);
							for (var i = 0; i < currentChunkInChainsListSize; i++) {
								scr_alignChain2ElectricBoogaloo(currentChunkInChainsList[| i]);
							}
						}
					}
				}
			}
			scr_deleteFromList(inChunkList, currentChunk);
		}
	}
	
	// remove this token from all trees it is in
	var treeList = global.nodeMap[? "treeList"];
	if (scr_isNumericAndExists(treeList, ds_type_list) && scr_isNumericAndExists(global.treeMap, ds_type_map)) {
		var treeListSize = ds_list_size(treeList);
		for (var i = 0; i < treeListSize; i++) {
			var currentTree = treeList[| i];
			var currentTreeSubMap = global.treeMap[? currentTree];
			if (!scr_isNumericAndExists(currentTreeSubMap, ds_type_map)) continue;
			var currentTokenList = currentTreeSubMap[? "tokenList"];
			if (!scr_isNumericAndExists(currentTokenList, ds_type_list)) continue;
			var currentSetList = currentTreeSubMap[? "setIDList"];
			if (!scr_isNumericAndExists(currentSetList, ds_type_list)) continue;
			
			// check if the token appears in this tree, if the token is in this tree find its corresponding entry
			if (ds_list_find_index(currentTokenList, tokenID) == -1) continue;
			var currentSetListSize = ds_list_size(currentSetList);
			for (var j = 0; j < currentSetListSize; j++) {
				var currentEntry = currentSetList[| j];
				var currentEntrySubMap = global.treeMap[? currentEntry];
				if (!scr_isNumericAndExists(currentEntrySubMap, ds_type_map)) continue;
				
				var currentEntryTokenList = currentEntrySubMap[? "tokenList"];
				if (ds_list_find_index(currentEntryTokenList, tokenID) >= 0) {				
					
					// we have found the corresponding tree entry, let's remove it from the entry's tokenList
					scr_deleteFromList(currentEntryTokenList, tokenID);
					
					// if there is nothing else in the entry's token list, let's delete it from the tree
					if (ds_list_size(currentEntryTokenList) == 0) {
						obj_chain.currentFocusedEntryID = currentEntry;
						scr_deleteTreeEntry();
						scr_deleteFromList(currentSetList, currentEntry);
					}
				}
			}
			
			// remove the token from the tree's tokenList
			scr_deleteFromList(currentTokenList, tokenID);
		}
	}
	
	
	// remove this token's entry from the unit's entry list
	ds_list_delete(entryList, entryListIndex);
	
	// remove this token from the discourse's tokenList
	scr_deleteFromList(discourseTokenList, tokenID);
	
	// remove this token from the nodeMap :o
	ds_map_delete(global.nodeMap, tokenID);
	
	// collect & destroy all of this token's sub-data structures
	var tagMap = tokenSubMap[? "tagMap"];
	var inChainsList = tokenSubMap[? "inChainsList"];
	if (scr_isNumericAndExists(tagMap, ds_type_map)) ds_map_destroy(tagMap);
	if (scr_isNumericAndExists(inChainsList, ds_type_list)) ds_list_destroy(inChainsList);
	if (scr_isNumericAndExists(inChunkList, ds_type_list)) ds_list_destroy(inChunkList);
	
	// destroy this token's submap
	ds_map_destroy(tokenSubMap);
	

}