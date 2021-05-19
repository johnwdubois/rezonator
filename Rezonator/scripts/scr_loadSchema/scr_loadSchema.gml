function scr_loadSchema(autoload) {


	var fileName = "";
	
	// if this is an autoload, Rezonator will try to get the RZS file from the program directory, otherwise prompt the user to select a file
	if (autoload) {
		
		show_debug_message("scr_loadSchema, AUTOLOAD");
		if (global.importType == global.importType_IGT) {
			if (os_type == os_macosx) {
				fileName = global.rezonatorDirString + "/Schemas/igt_schema.rzs";
			}
			else {
				fileName = global.rezonatorDirString + "\\Schemas\\IGT Schema.rzs";
			}
		}
		else if (global.importType == global.importType_CSV) {
			if (os_type == os_macosx) {
				fileName = global.rezonatorDirString + "/Schemas/csv_schema.rzs";
			}
			else {
				fileName = global.rezonatorDirString + "\\Schemas\\CSV Schema.rzs";
			}
		}
		else if (global.importType == global.importType_CoNLLU) {
			if (os_type == os_macosx) {
				fileName = global.rezonatorDirString + "/Schemas/conll-u_schema.rzs";
			}
			else {
				fileName = global.rezonatorDirString + "\\Schemas\\CoNLL-U Schema.rzs";
			}
		}
		else {
			exit;
		}
		
	}
	else {
		fileName = (global.importGroupSchemaFile == "") ? get_open_filename_ext("SCHEMA file|*.rzs", "", global.rezonatorSchemaDirString, "Open Schema") : global.importGroupSchemaFile;
	}
	
	
	show_debug_message("scr_loadSchema, schema fileName: " + string(fileName));

	// make sure the file exists
	if (fileName == "" or not file_exists(fileName)) {
		show_debug_message("scr_loadSchema, ERROR: file does not exist");
		exit;
	}

	var wrapper = scr_loadJSONBuffer(fileName);
	
	if (not ds_exists(wrapper, ds_type_map)) {
		show_message("Error loading " + fileName);
		room_goto(rm_openingScreen);
		exit;
	}
	
	var list = ds_map_find_value(wrapper, "ROOT");
	
	if (is_undefined(list)) {
		show_message("Error loading " + fileName);
		room_goto(rm_openingScreen);
		exit;
	}
	obj_importMapping.levelEstimateColumnSelected = global.tagInfoGrid_colLevelSchema;
	
	// clear all Special Fields
	ds_grid_set_region(global.tagInfoGrid, global.tagInfoGrid_colSpecialFields, 0, global.tagInfoGrid_colSpecialFields, ds_grid_height(global.tagInfoGrid), "");
	
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
				ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colLevelSchema, i, levelFromMap);
			}
			if (!is_undefined(specialFieldFromMap)) {
				if (specialFieldFromMap == "Display Token" || specialFieldFromMap == "Token Delimiter"
				|| specialFieldFromMap == "Unit Delimiter") {
					ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colKey, i, specialFieldFromMap);
				}
				else {
					ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colSpecialFields, i, specialFieldFromMap);
				}
			}
		}
	}
	
	
	var rowOfDisplayToken = ds_grid_value_y(global.tagInfoGrid, global.tagInfoGrid_colKey, 0, global.tagInfoGrid_colKey, ds_grid_height(global.tagInfoGrid), "Display Token");
	var rowOfWordDelimiter = ds_grid_value_y(global.tagInfoGrid, global.tagInfoGrid_colKey, 0, global.tagInfoGrid_colKey, ds_grid_height(global.tagInfoGrid), "Word Delimiter");
	if (rowOfDisplayToken > -1) {
		obj_importMapping.displayMarker = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, rowOfDisplayToken);
	}
	if (rowOfWordDelimiter > -1) {
		obj_importMapping.wordDelimMarker = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, rowOfWordDelimiter);
	}
	show_debug_message("scr_loadSchema, displayMarker: " + string(obj_importMapping.displayMarker) + ", wordDelimMarker: " + string(obj_importMapping.wordDelimMarker));
	
	
	with (obj_importMapping) {
		alarm[4] = 2;
	}
}
 