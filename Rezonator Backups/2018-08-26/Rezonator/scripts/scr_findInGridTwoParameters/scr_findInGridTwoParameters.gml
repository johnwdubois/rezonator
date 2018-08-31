var grid = argument0;
var col1 = argument1;
var valueInCol1 = argument2;
var col2 = argument3;
var valueInCol2 = argument4;

var tempGrid = ds_grid_create(ds_grid_width(grid), ds_grid_height(grid));

ds_grid_copy(tempGrid, grid);

var possibleRowsList = ds_list_create();

while (ds_grid_value_exists(tempGrid, col1, 0, col1, ds_grid_height(tempGrid), valueInCol1))
{
	var rowInGrid = ds_grid_value_y(tempGrid, col1, 0, col1, ds_grid_height(tempGrid), valueInCol1);
	ds_list_add(possibleRowsList, rowInGrid);
	ds_grid_set(tempGrid, col1, rowInGrid, undefined);
}

var rowReturn = -1;

for (var i = 0; i < ds_list_size(possibleRowsList); i++)
{
	var rowInGrid = ds_list_find_value(possibleRowsList, i);
	var col2Element = ds_grid_get(tempGrid, col2, rowInGrid);
	
	if (col2Element == valueInCol2)
	{
		rowReturn = rowInGrid;
		break;
	}
}

ds_grid_destroy(tempGrid);

return rowReturn;