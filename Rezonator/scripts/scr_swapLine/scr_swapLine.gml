

/*
	scr_swapLine();
	
	Last Updated: 2019-08-10
	
	Called from: obj_diaalogueBox
	
	Purpose: swaps the position of two lines in the line grid and stores original in back up
	
	Mechanism: used for rezzles that require line swapping
				
	Author: Brady Moore
*/



if(obj_control.swapLinePos2 < 0  and  obj_control.swapLinePos2 > ds_grid_height(obj_control.lineGrid)){
	show_message("Please input a number in range." + string(obj_control.swapLinePos2));
exit;
}

// get correct position of line 2 in grid
obj_control.swapLinePos2 = obj_control.swapLinePos2 -1; 

// copy original grid into new grid
var swappedLineGrid = ds_grid_create(obj_control.lineGridWidth, 0);
ds_grid_copy(swappedLineGrid, obj_control.lineGrid);

// loop through line to be swapped and copy each value from both lines for each column
for(var i =1 ; i < ds_grid_width(obj_control.lineGrid); i ++){
	
	
	var Line1CurrentSwap  = ds_grid_get(obj_control.lineGrid, i , obj_control.swapLinePos1);
	//show_message(string(Line1CurrentSwap));
	ds_grid_set(swappedLineGrid, i, obj_control.swapLinePos2,  Line1CurrentSwap);
	
	
	
	var Line2CurrentSwap  = ds_grid_get(obj_control.lineGrid, i , obj_control.swapLinePos2);
	//show_message(string(Line2CurrentSwap));
	ds_grid_set(swappedLineGrid, i, obj_control.swapLinePos1,  Line2CurrentSwap);
	
	
}

// return swapped grid back into orginal grid
ds_grid_copy(obj_control.lineGrid, swappedLineGrid);

scr_refreshLineGridPixelY();