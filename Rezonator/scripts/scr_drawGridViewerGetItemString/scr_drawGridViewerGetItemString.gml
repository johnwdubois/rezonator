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
