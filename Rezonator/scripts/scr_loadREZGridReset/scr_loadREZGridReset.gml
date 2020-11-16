function scr_loadREZGridReset(tempGrid, map, mapKey) {
	// Reset the tempGrid to load in the next Map into its respective grid

	var mapFind = ds_map_find_value(map, mapKey);


	if (is_undefined(mapFind)) {
		exit;
	}

	scr_loadREZGridResize(tempGrid, mapFind);
	ds_grid_clear(tempGrid, -1);
	scr_JSONListsToGrid(tempGrid, mapFind, map, mapKey);


}
