function scr_setAllValuesInCol(grid, col, val) {
	// Shorthand of set_region specifically for columns

	ds_grid_set_region(grid, col, 0, col, ds_grid_height(grid), val);
}
