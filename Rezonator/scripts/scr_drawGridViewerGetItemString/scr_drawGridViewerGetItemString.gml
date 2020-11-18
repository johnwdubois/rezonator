/*
	scr_drawGridViewerGetItemString(grid, col, row);
	
	Last Updated: 2018-09-11
	
	Called from: obj_gridViewer
	
	Purpose: return the string version of the specified cell in the specified grid
	
	Mechanism: test the grid and the column specified in the arguments and take the necessary
				action to convert the cell value to a human-readable string
	
	Author: Terry DuBois
*/
function scr_drawGridViewerGetItemString(grid, col, row) {
	

	var currentCell = ds_grid_get(grid, col, row);
	var itemString = "";

	if (scr_isItemAList(grid, col, row)) {
		itemString = scr_getStringOfList(currentCell);
	}
	else {
		itemString = string(currentCell);
	}

	if (string_length(itemString) == 0) {
		itemString = " ";
	}

	return itemString;


}
