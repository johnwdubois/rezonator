function scr_gridToJSONLists(argument0) {
	// Convert grid data in lists to JSON strings

	var grid = argument0;
	var gridClone = ds_grid_create(ds_grid_width(grid), ds_grid_height(grid));

	ds_grid_copy(gridClone, grid);

	var colList = ds_list_create();

	var gridCloneWidth = ds_grid_width(gridClone);
	for (var i = 0; i < gridCloneWidth; i++)
	{
		var cellContainsList = false;
		//if (string_count("}", scr_drawGridViewerGetItemString(grid, i, 0)) > 0)
		if (scr_isItemAList(grid, i, 0))
		{
			cellContainsList = true;
		}
	
		var rowList = ds_list_create();
	
		ds_list_add(rowList, ds_grid_height(gridClone));
	
		var gridCloneHeight = ds_grid_height(gridClone);
		for (var j = 0; j < gridCloneHeight; j++)
		{		
			var value = ds_grid_get(gridClone, i, j);
		
			if (cellContainsList)
			{
				var valueList = ds_list_create();
				if (typeof(value) == "string") {
					show_message("Error:" + value);
				}
			
				ds_list_copy(valueList, value);
				value = valueList;
			}
		
			ds_list_add(rowList, value);
		
			if (cellContainsList)
			{
				ds_list_mark_as_list(rowList, ds_list_size(rowList) - 1);
			}
		}
	
		ds_list_add(colList, rowList);
		ds_list_mark_as_list(colList, ds_list_size(colList) - 1);
	
	}

	ds_grid_destroy(gridClone);

	return colList;


}
