function scr_newToken(newTokenStr, refTokenID) {
	/*
		Purpose: Create a new word within the discourse based on user string input
	*/
	if(string_length(string(newTokenStr)) <= 0 or newTokenStr == undefined){exit;}

	var refTokenSubMap = global.nodeMap[? refTokenID];
	if(!scr_isNumericAndExists(refTokenSubMap, ds_type_map)){ exit; }
	
	
	// get the tokenSeq & displayCol for our new token
	show_debug_message("insert Before:   "+ string(obj_control.before));
	var newTokenSeqIncr = (obj_control.before) ? 0 : 1;
	var newDiscourseTokenSeq = refTokenSubMap[? "docTokenSeq"] + newTokenSeqIncr;
	var newTokenSeq = refTokenSubMap[? "tokenOrder"] + newTokenSeqIncr;
	var newDisplayCol = refTokenSubMap[? "displayCol"] + newTokenSeqIncr;

	
	// get the unitID for the ref token
	var unitID = refTokenSubMap[? "unit"];
	var unitSubMap = global.nodeMap[? unitID];
	
	// get chunkList for ref token
	var refTokenInChunkList = refTokenSubMap[? "inChunkList"];
	
	// create new token Node
	var newTokenID = scr_createTokenNode(newDiscourseTokenSeq, newTokenStr, newTokenSeq, newDisplayCol, unitID);
	
	

	var unitEntryList = unitSubMap[?"entryList"];
	var indexToAdd = -1;
	
	// find which index in the unit's entryList the refToken is at
	var sizeOfEntryList = ds_list_size(unitEntryList);
	for (var i = 0; i < sizeOfEntryList; i++) {
		var currentEntry = unitEntryList[| i];
		var currentEntrySubMap = global.nodeMap[? currentEntry];
		if (refTokenID == currentEntrySubMap[? "token"]) {
			indexToAdd = i;
		}
	}
	indexToAdd += newTokenSeqIncr;
	
	
	// make entry node for newToken
	var currentEntryNode = scr_addToNodeMap("entry");
	var currentEntrySubMap = global.nodeMap[? currentEntryNode];
	ds_map_add(currentEntrySubMap, "token", newTokenID);
	ds_map_add(currentEntrySubMap, "unit", unitID);
	
	// inserting entry node into unit's entry list
	ds_list_insert(unitEntryList, indexToAdd, currentEntryNode);
	
	
	// find which index of the tokenList the refToken is at
	var discourseSubMap = global.nodeMap[? global.discourseNode];
	var tokenList = discourseSubMap[? "tokenList"];
	var indexOfRefToken = ds_list_find_index(tokenList, refTokenID);
		
	// insert new token into the tokenList
	var indexOfNewToken = indexOfRefToken + newTokenSeqIncr;
	ds_list_insert(tokenList, indexOfNewToken, newTokenID);
	
	
	// increment the tokenSeq values for every token past newToken
	var sizeOfTokenList = ds_list_size(tokenList);
	for (var i = indexOfNewToken + 1; i < sizeOfTokenList; i++) {
		
		var currentToken = tokenList[| i];
		var currentTokenSubMap = global.nodeMap[? currentToken];
		var currentUnitID = currentTokenSubMap[? "unit"];
		
		// if this token is in the same unit as our new token, we need to increment its tokenSeq
		if (unitID == currentUnitID) {
			currentTokenSubMap[? "tokenOrder"]++;
		}
		
		// increment discourseTokenSeq
		currentTokenSubMap[? "docTokenSeq"]++;
	}
	
	if(obj_chain.currentFocusedChainID != ""){
		var chainSubMap = global.nodeMap[?obj_chain.currentFocusedChainID];
		if(scr_isNumericAndExists(chainSubMap, ds_type_map)){
			if(chainSubMap[?"type"] != "stack"){
				scr_newLink(newTokenID);
			}
		}
	}
	
	// run through unit again and refresh each token's prevToken
	sizeOfEntryList = ds_list_size(unitEntryList);
	for (var i = 0; i < sizeOfEntryList; i++) {
		var currentEntry = unitEntryList[| i];
		var currentEntrySubMap = global.nodeMap[? currentEntry];
		var currentToken = currentEntrySubMap[? "token"];
		var currentTokenSubMap = global.nodeMap[? currentToken];
		
		currentTokenSubMap[? "prevToken"] = scr_prevTokenInSequence(currentToken);
	}
	
	
	// insert the new token into any chunks, if we need to
	var refTokenInChunkListSize = ds_list_size(refTokenInChunkList);
	for (var i = 0; i < refTokenInChunkListSize; i++) {
		var currentChunk = refTokenInChunkList[| i];
		var currentChunkSubMap = global.nodeMap[? currentChunk];
		if (!scr_isNumericAndExists(currentChunkSubMap, ds_type_map)) continue;
		var currentChunkTokenList = currentChunkSubMap[? "tokenList"];
		if (!scr_isNumericAndExists(currentChunkTokenList, ds_type_list)) continue;
		
		var refTokenChunkIndex = ds_list_find_index(currentChunkTokenList, refTokenID);
		var newTokenChunkIndex = (obj_control.before) ? refTokenChunkIndex : refTokenChunkIndex + 1;
		ds_list_insert(currentChunkTokenList, newTokenChunkIndex, newTokenID);
	}
	
	
	// get the tokens that surround the new token within the unit, if they exist
	var newTokenUnitIndex = ds_list_find_index(unitEntryList, currentEntryNode);
	var prevEntryID = "";
	var prevTokenID = "";
	var nextEntryID = "";
	var nextTokenID = "";
	if (newTokenUnitIndex - 1 >= 0) {
		prevEntryID = unitEntryList[| newTokenUnitIndex - 1];
		var prevEntrySubMap = global.nodeMap[? prevEntryID];
		prevTokenID = prevEntrySubMap[? "token"];
	}
	if (newTokenUnitIndex + 1 < ds_list_size(unitEntryList)) {
		nextEntryID = unitEntryList[| newTokenUnitIndex + 1];
		var nextEntrySubMap = global.nodeMap[? nextEntryID];
		nextTokenID = nextEntrySubMap[? "token"];
	}
	show_debug_message("prevTokenID: " + string(prevTokenID) + ", nextTokenID: " + string(nextTokenID));
	
	// add this to a tree if we need to
	var treeList = global.nodeMap[? "treeList"];
	var treeListSize = ds_list_size(treeList);
	for (var i = 0; i < treeListSize; i++) {
		var currentTree = treeList[| i];
		var currentTreeSubMap = global.treeMap[? currentTree];
		var currentTreeTokenList = currentTreeSubMap[? "tokenList"];
		
		var addingToTreeChunk = false;
		
		// if this tree contains the ref token, we need to add to it
		var refTokenInTreeIndex = ds_list_find_index(currentTreeTokenList, refTokenID);
		if (refTokenInTreeIndex >= 0) {
			
			// now we determine if we're adding to a tree chunk, or just making a new tree entry
			var currentTreeSetIDList = currentTreeSubMap[? "setIDList"];
			var currentTreeSetIDListSize = ds_list_size(currentTreeSetIDList);
			for (var j = 0; j < currentTreeSetIDListSize; j++) {
				
				var currentTreeEntry = currentTreeSetIDList[| j];
				var currentTreeEntrySubMap = global.treeMap[? currentTreeEntry];
				var currentTreeEntryTokenList = currentTreeEntrySubMap[? "tokenList"];
				
				// check if the new token should be added to a tree chunk (the tree chunk would need at least 2 tokens)
				if (prevTokenID != "" && nextTokenID != "" && ds_list_size(currentTreeEntryTokenList) >= 2) {
					var prevTokenIndex = ds_list_find_index(currentTreeEntryTokenList, prevTokenID);
					var nextTokenIndex = ds_list_find_index(currentTreeEntryTokenList, nextTokenID);
					show_debug_message("prevTokenIndex: " + string(prevTokenIndex) + ", nextTokenIndex: " + string(nextTokenIndex));
						
					if (prevTokenIndex >= 0 && nextTokenIndex >= 0) {
						ds_list_insert(currentTreeEntryTokenList, nextTokenIndex, newTokenID);
						addingToTreeChunk = true;
					}
				}
			}
			
			// if we're not adding to a tree chunk, we will create a new tree entry
			if (!addingToTreeChunk) {
				var newTreeEntryOrder = (obj_control.before) ? refTokenInTreeIndex - 1 : refTokenInTreeIndex;
				scr_createTreeEntry(currentTree, newTokenID, newTreeEntryOrder);
				// because we've inserted a new tree entry, we need to increment the order values for the following entries in this tree
				for (var j = newTreeEntryOrder; j < currentTreeSetIDListSize; j++) {
					var currentTreeEntry = currentTreeSetIDList[| j];
					var currentTreeEntrySubMap = global.treeMap[? currentTreeEntry];
					currentTreeEntrySubMap[? "order"] = currentTreeEntrySubMap[? "order"] + 1;
				}
			}
			
			show_debug_message("addingToTreeChunk: " + string(addingToTreeChunk));
		}
	}
	
}
