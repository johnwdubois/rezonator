var grid = argument0;
var row = argument1;
var gridWidth = ds_grid_width(grid);
var gridHeight = ds_grid_height(grid);

ds_grid_set_grid_region(grid, grid, 0, row + 1, gridWidth - 1, gridHeight - 1, 0, row);
ds_grid_resize(grid, gridWidth, gridHeight - 1);