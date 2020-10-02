// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_deleteChain(chainID){
	
	// first, we find the grid that this chain is
	var grid = -1;
	var rowInGrid = -1;
	for (var i = 0; i < 3; i++) {
		var testGrid = -1;
		if (i == 0) {
			testGrid = obj_chain.rezChainGrid;
			show_debug_message("scr_deleteChain()... testGrid: rezChainGrid");
		}
		else if (i == 1) {
			testGrid = obj_chain.trackChainGrid;
			show_debug_message("scr_deleteChain()... testGrid: trackChainGrid");
		}
		else {
			testGrid = obj_chain.stackChainGrid;
			show_debug_message("scr_deleteChain()... testGrid: stackChainGrid");
		}
		rowInGrid = ds_grid_value_y(testGrid, obj_chain.chainGrid_colChainID, 0, obj_chain.chainGrid_colChainID, ds_grid_height(testGrid), chainID);
		if (rowInGrid > -1) {
			break;
		}
	}
	if (rowInGrid == -1) {
		show_debug_message("scr_deleteChain()... rowInGrid == -1, exiting...");
		exit;
	}
	show_debug_message("scr_deleteChain()... rowInGrid: " + string(rowInGrid));
	grid = testGrid;
	
	
	// now we know the grid and the rowInGrid, let's delete EVERYTHING
	var IDList = ds_grid_get(grid, obj_chain.chainGrid_colWordIDList, rowInGrid);
	var IDListSize = ds_list_size(IDList);
	
	// if this is a rezChain or trackChain, let's remove this chainID from all of the words' inChainsList
	if (grid == obj_chain.rezChainGrid or grid == obj_chain.trackChainGrid) {
		for (i = 0; i < IDListSize; i++) {
			var currentWordID = ds_list_find_value(IDList, i);
			var currentInChainsList = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInChainList, currentWordID - 1);
			var indexOfInChainsList = ds_list_find_index(currentInChainsList, chainID);
			ds_list_delete(currentInChainsList, indexOfInChainsList);
		
			// if this is a wordID (not a unitID) then we must update the wordDrawGrid
			if (grid == obj_chain.rezChainGrid) {
				ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colBorder, currentWordID - 1, false);
				
				// if there is another chain still left in this inChainsList, it must be a Track chain,
				// so we will draw the Track border again
				if (ds_list_size(currentInChainsList) > 0) {
					ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colBorder, currentWordID - 1, true);
					ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colBorderRounded, currentWordID - 1, true);
					var trackChainID = ds_list_find_value(currentInChainsList, 0);
					var trackChainRow = ds_grid_value_y(obj_chain.trackChainGrid, obj_chain.chainGrid_colChainID, 0, obj_chain.chainGrid_colChainID, ds_grid_height(obj_chain.trackChainGrid), trackChainID);
					show_debug_message("scr_deleteChain() ... trackChainID: " + string(trackChainID) + "... trackChainRow: " + string(trackChainRow) + " trackChainGridHeight: " + string(ds_grid_height(obj_chain.trackChainGrid)));
					if (trackChainRow >= 0 && trackChainRow < ds_grid_height(obj_chain.trackChainGrid)) {
						var trackChainColor = ds_grid_get(obj_chain.trackChainGrid, obj_chain.chainGrid_colColor, trackChainRow);
						show_debug_message("scr_deleteChain() ... trackChainColor: " + string(trackChainColor));
						ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colEffectColor, currentWordID - 1, trackChainColor);
					}
				}
			}
			else if (grid == obj_chain.trackChainGrid) {
				ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colBorder, currentWordID - 1, false);
				ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colBorderRounded, currentWordID - 1, false);
				
				// if there is another chain still left in this inChainsList, it must be a Rez chain,
				// so we will draw the Rez border again
				if (ds_list_size(currentInChainsList) > 0) {
					ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colBorder, currentWordID - 1, true);
					var rezChainID = ds_list_find_value(currentInChainsList, 0);
					var rezChainRow = ds_grid_value_y(obj_chain.rezChainGrid, obj_chain.chainGrid_colChainID, 0, obj_chain.chainGrid_colChainID, ds_grid_height(obj_chain.rezChainGrid), rezChainID);
					show_debug_message("scr_deleteChain() ... rezChainID: " + string(rezChainID) + "... rezChainRow: " + string(rezChainRow) + " rezChainGridHeight: " + string(ds_grid_height(obj_chain.rezChainGrid)));
					if (rezChainRow >= 0 && rezChainRow < ds_grid_height(obj_chain.rezChainGrid)) {
						var rezChainColor = ds_grid_get(obj_chain.rezChainGrid, obj_chain.chainGrid_colColor, rezChainRow);
						show_debug_message("scr_deleteChain() ... rezChainColor: " + string(rezChainColor));
						ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colEffectColor, currentWordID - 1, rezChainColor);
					}
				}
			}
			ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colFillRect, currentWordID - 1, false);
		}
	}
	
	// if this is a stack, let's remove its units from the unitInStackGrid
	if (grid == obj_chain.stackChainGrid) {
		for (i = 0; i < IDListSize; i++) {
			var currentUnitID = ds_list_find_value(IDList, i);
			ds_grid_set(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colStack, currentUnitID - 1, -1);
			ds_grid_set(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colStackType, currentUnitID - 1, -1);
		}
	}
	
	// second, we kill every living link from this chain in the link grid
	var rowToKill = scr_findInGridTwoParameters(obj_chain.linkGrid, obj_chain.linkGrid_colChainID, chainID, obj_chain.linkGrid_colDead, false);
	while (rowToKill > -1) {
		ds_grid_set(obj_chain.linkGrid, obj_chain.linkGrid_colDead, rowToKill, true);
		rowToKill = scr_findInGridTwoParameters(obj_chain.linkGrid, obj_chain.linkGrid_colChainID, chainID, obj_chain.linkGrid_colDead, false);
	}
	
	// third, we delete the row from the chainGrid
	scr_gridDeleteRow(grid, rowInGrid);
	
}