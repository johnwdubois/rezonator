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
		if (scr_isNumericAndExists(currentEntrySubMap, ds_type_map)) {
				
			// get unit/word from this entry
			var discourseTokenSeq = -1;
			var currentUnitSeq = -1;
			var currentToken = -1;
			var currentChunkFirstWord = -1;
			var currentTokenCount = "N/A";
			if (chainType == "rezChain" || chainType == "trackChain") {
				currentToken = ds_map_find_value(currentEntrySubMap, "token");
				currentChunkFirstWord = scr_getFirstWordOfChunk(currentToken);
				var tokenSubMap = global.nodeMap[?currentToken];
				if(scr_isNumericAndExists(tokenSubMap,ds_type_map)){
					var tokenUnitID = tokenSubMap[?"unit"];	
					var unitSubMap = global.nodeMap[?tokenUnitID];
					if(scr_isNumericAndExists(unitSubMap,ds_type_map)){
						currentUnitSeq = unitSubMap[?"unitSeq"];
					}
				}
			}
			else if (chainType == "stackChain") {
				var unitID = currentEntrySubMap[? "unit"];
				var unitSubMap = global.nodeMap[?unitID];
				currentUnitSeq = unitSubMap[?"unitSeq"];
			}
				
			// calculate gapUnits
			var currentGapUnits = "N/A";
			if (prevUnit >= 0) {
				currentGapUnits = currentUnitSeq - prevUnit;
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
						discourseTokenSeq = tokenSubMap[?"discourseTokenSeq"];
						currentGapWords = discourseTokenSeq - prevWord;
					}
				}
					
				// calculate character & token count
				if (currentChunkFirstWord == -1) {
					if (currentToken != "") {
						var tokenTagMap = tokenSubMap[?"tagMap"];
						var currentDisplayStr = tokenTagMap[?global.displayTokenField];
						currentCharCount = string_length(currentDisplayStr);
						if (currentChunkFirstWord >= 0) {
							var displayStrNoWhitespace = string_replace_all(currentDisplayStr, " ", "");
							currentCharCount = string_length(displayStrNoWhitespace);
						}
						if (currentTokenCount == "N/A") {
							currentTokenCount = 1;
						}
					}
				}
				else {
					// calculate character & token count ... for chunks!!
					var chunkSubMap = global.nodeMap[? currentToken];
					var tokenList = chunkSubMap[? "tokenList"];
					var tokenListSize = ds_list_size(tokenList);
					currentCharCount = 0;
					for (var j = 0; j < tokenListSize; j++) {
						var currentToken = tokenList[| j];
						var currentTokenDisplayStr = string(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, currentToken - 1));
						currentCharCount += string_length(currentTokenDisplayStr);
					}
					currentTokenCount = tokenListSize;
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
			prevUnit = currentUnitSeq;
			prevWord = (currentChunkFirstWord >= 0) ? currentChunkFirstWord : discourseTokenSeq;
		}	
	}
}