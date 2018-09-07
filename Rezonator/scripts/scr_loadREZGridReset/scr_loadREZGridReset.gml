var grid = argument0;
var map = argument1;
var mapKey = argument2;

var mapFind = ds_map_find_value(map, mapKey);


if (is_undefined(mapFind))
{
	exit;
}


scr_loadREZGridResize(grid, mapFind);
ds_grid_clear(grid, -1);
scr_JSONListsToGrid(grid, mapFind);