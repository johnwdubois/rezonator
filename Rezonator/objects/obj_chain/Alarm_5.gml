/*
Alarm for displaying the correct focus for all contexts
Author: Terry DuBois and Georgio Klironomos
*/
if (unitIDOfFirstWord < 0 or unitIDOfLastWord < 0) {
	exit;
}

//retrieve the units of the top/bottom words
var rowOfFirstUnitInFilterGrid = ds_grid_value_y(obj_control.filterGrid, obj_control.lineGrid_colUnitID, 0, obj_control.lineGrid_colUnitID, ds_grid_height(obj_control.filterGrid), unitIDOfFirstWord);
var rowOfLastUnitInFilterGrid = ds_grid_value_y(obj_control.filterGrid, obj_control.lineGrid_colUnitID, 0, obj_control.lineGrid_colUnitID, ds_grid_height(obj_control.filterGrid), unitIDOfLastWord);

if (rowOfFirstUnitInFilterGrid < 0 or rowOfFirstUnitInFilterGrid >= ds_grid_height(obj_control.filterGrid)
or rowOfLastUnitInFilterGrid < 0 or rowOfLastUnitInFilterGrid >= ds_grid_height(obj_control.filterGrid)) {
	exit;
}
//retrieve display rows of the top/bottom words
var firstUnitDisplayRow = ds_grid_get(obj_control.filterGrid, obj_control.lineGrid_colDisplayRow, rowOfFirstUnitInFilterGrid);
var lastUnitDisplayRow = ds_grid_get(obj_control.filterGrid, obj_control.lineGrid_colDisplayRow, rowOfLastUnitInFilterGrid);

var averageDisplayRow = floor(mean(firstUnitDisplayRow, lastUnitDisplayRow));

//check for correct context
if(obj_chain.focusPrior) {
	obj_control.currentCenterDisplayRow = firstUnitDisplayRow;
}else if(obj_chain.focusTween) {
	obj_control.currentCenterDisplayRow = averageDisplayRow;
}else if(obj_chain.focusNext) {
	obj_control.currentCenterDisplayRow = lastUnitDisplayRow;
}	

//reset variables for next use
obj_chain.focusPrior = false;
obj_chain.focusTween = false;
obj_chain.focusNext = false;
