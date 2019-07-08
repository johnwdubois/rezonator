for (var i = 0; i < ds_grid_height(wordGrid); i++)
{
	ds_grid_resize(dynamicWordGrid, dynamicWordGridWidth, ds_grid_height(dynamicWordGrid) + 1);
	var currentRowDynamicWordGrid = ds_grid_height(dynamicWordGrid) - 1;
	
	var currentWordID = ds_grid_get(wordGrid, wordGrid_colWordID, i);
	var currentUtteranceID = ds_grid_get(wordGrid, wordGrid_colUtteranceID, i);
	var currentWordPositionCol = ds_grid_get(wordGrid, wordGrid_colWordSeq, i);
	var currentWordX = currentWordPositionCol * gridSpaceHorizontal + wordLeftMargin;
	var currentWordY = ds_grid_get(wordGrid, wordGrid_colUnitID, i) * gridSpaceVertical;
	var currentWordTranscript = ds_grid_get(wordGrid, wordGrid_colWordTranscript, i);
	var emptyList = ds_list_create();
	var emptyListTwo = ds_list_create();
	
	ds_grid_set(dynamicWordGrid, dynamicWordGrid_colWordID, currentRowDynamicWordGrid, currentWordID);
	ds_grid_set(dynamicWordGrid, dynamicWordGrid_colUtteranceID, currentRowDynamicWordGrid, currentUtteranceID);
	ds_grid_set(dynamicWordGrid, dynamicWordGrid_colDisplayCol, currentRowDynamicWordGrid, currentWordPositionCol);
	ds_grid_set(dynamicWordGrid, dynamicWordGrid_colPixelX, currentRowDynamicWordGrid, currentWordX);
	ds_grid_set(dynamicWordGrid, dynamicWordGrid_colDisplayString, currentRowDynamicWordGrid, currentWordTranscript);
	ds_grid_set(dynamicWordGrid, dynamicWordGrid_colInChainList, currentRowDynamicWordGrid, emptyList);
	ds_grid_set(dynamicWordGrid, dynamicWordGrid_colInBoxList, currentRowDynamicWordGrid, emptyListTwo);
	ds_grid_set(dynamicWordGrid, dynamicWordGrid_colAligned, currentRowDynamicWordGrid, true);
	ds_grid_set(dynamicWordGrid, dynamicWordGrid_colReplaceWord, currentRowDynamicWordGrid, "");
	
	
	
	ds_grid_resize(wordDrawGrid, wordDrawGridWidth, ds_grid_height(wordDrawGrid) + 1);
	var currentRowWordDrawGrid = ds_grid_height(wordDrawGrid) - 1;
	
	ds_grid_set(wordDrawGrid, wordDrawGrid_colBorder, currentRowWordDrawGrid, false);
	ds_grid_set(wordDrawGrid, wordDrawGrid_colBorderRounded, currentRowWordDrawGrid, false);
	ds_grid_set(wordDrawGrid, wordDrawGrid_colFillRect, currentRowWordDrawGrid, false);
	ds_grid_set(wordDrawGrid, wordDrawGrid_colTextColor, currentRowWordDrawGrid, c_black);
	ds_grid_set(wordDrawGrid, wordDrawGrid_colEffectColor, currentRowWordDrawGrid, c_ltblue);
}