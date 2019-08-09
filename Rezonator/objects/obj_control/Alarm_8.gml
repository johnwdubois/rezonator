///@description QuickLink Creation
//show_message(scr_getStringOfList(inRectWordIDList));

if (current_time - sessionStartTime < 2000 or not quickLinkAllowed) {
	exit;
}
//if (searchGridActive) {
//	show_message("trying to change tool");
//	obj_toolPane.currentTool = obj_toolPane.toolTrackBrush;
//}
var gridOfFutureChainsWidth = 3;
var gridOfFutureChains_colDisplayCol = 0;
var gridOfFutureChains_colWordIDList = 1;
var gridOfFutureChains_colFocused = 2;
var gridOfFutureChains = ds_grid_create(gridOfFutureChainsWidth, 0);
if (ds_list_size(inRectWordIDList) > 0) {
	moveCounter++;
}

// Use the wordList or hitList depending on the context
var inRectList = ds_list_create();
if(obj_toolPane.currentTool == obj_toolPane.toolTrackBrush){
	if(not searchGridActive) {
		alarm[10] = 1;
		exit;
	}
	ds_list_copy(inRectList, inRectHitIDList);
} 
else {
	ds_list_copy(inRectList, inRectWordIDList);
}

for (var i = 0; i < ds_list_size(inRectList); i++) {
	var currentWordID = ds_list_find_value(inRectList, i);
	
	// Access the display column of the relevent grid
	if(obj_toolPane.currentTool == obj_toolPane.toolTrackBrush){
		// Instead hitID
		var currentDisplayCol = ds_grid_get(hitGrid, hitGrid_colDisplayCol, currentWordID - 1);
	}
	else {
		// Instead hitID
		var currentDisplayCol = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colDisplayCol, currentWordID - 1);
	}

	// Mechanism for splitting wordLists into their respective dislayColumns
	var rowInFutureChainGrid = ds_grid_value_y(gridOfFutureChains, gridOfFutureChains_colDisplayCol, 0, gridOfFutureChains_colDisplayCol, ds_grid_height(gridOfFutureChains), currentDisplayCol);
	if (rowInFutureChainGrid < 0 or ds_grid_height(gridOfFutureChains) < 1) {
		ds_grid_resize(gridOfFutureChains, gridOfFutureChainsWidth, ds_grid_height(gridOfFutureChains) + 1);
		
		var newWordIDList = ds_list_create();
		ds_list_add(newWordIDList, ds_list_find_value(inRectWordIDList, i));
		
		ds_grid_set(gridOfFutureChains, gridOfFutureChains_colDisplayCol, ds_grid_height(gridOfFutureChains) - 1, currentDisplayCol);
		ds_grid_set(gridOfFutureChains, gridOfFutureChains_colWordIDList, ds_grid_height(gridOfFutureChains) - 1, newWordIDList);
		ds_grid_set(gridOfFutureChains, gridOfFutureChains_colFocused, ds_grid_height(gridOfFutureChains) - 1, false);
		
	}
	else {
		var displayColList = ds_grid_get(gridOfFutureChains, gridOfFutureChains_colWordIDList, rowInFutureChainGrid);
		ds_list_add(displayColList, ds_list_find_value(inRectWordIDList, i));
	}
}

// Keep the focus of chains during the process
if (obj_chain.currentFocusedChainID >= 0) {
	
	// Keep the focus of track chains
	if(obj_toolPane.currentTool == obj_toolPane.toolTrackBrush){
		//show_message("trying to make track link");
		var rowInTrackChainGrid = ds_grid_value_y(obj_chain.trackChainGrid, obj_chain.chainGrid_colChainID, 0, obj_chain.chainGrid_colChainID, ds_grid_height(obj_chain.trackChainGrid), obj_chain.currentFocusedChainID);
		if (rowInTrackChainGrid >= 0) {
			var focusedChainWordIDList = ds_grid_get(obj_chain.trackChainGrid, obj_chain.chainGrid_colWordIDList, rowInTrackChainGrid);
			//show_message("size of chain to be added" + string(ds_list_size(focusedChainWordIDList)));
			if (ds_list_size(focusedChainWordIDList) > 0) {
			
				var focusedChainFirstWordID = ds_list_find_value(focusedChainWordIDList, 0);
				if(obj_toolPane.currentTool == obj_toolPane.toolTrackBrush) {
					var focusedChainFirstHitGridRow = ds_grid_value_y(obj_control.hitGrid, obj_control.hitGrid_colWordID, 0, obj_control.hitGrid_colWordID, ds_grid_height(obj_control.hitGrid), focusedChainFirstWordID);
					var firstItemDisplayCol = ds_grid_get(obj_control.hitGrid, obj_control.hitGrid_colDisplayCol, focusedChainFirstHitGridRow);
				}
				else {
					var firstItemDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, focusedChainFirstWordID - 1);
				}
				// Change this to hitGrid
			
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
	// Keep the focus of Rez chains
	else {
		var rowInRezChainGrid = ds_grid_value_y(obj_chain.rezChainGrid, obj_chain.chainGrid_colChainID, 0, obj_chain.chainGrid_colChainID, ds_grid_height(obj_chain.rezChainGrid), obj_chain.currentFocusedChainID);
		if (rowInRezChainGrid >= 0) {
			var focusedChainWordIDList = ds_grid_get(obj_chain.rezChainGrid, obj_chain.chainGrid_colWordIDList, rowInRezChainGrid);
						//show_message("size of chain to be added" + string(ds_list_size(focusedChainWordIDList)));
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
	
}

// Using the organized grid, simulate clicks to create the chains
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

// Clear the data structures
ds_grid_destroy(gridOfFutureChains);

ds_list_clear(inRectWordIDList);
ds_list_clear(inRectHitIDList);