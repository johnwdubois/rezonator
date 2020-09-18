function scr_drawGridViewerGetItemString(argument0, argument1, argument2) {
	/*
		scr_drawGridViewerGetItemString(grid, col, row);
	
		Last Updated: 2018-09-11
	
		Called from: obj_gridViewer
	
		Purpose: return the string version of the specified cell in the specified grid
	
		Mechanism: test the grid and the column specified in the arguments and take the necessary
					action to convert the cell value to a human-readable string
	
		Author: Terry DuBois
	*/

	var grid = argument0;
	var col = argument1;
	var row = argument2;

	var currentCell = ds_grid_get(grid, col, row);
	var itemString = "";

	if (scr_isItemAList(grid, col, row)) {
		itemString = scr_getStringOfList(currentCell);
	}
	else {
		itemString = string(ds_grid_get(grid, col, row));
	}

	if (string_length(itemString) == 0) {
		itemString = " ";
	}

	return itemString;


}
