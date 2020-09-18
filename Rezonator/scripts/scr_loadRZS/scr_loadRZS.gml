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


	if (fileName == "" or not file_exists(fileName)) {
		exit;
	}



	var newInstList = ds_list_create();

	if (file_exists(fileName)) {
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
	
		//show_message("global.tokenImportGridWidth: " + string(ds_grid_width(global.tokenImportGrid)) + ", global.tokenImportGridHeight: " + string(ds_grid_height(global.tokenImportGrid)));
	
		var listSize = ds_list_size(list);
		for (var i = 0; i < listSize; i++) {
		
		
			var map = ds_list_find_value(list, i);
		

			global.previousSpecialFields = ds_map_find_value(map, "previousSpecialFields");
			global.previousLevelEstimates = ds_map_find_value(map, "previousLevelEstimates");
			if (global.tokenImportColNameList != undefined) {
				global.tokenImportGridWidth = ds_list_size(global.tokenImportColNameList);
			}
			if (global.unitImportColNameList != undefined) {
				global.unitImportGridWidth = ds_list_size(global.unitImportColNameList);
			}
				
				
				
				
					
		}
	}

	ds_list_destroy(newInstList);

	scr_updateSchLists();


}
