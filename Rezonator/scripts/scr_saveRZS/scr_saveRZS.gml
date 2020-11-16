function scr_saveRZS() {
	/*
		scr_saveRzs();
	
		Last Updated: 2020-08-19
	
		Called from: obj_fileLoader
	
		Purpose: Save all user defined feilds durring import for easy reuse
	
		Mechanism: Organize the data into maps, then transfer those maps as JSON strings into the user specified file location
	
		Author: Brady Moore
	*/


	var fileName = get_save_filename_ext("Schema file|*.rzs", string_lettersdigits("Schema"), global.rezonatorSchemaDirString, scr_get_translation("msg_save_schema_file"));
	// Check if the name is valid, or if the user exited the window
	if (fileName == "" or fileName == "undefined") {
		show_message(scr_get_translation("save_error"));
		exit;
	}





	var rootList = ds_list_create();

	var map = ds_map_create();
	ds_list_add(rootList, map);
	ds_list_mark_as_map(rootList, ds_list_size(rootList) - 1);
	
	
	
	
	// loop through the tagInfoGrid, and make every field have a node in a map
	var tagInfoGridHeight = ds_grid_height(global.tagInfoGrid);
	for (var i = 0; i < tagInfoGridHeight; i++) {
		
		var currentField = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, i);
		var currentLevel = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colLevel, i);
		var currentSpecialField = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colSpecialFields, i);
		
		// for every field, make a map that contains the level and special field
		var currentFieldMap = ds_map_create();
		ds_map_add(currentFieldMap, "level", currentLevel);
		ds_map_add(currentFieldMap, "specialField", currentSpecialField);
		
		// add currentFieldMap to the overall Map (with the key being the name of the field)
		ds_map_add_map(map, currentField, currentFieldMap);
	}
	
	
	
	
	/*
	var tempList = ds_list_create();
	if (global.previousLevelEstimates != undefined) {
		ds_list_copy(tempList, global.previousLevelEstimates);
	}
	ds_map_add_list(map, "previousLevelEstimates", tempList);
		


	var tempList2 = ds_list_create();
	if (global.previousSpecialFields  != undefined) {
		ds_list_copy(tempList2, global.previousSpecialFields);
	}
	ds_map_add_list(map, "previousSpecialFields", tempList2);
	*/
	
	
	
	
	
	
	
	
	
	
		

	var wrapper = ds_map_create();
	ds_map_add_list(wrapper, "ROOT", rootList);

	var jsonString = json_encode(wrapper);
	jsonString = scr_jsonBeautify(jsonString);





	scr_saveFileBuffer(working_directory + filename_name(fileName), fileName, jsonString);


	ds_map_destroy(wrapper);



}
