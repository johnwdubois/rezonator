function scr_loadRZS() {
	/*
		scr_loadRez();
	
		Last Updated: 2020-01-01
	
		Called from: obj_fileLoader
	
		Purpose: Load data from a Rez file into Rezonator
	
		Mechanism: Separate the JSON string into its different maps, then load the data from those maps into all the grids.
	
		Author: Terry DuBois
	*/

	var fileName = (global.importGroupSchemaFile == "") ? get_open_filename_ext("SCHEMA file|*.rzs", "", global.rezonatorSchemaDirString, "Open Schema") : global.importGroupSchemaFile;
	show_debug_message("scr_loadSCH, schema fileName: " + string(fileName));

	// make sure the file exists
	if (fileName == "" or not file_exists(fileName)) {
		exit;
	}



	var newInstList = ds_list_create();
	var wrapper = scr_loadJSONBuffer(fileName);
	
	if (not ds_exists(wrapper, ds_type_map)) {
		show_message("Error loading " + fileName);
		game_restart();
		exit;
	}
	
	var list = ds_map_find_value(wrapper, "ROOT");
	
	if (is_undefined(list)) {
		show_message("Error loading " + fileName);
		game_restart();
		exit;
	}
	
	
	// the map will be the one and only item in the rootList
	var map = ds_list_find_value(list, 0);
	
	// loop through the tagInfoGrid, and look for the field's info in the map
	var tagInfoGridHeight = ds_grid_height(global.tagInfoGrid);
	for (var i = 0; i < tagInfoGridHeight; i++) {
		
		var currentField = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, i);
		
		// check to see if currentField is in this map
		if (ds_map_exists(map, currentField)) {
			
			// get this field's map in the overall map
			var currentFieldMap = ds_map_find_value(map, currentField);
			
			// get this field's level & special field from this field's map
			var levelFromMap = ds_map_find_value(currentFieldMap, "level");
			var specialFieldFromMap = ds_map_find_value(currentFieldMap, "specialField");
			
			// set level & special field (if they were found in this field's map)
			if (!is_undefined(levelFromMap)) {
				ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colLevel, i, levelFromMap);
			}
			if (!is_undefined(specialFieldFromMap)) {
				ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colSpecialFields, i, specialFieldFromMap);
			}
		}
	}
	
	
	
		
	/*
	global.previousSpecialFields = ds_map_find_value(map, "previousSpecialFields");
	global.previousLevelEstimates = ds_map_find_value(map, "previousLevelEstimates");
	if (global.tokenImportColNameList != undefined) {
		global.tokenImportGridWidth = ds_list_size(global.tokenImportColNameList);
	}
	if (global.unitImportColNameList != undefined) {
		global.unitImportGridWidth = ds_list_size(global.unitImportColNameList);
	}
	*/

	ds_list_destroy(newInstList);

	//scr_updateSchLists();


}
 