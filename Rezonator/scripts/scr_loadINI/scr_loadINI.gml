function scr_loadINI() {

	if (global.html5) exit;
	
	// get filepath for ini
	var fileName = "";
	if (os_type == os_macosx) {
		fileName = global.rezonatorDirString + "\\~usersettings.ini";
	}
	else {
		fileName = global.rezonatorDirString + "/~usersettings.ini";
	}
	
	// Check if the name is valid, or if the user exited the window
	if (fileName == "" || fileName == "undefined" || !file_exists(fileName)) {
		show_message(scr_get_translation("error_ini-loading"));
		exit;
	}
	
	

	if (file_exists(fileName)) {
		var wrapper = scr_loadJSONBuffer(fileName);
	
		if (not ds_exists(wrapper, ds_type_map)) {
			show_message(scr_get_translation("msg_error_loading") + fileName + "\n" + scr_get_translation("error_user-outdated"));
			exit;
		}
	
		var list = ds_map_find_value(wrapper, "ROOT");
	
		if (is_undefined(list)) {
			show_debug_message("Error loading " + fileName);
			//game_restart();
			exit;
		}
	
		
		var listSize = ds_list_size(list);
		for (var i = 0; i < listSize; i++) {
		
		
			var map = list[| i];
		
		
			if (room == rm_openingScreen) {

				global.rememberMe = ds_map_find_value(map, "rememberMe");
				
				var _importType = map[? "importType"];
				if (is_string(_importType)) global.importType = _importType;
				
				var _aiChatAPIKey = map[? "aiChatAPIKey"];
				if (is_string(_aiChatAPIKey)) global.aiChatAPIKey = _aiChatAPIKey;
				
				var _readHintHide = map[? "readHintHide"];
				if (is_numeric(_readHintHide)) global.readHintHide = _readHintHide;
				
				var _autosaveTimerFull = map[? "autosaveTimerFull"];
				if (is_numeric(_autosaveTimerFull)) {
					global.autosaveTimerFull = _autosaveTimerFull;
					global.autosaveTimer = global.autosaveTimerFull;
				}
				
				var _recentFilesMap = map[? "recentFilesMap"];
				if (scr_isNumericAndExists(_recentFilesMap, ds_type_map)) {
					global.recentFilesMap = _recentFilesMap;
				}
				
				var _recentFilesList = map[? "recentFilesList"];
				if (scr_isNumericAndExists(_recentFilesList, ds_type_list)) {
					global.recentFilesList = _recentFilesList;
				}
				
				var _usedImports = map[? "usedImports"];
				if (scr_isNumericAndExists(_usedImports, ds_type_list)) {
					global.usedImports = _usedImports;
				}
				


				if (global.rememberMe) {
					global.userName = string(ds_map_find_value(map, "userName"));
					if (!is_string(global.userName) || global.userName == "Unknown") global.userName = "";
					show_debug_message("username from INI: " + string(global.userName));
				}

				global.previousRezDirectory = ds_map_find_value(map, "previousRezDirectory"); 

				global.previousImportDirectory = ds_map_find_value(map, "previousImportDirectory");
				global.previousSaveDirectory = ds_map_find_value(map, "previousSaveDirectory"); 
				global.previousAudioDirectory = ds_map_find_value(map, "previousAudioDirectory"); 
		

				global.previousSpecialFields = ds_map_find_value(map, "previousSpecialFields");
				global.previousLevelEstimates = ds_map_find_value(map, "previousLevelEstimates");
			
				global.fontSize = ds_map_find_value(map, "fontSize");
				
			}		
			else if (room  == rm_mainScreen) {
			

				obj_control.gridSpaceVertical = ds_map_find_value(map, "lineHeight"); 
				obj_control.gridSpaceHorizontal = ds_map_find_value(map, "columnWidth");
				obj_control.proseSpaceHorizontal = ds_map_find_value(map, "proseWidth");
				if (!is_numeric(obj_control.proseSpaceHorizontal)) obj_control.proseSpaceHorizontal = 100;
				
				obj_control.gridSpaceRatio = (obj_control.gridSpaceVertical/obj_control.prevGridSpaceVertical);
			
				// reset the ratio
				obj_control.prevGridSpaceVertical = obj_control.gridSpaceVertical;
	
				//obj_control.prevGridSpaceVertical = obj_control.gridSpaceVertical ;
			

				global.fontSize = ds_map_find_value(map, "fontSize"); 

			
				obj_panelPane.showNav = map[? "showNav"];
				obj_panelPane.showNavLeft = map[? "showNavLeft"];
				obj_panelPane.showNavRight = map[? "showNavRight"];
				if (is_undefined(obj_panelPane.showNav)) obj_panelPane.showNav = true;
				if (is_undefined(obj_panelPane.showNavLeft)) obj_panelPane.showNavLeft = true;
				if (is_undefined(obj_panelPane.showNavRight)) obj_panelPane.showNavRight = true;

			}
		}
	}

	global.fontSize = clamp(global.fontSize, 0, global.fontSizeMax);
	show_debug_message("scr_loadINI, fontSize: " + string(global.fontSize));

}
