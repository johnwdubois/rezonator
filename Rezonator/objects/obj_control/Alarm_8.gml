//show_message(scr_getStringOfList(inRectWordIDList));

if (current_time - sessionStartTime < 2000) {
	exit;
}

var gridOfFutureChainsWidth = 2;
var gridOfFutureChains_colDisplayCol = 0;
var gridOfFutureChains_colWordIDList = 1;
var gridOfFutureChains = ds_grid_create(gridOfFutureChainsWidth, 0);

for (var i = 0; i < ds_list_size(inRectWordIDList); i++) {
	var currentWordID = ds_list_find_value(inRectWordIDList, i);
	var currentDisplayCol = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colDisplayCol, currentWordID - 1);
	
	var rowInFutureChainGrid = ds_grid_value_y(gridOfFutureChains, gridOfFutureChains_colDisplayCol, 0, gridOfFutureChains_colDisplayCol, ds_grid_height(gridOfFutureChains), currentDisplayCol);
	if (rowInFutureChainGrid < 0 or ds_grid_height(gridOfFutureChains) < 1) {
		ds_grid_resize(gridOfFutureChains, gridOfFutureChainsWidth, ds_grid_height(gridOfFutureChains) + 1);
		
		var newWordIDList = ds_list_create();
		ds_list_add(newWordIDList, currentWordID);
		
		ds_grid_set(gridOfFutureChains, gridOfFutureChains_colDisplayCol, ds_grid_height(gridOfFutureChains) - 1, currentDisplayCol);
		ds_grid_set(gridOfFutureChains, gridOfFutureChains_colWordIDList, ds_grid_height(gridOfFutureChains) - 1, newWordIDList);
	}
	else {
		var displayColList = ds_grid_get(gridOfFutureChains, gridOfFutureChains_colWordIDList, rowInFutureChainGrid);
		ds_list_add(displayColList, currentWordID);
	}	
}

if (ds_grid_height(gridOfFutureChains) > 0) {
	for (var i = 0; i < ds_grid_height(gridOfFutureChains); i++) {
		var currentList = ds_grid_get(gridOfFutureChains, gridOfFutureChains_colWordIDList, i);
	
		if (ds_list_size(currentList) > 1) {
			for (var j = 0; j < ds_list_size(currentList); j++) {
				var currentWordID = ds_list_find_value(currentList, j);
				var currentUnitID = ds_grid_get(wordGrid, wordGrid_colUnitID, currentWordID - 1);
				with (obj_chain) {
					scr_wordClicked(currentWordID, currentUnitID);
				}
			}
		}
		scr_unFocusAllChains();
	
		ds_list_destroy(currentList);
	}
	
	scr_setAllValuesInCol(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, false);
	scr_setAllValuesInCol(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colFillRect, false);
}


ds_grid_destroy(gridOfFutureChains);

ds_list_clear(inRectWordIDList);