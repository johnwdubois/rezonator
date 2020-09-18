function scr_fillCustomLabelGrid() {
	// scan through tagInfoGrid and add a row to the customLabelGrid for each marker

	var tagInfoGridHeight = ds_grid_height(global.tagInfoGrid);
	for (var i = 0; i < tagInfoGridHeight; i++) {

		var currentLevel = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colLevel, i);	
		var currentMarker = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, i);
		
		ds_grid_resize(global.customLabelGrid, global.customLabelGridWidth, ds_grid_height(global.customLabelGrid) + 1);
		var currentCustomLabelGridRow = ds_grid_height(global.customLabelGrid) - 1;
		ds_grid_set(global.customLabelGrid, global.customLabelGrid_colLevel, currentCustomLabelGridRow, currentLevel);
		ds_grid_set(global.customLabelGrid, global.customLabelGrid_colMarker, currentCustomLabelGridRow, currentMarker);
		var emptyList = ds_list_create();
		ds_grid_set(global.customLabelGrid, global.customLabelGrid_colTagList, currentCustomLabelGridRow, emptyList);
	}


}
