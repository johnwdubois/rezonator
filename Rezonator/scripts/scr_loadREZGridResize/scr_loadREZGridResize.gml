function scr_loadREZGridResize(grid, gridLists) {
	// Resize a loaded grid

	var firstColList = ds_list_find_value(gridLists, 0);
	if (firstColList != undefined) {
		var newGridHeight = ds_list_find_value(firstColList, 0);

		ds_grid_resize(grid, ds_grid_width(grid), newGridHeight);
	}


}
