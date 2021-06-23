function scr_checkTokenCount() {
	ds_list_clear(global.importGridTokenCountList);

	var importGridWidth = ds_grid_width(global.importGrid);
	var importGridHeight = ds_grid_height(global.importGrid);

	for (var i = 0; i < importGridWidth; i++) {
	
		var currentMarker = ds_list_find_value(global.importGridColNameList, i);
		var tokenCount = 0;
	
		for (var j = 0; j < importGridHeight; j++) {
		
			var currentCell = ds_grid_get(global.importGrid, i, j);
			var currentTokenList = scr_splitStringImport(currentCell, " ");
			tokenCount += ds_list_size(currentTokenList);
			ds_list_destroy(currentTokenList);
		}
	
		ds_list_add(global.importGridTokenCountList, tokenCount);
	}


}
