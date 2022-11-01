function scr_extendChunk(ID, extendToPrev){
	
	// make sure we have a valid submap
	var subMap = global.nodeMap[? ID];
	if (!scr_isNumericAndExists(subMap, ds_type_map)) {
		exit;
	}
	var idType = subMap[? "type"];


	// if we have a chunk, we can extend that chunk
	if (idType == "chunk") {
		
		var chunkID = ID;
		var chunkSubMap = subMap;
			
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
	else if (idType == "token") {
		
		// if we have a token, we need to create a chunk
		var tokenID = ID;
		var tokenSubMap = subMap;
		
		if (extendToPrev) {
			var prevToken = tokenSubMap[? "prevToken"];
			if (is_string(prevToken) && prevToken != "") {
				ds_list_clear(obj_control.inRectTokenIDList);
				ds_list_add(obj_control.inRectTokenIDList, prevToken, tokenID);
				ds_list_clear(obj_control.inRectUnitIDList);
				var origUnitID = tokenSubMap[? "unit"];
				ds_list_add(obj_control.inRectUnitIDList, origUnitID);
				obj_control.mouseoverPanelPane = false;
				obj_control.createChunkNoChain = true;
				scr_createChunk();
			}
		}
		else {
			var nextToken = "";
			var unitID = tokenSubMap[? "unit"];
			var unitSubMap = global.nodeMap[? unitID];
			var unitEntryList = unitSubMap[? "entryList"];
			var unitEntryListSize = ds_list_size(unitEntryList);
			
			for (var i = 0; i < unitEntryListSize; i++) {
				var currentUnitEntry = unitEntryList[| i];
				var currentUnitEntrySubMap = global.nodeMap[? currentUnitEntry];
				var currentUnitToken = currentUnitEntrySubMap[? "token"];
				if (currentUnitToken == tokenID && i + 1 < unitEntryListSize) {
					var nextUnitEntry = unitEntryList[| i + 1];
					var nextUnitEntrySubMap = global.nodeMap[? nextUnitEntry];
					nextToken = nextUnitEntrySubMap[? "token"];
				}
			}
			
			if (is_string(nextToken) && nextToken != "") {
				ds_list_clear(obj_control.inRectTokenIDList);
				ds_list_add(obj_control.inRectTokenIDList, tokenID, nextToken);
				ds_list_clear(obj_control.inRectUnitIDList);
				var origUnitID = tokenSubMap[? "unit"];
				ds_list_add(obj_control.inRectUnitIDList, origUnitID);
				obj_control.mouseoverPanelPane = false;
				obj_control.createChunkNoChain = true;
				scr_createChunk();
			}
		}
		
		
		
		var tokenInChainsList = tokenSubMap[? "inChainsList"];
		var tokenInChainsListSize = ds_list_size(tokenInChainsList)
		if (tokenInChainsListSize >= 1) {
			for (var i = 0; i < tokenInChainsListSize; i++) {
				var currentChain = tokenInChainsList[| i];
				var currentChainSubMap = global.nodeMap[? currentChain];
				var currentChainType = currentChainSubMap[? "type"];
				if (currentChainType == "resonance") {
					obj_toolPane.currentMode = obj_toolPane.modeRez;
					obj_toolPane.currentTool = obj_toolPane.toolRezBrush;
				}
				else if (currentChainType == "trail") {
					obj_toolPane.currentMode = obj_toolPane.modeTrack;
					obj_toolPane.currentTool = obj_toolPane.toolTrackBrush;
				}
				
				obj_chain.currentFocusedChainID = currentChain;
				scr_newLink(obj_chain.currentFocusedChunkID);
			}
		}
	}

}