var grid = argument0;
var gridLists = argument1;

var firstColList = ds_list_find_value(gridLists, 0);
var newGridHeight = ds_list_find_value(firstColList, 0);

ds_grid_resize(grid, ds_grid_width(grid), newGridHeight);