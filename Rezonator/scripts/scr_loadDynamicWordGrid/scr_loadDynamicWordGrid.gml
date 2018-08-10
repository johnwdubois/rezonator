for (var i = 0; i < ds_grid_height(wordGrid); i++)
{
	ds_grid_resize(dynamicWordGrid, dynamicWordGridWidth, ds_grid_height(dynamicWordGrid) + 1);
	var currentRowDynamicWordGrid = ds_grid_height(dynamicWordGrid) - 1;
	
	var currentWordID = ds_grid_get(wordGrid, wordGrid_colWordID, i);
	var currentWordPositionCol = ds_grid_get(wordGrid, wordGrid_colWordSeq, i);
	var currentWordX = currentWordPositionCol * gridSpaceHorizontal + wordLeftMargin;
	var currentWordY = ds_grid_get(wordGrid, wordGrid_colUnitID, i) * gridSpaceVertical;
	var currentWordTranscript = ds_grid_get(wordGrid, wordGrid_colWordTranscript, i);
	var emptyList = ds_list_create();
	
	ds_grid_set(dynamicWordGrid, dynamicWordGrid_colWordID, currentRowDynamicWordGrid, currentWordID);
	ds_grid_set(dynamicWordGrid, dynamicWordGrid_colDisplayCol, currentRowDynamicWordGrid, currentWordPositionCol);
	ds_grid_set(dynamicWordGrid, dynamicWordGrid_colPixelX, currentRowDynamicWordGrid, currentWordX);
	ds_grid_set(dynamicWordGrid, dynamicWordGrid_colDisplayString, currentRowDynamicWordGrid, currentWordTranscript);
	ds_grid_set(dynamicWordGrid, dynamicWordGrid_colInChainList, currentRowDynamicWordGrid, emptyList);
}