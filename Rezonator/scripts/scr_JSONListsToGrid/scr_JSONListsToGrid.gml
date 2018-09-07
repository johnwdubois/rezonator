var grid = argument0;
var gridLists = argument1;

for (var i = 0; i < ds_list_size(gridLists); i++)
{	
	var rowList = ds_list_find_value(gridLists, i);
	
	for (var j = 1; j < ds_list_size(rowList); j++)
	{
		var currentCellValue = ds_list_find_value(rowList, j);
		
		ds_grid_set(grid, i, j - 1, currentCellValue);
	}
}