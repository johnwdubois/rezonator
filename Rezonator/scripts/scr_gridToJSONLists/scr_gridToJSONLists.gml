function scr_gridToJSONLists(grid) {
	// Convert grid data in lists to JSON strings

	// create a copy of the grid we want to convert
	var gridClone = ds_grid_create(ds_grid_width(grid), ds_grid_height(grid));
	ds_grid_copy(gridClone, grid);

	var colList = ds_list_create();

	// loop through grid and turn it into a list of lists	
	var gridCloneWidth = ds_grid_width(gridClone);
	for (var i = 0; i < gridCloneWidth; i++) {
		
		var cellContainsList = false;
		if (scr_isItemAList(grid, i, 0)) {
			cellContainsList = true;
		}
		
		// make a list for each row
		var rowList = ds_list_create();
	
		ds_list_add(rowList, ds_grid_height(gridClone));
	
		var gridCloneHeight = ds_grid_height(gridClone);
		for (var j = 0; j < gridCloneHeight; j++) {		
			var value = ds_grid_get(gridClone, i, j);
		
			if (cellContainsList) {
				var valueList = ds_list_create();
				if (typeof(value) == "string") {
					show_message(scr_get_translation("msg_error_type") + value);
				}
				ds_list_copy(valueList, value);
				value = valueList;
			}
		
			ds_list_add(rowList, value);
		
			if (cellContainsList) {
				ds_list_mark_as_list(rowList, ds_list_size(rowList) - 1);
			}
		}
	
		ds_list_add(colList, rowList);
		ds_list_mark_as_list(colList, ds_list_size(colList) - 1);
	
	}

	ds_grid_destroy(gridClone);

	return colList;


}
