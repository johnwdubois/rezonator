/*
	scr_killEmptyChains(grid);
	
	Last Updated: 2018-09-11
	
	Called from: obj_chain
	
	Purpose: delete any chain that contains 1 or less items
	
	Mechanism: iterate over specified chainGrid to check every chain's idList size, and
				if the size is less than or equal to 1, delete the row in the chainGrid
	
	Author: Terry DuBois
*/
function scr_killEmptyChains(grid) {
	

	// loop through chainGrid 
	var gridHeight = ds_grid_height(grid);
	for (var i = 0; i < gridHeight; i++) {
		if (i >= ds_grid_height(grid)) {
			continue;
		}
	
		var idList = ds_grid_get(grid, obj_chain.chainGrid_colWordIDList, i);
		var chainState = ds_grid_get(grid, obj_chain.chainGrid_colChainState, i);
	
		if (ds_list_size(idList) == 0) {
			chainState = obj_chain.chainStateDead;
			ds_grid_set(grid, obj_chain.chainGrid_colChainState, i, chainState);
		}
	
		if (ds_list_size(idList) <= 0 and not (chainState == obj_chain.chainStateFocus) and not (chainState == obj_chain.chainStateDead) and not(grid == obj_chain.stackChainGrid)) {
			chainState = obj_chain.chainStateDead;
			ds_grid_set(grid, obj_chain.chainGrid_colChainState, i, chainState);
		
			if (ds_list_size(idList) == 1) {
				var chainID = ds_grid_get(grid, obj_chain.chainGrid_colChainID, i);
				var lastItemId = ds_list_find_value(idList, 0);
			
				if(lastItemId > 0) {
					if (grid == obj_chain.rezChainGrid) {
						ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colBorder, lastItemId - 1, false);
					}
					else if (grid == obj_chain.trackChainGrid) {
						ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colBorderRounded, lastItemId - 1, false);
						ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colBorder, lastItemId - 1, false);
					}
				}
			
				var lastItemInChainsList = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInChainList, lastItemId - 1);
				var indexInLastItemInChainsList = ds_list_find_index(lastItemInChainsList, chainID);
				if (indexInLastItemInChainsList >= 0) {
					ds_list_delete(lastItemInChainsList, indexInLastItemInChainsList);
				}
			}
		
			// if deleting a stack chain with one unit, mark that change in unitInStackGrid
			if (grid == obj_chain.stackChainGrid and ds_list_size(idList) > 0) {
				var unitID = ds_list_find_value(idList, 0);
				ds_grid_set(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colStack, unitID - 1, -1);
				ds_grid_set(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colStackType, unitID - 1, -1);
			}
		}
	}

	// Delete dead chains from chainGrid
	while (ds_grid_value_exists(grid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(grid), obj_chain.chainStateDead)) {
		var deadRow = ds_grid_value_y(grid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(grid), obj_chain.chainStateDead);
		scr_gridDeleteRow(grid, deadRow);
	}
	//show_message("ehere");
	//scr_refreshChainGrid();


}
