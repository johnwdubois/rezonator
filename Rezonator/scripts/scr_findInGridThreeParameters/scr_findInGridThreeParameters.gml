function scr_findInGridThreeParameters(grid, col1, valueInCol1, col2, valueInCol2, col3, valueInCol3) {
	

	var tempGrid = ds_grid_create(ds_grid_width(grid), ds_grid_height(grid));

	ds_grid_copy(tempGrid, grid);

	var possibleRowsList1 = ds_list_create();
	var possibleRowsList2 = ds_list_create();

	// find rows in grid that contain correct value in first column, store those in possibleRowsList1
	while (ds_grid_value_exists(tempGrid, col1, 0, col1, ds_grid_height(tempGrid), valueInCol1)) {
		var rowInGrid = ds_grid_value_y(tempGrid, col1, 0, col1, ds_grid_height(tempGrid), valueInCol1);
		ds_list_add(possibleRowsList1, rowInGrid);
		ds_grid_set(tempGrid, col1, rowInGrid, undefined);
	}

	// find rows in grid that contain correct value in second column, store those in possibleRowsList2
	var possibleRowsList1Size = ds_list_size(possibleRowsList1);
	for (var i = 0; i < possibleRowsList1Size; i++) {
		var rowInGrid = ds_list_find_value(possibleRowsList1, i);
		var col2Element = ds_grid_get(tempGrid, col2, rowInGrid);
	
		if (col2Element == valueInCol2) {
			ds_list_add(possibleRowsList2, rowInGrid);
		}
	}

	var rowReturn = -1;

	var possibleRowsList2Size = ds_list_size(possibleRowsList2);
	for (var i = 0; i < possibleRowsList2Size; i++) {
		var rowInGrid = ds_list_find_value(possibleRowsList2, i);
		var col3Element = ds_grid_get(tempGrid, col3, rowInGrid);
	
		if (col3Element == valueInCol3) {
			rowReturn = rowInGrid;
			break;
		}
	}

	ds_list_destroy(possibleRowsList1);
	ds_list_destroy(possibleRowsList2);
	ds_grid_destroy(tempGrid);

	return rowReturn;


}
