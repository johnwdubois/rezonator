var grid = argument0;

var importGridXColList = ds_map_find_value(gridViewColXListMap, grid);
var currentColX = windowX;
var importGridWidth = ds_grid_width(grid);
var defaultGridColWidth = windowWidth / importGridWidth;

ds_list_clear(importGridXColList);

for (var j = 0; j < importGridWidth; j++) {
	ds_list_add(importGridXColList, currentColX + scrollBarWidth);
	currentColX += defaultGridColWidth;
}