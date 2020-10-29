// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_importIGT(){
	
	// Fill up BlockGrid & BlockTypeGrid
	scr_identifyBlocks();
	
	// The first 2 columns of importGrid will be BlockID and BlockSeq
	global.importGridWidth = 2;
	var importGrid_colBlockID = 0;
	var importGrid_colBlockSeq = 1;
	ds_list_add(global.importGridColNameList, "~blockID");
	ds_list_add(global.importGridColNameList, "~blockSeq");
	
	
	// Fill up the importGrid based on blockGrid
	var blockGridHeight = ds_grid_height(global.blockGrid);
	for (var i = 0; i < blockGridHeight; i++) {
		var currentBlockType = ds_grid_get(global.blockGrid, global.blockGrid_colBlockType, i);
		var currentBlockTypeRow = currentBlockType - 1;
		var currentBlockCategory = ds_grid_get(global.blockTypeGrid, global.blockTypeGrid_colBlockCategory, currentBlockTypeRow);
			
		// loop over every block of category Unit
		if (currentBlockCategory == global.blockCategoryUnit) {
			var currentBlockLineList = ds_grid_get(global.blockGrid, global.blockGrid_colLineList, i);
			var currentBlockLineListSize = ds_list_size(currentBlockLineList);
			var currentBlockID = ds_grid_get(global.blockGrid, global.blockGrid_colBlockID, i);
			var currentBlockSeq = ds_grid_height(global.importGrid) + 1;
			var currentFieldList = ds_grid_get(global.blockTypeGrid, global.blockTypeGrid_colFieldList, currentBlockTypeRow);
				
			// add a new row to the importGrid for every block of category Unit
			ds_grid_resize(global.importGrid, global.importGridWidth, ds_grid_height(global.importGrid) + 1);
			var importGridRow = ds_grid_height(global.importGrid) - 1;
			
			// set the BlockID and BlockSeq for this row in the importGrid
			ds_grid_set(global.importGrid, importGrid_colBlockID, importGridRow, currentBlockID);
			ds_grid_set(global.importGrid, importGrid_colBlockSeq, importGridRow, currentBlockSeq);
				
			// loop over every line in this Block
			for (var j = 0; j < currentBlockLineListSize; j++) {
					
				var currentLineIndex = ds_list_find_value(currentBlockLineList, j);
				var currentLineStr = ds_grid_get(global.importTXTLineGrid, global.importTXTLineGrid_colLine, currentLineIndex);
					
				// if we have a field at this point, let's remove it (because we already know the field from the Block Type's fieldList)
				var currentField = scr_stringGetField(currentLineStr);
				if (string_length(currentField) > 0) {
					currentLineStr = string_delete(currentLineStr, 1, string_length(currentField));
					ds_grid_set(global.importTXTLineGrid, global.importTXTLineGrid_colLine, currentLineIndex, currentLineStr);
				}
					
				// Now we will put this line in the importGrid. If we can find the currentField string in the importGridColMap map,
				// then we get the importGrid column from that key in the map. If we cannot find the currentField string in importGridColMap,
				// we add it to the map and make a new column in the importGrid.
				
				currentField = ds_list_find_value(currentFieldList, j);
				
				var importGridCol = ds_map_find_value(global.importGridColMap, currentField);
				if (is_undefined(importGridCol)) {
					global.importGridWidth++;
					ds_grid_resize(global.importGrid, global.importGridWidth, ds_grid_height(global.importGrid));
					ds_list_add(global.importGridColNameList, currentField);
					importGridCol = global.importGridWidth - 1;
					ds_map_add(global.importGridColMap, currentField, importGridCol);
				}
				ds_grid_set(global.importGrid, importGridCol, importGridRow, currentLineStr);
					
			}
		}
	}
	
	scr_setTokenCountPerLine();
	scr_setFieldRelations();
}