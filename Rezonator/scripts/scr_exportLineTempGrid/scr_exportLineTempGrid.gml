// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_exportLineTempGrid(gridSource){

	// create copy of source grid but with extra column
	var grid = ds_grid_create(ds_grid_width(gridSource), ds_grid_height(gridSource));
	ds_grid_copy(grid, gridSource);
	ds_grid_resize(grid, ds_grid_width(grid) + 1, ds_grid_height(grid));
	
	// fill in extra column
	var gridHeight = ds_grid_height(grid);
	for (var i = 0; i < gridHeight; i++) {
		
		var currentLineText = "";
		var currentWordIDList = ds_grid_get(grid, obj_control.lineGrid_colWordIDList, i);
		var currentWordIDListSize = ds_list_size(currentWordIDList);
		for (var j = 0; j < currentWordIDListSize; j++) {
			
			// get the current word and add it to the unit text for this line
			var currentWordID = ds_list_find_value(currentWordIDList, j);
			var currentDisplayStr = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, currentWordID - 1);
			currentLineText += currentDisplayStr;
			if (j < currentWordIDListSize - 1) {
				currentLineText += " ";
			}
		}
		
		// set the line text in the tempgrid
		ds_grid_set(grid, ds_grid_width(grid) - 1, i, currentLineText);
	}
	
	return grid;
	
}