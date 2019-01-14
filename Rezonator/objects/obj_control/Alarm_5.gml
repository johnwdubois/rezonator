/// @description Insert description here
// You can write your code in this editor
var row = ds_grid_value_y(obj_control.lineGrid, obj_control.lineGrid_colUnitID, 0, obj_control.lineGrid_colUnitID, ds_grid_height(lineGrid), obj_control.prevCenterDisplayRow);
if(row < 0 or row >= ds_grid_height(lineGrid)) 
{
	exit;	
}
obj_control.currentCenterDisplayRow = ds_grid_get(lineGrid, lineGrid_colDisplayRow, row);