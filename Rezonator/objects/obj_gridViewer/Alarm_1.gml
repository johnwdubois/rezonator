/// @description GridList Dynamic
// You can write your code in this editor

var importGridXColList = ds_map_find_value(gridViewColXListMap, global.importGrid);


var currentColX = windowX;
var defaultGridColWidth = windowWidth / ds_grid_width(global.importGrid);
var importGridWidth = ds_grid_width(global.importGrid);
for (var j = 0; j < importGridWidth; j++) {
	ds_list_add(importGridXColList, currentColX + scrollBarWidth);
	currentColX += defaultGridColWidth;
}
