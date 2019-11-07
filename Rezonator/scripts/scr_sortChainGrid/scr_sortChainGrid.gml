var grid = argument0;
var sortCol = argument1;
// -1...wordID
// 0...uID
// 1...place
// 2...text
var tempGrid_colWordID = 0;
var tempGrid_colSortVal = 1;

for (var i = 0; i < ds_grid_height(grid); i++) {
	
	// get wordIDList and write info to a temp grid
	var currentWordIDList = ds_grid_get(grid, obj_chain.chainGrid_colWordIDList, i);
	
	if (ds_list_size(currentWordIDList) < 1) {
		continue;
	}
	if (sortCol < 0) {
		ds_list_sort(currentWordIDList, true);
	}
	else {
		
		// make tempGrid with the height of the list size, fill in 2 columns for wordID and sortVal
		var tempGrid = ds_grid_create(2, ds_list_size(currentWordIDList));
		for (var j = 0; j < ds_list_size(currentWordIDList); j++) {
		
			var currentWordID = ds_list_find_value(currentWordIDList, j);
			var currentUnitID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, currentWordID - 1);
			ds_grid_set(tempGrid, tempGrid_colWordID, j, currentWordID);
		
			var sortVal = 0;
			switch (sortCol) {
				case 0:
					sortVal = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colUtteranceID, currentUnitID - 1);
					break;
				case 1:
					sortVal = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordSeq, currentWordID - 1);
					break;
				case 2:
					sortVal = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, currentWordID - 1);
					break;
				default:
					break;
			}
		}
		ds_grid_sort(tempGrid, tempGrid_colSortVal, true);
		
		for (var j = 0; j < ds_grid_height(tempGrid); j++) {
			
			var currentWordID = ds_grid_get(tempGrid, tempGrid_colWordID, j);
			ds_list_set(currentWordIDList, j, currentWordID);
		}
		
		ds_grid_destroy(tempGrid);
	}
}