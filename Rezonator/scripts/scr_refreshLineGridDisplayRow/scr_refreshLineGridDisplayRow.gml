/*
	scr_refreshLineGridDisplayRow();
	
	Last Updated: 2018-07-12
	
	Called from: obj_control
	
	Purpose: set every item in the lineGrid's displayRow column to whatever row in the grid it exists on
	
	Mechanism: loop through entire lineGrid
*/

var grid = obj_control.lineGrid;
var col = obj_control.lineGrid_colDisplayRow;

for (var i = 0; i < ds_grid_height(grid); i++)
{
	ds_grid_set(grid, col, i, i);
}