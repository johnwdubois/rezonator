/// @description GridList Dynamic
// You can write your code in this editor

var importGridXColList = ds_map_find_value(gridViewColXListMap, global.tokenImportGrid);
var currentColX = windowX;
var importGridWidth = ds_grid_width(global.tokenImportGrid);
var defaultGridColWidth = windowWidth / importGridWidth;

ds_list_clear(importGridXColList);

for (var j = 0; j < importGridWidth; j++) {
	ds_list_add(importGridXColList, currentColX + scrollBarWidth);
	currentColX += defaultGridColWidth;
}




importGridXColList = ds_map_find_value(gridViewColXListMap, global.unitImportGrid);
currentColX = windowX;
importGridWidth = ds_grid_width(global.unitImportGrid);
defaultGridColWidth = windowWidth / importGridWidth;

ds_list_clear(importGridXColList);

for (var j = 0; j < importGridWidth; j++) {
	ds_list_add(importGridXColList, currentColX + scrollBarWidth);
	currentColX += defaultGridColWidth;
}