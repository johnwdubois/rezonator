/*
	scr_sortChainGrid(grid, sortCol, ascending);
	
	Last Updated: 2019-27-12
	
	Called from: obj_panelPane
	
	Purpose: Sort a specified column of a chain grid
	
	Mechanism: ???
	
	Author: Terry DuBois
*/
function scr_sortChainGrid(grid, sortCol, ascending) {
	
	show_message("scr_sortChainGrid() ... sortCol: " + string(sortCol) + ", ascending: " + string(ascending));
	

	// -1...wordID
	// 0...uID
	// 1...place
	// 2...text
	var tempGrid_colWordID = 0;
	var tempGrid_colSortVal = 1;

	var gridHeight = ds_grid_height(grid);
	for (var i = 0; i < gridHeight; i++) {
	
		// get wordIDList and write info to a temp grid
		var currentWordIDList = ds_grid_get(grid, obj_chain.chainGrid_colWordIDList, i);
	
		if (!is_undefined(currentWordIDList)) {
	
			if (ds_list_size(currentWordIDList) < 1) {
				continue;
			}
			if (sortCol < 0) {
				ds_list_sort(currentWordIDList, true);
			}
			else {
		
				// make tempGrid with the height of the list size, fill in 2 columns for wordID and sortVal
				var tempGrid = ds_grid_create(2, ds_list_size(currentWordIDList));
				var currentWordIDListSize = ds_list_size(currentWordIDList);
				for (var j = 0; j < currentWordIDListSize; j++) {
		
					var currentWordID = ds_list_find_value(currentWordIDList, j);
					var currentUnitID = (grid == obj_chain.stackChainGrid) ? currentWordID : ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, currentWordID - 1);
					ds_grid_set(tempGrid, tempGrid_colWordID, j, currentWordID);
		
					var sortVal = 0;
					switch (sortCol) {
						case 0:
							sortVal = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colUtteranceID, currentUnitID - 1);
							break;
						case 1:
							if (grid == obj_chain.stackChainGrid) {
								sortVal = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colParticipantName, currentUnitID - 1);
							}
							else {
								sortVal = ds_grid_get(obj_control.wordGrid, obj_control.dynamicWordGrid_colDisplayWordSeq, currentWordID - 1);
							}
							break;
						case 2:
							if (grid == obj_chain.stackChainGrid) {
								var unitWordIDList = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colWordIDList, currentUnitID - 1);
								sortVal = "";
								var unitWordIDListSize = ds_list_size(unitWordIDList);
								for (var k = 0; k < unitWordIDListSize; k++) {
									var currentUnitWordIDListWordID = ds_list_find_value(unitWordIDList, k);
									sortVal += string(ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordToken, currentUnitWordIDListWordID - 1));
								}
							}
							else {
								sortVal = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, currentWordID - 1);
							}
							break;
						default:
							break;
					}
			
					ds_grid_set(tempGrid, tempGrid_colSortVal, j, sortVal);
				}
				ds_grid_sort(tempGrid, tempGrid_colSortVal, ascending);
		
				var sortedList = ds_list_create();
				var tempGridHeight = ds_grid_height(tempGrid);
				for (var j = 0; j < tempGridHeight; j++) {
			
					var currentWordID = ds_grid_get(tempGrid, tempGrid_colWordID, j);
					ds_list_add(sortedList, currentWordID);
				}
		
				ds_list_clear(currentWordIDList);
				ds_list_copy(currentWordIDList, sortedList);
		
				ds_grid_destroy(tempGrid);
				ds_list_destroy(sortedList);
			}
		}
	}


}
