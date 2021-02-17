// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_exportChainEntryGridNewRow(grid, chainID, chainName, entry, wordID, chainSeq, trackSeq, isChunk, isInChunk){
	
	show_debug_message("scr_exportChainEntryGridNewRow() ... wordID: " + string(wordID));
	
	var entrySubMap = ds_map_find_value(global.nodeMap, entry);
	var gridWidth = ds_grid_width(grid);
	
	if (is_numeric(entrySubMap)) {
		if (ds_exists(entrySubMap, ds_type_map)) {
					
			// get currentEntry's tagmap
			var tagMap = ds_map_find_value(entrySubMap, "tagMap");
			var gapUnits = ds_map_find_value(tagMap, "gapUnits");
			
			// get word info
			var text = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordToken, wordID - 1);
			var transcript = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordTranscript, wordID - 1);
			if (transcript == 0 || transcript == "0") transcript = "";
			
			// get UnitText
			var unitID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, wordID - 1);
			var unitText = scr_getUnitText(unitID);
			
			// get chunkID 
			var chunkID = "";
			if (isInChunk) {
				chunkID = ds_map_find_value(entrySubMap, "word");
			}
			
			// add new row to trackGrid
			ds_grid_resize(grid, gridWidth, ds_grid_height(grid) + 1);
			var newGridRow = ds_grid_height(grid) - 1;
			ds_grid_set(grid, obj_chain.trackGrid_colChainID, newGridRow, chainID);
			ds_grid_set(grid, obj_chain.trackGrid_colChainName, newGridRow, chainName);
			ds_grid_set(grid, obj_chain.trackGrid_colChainSeq, newGridRow, chainSeq);
			ds_grid_set(grid, obj_chain.trackGrid_colTrackSeq, newGridRow, trackSeq);
			ds_grid_set(grid, obj_chain.trackGrid_colWordID, newGridRow, wordID);
			ds_grid_set(grid, obj_chain.trackGrid_colIsChunk, newGridRow, (isChunk) ? "TRUE" : "FALSE");
			ds_grid_set(grid, obj_chain.trackGrid_colChunkID, newGridRow, chunkID);
			ds_grid_set(grid, obj_chain.trackGrid_colText, newGridRow, text);
			ds_grid_set(grid, obj_chain.trackGrid_colTranscript, newGridRow, transcript);
			ds_grid_set(grid, obj_chain.trackGrid_colUnitText, newGridRow, unitText);
			ds_grid_set(grid, obj_chain.trackGrid_colGapUnits, newGridRow, gapUnits);
					
			// add tokenImport data to trackGrid (as long as this entry is not a chunk)
			var tokenImportGridWidth = ds_grid_width(global.tokenImportGrid);
			for (var i = 4; i < tokenImportGridWidth; i++) {
				var currentTokenImportValue = ds_grid_get(global.tokenImportGrid, i, wordID - 1);
				ds_grid_set(grid, obj_chain.trackGridWidth - 4 + i, ds_grid_height(grid) - 1, (isChunk) ? "" : currentTokenImportValue);
			}
		}
	}
	
	
}