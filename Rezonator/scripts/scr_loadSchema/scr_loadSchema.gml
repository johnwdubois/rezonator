function scr_loadSchema(autoload) {


	var fileName = global.schemaFileName;
	ds_list_clear(global.importFieldTagList);
	
	// if this is an autoload, Rezonator will try to get the schema file from the program directory, otherwise prompt the user to select a file
	if (autoload) {
		
		show_debug_message("scr_loadSchema, AUTOLOAD");
		if (global.importType == "import_type_interlinear") {
			if (os_type == os_macosx) {
				fileName = global.rezonatorDirString + "/Schemas/Import/igt_schema.json";
			}
			else {
				fileName = global.rezonatorDirString + "\\Schemas\\Import\\igt_scription.json";
			}
		}
		else if (global.importType == "import_type_word") {
			if (os_type == os_macosx) {
				fileName = global.rezonatorDirString + "/Schemas/Import/owpl_sbc.json";
			}
			else {
				fileName = global.rezonatorDirString + "\\Schemas\\Import\\owpl_sbc.json";
			}
		}
		else if (global.importType == "import_type_conllu") {
			if (os_type == os_macosx) {
				fileName = global.rezonatorDirString + "/Schemas/Import/conll_u.json";
			}
			else {
				fileName = global.rezonatorDirString + "\\Schemas\\Import\\conll_u.json";
			}
		}
		else {
			exit;
		}
		
	}
	else {
		var openFileName = (global.importGroupSchemaFile == "") ? get_open_filename_ext("SCHEMA file|*.json", "", global.rezonatorSchemaDirString, "Open Schema") : global.importGroupSchemaFile;
		if (openFileName != "") {
			fileName = openFileName;
		}
	}
	
	global.schemaFileName = filename_name(fileName);
	show_debug_message("scr_loadSchema, schema fileName: " + string(fileName));

	// make sure the file exists
	if (fileName == "" or not file_exists(fileName)) {
		show_debug_message("scr_loadSchema, ERROR: file does not exist");
		exit;
	}

	var wrapper = scr_loadJSONBuffer(fileName);
	if (!scr_isNumericAndExists(wrapper, ds_type_map)) {
		show_message("Error loading " + fileName);
		show_debug_message("Going to openingScreen, scr_loadSchema");
		room_goto(rm_openingScreen);
		exit;
	}
	
	var list = ds_map_find_value(wrapper, "ROOT");
	if (!scr_isNumericAndExists(list, ds_type_list)) {
		show_message("Error loading " + fileName);
		show_debug_message("Going to openingScreen, scr_loadSchema");
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
			var levelFromMap = currentFieldMap[? "level"];
			var specialFieldFromMap = currentFieldMap[? "specialField"];
			var keyFromMap = currentFieldMap[? "key"];
			var collectTagsFromMap = currentFieldMap[? "collectTags"];
			show_debug_message("scr_loadSchema ... currentField: " + string(currentField) + ", levelFromMap: " + string(levelFromMap) + ", specialFieldFromMap: " + string(specialFieldFromMap) + ", keyFromMap: " + string(keyFromMap) + ", collectTagsFromMap: " + string(collectTagsFromMap));
			
			// set level & special field (if they were found in this field's map)
			if (!is_undefined(levelFromMap)) {
				ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colLevelSchema, i, levelFromMap);
				ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colLevel, i, levelFromMap);
			}
			if (!is_undefined(specialFieldFromMap)) {
				ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colSpecialFields, i, specialFieldFromMap);
				//if (global.CoNLLUwithMeta && currentField == " MISC" && specialFieldFromMap == "tab_name_track") {
				//	ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colSpecialFields, i, "");
				//}
			}
			if (!is_undefined(keyFromMap)) {
				ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colKey, i, keyFromMap);
			}
			if (!is_undefined(collectTagsFromMap) && collectTagsFromMap) {
				scr_addToListOnce(global.importFieldTagList, currentField);
			}
		}
	}
	
	// get nav field lists from schema
	var navTokenFieldList = map[? "navTokenFieldList"];
	if (scr_isNumericAndExists(navTokenFieldList, ds_type_list)) global.schemaNavTokenFieldList = navTokenFieldList;
	var navUnitFieldList = map[? "navUnitFieldList"];
	if (scr_isNumericAndExists(navUnitFieldList, ds_type_list)) global.schemaNavUnitFieldList = navUnitFieldList;
	
	
	var rowOfDisplayToken = ds_grid_value_y(global.tagInfoGrid, global.tagInfoGrid_colKey, 0, global.tagInfoGrid_colKey, ds_grid_height(global.tagInfoGrid), "option_display-token");
	var rowOfWordDelimiter = ds_grid_value_y(global.tagInfoGrid, global.tagInfoGrid_colKey, 0, global.tagInfoGrid_colKey, ds_grid_height(global.tagInfoGrid), "option_word-delimiter");
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
 