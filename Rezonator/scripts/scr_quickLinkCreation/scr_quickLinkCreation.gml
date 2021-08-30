// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_quickLinkCreation(){
	obj_chain.quickLinkCreated = true;
	var quickLinkTokenIDList = inRectTokenIDList;
	show_debug_message("scr_quickLinkCreation() ... quickLinkTokenIDList: " + scr_getStringOfList(quickLinkTokenIDList));
	
	if (current_time - sessionStartTime < 2000 or not quickLinkAllowed) {
		show_debug_message("quickLink not allowed. Exiting...");
		exit;
	}
	
	// create a temporary grid: "the grid of future chains"
	// this will organize the group of words in the quickLinkTokenIDList by their
	// display columns, so we can then create quicklinks based on their display columns
	var gridOfFutureChainsWidth = 3;
	var gridOfFutureChains_colDisplayCol = 0;
	var gridOfFutureChains_colTokenIDList = 1;
	var gridOfFutureChains_colFocused = 2;
	var gridOfFutureChains = ds_grid_create(gridOfFutureChainsWidth, 0);
	if (ds_list_size(quickLinkTokenIDList) > 0) {
		moveCounter++;
	}

	
	// fill up the grid of future chains
	var quickLinkTokenIDListSize = ds_list_size(quickLinkTokenIDList);
	for (var i = 0; i < quickLinkTokenIDListSize; i++) {
		
		// get current token, make sure it exists
		var currentTokenID = quickLinkTokenIDList[| i];
		var currentTokenSubMap = global.nodeMap[? currentTokenID];
		if (!scr_isNumericAndExists(currentTokenSubMap, ds_type_map)) continue;
		
		// get this token's displayCol
		var currentDisplayCol = currentTokenSubMap[? "displayCol"];
		
		/*
		// Access the display column of the relevent grid
		if (obj_toolPane.currentTool == obj_toolPane.toolTrackBrush) {
			// Instead hitID
			var currentDisplayCol = ds_grid_get(hitGrid, hitGrid_colDisplayCol, currentWordID - 1);
		}
		else {
			// Instead hitID
			var currentDisplayCol = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colDisplayCol, currentWordID - 1);
			
			// make sure this word isn't in a track
			var currentWordInChainsList = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInChainList, currentWordID - 1);
			var currentWordInChainsListSize = ds_list_size(currentWordInChainsList);
			var wordIsInTrackChain = false;
			for (var j = 0; j < currentWordInChainsListSize; j++) {
				var currentChain = ds_list_find_value(currentWordInChainsList, j);
				var currentChainSubMap = ds_map_find_value(global.nodeMap, currentChain);
				var currentChainType = ds_map_find_value(currentChainSubMap, "type");
				if (currentChainType == "trail") {
					wordIsInTrackChain = true;
				}
			}
			if (wordIsInTrackChain) {
				//continue;
			}
		}
		*/
		

		// check if this displayCol has already been added to the gridOfFutureChains
		var rowInFutureChainGrid = ds_grid_value_y(gridOfFutureChains, gridOfFutureChains_colDisplayCol, 0, gridOfFutureChains_colDisplayCol, ds_grid_height(gridOfFutureChains), currentDisplayCol);
		var newDisplayCol = (rowInFutureChainGrid == -1 or ds_grid_height(gridOfFutureChains) < 1);
		
		
		if (newDisplayCol) {
			
			// if we have not yet encountered this displayCol, let's grow the gridOfFutureChains by 1 row
			ds_grid_resize(gridOfFutureChains, gridOfFutureChainsWidth, ds_grid_height(gridOfFutureChains) + 1);
			
			// create the tokenList for this displayCol and add the current token
			var newTokenIDList = ds_list_create();
			ds_list_add(newTokenIDList, currentTokenID);
			
			// set everything in gridOfFutureChains
			ds_grid_set(gridOfFutureChains, gridOfFutureChains_colDisplayCol, ds_grid_height(gridOfFutureChains) - 1, currentDisplayCol);
			ds_grid_set(gridOfFutureChains, gridOfFutureChains_colTokenIDList, ds_grid_height(gridOfFutureChains) - 1, newTokenIDList);
			ds_grid_set(gridOfFutureChains, gridOfFutureChains_colFocused, ds_grid_height(gridOfFutureChains) - 1, false);
		}
		else {
			
			// if we have already seen this displayCol before, we will add the current token to the tokenList for this displayCol
			var tokenIDList = ds_grid_get(gridOfFutureChains, gridOfFutureChains_colTokenIDList, rowInFutureChainGrid);
			scr_addToListOnce(tokenIDList, currentTokenID);
		}

	}
	
	
	
	
	
	
	

	// if there is a chain focused at the time of making quick links,
	// we need to make sure we keep it focused
	if (ds_map_exists(global.nodeMap, obj_chain.currentFocusedChainID) && obj_chain.currentFocusedChainID != "") {
	
		// Keep the focus of Rez chains
		if (obj_toolPane.currentMode == obj_toolPane.modeRez) {
		
			var focusedChainSubMap = global.nodeMap[? obj_chain.currentFocusedChainID];
			if (scr_isNumericAndExists(focusedChainSubMap, ds_type_map)) {
				
				var focusedChainType = focusedChainSubMap[? "type"];
				if (focusedChainType == "resonance") {
					var setIDList = focusedChainSubMap[? "setIDList"];
					var setIDListSize = ds_list_size(setIDList);
					
					if (setIDListSize > 0) {
						
						var focusedChainFirstEntry = setIDList[| 0];
						var focusedChainFirstEntrySubMap = global.nodeMap[? focusedChainFirstEntry];
						var focusedChainFirstTokenID = focusedChainFirstEntrySubMap[? "token"];
						var focusedChainFirstTokenSubMap = global.nodeMap[? focusedChainFirstTokenID];
						var firstItemDisplayCol = focusedChainFirstTokenSubMap[? "displayCol"];
						
						var gridOfFutureChainsHeight = ds_grid_height(gridOfFutureChains);
						for (var i = 0; i < gridOfFutureChainsHeight; i++) {
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
	}


	// Using the organized & sorted grid, simulate clicks to create the chains
	if (ds_grid_height(gridOfFutureChains) > 0) {
		
		obj_chain.currentFocusedChainID = "";
		var gridOfFutureChainsHeight = ds_grid_height(gridOfFutureChains);
		for (var i = 0; i < gridOfFutureChainsHeight; i++) {
			if(i == gridOfFutureChainsHeight-1){
				obj_chain.quickLinkCreated = false;
			}
			
			var currentTokenIDList = ds_grid_get(gridOfFutureChains, gridOfFutureChains_colTokenIDList, i);
			var currentTokenIDListSize = ds_list_size(currentTokenIDList);

			if (currentTokenIDListSize > 1) {
				for (var j = 0; j < currentTokenIDListSize; j++) {
					var currentTokenID = currentTokenIDList[| j];
					if (is_string(currentTokenID)) {
						with (obj_chain) {
							scr_tokenClicked(currentTokenID)
						}
					}
				}
			}
			
			// unfocus the chain and destroy that list cuz we don't need it no more
			obj_chain.currentFocusedChainID = "";
			ds_list_destroy(currentTokenIDList);
		}
	}

	// Clear/destroy/reset the quicklink data structures
	ds_grid_destroy(gridOfFutureChains);
}