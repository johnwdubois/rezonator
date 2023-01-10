function scr_saveINI() {
	
	var map = -1;
	var fileName = "";
	
	if (os_type == os_macosx) {
		fileName = global.rezonatorDirString + "/~usersettings.ini";
	}
	else {
		fileName = global.rezonatorDirString + "\\~usersettings.ini";
	}
	
	// Check if the name is valid, or if the user exited the window
	if (fileName == "" or fileName == "undefined") {
		show_message(scr_get_translation("save_error"));
		exit;
	}
	
	if (file_exists(fileName)) {
		var wrapper = scr_loadJSONBuffer(fileName);
		var list = ds_map_find_value(wrapper, "ROOT");
		if (scr_isNumericAndExists(list, ds_type_list)) {
			map = list[|0];
		}
	}


	var rootList = ds_list_create();

	if (!scr_isNumericAndExists(map,ds_type_map)) map = ds_map_create();
	ds_list_add(rootList, map);
	ds_list_mark_as_map(rootList, ds_list_size(rootList) - 1);

	
	
	// create maps to hold copies of other maps we want in the REZ file
	var recentFilesMapCopy = ds_map_create();

	map[? "rememberMe"] = global.rememberMe;
	map[? "importType"] = global.importType;
	map[? "readHintHide"] = global.readHintHide;
	map[? "userName"] = global.userName;
	map[? "autosaveTimerFull"] = global.autosaveTimerFull;
	map[? "fontSize"] = global.fontSize;
	
	if (room == rm_mainScreen) {
		map[? "lineHeight"] = obj_control.gridSpaceVertical;
		map[? "columnWidth"] = obj_control.gridSpaceHorizontal;
		map[? "proseWidth"] = obj_control.proseSpaceHorizontal;
		map[? "showNav"] = obj_panelPane.showNav;
		map[? "showNavLeft"] = obj_panelPane.showNavLeft;
		map[? "showNavRight"] = obj_panelPane.showNavRight;
	}
	
	
	var tempList = ds_list_create();
	if (global.previousLevelEstimates != undefined) {
		ds_list_copy(tempList, global.previousLevelEstimates);
	}
	if (ds_map_exists(map,"previousLevelEstimates")) {
		ds_map_replace_list(map, "previousLevelEstimates", tempList);
	}
	else {
		ds_map_add_list(map, "previousLevelEstimates", tempList);
	}
	
	var tempList2 = ds_list_create();
	if (global.previousSpecialFields  != undefined) {
		ds_list_copy(tempList2, global.previousSpecialFields);
	}
	if (ds_map_exists(map,"previousSpecialFields")) {
		ds_map_replace_list(map, "previousSpecialFields", tempList2);
	}
	else {
		ds_map_add_list(map, "previousSpecialFields", tempList2);
	}

	
	map[? "previousRezDirectory"] = global.previousRezDirectory;
	map[? "previousImportDirectory"] = global.previousImportDirectory;
	map[? "previousSaveDirectory"] = global.previousSaveDirectory;
	map[? "previousAudioDirectory"] = global.previousAudioDirectory;
		

	var tempList3 = ds_list_create();
	if (global.recentFilesList != undefined) {
		ds_list_copy(tempList3, global.recentFilesList);
	}
	if (ds_map_exists(map,"recentFilesList")) {
		ds_map_replace_list(map, "recentFilesList", tempList3);
	}
	else {
		ds_map_add_list(map, "recentFilesList", tempList3);
	}

	
	var tempList4 = ds_list_create();
	if (global.usedImports != undefined) {
		ds_list_copy(tempList4, global.usedImports);
	}
	ds_map_add_list(map, "usedImports", tempList4);
	
	if (ds_map_exists(map,"usedImports")) {
		ds_map_replace_list(map, "usedImports", tempList4);
	}
	else {
		ds_map_add_list(map, "usedImports", tempList4);
	}
	

	recentFilesMapCopy = json_decode(json_encode(global.recentFilesMap));
	
	if (ds_map_exists(map,"recentFilesMap")) {
		ds_map_replace_map(map, "recentFilesMap", recentFilesMapCopy);
	}
	else {
		ds_map_add_map(map, "recentFilesMap", recentFilesMapCopy);
	}

	var wrapper = ds_map_create();
	ds_map_add_list(wrapper, "ROOT", rootList);

	var jsonString = json_encode(wrapper);
	jsonString = scr_jsonBeautify(jsonString);





	scr_saveFileBuffer(working_directory + filename_name(fileName), fileName, jsonString);

	show_debug_message(string(working_directory) + string(filename_name(fileName)));
	ds_map_destroy(wrapper);



}
