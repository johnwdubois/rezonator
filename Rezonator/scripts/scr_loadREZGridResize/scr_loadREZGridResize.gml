function scr_loadREZGridResize(argument0, argument1) {
	// Resize a loaded grid

	var grid = argument0;
	var gridLists = argument1;

	var firstColList = ds_list_find_value(gridLists, 0);
	if (firstColList != undefined) {
		var newGridHeight = ds_list_find_value(firstColList, 0);

		ds_grid_resize(grid, ds_grid_width(grid), newGridHeight);
	}


}
