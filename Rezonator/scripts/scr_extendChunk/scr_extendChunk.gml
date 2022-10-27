function scr_extendChunk(chunkID, extendToPrev){
	
	var chunkSubMap = global.nodeMap[? chunkID];
	if (!scr_isNumericAndExists(chunkSubMap, ds_type_map)) {
		exit;
	}
	
	var tokenList = chunkSubMap[? "tokenList"];
	if (!scr_isNumericAndExists(tokenList, ds_type_list)) {
		exit;
	}

	
	if (extendToPrev) {
		var firstToken = tokenList[| 0];
		var firstTokenSubMap = global.nodeMap[? firstToken];
		var prevToken = firstTokenSubMap[? "prevToken"];
		if (is_string(prevToken) && prevToken != "") {
			ds_list_insert(tokenList, 0, prevToken);
		}
	}
	else {
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
						ds_list_add(tokenList, nextToken);
					}
				}
			}
		}
	}

}