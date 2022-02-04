

function scr_exportChainEntryGridNewRow(grid, chainID, chainName, entry, tokenID, chainSeq, trackSeq, isChunk, inChunkID) {
	
	show_debug_message("scr_exportChainEntryGridNewRow() ... tokenID: " + string(tokenID));
	var tokenSubMap = -1;
	
	var entrySubMap = global.nodeMap[? entry];
	var gridWidth = ds_grid_width(grid);
	
	// get chunkID
	var chunkID = "";
	var chunkSubMap = -1;
	var firstTokenOfChunk = "";
	var unitID = "";
	if (isChunk) {
		chunkID = entrySubMap[? "token"];
		chunkSubMap = global.nodeMap[? chunkID];
		firstTokenOfChunk = scr_getFirstWordOfChunk(chunkID);
		var firstTokenOfChunkSubMap = global.nodeMap[? firstTokenOfChunk];
		unitID = firstTokenOfChunkSubMap[? "unit"];
	}
	else {
		tokenSubMap = global.nodeMap[? tokenID];
		unitID = tokenSubMap[? "unit"];
	}

	
	if (scr_isNumericAndExists(entrySubMap, ds_type_map)) {
					
		// get currentEntry's tagmap
		var tagMap = entrySubMap[? "tagMap"];
		var tokenTagMap = -1;
		
		// get token info
		var text = "";
		var transcript = "";
		if (isChunk) {
			text = scr_getChunkText(chunkID);
			transcript = scr_getChunkText(chunkID);
		}
		else {
			tokenTagMap = tokenSubMap[? "tagMap"];
			text = tokenTagMap[? global.displayTokenField];
			transcript = tokenTagMap[? global.tokenImportTranscriptColName];
		}
		if (transcript == 0 || transcript == "0"|| transcript == undefined || transcript == "undefined") transcript = "";
			
		// get UnitText
		var unitText = scr_getUnitText(global.nodeMap[? unitID]);
			
		// add new row to trackGrid
		ds_grid_resize(grid, gridWidth, ds_grid_height(grid) + 1);
		var newGridRow = ds_grid_height(grid) - 1;
		ds_grid_set(grid, obj_chain.trackGrid_colChainID, newGridRow, chainID);
		ds_grid_set(grid, obj_chain.trackGrid_colChainName, newGridRow, chainName);
		ds_grid_set(grid, obj_chain.trackGrid_colChainSeq, newGridRow, chainSeq);
		ds_grid_set(grid, obj_chain.trackGrid_colTrackSeq, newGridRow, trackSeq);
		ds_grid_set(grid, obj_chain.trackGrid_colWordID, newGridRow, tokenID);
		ds_grid_set(grid, obj_chain.trackGrid_colIsChunk, newGridRow, (isChunk) ? "TRUE" : "FALSE");
		ds_grid_set(grid, obj_chain.trackGrid_colChunkID, newGridRow, inChunkID);
		ds_grid_set(grid, obj_chain.trackGrid_colText, newGridRow, text);
		ds_grid_set(grid, obj_chain.trackGrid_colTranscript, newGridRow, transcript);
		ds_grid_set(grid, obj_chain.trackGrid_colUnitText, newGridRow, unitText);
					
		// add token data to trackGrid (as long as this entry is not a chunk)
		var tokenFieldListSize = ds_list_size(obj_control.tokenFieldList);
		if (!isChunk && scr_isNumericAndExists(tokenTagMap, ds_type_map)) {
			for (var i = 0; i < tokenFieldListSize; i++) {
				var currentField = obj_control.tokenFieldList[| i];
				var currentTag = tokenTagMap[? currentField];
				var currentCol = obj_chain.trackGridWidth + i;
				ds_grid_set(grid, currentCol, ds_grid_height(grid) - 1, currentTag);
			}
		}
		
			
		// add entry tags to trackGrid
		var chainEntryFieldListSize = ds_list_size(global.chainEntryFieldList);
		for (var i = 0; i < chainEntryFieldListSize; i++) {
			var currentEntryField = global.chainEntryFieldList[| i];
			var tag = "";
			if (ds_map_exists(tagMap, currentEntryField)) {
				tag = tagMap[? currentEntryField];
			}
			var currentCol = obj_chain.trackGridWidth + tokenFieldListSize + i;
			ds_grid_set(grid, currentCol, ds_grid_height(grid) - 1, (inChunkID == "") ? tag : "");
		}
	}
	
	
}