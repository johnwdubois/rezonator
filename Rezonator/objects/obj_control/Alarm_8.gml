///@description QuickLink Creation
//show_message(scr_getStringOfList(inRectWordIDList));

if (current_time - sessionStartTime < 2000) {
	exit;
}

var gridOfFutureChainsWidth = 3;
var gridOfFutureChains_colDisplayCol = 0;
var gridOfFutureChains_colWordIDList = 1;
var gridOfFutureChains_colFocused = 2;
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
		ds_grid_set(gridOfFutureChains, gridOfFutureChains_colFocused, ds_grid_height(gridOfFutureChains) - 1, false);
		
		//if (ds_list_size())
	}
	else {
		var displayColList = ds_grid_get(gridOfFutureChains, gridOfFutureChains_colWordIDList, rowInFutureChainGrid);
		ds_list_add(displayColList, currentWordID);
	}
}

if (obj_chain.currentFocusedChainID >= 0) {
	
	var rowInRezChainGrid = ds_grid_value_y(obj_chain.rezChainGrid, obj_chain.chainGrid_colChainID, 0, obj_chain.chainGrid_colChainID, ds_grid_height(obj_chain.rezChainGrid), obj_chain.currentFocusedChainID);
	if (rowInRezChainGrid >= 0) {
		var focusedChainWordIDList = ds_grid_get(obj_chain.rezChainGrid, obj_chain.chainGrid_colWordIDList, rowInRezChainGrid);
		if (ds_list_size(focusedChainWordIDList) > 0) {
			
			var focusedChainFirstWordID = ds_list_find_value(focusedChainWordIDList, 0);
			var firstItemDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, focusedChainFirstWordID - 1);
			
			for (var i = 0; i < ds_grid_height(gridOfFutureChains); i++) {
				var currentRowDisplayCol = ds_grid_get(gridOfFutureChains, gridOfFutureChains_colDisplayCol, i);
				if (currentRowDisplayCol == firstItemDisplayCol) {
					ds_grid_set(gridOfFutureChains, gridOfFutureChains_colFocused, i, true);
				}
			}
			ds_grid_sort(gridOfFutureChains, gridOfFutureChains_colFocused, false);
		}
	}
}

if (ds_grid_height(gridOfFutureChains) > 0) {
	//scr_unFocusAllChains();
	
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