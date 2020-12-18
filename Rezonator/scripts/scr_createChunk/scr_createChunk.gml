// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_createChunk(){
	
	// Place all captured unit and word info into the box grid
	var inRectWordIDListSize = ds_list_size(inRectWordIDList);
	var inRectUnitIDListSize = ds_list_size(inRectUnitIDList);
	
	var lastWordID = ds_list_find_value(inRectWordIDList, inRectWordIDListSize - 1);
	var lastWordDisplayRow = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayRow, lastWordID - 1);

	if(inRectWordIDListSize > 0 and not inRectUnitIDListSize > 0 and obj_control.mouseRectWithinLine) {
		ds_list_add(inRectUnitIDList, ds_grid_get(wordGrid, wordGrid_colUnitID, ds_list_find_value(inRectWordIDList, 0) - 1));

		trackChunkMade = true;
	}
	inRectUnitIDListSize = ds_list_size(inRectUnitIDList);

	if (inRectUnitIDListSize > 0 && inRectWordIDListSize > 0 && is_numeric(obj_control.chunkID)) { // Make sure the box captured something
		
		// Retrieve references of the lists being added to
		var currentUnitList = ds_list_create();
		var currentWordList = ds_list_create();
		

		// Expand the box grid to fit the new info
		ds_grid_resize(obj_chain.chunkGrid, obj_chain.chainGridWidth + 2, ds_grid_height(obj_chain.chunkGrid) + 1);
		ds_grid_set(obj_chain.chunkGrid, obj_chain.chainGrid_colChainID, ds_grid_height(obj_chain.chunkGrid) - 1, ++obj_control.chunkID);

		ds_grid_set(obj_chain.chunkGrid, obj_chain.chainGrid_colWordIDList, ds_grid_height(obj_chain.chunkGrid) - 1, currentUnitList);
		ds_grid_set(obj_chain.chunkGrid, obj_chain.chunkGrid_colBoxWordIDList, ds_grid_height(obj_chain.chunkGrid) - 1, currentWordList);
		ds_grid_set(obj_chain.chunkGrid, obj_chain.chunkGrid_colNest, ds_grid_height(obj_chain.chunkGrid) - 1, false);

		
		var innerLoop = 0;
	
		// Loop through words found in rectangle at time of mouse release
		for (var quickLoop = 0; quickLoop < inRectUnitIDListSize; quickLoop++) {
		
			// Extract the unit and word ID's that were captured
			var currentWordID = ds_list_find_value(inRectWordIDList, innerLoop);
			var currentUnitID = ds_list_find_value(inRectUnitIDList, quickLoop);
			
			show_debug_message("scr_createChunk() ... currentUnitList: " + scr_getStringOfList(currentUnitList) + ", " + "currentUnitID: " + string(currentUnitID));
		
			// Place unitID into box grid
			if (ds_list_find_index(currentUnitList, currentUnitID) == -1) {
				ds_list_add(currentUnitList, currentUnitID);
			}
		
			// Populate inBoxList of all words in new Chunk, still really need a better mechanism than this
			while (currentUnitID == ds_grid_get(wordGrid, wordGrid_colUnitID, currentWordID - 1)) {
			
				// Access the inBoxList
				var currentInBoxList = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInBoxList, currentWordID-1);
				if (ds_list_find_index(currentWordList, currentWordID) == -1) {
					// Place wordID into box grid
					ds_list_add(currentWordList, currentWordID);

					ds_list_add(currentInBoxList, obj_control.chunkID);
				} 
				// Safety check to not go over the list size
				if (innerLoop == inRectWordIDListSize - 1) {
					break;
				}
				// increment the current word
				currentWordID = ds_list_find_value(inRectWordIDList, ++innerLoop);
			}
		}
		
		show_debug_message("scr_createChunk() ... currentWordList: " + scr_getStringOfList(currentWordList));
	
		ds_grid_set(obj_chain.chunkGrid, obj_chain.chainGrid_colTiltSum, ds_grid_height(obj_chain.chunkGrid) - 1, ds_list_find_value(inRectWordIDList, inRectWordIDListSize - 1));
		if(not trackChunkMade) {
			scr_unFocusAllChains();
		}
		// If this box counts as a Chunk, mark it as such and nest it if possible
		if(ds_list_size(currentUnitList) == 1 && ds_list_size(currentWordList) > 1) {
		
			// Access the first word's in Chunk list
			var currentInChunkList = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInBoxList, ds_list_find_value(currentWordList, 0) - 1);
			
			var uniqueChunk = true;	
			// Loop through the in Chunk list, check if any elements are not the current chunk
			for(var chunkListLoop = 0; chunkListLoop < ds_list_size(currentInChunkList); chunkListLoop++) {
				
				var currentChunkID = obj_control.chunkID;
				var otherChunkID = ds_list_find_value(currentInChunkList, chunkListLoop);
				
				// Check if this word lies within another chunk
				if(currentChunkID != otherChunkID) {
					
					// Retrieve the word list of the Chunk to be compared
					var currentChunkRow = otherChunkID - 1;
					if(currentChunkRow < 0) {
						exit;
					}
					var otherChunkWordList = ds_grid_get(obj_chain.chunkGrid, obj_chain.chunkGrid_colBoxWordIDList, currentChunkRow);
				
					
					// Check if this chunk contains the other chunk
					if(scr_listContainsSublist(otherChunkWordList, currentWordList) != -1) {
					
						// Make sure this new Chunk is unique
						var currentListFirstWord = ds_list_find_value(currentWordList, 0);
						var currentListLastWord = ds_grid_get(obj_chain.chunkGrid, obj_chain.chainGrid_colTiltSum, ds_grid_height(obj_chain.chunkGrid) - 1);
						var otherListFirstWord = ds_list_find_value(otherChunkWordList, 0);
						var otherListLastWord = ds_grid_get(obj_chain.chunkGrid, obj_chain.chainGrid_colTiltSum, currentChunkRow);
					
						if(currentListFirstWord == otherListFirstWord && currentListLastWord == otherListLastWord) {
							uniqueChunk = false;
							continue;
						}
						//wordRectBuffer = 4;
						// Mark this Chunk as nested
						ds_grid_set(obj_chain.chunkGrid, obj_chain.chunkGrid_colNest, ds_grid_height(obj_chain.chunkGrid) - 1, true);
						continue;
					}
				}
			}
		
		
			if(uniqueChunk) {
				// Create an invisible new word to act as this Chunk's data type
				var currentWordID = ds_list_find_value(currentWordList, ds_list_size(currentWordList) - 1); // Use the last word so the contained words are drawn first
				var currentUnitID = ds_list_find_value(currentUnitList, 0);
				var chunkWordSeq = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordSeq, currentWordID - 1);
				scr_newWord(currentUnitID, chunkWordSeq, "", currentWordID, obj_control.chunkID);
		
				// Store the new word's ID
				var currentChunkWordID = ds_grid_height(obj_control.wordGrid);
				ds_grid_set(obj_chain.chunkGrid, obj_chain.chainGrid_colName, ds_grid_height(obj_chain.chunkGrid) - 1, currentChunkWordID);
				
				// Add the ChunkID to the front of the chunkWord's inBoxList
				ds_list_insert(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInBoxList, ds_grid_height(obj_control.dynamicWordGrid) - 1), 0, obj_control.chunkID);
			
			
				if(trackChunkMade) { 
					with (obj_chain) {
						scr_wordClicked(currentChunkWordID, currentUnitID);
					}
					mouseHoldRectX1 = 0; 
					mouseHoldRectX2 = 0; 
					mouseHoldRectY1 = 0; 
					mouseHoldRectY2 = 0; 
					//trackChunkMade = false;
				}
			}
		
		}
		// If this box is not a Chunk, then retrieve scroing information and package it for sending.
		else {
			/* Information needed
				-UnitID list
				-WordID list, segmented into units
				-inChainList for each word
				-voidSum from lineGrid
				-column for timeSpentOnLine
				-column for movesOnLine
				*/
			var newBoxGrid = ds_grid_create(boxGridWidth, ds_list_size(currentUnitList));
			var wordIDListLoop = 0;
			// Fill the UnitId and WordIdList columns
			var currentUnitListSize = ds_list_size(currentUnitList);
			for(var unitIDListLoop = 0; unitIDListLoop < currentUnitListSize ; unitIDListLoop++) {
				var currentUnitID = ds_list_find_value(currentUnitList, unitIDListLoop);
				ds_grid_set(newBoxGrid, boxGrid_colUnitID, unitIDListLoop, currentUnitID);
				var currentWordIDList = ds_list_create();
				var currentChainIDListList = ds_list_create();
				// Wondering how to get the words in an organized fashion??
				var currentWordID = ds_list_find_value(currentWordList, wordIDListLoop);
				while(wordIDListLoop < ds_list_size(currentWordList) && currentUnitID == ds_grid_get(wordGrid, wordGrid_colUnitID, currentWordID - 1)) {
					ds_list_add(currentWordIDList, currentWordID);
					// For each word, place their inChainList into the chainIDListList
					var currentChainIDList = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colInChainList, currentWordID - 1);
					ds_list_add(currentChainIDListList, currentChainIDList);
					// Increment the WordID
					currentWordID = ds_list_find_value(currentWordList, ++wordIDListLoop);
				}
				ds_grid_set(newBoxGrid, boxGrid_colWordIDList, unitIDListLoop, currentWordIDList);
				ds_grid_set(newBoxGrid, boxGrid_colChainIDLists, unitIDListLoop, currentChainIDListList);

			
				// From the lineGrid, gather the moveCount and secondsSpent for this line
			
			}
		
		}
	}

	// Clear the rect word list for next use
	//if (ds_list_size(inRectUnitIDList) > 0 or trackChunkMade) {
		ds_list_clear(inRectUnitIDList);
		ds_list_clear(inRectWordIDList);
	//}


	// List print for debug purposes


	// Reset all box grid variables
	boxHoldRectX1 = 0; 
	boxHoldRectX2 = 0; 
	boxHoldRectY1 = 0; 
	boxHoldRectX2 = 0; 
	boxRectMade = false;
	boxRectReleased = true;
	boxRectAbleToInitiate = true;
	trackChunkMade = false;
	obj_control.mouseRectWithinLine = false;
	obj_control.mouseRectWithinColumn = false;
	boxRectWithinLine = false;




}