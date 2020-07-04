// Copy word data from the wordGrid to the dynamicWordGrid ("vizWordGrid"), line by line


var rowInWordGrid = argument0;

ds_grid_resize(obj_control.dynamicWordGrid, obj_control.dynamicWordGridWidth, ds_grid_height(obj_control.dynamicWordGrid) + 1);
var currentRowDynamicWordGrid = ds_grid_height(obj_control.dynamicWordGrid) - 1;
	
var currentWordID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordID, rowInWordGrid);
var currentUtteranceID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUtteranceID, rowInWordGrid);
var currentWordPositionCol = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordSeq, rowInWordGrid);
var currentWordX = currentWordPositionCol * obj_control.gridSpaceHorizontal + obj_control.wordLeftMargin;
//var currentWordY = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, rowInWordGrid) * obj_control.gridSpaceVertical;
//var currentWordTranscript = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordTranscript, rowInWordGrid);
var currentWordToken = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordToken, rowInWordGrid);
var emptyList = ds_list_create();
var emptyListTwo = ds_list_create();
var currentWordState = (string_length(string(currentWordToken)) < 1) ? obj_control.wordStateDead : obj_control.wordStateNormal;

	
ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordID, currentRowDynamicWordGrid, currentWordID);
ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWID, currentRowDynamicWordGrid, currentWordID);
ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colUtteranceID, currentRowDynamicWordGrid, currentUtteranceID);
ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentRowDynamicWordGrid, currentWordPositionCol);
ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colPixelX, currentRowDynamicWordGrid, currentWordX);
ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, currentRowDynamicWordGrid, currentWordToken);
ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInChainList, currentRowDynamicWordGrid, emptyList);
ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInBoxList, currentRowDynamicWordGrid, emptyListTwo);
ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colAligned, currentRowDynamicWordGrid, true);
ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colVoid, currentRowDynamicWordGrid, 0);
ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colReplaceWord, currentRowDynamicWordGrid, "");
ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, currentRowDynamicWordGrid, currentWordState);
	

	
ds_grid_resize(obj_control.wordDrawGrid, obj_control.wordDrawGridWidth, ds_grid_height(obj_control.wordDrawGrid) + 1);
var currentRowWordDrawGrid = ds_grid_height(obj_control.wordDrawGrid) - 1;
	
ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colBorder, currentRowWordDrawGrid, false);
ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colBorderRounded, currentRowWordDrawGrid, false);
ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colFillRect, currentRowWordDrawGrid, false);
ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colTextColor, currentRowWordDrawGrid, c_black);
ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colEffectColor, currentRowWordDrawGrid, 0);