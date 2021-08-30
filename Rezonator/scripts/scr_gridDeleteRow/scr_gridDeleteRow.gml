function scr_gridDeleteRow(grid, row) {

	var gridWidth = ds_grid_width(grid);
	var gridHeightNew = ds_grid_height(grid) - 1;

	ds_grid_set_grid_region(grid, grid, 0, row + 1, gridWidth - 1, gridHeightNew, 0, row);
	ds_grid_resize(grid, gridWidth, gridHeightNew);


}
