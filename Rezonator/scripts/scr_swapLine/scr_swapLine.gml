function scr_swapLine() {
	/*
		Purpose: swaps the position of two lines in the line grid and stores original in back up
	*/


	if (obj_control.swapLinePos2 <= 0 or obj_control.swapLinePos2 > ds_grid_height(obj_control.lineGrid)) {
		show_message(scr_get_translation("msg_number-range"));
		exit;
	}

	// copy original grid into new grid
	var swappedLineGrid = ds_grid_create(obj_control.lineGridWidth, 0);
	ds_grid_copy(swappedLineGrid, obj_control.lineGrid);

	var rowSwapLine1 = ds_grid_value_y(obj_control.lineGrid, obj_control.lineGrid_colUnitID, 0, obj_control.lineGrid_colUnitID, ds_grid_height(obj_control.lineGrid), obj_control.swapLinePos1);
	var rowSwapLine2 = ds_grid_value_y(obj_control.lineGrid, obj_control.lineGrid_colUnitID, 0, obj_control.lineGrid_colUnitID, ds_grid_height(obj_control.lineGrid), obj_control.swapLinePos2);


	// loop through line to be swapped and copy each value from both lines for each column
	var lineGridWidth = ds_grid_width(obj_control.lineGrid);
	for(var i = 0; i < lineGridWidth; i++) {
	
		if(i != 0){
			var Line1CurrentSwap  = ds_grid_get(obj_control.lineGrid, i , rowSwapLine2);
			ds_grid_set(swappedLineGrid, i, rowSwapLine1,  Line1CurrentSwap);
	
	
	
			var Line2CurrentSwap  = ds_grid_get(obj_control.lineGrid, i , rowSwapLine1);
			ds_grid_set(swappedLineGrid, i, rowSwapLine2,  Line2CurrentSwap);
		}
	}


	// return swapped grid back into orginal grid
	ds_grid_copy(obj_control.lineGrid, swappedLineGrid);

	ds_grid_destroy(swappedLineGrid);



}
