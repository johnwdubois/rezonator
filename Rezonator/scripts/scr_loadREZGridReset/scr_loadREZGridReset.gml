function scr_loadREZGridReset(argument0, argument1, argument2) {
	// Reset the tempGrid to load in the next Map into its respective grid

	var tempGrid = argument0;
	var map = argument1;
	var mapKey = argument2;

	var mapFind = ds_map_find_value(map, mapKey);


	if (is_undefined(mapFind)) {
		exit;
	}

	scr_loadREZGridResize(tempGrid, mapFind);
	ds_grid_clear(tempGrid, -1);
	scr_JSONListsToGrid(tempGrid, mapFind, map, mapKey);


}
