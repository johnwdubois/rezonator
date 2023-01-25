function scr_deleteToken(tokenID) {
	
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
	var tokenSeq = tokenSubMap[? "tokenOrder"];
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
			currentTokenSubMap[? "tokenOrder"]--;
		}
		
		// always decrement discourseTokenSeq
		currentTokenSubMap[? "docTokenSeq"]--;
	}
	
	// remove this token from all chains that it is in
    var inChainsList = tokenSubMap[? "inChainsList"];
    if (scr_isNumericAndExists(inChainsList, ds_type_list)) {
        while (ds_list_size(inChainsList) > 0) {
            obj_chain.currentFocusedChainID = inChainsList[| 0];

            var chainSubMap = global.nodeMap[? obj_chain.currentFocusedChainID];
            if (scr_isNumericAndExists(chainSubMap, ds_type_map)) {
                scr_deleteFromChain(true);
            }
        }
    }
	
	entryListSize = ds_list_size(entryList);
	if (entryListSize <= 1) {
		scr_unitClicked(unitID);
		scr_objControlKeyDelete();
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
			
			with (obj_panelPane) functionTree_treeSelected = currentTree;
			
			var currentSetListSize = ds_list_size(currentSetList);
			for (var j = 0; j < currentSetListSize; j++) {
				var currentEntry = currentSetList[| j];
				var currentEntrySubMap = global.treeMap[? currentEntry];
				if (!scr_isNumericAndExists(currentEntrySubMap, ds_type_map)) continue;
				
				var currentEntryTokenList = currentEntrySubMap[? "tokenList"];
				if (!scr_isNumericAndExists(currentEntryTokenList, ds_type_list)) continue;
				
				if (ds_list_find_index(currentEntryTokenList, tokenID) >= 0) {				
					
					// we have found the corresponding tree entry, let's remove it from the entry's tokenList
					scr_deleteFromList(currentEntryTokenList, tokenID);
					
					// if there is nothing else in the entry's token list, let's delete it from the tree
					if (ds_list_size(currentEntryTokenList) == 0) {
						obj_chain.currentFocusedEntryID = currentEntry;
						scr_deleteTreeEntry();
						scr_deleteFromList(currentSetList, currentEntry);
						
						// now we must destroy the entrySubMap itself, everything data structure it contains, and remove it from the treeMap
						ds_map_delete(global.treeMap, currentEntry);
						var currentEntryGoalLinkList = currentEntrySubMap[? "goalLinkList"];
						if (scr_isNumericAndExists(currentEntryGoalLinkList, ds_type_list)) ds_list_destroy(currentEntryGoalLinkList);
						ds_list_destroy(currentEntryTokenList);
						ds_map_destroy(currentEntrySubMap);
					}
				}
			}
			
			// remove the token from the tree's tokenList
			scr_deleteFromList(currentTokenList, tokenID);
			
			// if there is nothing else in this tree, let's delete the entire tree
			if (ds_list_size(currentTokenList) < 1) {
				scr_deleteTree(currentTree);
				with (obj_panelPane) functionTree_treeSelected = "";
			}
			else {
				// now we have to update all the order values from this tree
				var currentSetListSize = ds_list_size(currentSetList);
				for (var j = 0; j < currentSetListSize; j++) {
					var currentEntry = currentSetList[| j];
					var currentEntrySubMap = global.treeMap[? currentEntry];
					if (!scr_isNumericAndExists(currentEntrySubMap, ds_type_map)) continue;
					currentEntrySubMap[? "order"] = j;
				}
			}
		}
	}
	
	// remove this token from any searches that it is in
	var removeSearchList = ds_list_create();
	var searchList = global.nodeMap[? "searchNodeList"];
	var searchListSize = ds_list_size(searchList);
	var searchMap = global.nodeMap[? "searchMap"];
	for (var i = 0; i < searchListSize; i++) {
		var currentSearchID = searchList[| i];
		var currentSearchSubMap = searchMap[? currentSearchID];
		var currentSearchDisplayTokenList = currentSearchSubMap[? "displayTokenList"];
		var currentSearchDisplayUnitList = currentSearchSubMap[? "displayUnitList"];
		var currentSearchSelectedTokenList = currentSearchSubMap[? "selectedTokenList"];
		scr_deleteFromList(currentSearchDisplayTokenList, tokenID);
		scr_deleteFromList(currentSearchSelectedTokenList, tokenID);
		
		// let's check to see if there is anything left in the search, now that we've removed the deleted token
		var currentSearchDisplayTokenListSize = ds_list_size(currentSearchDisplayTokenList);
		if (currentSearchDisplayTokenListSize < 1) {
			ds_list_add(removeSearchList, currentSearchID);
		}
		else {
			// we need to check if this search has any other token that belongs to this unit (to see if we should remove from the displayUnitList)
			var removeUnit = true;
			for (var j = 0; j < currentSearchDisplayTokenListSize; j++) {
				var currentSearchDisplayToken = currentSearchDisplayTokenList[| j];
				var currentSearchDisplayTokenSubMap = global.nodeMap[? currentSearchDisplayToken];
				var currentSearchDisplayUnit = currentSearchDisplayTokenSubMap[? "unit"];
				if (currentSearchDisplayUnit == unitID) {
					removeUnit = false;
					break;
				}
			}
		
			if (removeUnit) {
				scr_deleteFromList(currentSearchDisplayUnitList, unitID);
			}
		}
	}
	
	// delete any searches if we need to (we do this after the fact so that our loop doesn't get screwed up)
	var removeSearchListSize = ds_list_size(removeSearchList);
	for (var i = 0; i < removeSearchListSize; i++) {
		var currentSearchID = removeSearchList[| i];
		scr_removeSearch(currentSearchID);
	}
	ds_list_destroy(removeSearchList);
	
	
	// remove this token's entry from the unit's entry list
	ds_list_delete(entryList, entryListIndex);
	
	// remove this token from the discourse's tokenList
	scr_deleteFromList(discourseTokenList, tokenID);
	
	// remove this token from the nodeMap :o
	scr_deleteFromNodeMap(tokenID);
	
	// collect & destroy all of this token's sub-data structures
	var tagMap = tokenSubMap[? "tagMap"];
	var inChainsList = tokenSubMap[? "inChainsList"];
	if (scr_isNumericAndExists(tagMap, ds_type_map)) ds_map_destroy(tagMap);
	if (scr_isNumericAndExists(inChainsList, ds_type_list)) ds_list_destroy(inChainsList);
	if (scr_isNumericAndExists(inChunkList, ds_type_list)) ds_list_destroy(inChunkList);
	
	// destroy this token's submap
	ds_map_destroy(tokenSubMap);
	

}