var rowInWordGrid = argument0;

ds_grid_resize(obj_control.dynamicWordGrid, obj_control.dynamicWordGridWidth, ds_grid_height(obj_control.dynamicWordGrid) + 1);
var currentRowDynamicWordGrid = ds_grid_height(obj_control.dynamicWordGrid) - 1;
	
var currentWordID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordID, rowInWordGrid);
var currentWordPositionCol = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordSeq, rowInWordGrid);
var currentWordX = currentWordPositionCol * obj_control.gridSpaceHorizontal + obj_control.wordLeftMargin;
//var currentWordY = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, rowInWordGrid) * obj_control.gridSpaceVertical;
var currentWordTranscript = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordTranscript, rowInWordGrid);
var emptyList = ds_list_create();
	
ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordID, currentRowDynamicWordGrid, currentWordID);
ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentRowDynamicWordGrid, currentWordPositionCol);
ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colPixelX, currentRowDynamicWordGrid, currentWordX);
ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, currentRowDynamicWordGrid, currentWordTranscript);
ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInChainList, currentRowDynamicWordGrid, emptyList);
ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colAligned, currentRowDynamicWordGrid, true);
ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colVoid, currentRowDynamicWordGrid, 0);
	

	
ds_grid_resize(obj_control.wordDrawGrid, obj_control.wordDrawGridWidth, ds_grid_height(obj_control.wordDrawGrid) + 1);
var currentRowWordDrawGrid = ds_grid_height(obj_control.wordDrawGrid) - 1;
	
ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colBorder, currentRowWordDrawGrid, false);
ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colBorderRounded, currentRowWordDrawGrid, false);
ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colFillRect, currentRowWordDrawGrid, false);
ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colTextColor, currentRowWordDrawGrid, c_black);
ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colEffectColor, currentRowWordDrawGrid, obj_control.c_ltblue);