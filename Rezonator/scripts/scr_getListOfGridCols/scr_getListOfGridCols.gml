// returns a list of the column names (as strings) for a specified grid

var grid = argument0;
var listOfGridCols = ds_list_create();

for (var i = 0; i < ds_grid_width(grid); i++) {
	var currentColName = scr_getColNameString(grid, i);
	ds_list_add(listOfGridCols, currentColName);
}

return listOfGridCols;