// swaps all the cells for 2 columns in a grid
var grid = argument0;
var col1 = argument1;
var col2 = argument2;

var gridCopy = ds_grid_create(ds_grid_width(grid), ds_grid_height(grid));
ds_grid_copy(gridCopy, grid);

ds_grid_set_grid_region(grid, gridCopy, col2, 0, col2, ds_grid_height(grid), col1, 0);
ds_grid_set_grid_region(grid, gridCopy, col1, 0, col1, ds_grid_height(grid), col2, 0);

ds_grid_destroy(gridCopy);