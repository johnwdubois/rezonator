function scr_saveINI() {



	if (os_type == os_macosx) {
		var fileName = global.rezonatorDirString + "/~usersettings.ini";
	}
	else {
		var fileName = global.rezonatorDirString + "\\~usersettings.ini";
	}
	// Check if the name is valid, or if the user exited the window
	if (fileName == "" or fileName == "undefined") {
		show_message(scr_get_translation("save_error"));
		exit;
	}





	var rootList = ds_list_create();

	var map = ds_map_create();
	ds_list_add(rootList, map);
	ds_list_mark_as_map(rootList, ds_list_size(rootList) - 1);
	


	ds_map_add(map,"rememberMe",global.rememberMe);
	ds_map_add(map,"readHintHide",global.readHintHide)
	ds_map_add(map,"userName", global.userName);
	ds_map_add(map,"autosaveTimer", global.autosaveTimer);
	ds_map_add(map,"lineHeight", obj_control.gridSpaceVertical);
	ds_map_add(map,"fontSize", global.fontSize);
	ds_map_add(map,"columnWidth", obj_control.gridSpaceHorizontal);

	
	
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
	ds_map_add(map, "previousRezDirectory", global.previousRezDirectory);
	ds_map_add(map, "previousImportDirectory", global.previousImportDirectory);
	ds_map_add(map, "fileExtentionOrder", global.fileExtentionOrder);
		
	
	if (instance_exists(obj_gridViewer)) {
		var tempGridViewColXListMap = ds_map_create();
		ds_map_clear(tempGridViewColXListMap);
		ds_map_copy(tempGridViewColXListMap, obj_gridViewer.gridViewColXListMap);
		ds_map_add_map(map, "gridViewColXListMap", tempGridViewColXListMap);
	}


	var wrapper = ds_map_create();
	ds_map_add_list(wrapper, "ROOT", rootList);

	var jsonString = json_encode(wrapper);
	jsonString = scr_jsonBeautify(jsonString);





	scr_saveFileBuffer(working_directory + filename_name(fileName), fileName, jsonString);


	ds_map_destroy(wrapper);



}
