// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_exportChainEntryGridNewRow(grid, chainID, chainName, entry, wordID, chainSeq, trackSeq, isChunk, inChunkID) {
	
	show_debug_message("scr_exportChainEntryGridNewRow() ... wordID: " + string(wordID));
	
	var entrySubMap = global.nodeMap[? entry];
	var gridWidth = ds_grid_width(grid);
	
	// get chunkID
	var chunkID = "";
	var chunkSubMap = -1;
	var firstWordOfChunk = -1;
	if (isChunk) {
		chunkID = entrySubMap[? "word"];
		chunkSubMap = global.nodeMap[? chunkID];
		firstWordOfChunk = scr_getFirstWordOfChunk(chunkID);
	}
	
	if (scr_isNumericAndExists(entrySubMap, ds_type_map)) {
					
		// get currentEntry's tagmap
		var tagMap = entrySubMap[? "tagMap"];
		var fieldIndex = ds_list_find_index(global.tokenImportColNameList, global.tokenImportTranscriptColName);
		
		// get word info
		var text = "";
		var transcript = "";
		if (isChunk) {
			text = scr_getChunkText(chunkID, global.tokenImportDisplayTokenColName);
			transcript = scr_getChunkText(chunkID, global.tokenImportTranscriptColName);
		}
		else {
			text = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordToken, wordID - 1);
			transcript = ds_grid_get(global.tokenImportGrid, fieldIndex, wordID - 1);
		}
		if (transcript == 0 || transcript == "0"|| transcript == undefined) transcript = "";
			
		// get UnitText
		var unitID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, (isChunk) ? firstWordOfChunk : wordID - 1);
		var unitText = scr_getUnitText(unitID);
			
		// add new row to trackGrid
		ds_grid_resize(grid, gridWidth, ds_grid_height(grid) + 1);
		var newGridRow = ds_grid_height(grid) - 1;
		ds_grid_set(grid, obj_chain.trackGrid_colChainID, newGridRow, chainID);
		ds_grid_set(grid, obj_chain.trackGrid_colChainName, newGridRow, chainName);
		ds_grid_set(grid, obj_chain.trackGrid_colChainSeq, newGridRow, chainSeq);
		ds_grid_set(grid, obj_chain.trackGrid_colTrackSeq, newGridRow, trackSeq);
		ds_grid_set(grid, obj_chain.trackGrid_colWordID, newGridRow, wordID);
		ds_grid_set(grid, obj_chain.trackGrid_colIsChunk, newGridRow, (isChunk) ? "TRUE" : "FALSE");
		ds_grid_set(grid, obj_chain.trackGrid_colChunkID, newGridRow, inChunkID);
		ds_grid_set(grid, obj_chain.trackGrid_colText, newGridRow, text);
		ds_grid_set(grid, obj_chain.trackGrid_colTranscript, newGridRow, transcript);
		ds_grid_set(grid, obj_chain.trackGrid_colUnitText, newGridRow, unitText);
					
		// add tokenImport data to trackGrid (as long as this entry is not a chunk)
		var tokenImportGridWidth = ds_grid_width(global.tokenImportGrid);
		for (var i = 4; i < tokenImportGridWidth; i++) {
			var currentCol = obj_chain.trackGridWidth + (i - 4);
			var currentTokenImportValue = (isChunk) ? "" : ds_grid_get(global.tokenImportGrid, i, wordID - 1);
			ds_grid_set(grid, currentCol, ds_grid_height(grid) - 1, currentTokenImportValue);
		}
			
		// add entry tags to trackGrid
		var chainEntryFieldListSize = ds_list_size(global.chainEntryFieldList);
		for (var i = 0; i < chainEntryFieldListSize; i++) {
			var currentEntryField = global.chainEntryFieldList[| i];
			var tag = "";
			if (ds_map_exists(tagMap, currentEntryField)) {
				tag = tagMap[? currentEntryField];
			}
			var currentCol = obj_chain.trackGridWidth + (tokenImportGridWidth - 4) + i;
			ds_grid_set(grid, currentCol, ds_grid_height(grid) - 1, (inChunkID == "") ? tag : "");
		}


	}
	
	
}