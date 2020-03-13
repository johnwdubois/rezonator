show_message("starting....")

for (var i = 0; i < ds_grid_width(global.customLabelGrid); i++) {
	
	var currentLabel = ds_grid_get(global.customLabelGrid, i, 0);
	var importGridCol = ds_list_find_index(global.importGridColNameList, "\\" + currentLabel);
	
	
	if (importGridCol >= 0) {
		
		var tokenList = ds_list_create();
		
		
		for (var j = 0; j < ds_grid_height(global.importGrid); j++) {
			
			var currentLine = ds_grid_get(global.importGrid, importGridCol, j);
			var currentLineTokenList = scr_splitStringImport(currentLine);
			for (var k = 0; k < ds_list_size(currentLineTokenList); k++) {
				ds_list_add(tokenList, ds_list_find_value(currentLineTokenList, k));
			}
			ds_list_destroy(currentLineTokenList);
		}
		
		for (var j = 0; j < ds_grid_height(global.labelWordGrid); j++) {
			var currentToken = ds_list_find_value(tokenList, j);
			ds_grid_set(global.labelWordGrid, i, j, currentToken);
		}
	}
}