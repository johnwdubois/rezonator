/*
	scr_refreshLineGridDisplayRow();
	
	Last Updated: 2018-07-12
	
	Called from: obj_control
	
	Purpose: set every item in the lineGrid's displayRow column to whatever row in the grid it exists on
	
	Mechanism: loop through entire lineGrid
	
	Author: Terry DuBois
*/
function scr_refreshLineGridDisplayRow(grid) {

	var col = obj_control.lineGrid_colDisplayRow;

	// set every row in grid column to i
	var gridHeight = ds_grid_height(grid);
	for (var i = 0; i < gridHeight; i++)
	{
		ds_grid_set(grid, col, i, i);
	}


}
