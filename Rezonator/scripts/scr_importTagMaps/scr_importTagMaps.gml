function scr_importTagMaps() {
	show_debug_message("scr_importTagMaps()");

	//fill maps for custom tagsets
	if (!global.unitTagMapFilled && ds_grid_height(global.unitImportGrid) > 0) {
		global.unitTagMapFilled = true;
	
		var gridWidth = ds_grid_width(global.unitImportGrid);
		for (var i = 0 ; i < gridWidth; i++) {
			var tempList = ds_list_create();
			ds_list_add(tempList, "Add new Tag");
			var mapKey = ds_list_find_value(global.unitImportColNameList, i);
			ds_map_add_list(global.unitImportTagMap, mapKey, tempList);
		}
	}


	if (!global.tokenTagMapFilled && ds_grid_height(global.tokenImportGrid) > 0) {
		global.tokenTagMapFilled = true;

		var gridWidth = ds_grid_width(global.tokenImportGrid);
		for (var i = 0 ; i < gridWidth; i++) {
			var tempList = ds_list_create();
			ds_list_add(tempList, "Add new Tag");
			var mapKey = ds_list_find_value(global.tokenImportColNameList, i);
			ds_map_add_list(global.tokenImportTagMap, mapKey, tempList);
		}
	}


}
