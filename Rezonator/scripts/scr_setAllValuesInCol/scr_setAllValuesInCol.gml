// Shorthand of set_region specifically for columns

var grid = argument0;
var col = argument1;
var val = argument2;

ds_grid_set_region(grid, col, 0, col, ds_grid_height(grid), val);