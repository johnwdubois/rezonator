var grid = argument0;
var col = argument1;

var dynamicWordGridHeight = ds_grid_height(obj_control.dynamicWordGrid);
for (var i = 0; i < dynamicWordGridHeight; i++) {

	var currentReplaceWord = ds_grid_get(grid, col, i);
		
	ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, i, currentReplaceWord);
}