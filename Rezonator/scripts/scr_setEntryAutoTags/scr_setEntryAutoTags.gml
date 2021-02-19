// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_setEntryAutoTags(grid, gridCol, vizSetIDList, chainType){
	
	var gridHeight = ds_grid_height(grid);
	var prevUnit = -1;
	var prevWord = -1;

	for (var i = 0; i < gridHeight; i++) {
		var currentEntry = ds_grid_get(grid, gridCol, i);
		ds_list_add(vizSetIDList, currentEntry);
		
		// set gap tag in this entry's tagmap
		var currentEntrySubMap = ds_map_find_value(global.nodeMap, currentEntry);
		if (is_numeric(currentEntrySubMap)) {
			if (ds_exists(currentEntrySubMap, ds_type_map)) {
				
				// get unit/word from this entry
				var currentUnit = -1;
				var currentWord = -1;
				var currentChunkFirstWord = -1;
				var currentTokenCount = "N/A";
				if (chainType == "rezChain" || chainType == "trackChain") {
					currentWord = ds_map_find_value(currentEntrySubMap, "word");
					currentUnit = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, currentWord - 1);
					
					// if this word is a chunk, we consider the currentWord to be the first word in the chunk (for gapWords)
					var rowInChunkGrid = ds_grid_value_y(obj_chain.chunkGrid, obj_chain.chainGrid_colName, 0, obj_chain.chainGrid_colName, ds_grid_height(obj_chain.chunkGrid), currentWord);
					if (rowInChunkGrid >= 0) {
						var boxWordList = ds_grid_get(obj_chain.chunkGrid, obj_chain.chunkGrid_colBoxWordIDList, rowInChunkGrid);
						if (is_numeric(boxWordList)) {
							if (ds_exists(boxWordList, ds_type_list)) {
								if (ds_list_size(boxWordList) > 0) {
									currentChunkFirstWord = ds_list_find_value(boxWordList, 0);
									currentTokenCount = ds_list_size(boxWordList) - 1;
								}
							}
						}
					}
				}
				else if (chainType == "stackChain") {
					currentUnit = ds_map_find_value(currentEntrySubMap, "unit");
				}
				
				// calculate gapUnits
				var currentGapUnits = "N/A";
				if (prevUnit >= 0) {
					currentGapUnits = currentUnit - prevUnit;
				}
				
				// calculate auto-tags for rez & track
				var currentGapWords = "N/A";
				var currentCharCount = "N/A";
				if (chainType == "rezChain" || chainType == "trackChain") {
					if (prevWord >= 0) {
						if (currentChunkFirstWord >= 0) {
							currentGapWords = currentChunkFirstWord - prevWord;
						}
						else {
							currentGapWords = currentWord - prevWord;
						}
					}
					if (currentWord >= 0) {
						var currentDisplayStr = "";
						currentDisplayStr = string(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, currentWord - 1));
						currentCharCount = string_length(currentDisplayStr);
						if (currentChunkFirstWord >= 0) currentCharCount -= 1;
						if (currentTokenCount == "N/A") {
							currentTokenCount = 1;
						}
					}
				}

				// set auto-tags
				var currentTagMap = ds_map_find_value(currentEntrySubMap, "tagMap");
				if (is_numeric(currentTagMap)) {
					if (ds_exists(currentTagMap, ds_type_map)) {
						scr_setMap(currentTagMap, "gapUnits", currentGapUnits);
						scr_setMap(currentTagMap, "gapWords", currentGapWords);
						scr_setMap(currentTagMap, "charCount", currentCharCount);
						scr_setMap(currentTagMap, "tokenCount", currentTokenCount);
					}
				}
				
				// used for gapUnits & gapWords
				prevUnit = currentUnit;
				prevWord = (currentChunkFirstWord >= 0) ? currentChunkFirstWord : currentWord;
			}
		}
	}


}