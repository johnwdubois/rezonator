var grid = argument0;
var col1 = argument1;
var valueInCol1 = argument2;
var col2 = argument3;
var valueInCol2 = argument4;
var col3 = argument5;
var valueInCol3 = argument6;

var tempGrid = ds_grid_create(ds_grid_width(grid), ds_grid_height(grid));

ds_grid_copy(tempGrid, grid);

var possibleRowsList1 = ds_list_create();
var possibleRowsList2 = ds_list_create();

while (ds_grid_value_exists(tempGrid, col1, 0, col1, ds_grid_height(tempGrid), valueInCol1))
{
	var rowInGrid = ds_grid_value_y(tempGrid, col1, 0, col1, ds_grid_height(tempGrid), valueInCol1);
	ds_list_add(possibleRowsList1, rowInGrid);
	ds_grid_set(tempGrid, col1, rowInGrid, undefined);
}

for (var i = 0; i < ds_list_size(possibleRowsList1); i++)
{
	var rowInGrid = ds_list_find_value(possibleRowsList1, i);
	var col2Element = ds_grid_get(tempGrid, col2, rowInGrid);
	
	if (col2Element == valueInCol2)
	{
		ds_list_add(possibleRowsList2, rowInGrid);
	}
}

var rowReturn = -1;

for (var i = 0; i < ds_list_size(possibleRowsList2); i++)
{
	var rowInGrid = ds_list_find_value(possibleRowsList2, i);
	var col3Element = ds_grid_get(tempGrid, col3, rowInGrid);
	
	if (col3Element == valueInCol3)
	{
		rowReturn = rowInGrid;
		break;
	}
}

ds_list_destroy(possibleRowsList1);
ds_list_destroy(possibleRowsList2);
ds_grid_destroy(tempGrid);

return rowReturn;