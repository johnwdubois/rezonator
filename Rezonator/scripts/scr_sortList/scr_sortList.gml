function scr_sortList(list){
	if(!scr_isNumericAndExists(list, ds_type_list)){exit;}
	var listSize = ds_list_size(list);
	var tempGridWidth = 2;
	var tempStrGrid = ds_grid_create(tempGridWidth, 0);
	var tempDigitGrid = ds_grid_create(tempGridWidth, 0);
	var tempGrid_colVal = 0;
	var tempGrid_colModVal = 1;	
	
	for(var i = 0; i < listSize; i++){
		var currentValue = list[|i];
		var strDigit = string_digits(currentValue);
		var currentModValue = "";

		//is definitley a number
		if(string_length(strDigit) > 0 && string_length(strDigit) == string_length(currentValue)){
			currentModValue =  real(currentValue);
		}
		else{
			currentModValue = string_lower(currentValue);
		}
		// put the currentVal into either the tempStrGrid or tempDigitGrid
		var grid = (is_string(currentModValue)) ? tempStrGrid : tempDigitGrid;
		ds_grid_resize(grid, tempGridWidth, ds_grid_height(grid) + 1);
		grid[# tempGrid_colVal, ds_grid_height(grid) - 1] = currentValue;
		grid[# tempGrid_colModVal, ds_grid_height(grid) - 1] = currentModValue;
	}
	
	
	ds_grid_sort(tempStrGrid,tempGrid_colModVal,1);
	ds_grid_sort(tempDigitGrid,tempGrid_colModVal,1);
	
	ds_list_clear(list);
	
	

	var tempStrGridHeight = ds_grid_height(tempStrGrid)
	for(var i = 0; i < tempStrGridHeight; i++){
		ds_list_add(list, tempStrGrid[# tempGrid_colVal,i]);
	}
	var tempDigitGridHeight = ds_grid_height(tempDigitGrid)
	for(var i = 0; i < tempDigitGridHeight; i++){
		ds_list_add(list, tempDigitGrid[# tempGrid_colVal,i]);
	}

	ds_grid_destroy(tempStrGrid);
	ds_grid_destroy(tempDigitGrid);
}