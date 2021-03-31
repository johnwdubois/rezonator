// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_createChunk(){
	
	// Place all captured unit and word info into the box grid
	var inRectWordIDListSize = ds_list_size(inRectWordIDList);
	var inRectUnitIDListSize = ds_list_size(inRectUnitIDList);
	if(inRectWordIDListSize <= 1){ exit;}

	if (inRectWordIDListSize > 0 and inRectUnitIDListSize <= 0 and obj_control.mouseRectWithinLine) {
		var wordID = ds_list_find_value(inRectWordIDList, 0);
		var unitID = ds_grid_get(wordGrid, wordGrid_colUnitID, wordID - 1);
		ds_list_add(inRectUnitIDList, unitID);
	}
	inRectUnitIDListSize = ds_list_size(inRectUnitIDList);
	
	
	if (inRectUnitIDListSize > 0 && inRectWordIDListSize > 0) { // Make sure the box captured something

		// Retrieve references of the lists being added to
		var currentUnitList = ds_list_create();
		var tokenIDList = ds_list_create();
		
		// copy contents of inRectWordIDList into tokenIDList
		ds_list_copy(tokenIDList, inRectWordIDList);
		show_debug_message("scr_createChunk() ... tokenIDList: " + scr_getStringOfList(tokenIDList));
		
		// create Chunk new node in node map
		var chunkID = scr_addToNodeMap("chunk");
		var chunkSubMap = global.nodeMap[? chunkID];
		ds_map_add_list(chunkSubMap, "tokenList", tokenIDList);
		
		//set to focused chunk
		obj_chain.currentFocusedChunkID = chunkID;
		
		// loop over tokenIDList and tell each word what its chunk is
		var tokenIDListSize = ds_list_size(tokenIDList);
		for (var i = 0; i < tokenIDListSize; i++) {
			var currentTokenID = tokenIDList[| i];
			var currentTokenInBoxList = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInBoxList, currentTokenID - 1);
			if (ds_list_find_index(currentTokenInBoxList, chunkID) == -1) ds_list_add(currentTokenInBoxList, chunkID);
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		// Expand the box grid to fit the new info
		ds_grid_resize(obj_chain.chunkGrid, obj_chain.chainGridWidth + 2, ds_grid_height(obj_chain.chunkGrid) + 1);
		ds_grid_set(obj_chain.chunkGrid, obj_chain.chainGrid_colChainID, ds_grid_height(obj_chain.chunkGrid) - 1, ++obj_control.chunkID);

		ds_grid_set(obj_chain.chunkGrid, obj_chain.chainGrid_colWordIDList, ds_grid_height(obj_chain.chunkGrid) - 1, currentUnitList);
		//ds_grid_set(obj_chain.chunkGrid, obj_chain.chunkGrid_colBoxWordIDList, ds_grid_height(obj_chain.chunkGrid) - 1, currentWordList);
		ds_grid_set(obj_chain.chunkGrid, obj_chain.chunkGrid_colNest, ds_grid_height(obj_chain.chunkGrid) - 1, false);

	
		

		
		
	
		ds_grid_set(obj_chain.chunkGrid, obj_chain.chainGrid_colTiltSum, ds_grid_height(obj_chain.chunkGrid) - 1, ds_list_find_value(inRectWordIDList, inRectWordIDListSize - 1));


		// If this box counts as a Chunk, mark it as such and nest it if possible
		if(ds_list_size(currentUnitList) == 1 && ds_list_size(tokenIDList) > 1) {
		
			// Access the first word's in Chunk list
			var firstWordID = ds_list_find_value(tokenIDList, 0);
			var currentInChunkList = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInBoxList, firstWordID - 1);
			
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
					if(scr_listContainsSublist(otherChunkWordList, tokenIDList) != -1) {
					
						// Make sure this new Chunk is unique
						var currentListFirstWord = ds_list_find_value(tokenIDList, 0);
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
		}
	}
		

	// Clear the rect word list for next use
	ds_list_clear(inRectUnitIDList);
	ds_list_clear(inRectWordIDList);



	// Reset all box grid variables
	boxHoldRectX1 = 0; 
	boxHoldRectX2 = 0; 
	boxHoldRectY1 = 0; 
	boxHoldRectX2 = 0; 
	boxRectMade = false;
	boxRectReleased = true;
	boxRectAbleToInitiate = true;
	obj_control.mouseRectWithinLine = false;
	obj_control.mouseRectWithinColumn = false;
	boxRectWithinLine = false;




}