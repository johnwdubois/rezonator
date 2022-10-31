function scr_extendChunk(chunkID, extendToPrev){
	
	// make sure we have a valid chunk with a tokenlist
	var chunkSubMap = global.nodeMap[? chunkID];
	if (!scr_isNumericAndExists(chunkSubMap, ds_type_map)) {
		exit;
	}
	var tokenList = chunkSubMap[? "tokenList"];
	if (!scr_isNumericAndExists(tokenList, ds_type_list)) {
		exit;
	}
	
	
	var tokenToInsert = "";

	
	if (extendToPrev) {
		// if extending to previous, we can just use the first token's prevToken field
		var firstToken = tokenList[| 0];
		var firstTokenSubMap = global.nodeMap[? firstToken];
		var prevToken = firstTokenSubMap[? "prevToken"];
		if (is_string(prevToken) && prevToken != "") {
			tokenToInsert = prevToken;
		}
	}
	else {
		// if extending to next, we have to find the next token by looking in the unit's entrylist
		var lastToken = tokenList[| ds_list_size(tokenList) - 1];
		var lastTokenSubMap = global.nodeMap[? lastToken];
		var lastTokenUnit = lastTokenSubMap[? "unit"];
		var lastTokenUnitSubMap = global.nodeMap[? lastTokenUnit];
		if (scr_isNumericAndExists(lastTokenUnitSubMap, ds_type_map)) {
			var lastTokenUnitEntryList = lastTokenUnitSubMap[? "entryList"];
			if (scr_isNumericAndExists(lastTokenUnitEntryList, ds_type_list)) {
				
				// find the token after the last token in the chunk
				var lastTokenUnitEntryListSize = ds_list_size(lastTokenUnitEntryList);
				for (var i = 0; i < lastTokenUnitEntryListSize; i++) {
					var currentEntry = lastTokenUnitEntryList[| i];
					var currentEntrySubMap = global.nodeMap[? currentEntry];
					var currentToken = currentEntrySubMap[? "token"];
					
					// if we've found the last token in the chunk, and there are still more tokens in the unit...
					if (currentToken == lastToken && i + 1 < lastTokenUnitEntryListSize) {
						var nextEntry = lastTokenUnitEntryList[| i + 1];
						var nextEntrySubMap = global.nodeMap[? nextEntry];
						var nextToken = nextEntrySubMap[? "token"];
						tokenToInsert = nextToken;
					}
				}
			}
		}
	}
	
	
	if (is_string(tokenToInsert) && tokenToInsert != "") {
		
		// save list before adding
		var listBeforeAdding = ds_list_create();
		ds_list_copy(listBeforeAdding, tokenList);
		
		if (extendToPrev) ds_list_insert(tokenList, 0, tokenToInsert);
		else ds_list_add(tokenList, tokenToInsert);
		
		// show alert if chunk already exists
		if (scr_checkChunkAlreadyExists(chunkID, tokenList)) {
			show_debug_message("scr_extendChunk, chunk already exists");
			var inst = instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
			with (inst) {
				alertWindowActive = true;
				chunkAlreadyExists = true;
			}
			
			// if the chunk already exists, we will restore the original list
			ds_list_copy(tokenList, listBeforeAdding);
		}
		
		ds_list_destroy(listBeforeAdding);
	}

}