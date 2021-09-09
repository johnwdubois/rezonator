// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_updateChainShowList(inChainsList, inEntryList, chainShowList, inBoxList, chunkShowList, tokenID,rectX1,rectY1,rectX2,rectY2){
	
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
			
			if (updateChainShowMap) {
				// add this chain to chainShowList and chainShowMap
				scr_addToListOnce(chainShowList, currentChain);
				scr_updateChainShowMap(currentChain, inEntryList);
			}
			
			
			
			// get cool chain vars
			var chainSubMap = global.nodeMap[?currentChain];
			var chainColor = chainSubMap[?"chainColor"];
			var chainType = chainSubMap[?"type"];
			var chainVisible = chainSubMap[? "visible"];
				
			// draw filled in rect if this is the focused entry of the focused chain
			if (obj_chain.mouseLineWordID == tokenID && obj_chain.currentFocusedChainID == currentChain) {
				draw_set_alpha(0.25);
				draw_set_color(chainColor);
				if (chainType == "resonance") draw_rectangle(rectX1, rectY1, rectX2, rectY2, false);
				else if (chainType == "trail") draw_roundrect(rectX1, rectY1, rectX2, rectY2, false);
				draw_set_alpha(1);
			}
				
			// draw border around token if its in a chain
			if (chainVisible) {
				draw_set_color(chainColor);
				draw_set_alpha(1);
				scr_drawRectWidth(rectX1, rectY1, rectX2, rectY2, 2, chainType == "trail");
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
		if (ds_list_find_index(chunkShowList, currentChunk) == -1) {
			ds_list_add(chunkShowList, currentChunk);
		}
		// check if this chunk is in any chains that should be added to chainShowList
		var currentChunkSubMap = global.nodeMap[? currentChunk];
		if (scr_isNumericAndExists(currentChunkSubMap, ds_type_map)) {
			if (updateChainShowMap) {
				var currentChunkInChainsList = currentChunkSubMap[? "inChainsList"];
				var currentChunkInEntryList = currentChunkSubMap[? "inEntryList"];
				if (scr_isNumericAndExists(currentChunkInChainsList, ds_type_list) && scr_isNumericAndExists(currentChunkInEntryList, ds_type_list)) {
					var currentChunkInChainsListSize = ds_list_size(currentChunkInChainsList);
					for (var j = 0; j < currentChunkInChainsListSize; j++) {
						var currentChain = currentChunkInChainsList[| j];
						scr_addToListOnce(chainShowList, currentChain);
						scr_updateChainShowMap(currentChain, currentChunkInEntryList);
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