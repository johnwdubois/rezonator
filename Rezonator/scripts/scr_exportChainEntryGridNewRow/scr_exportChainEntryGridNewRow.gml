// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_exportChainEntryGridNewRow(grid, chainID, chainName, entry, wordID, chainSeq, trackSeq, isChunk, isInChunk){
	
	// if (!isChunk && !isInChunk)
	// entry is the track or rez that we want to make a new row for
	// word is the wordID for that entry
	
	// if (isChunk && !isInChunk)
	// entry is the track or rez that we want to make a new row for
	// word is -1
	
	// if (!isChunk && isInChunk)
	// entry is the track or rez FOR THE CHUNK that this word corresponds to, so we can get its entry's tags
	// word is what we will be making a new row for
	
	
	var entrySubMap = ds_map_find_value(global.nodeMap, entry);
	var gridWidth = ds_grid_width(grid);
	
	if (is_numeric(entrySubMap)) {
		if (ds_exists(entrySubMap, ds_type_map)) {
					
			// get currentEntry's tagmap
			var currentTagMap = ds_map_find_value(entrySubMap, "tagMap");
			var currentGapUnits = ds_map_find_value(currentTagMap, "gapUnits");
			
			// get word info
			var currentText = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordToken, wordID - 1);
			var currentTranscript = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordTranscript, wordID - 1);
			if (currentTranscript == 0 || currentTranscript == "0") currentTranscript = "";
					
			// get unitText
			var currentUnitText = "";
			var currentUnitID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, wordID - 1);
			var currentUnitWordIDList = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colWordIDList, currentUnitID - 1);
			var currentUnitWordIDListSize = ds_list_size(currentUnitWordIDList);
			for (var k = 0; k < currentUnitWordIDListSize; k++) {
				var unitTextWordID = ds_list_find_value(currentUnitWordIDList, k);
				var unitTextWordDisplayStr = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, unitTextWordID - 1);
				if (is_string(unitTextWordDisplayStr)) currentUnitText += unitTextWordDisplayStr;
				if (k < currentUnitWordIDListSize - 1) currentUnitText += " ";
			}
					
			show_debug_message("scr_exportChainEntryGrid() ... wordID: " + string(wordID));
			
			// add new row to trackGrid
			ds_grid_resize(grid, gridWidth, ds_grid_height(grid) + 1);
			var newGridRow = ds_grid_height(grid) - 1;
			ds_grid_set(grid, obj_chain.trackGrid_colChainID, newGridRow, chainID);
			ds_grid_set(grid, obj_chain.trackGrid_colChainName, newGridRow, chainName);
			ds_grid_set(grid, obj_chain.trackGrid_colChainSeq, newGridRow, chainSeq);
			ds_grid_set(grid, obj_chain.trackGrid_colTrackSeq, newGridRow, trackSeq);
			ds_grid_set(grid, obj_chain.trackGrid_colWordID, newGridRow, wordID);
			ds_grid_set(grid, obj_chain.trackGrid_colText, newGridRow, currentText);
			ds_grid_set(grid, obj_chain.trackGrid_colTranscript, newGridRow, currentTranscript);
			ds_grid_set(grid, obj_chain.trackGrid_colUnitText, newGridRow, currentUnitText);
			ds_grid_set(grid, obj_chain.trackGrid_colGapUnits, newGridRow, currentGapUnits);
					
			// add tokenImport data to trackGrid (as long as this entry is not a chunk)
			var tokenImportGridWidth = ds_grid_width(global.tokenImportGrid);
			for (var k = 4; k < tokenImportGridWidth; k++) {
				var currentTokenImportValue = ds_grid_get(global.tokenImportGrid, k, wordID - 1);
				ds_grid_set(grid, obj_chain.trackGridWidth - 4 + k, ds_grid_height(grid) - 1, (isChunk) ? "" : currentTokenImportValue);
			}
		}
	}
	
	
}