

function scr_fillFieldLevelMap(){
	show_debug_message("scr_fillFieldLevelMap");
	
	// store the level for every field in a map, so they can be quickly referenced by name
	var tagInfoGridHeight = ds_grid_height(global.tagInfoGrid);
	for (var i = 0; i < tagInfoGridHeight; i++) {
		
		var currentField = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, i);
		var currentLevel = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colLevel, i);
		
		// if the currentField does not yet exist in the map, let's add it, with the currentLevel as the value
		if (!ds_map_exists(global.fieldLevelMap, currentField)) {
			ds_map_add(global.fieldLevelMap, currentField, currentLevel);
		}
	}
	
}