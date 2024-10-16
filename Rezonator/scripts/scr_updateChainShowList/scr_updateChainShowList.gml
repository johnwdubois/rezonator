

function scr_updateChainShowList(inChainsList, inEntryList, chainShowList, inBoxList,tokenID,rectX1,rectY1,rectX2,rectY2, mouseOverToken) {
	
	// get size of inChainsList
	var inChainsListSize = 0;
	if (scr_isNumericAndExists(inChainsList, ds_type_list)) inChainsListSize = ds_list_size(inChainsList);
		
	// if this word has any chains that are not yet in the chainShowList, add them!
	for (var i = 0; i < inChainsListSize; i++) {
		var currentChain = inChainsList[| i];
		if (ds_map_exists(global.nodeMap,currentChain)) {
			
			// if there is a chain in the inChainsList that is not a string, let's remove it
			if (!is_string(currentChain)) { 
				scr_deleteFromList(inChainsList, currentChain);
				continue;
			}
			
			var chainSubMap = global.nodeMap[?currentChain];
			var chainType = chainSubMap[? "type"];


			// add this chain to chainShowList and chainShowMap
			scr_addToListOnce(chainShowList, currentChain);
			
			var inEntryListSize = ds_list_size(inEntryList);
			for (var j = 0; j < inEntryListSize; j++) {
				var currentEntry = inEntryList[| j]
				var currentEntrySubMap = global.nodeMap[? currentEntry];
				var currentEntryType = currentEntrySubMap[? "type"];
				if ((chainType == "resonance" && currentEntryType == "rez") || (chainType == "trail" && currentEntryType == "track")) {
					scr_updateChainShowMap(currentChain, currentEntry, tokenID);
				}
			}

			

			
			
			
			// get cool chain vars
			var chainColor = chainSubMap[? "chainColor"];
			var chainType = chainSubMap[? "type"];
			var chainVisible = chainSubMap[? "visible"];
				
			// draw filled in rect if this is the focused entry of the focused chain
			if (obj_chain.mouseLineWordID == tokenID && obj_chain.currentFocusedChainID == currentChain) {
				draw_set_alpha(0.25);
				draw_set_color(chainColor);
				if (chainType == "resonance") draw_rectangle(rectX1, rectY1, rectX2, rectY2, false);
				else if (chainType == "trail") draw_roundrect(rectX1, rectY1, rectX2, rectY2, false);
				draw_set_alpha(1);
			}
			else if (mouseOverToken) {
				draw_set_color(merge_color(global.colorThemeSelected1, global.colorThemeBG, 0.5));
				if (chainType == "resonance") draw_rectangle(rectX1, rectY1, rectX2, rectY2, false);
				else if (chainType == "trail") draw_roundrect(rectX1, rectY1, rectX2, rectY2, false);
			}

				
			// draw border around token if its in a chain
			if (chainVisible) {
				draw_set_color(chainColor);
				draw_set_alpha(1);
				scr_drawRectWidth(rectX1, rectY1, rectX2, rectY2, (obj_chain.currentFocusedChainID == currentChain) ? 3 : 2, chainType == "trail");
			}
			
			
		}
		else {
			// if this chain can't be found in the nodeMap, we should remove it from the inChainsList!
			scr_deleteFromList(inChainsList, currentChain);
		}
	}
	
	
	
	// get size of inBoxList
	var inBoxListSize = 0;
	if (scr_isNumericAndExists(inBoxList, ds_type_list)) inBoxListSize = ds_list_size(inBoxList);
	
	// if this word has any chunks that are not yet in chunkShowList, add them!
	for (var i = 0; i < inBoxListSize; i++) {
		var currentChunk = inBoxList[| i];
		

		// check if this chunk is in any chains that should be added to chainShowList
		var currentChunkSubMap = global.nodeMap[? currentChunk];
		if (scr_isNumericAndExists(currentChunkSubMap, ds_type_map)) {
			
			var currentChunkNest = currentChunkSubMap[? "nest"];
			if (ds_map_exists(obj_chain.chunkShowMap, string(currentChunkNest))) {
				var nestList = obj_chain.chunkShowMap[? string(currentChunkNest) ];
				scr_addToListOnce(nestList, currentChunk);
			}
			else {
				var nestList = ds_list_create();
				ds_list_add(nestList, currentChunk);
				ds_map_add_list(obj_chain.chunkShowMap, string(currentChunkNest), nestList);
			}


			var currentChunkInChainsList = currentChunkSubMap[? "inChainsList"];
			var currentChunkInEntryList = currentChunkSubMap[? "inEntryList"];
			if (scr_isNumericAndExists(currentChunkInChainsList, ds_type_list) && scr_isNumericAndExists(currentChunkInEntryList, ds_type_list)) {
				var currentChunkInChainsListSize = ds_list_size(currentChunkInChainsList);
				for (var j = 0; j < currentChunkInChainsListSize; j++) {
					var currentChain = currentChunkInChainsList[| j];
					scr_addToListOnce(chainShowList, currentChain);
					var currentChainSubMap = global.nodeMap[? currentChain];
					var currentChainType = currentChainSubMap[? "type"];
					
					var currentChunkInEntryListSize = ds_list_size(currentChunkInEntryList);
					for (var k = 0; k < currentChunkInEntryListSize; k++) {
						var currentChunkEntry = currentChunkInEntryList[| k];
						var currentChunkEntrySubMap = global.nodeMap[? currentChunkEntry];
						var currentChunkEntryType = currentChunkEntrySubMap[? "type"];
						if ((currentChainType == "resonance" && currentChunkEntryType == "rez") || (currentChainType == "trail" && currentChunkEntryType == "track")) {
							scr_updateChainShowMap(currentChain, currentChunkEntry, scr_getFirstWordOfChunk(currentChunk));
						}
					}
				}
			}

		}
		else {
			// if this chunk can't be found in the nodeMap, we should remove it from the inBoxList!
			scr_deleteFromList(inBoxList, currentChunk);
		}
	}

}