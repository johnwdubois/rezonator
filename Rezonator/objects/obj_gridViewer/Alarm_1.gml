/// @description GridList Dynamic
// You can write your code in this editor

var toolboxGridXColList = ds_map_find_value(gridViewColXListMap, global.importToolboxGrid);


var currentColX = windowX;
var defaultGridColWidth = windowWidth / ds_grid_width(global.importToolboxGrid);
for (var j = 0; j < ds_grid_width(global.importToolboxGrid); j++) {
	ds_list_add(toolboxGridXColList, currentColX + scrollBarWidth);
	currentColX += defaultGridColWidth;
}
