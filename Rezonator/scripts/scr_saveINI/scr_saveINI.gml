function scr_saveINI() {
	var map = -1;


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


	if(file_exists(fileName)){
		var wrapper = scr_loadJSONBuffer(fileName);
		var list = ds_map_find_value(wrapper, "ROOT");
		if(scr_isNumericAndExists(list, ds_type_list)){
			map = list[|0];
		}
	}


	var rootList = ds_list_create();

	if(!scr_isNumericAndExists(map,ds_type_map)) map = ds_map_create();
	ds_list_add(rootList, map);
	ds_list_mark_as_map(rootList, ds_list_size(rootList) - 1);

	
	
	// create maps to hold copies of other maps we want in the REZ file
	var recentFilesMapCopy = ds_map_create();

	scr_setMap(map,"rememberMe",global.rememberMe)
	
	scr_setMap(map,"importType",global.importType);
	scr_setMap(map,"readHintHide",global.readHintHide)
	scr_setMap(map,"userName", global.userName);
	scr_setMap(map,"autosaveTimerFull", global.autosaveTimerFull);
	scr_setMap(map,"fontSize", global.fontSize);
	if(room == rm_mainScreen){
		scr_setMap(map,"lineHeight", obj_control.gridSpaceVertical);
		scr_setMap(map,"columnWidth", obj_control.gridSpaceHorizontal);
		scr_setMap(map,"proseWidth", obj_control.proseSpaceHorizontal);
		scr_setMap(map,"showNav", obj_panelPane.showNav);
		scr_setMap(map,"showNavLeft", obj_panelPane.showNavLeft);
		scr_setMap(map,"showNavRight", obj_panelPane.showNavRight);
	}
	
	

	var tempList = ds_list_create();
	if (global.previousLevelEstimates != undefined) {
		ds_list_copy(tempList, global.previousLevelEstimates);
	}
	if(ds_map_exists(map,"previousLevelEstimates")){
		ds_map_replace_list(map, "previousLevelEstimates", tempList);
	}
	else{
		ds_map_add_list(map, "previousLevelEstimates", tempList);
	}
	
	var tempList2 = ds_list_create();
	if (global.previousSpecialFields  != undefined) {
		ds_list_copy(tempList2, global.previousSpecialFields);
	}
	if(ds_map_exists(map,"previousSpecialFields")){
		ds_map_replace_list(map, "previousSpecialFields", tempList2);
	}
	else{
		ds_map_add_list(map, "previousSpecialFields", tempList2);
	}

	
	scr_setMap(map, "previousRezDirectory", global.previousRezDirectory);
	scr_setMap(map, "previousImportDirectory", global.previousImportDirectory);
	scr_setMap(map, "previousSaveDirectory", global.previousSaveDirectory);
		

	var tempList3 = ds_list_create();
	if (global.recentFilesList != undefined) {
		ds_list_copy(tempList3, global.recentFilesList);
	}
	if(ds_map_exists(map,"recentFilesList")){
		ds_map_replace_list(map, "recentFilesList", tempList3);
	}
	else{
		ds_map_add_list(map, "recentFilesList", tempList3);
	}

	
	var tempList4 = ds_list_create();
	if (global.usedImports != undefined) {
		ds_list_copy(tempList4, global.usedImports);
	}
	ds_map_add_list(map, "usedImports", tempList4);
	
	if(ds_map_exists(map,"usedImports")){
		ds_map_replace_list(map, "usedImports", tempList4);
	}
	else{
		ds_map_add_list(map, "usedImports", tempList4);
	}
	

	recentFilesMapCopy = json_decode(json_encode(global.recentFilesMap));
	
	if(ds_map_exists(map,"recentFilesMap")){
		ds_map_replace_map(map, "recentFilesMap", recentFilesMapCopy);
	}
	else{
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
