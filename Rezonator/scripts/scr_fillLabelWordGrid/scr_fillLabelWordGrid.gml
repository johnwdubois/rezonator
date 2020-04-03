// fill labelWordGrid with UnitID and WordID information
for (var i = 0; i < ds_grid_height(global.labelWordGrid); i++) {
	var currentUnitID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, i);
	var currentWordID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordID, i);
	ds_grid_set(global.labelWordGrid, global.labelWordGrid_colUnitID, i, currentUnitID);
	ds_grid_set(global.labelWordGrid, global.labelWordGrid_colWordID, i, currentWordID);
}

ds_list_clear(global.labelWordGridColNameList);
ds_list_add(global.labelWordGridColNameList, "UnitID", "WordID");

for (var i = 0; i < ds_grid_height(global.customLabelGrid); i++) {
	
	var currentLabel = ds_grid_get(global.customLabelGrid, global.customLabelGrid_colLabel, i);
	var importGridCol = ds_list_find_index(global.importGridColNameList, "\\" + currentLabel);
	
	ds_list_add(global.labelWordGridColNameList, currentLabel);
	
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
			ds_grid_set(global.labelWordGrid, i + 2, j, currentToken);
		}
	}
}