function scr_shuffleDisplayRows() {
	/*
		scr_shuffleDisplayRows();
	
		Last Updated: 2018-07-12
	
		Called from: obj_control
	
		Purpose: shuffle the lineGrid's rows
	
		Mechanism: create a shuffled list of the rows in the lineGrid, create a temporaryGrid to set
					new row information to, copy information from temporaryGrid to lineGrid
	*/

	var gridSource = obj_control.lineGrid;
	var gridShuffle = ds_grid_create(ds_grid_width(gridSource), ds_grid_height(gridSource));

	var gridSourceRowsToCopy = ds_list_create();
	var gridSourceHeight = ds_grid_height(gridSource);

	for (var i = 0; i < gridSourceHeight; i++)
	{
		ds_list_add(gridSourceRowsToCopy, i);
	}

	ds_list_shuffle(gridSourceRowsToCopy);



	var gridSourceRowsToCopySize = ds_list_size(gridSourceRowsToCopy);
	for (var j = 0; j < gridSourceRowsToCopySize; j++)
	{
		var rowToCopy = ds_list_find_value(gridSourceRowsToCopy, j);
	
		var gridSourceWidth = ds_grid_width(gridSource);
		for (var k = 0; k < gridSourceWidth; k++)
		{
			var value = ds_grid_get(gridSource, k, rowToCopy);
			ds_grid_set(gridShuffle, k, j, value);
		}
	}

	ds_grid_copy(gridSource, gridShuffle);


	ds_grid_destroy(gridShuffle);


}
