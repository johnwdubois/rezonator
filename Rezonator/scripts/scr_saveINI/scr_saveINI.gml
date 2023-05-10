function scr_saveINI() {
	
	try {
	
		// get filepath for ini
		var fileName = "";
		if (os_type == os_windows) {
			fileName = global.rezonatorDirString + "\\~usersettings.ini";
		}
		else {
			fileName = global.rezonatorDirString + "/~usersettings.ini";
		}
	
		// Check if the name is valid, or if the user exited the window
		if (fileName == "" or fileName == "undefined") {
			show_message(scr_get_translation("save_error"));
			exit;
		}
	
		// check if we can get map from ini
		var map = -1;
		if (file_exists(fileName)) {
			var wrapper = scr_loadJSONBuffer(fileName);
			var list = wrapper[? "ROOT"];
			if (scr_isNumericAndExists(list, ds_type_list)) {
				map = list[| 0];
			}
		}
	
		// create new rootList, add map to it
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
		map[? "aiChatAPIKey"] = global.aiChatAPIKey;
	
		if (room == rm_mainScreen) {
			map[? "lineHeight"] = obj_control.gridSpaceVertical;
			map[? "columnWidth"] = obj_control.gridSpaceHorizontal;
			map[? "proseWidth"] = obj_control.proseSpaceHorizontal;
			map[? "showNav"] = obj_panelPane.showNav;
			map[? "showNavLeft"] = obj_panelPane.showNavLeft;
			map[? "showNavRight"] = obj_panelPane.showNavRight;
		}
	
	
	
		scr_iniOverwriteList(map, "previousLevelEstimates", global.previousLevelEstimates);
		scr_iniOverwriteList(map, "previousSpecialFields", global.previousSpecialFields);
		scr_iniOverwriteList(map, "recentFilesList", global.recentFilesList);
		scr_iniOverwriteList(map, "usedImports", global.usedImports);
	

	
		map[? "previousRezDirectory"] = global.previousRezDirectory;
		map[? "previousImportDirectory"] = global.previousImportDirectory;
		map[? "previousSaveDirectory"] = global.previousSaveDirectory;
		map[? "previousAudioDirectory"] = global.previousAudioDirectory;
		



	
	

		recentFilesMapCopy = json_decode(json_encode(global.recentFilesMap));
	
		if (ds_map_exists(map,"recentFilesMap")) {
			ds_map_replace_map(map, "recentFilesMap", recentFilesMapCopy);
		}
		else {
			ds_map_add_map(map, "recentFilesMap", recentFilesMapCopy);
		}

		var wrapper = ds_map_create();
		ds_map_add_list(wrapper, "ROOT", rootList);


		var jsonString = json_encode(wrapper, true);
		scr_saveFileBuffer(fileName, jsonString);

		show_debug_message(string(working_directory) + string(filename_name(fileName)));
		ds_map_destroy(wrapper);
	
	}
	catch (e) {
		show_debug_message("scr_saveINI, Error saving ini: " + string(e.message));
	}

}