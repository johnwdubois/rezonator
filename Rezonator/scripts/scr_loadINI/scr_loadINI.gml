function scr_loadINI() {

	if (global.html5) exit;

	if (os_type == os_macosx) {
		var fileName = global.rezonatorDirString + "/~usersettings.ini";
	}
	else {
		var fileName = global.rezonatorDirString + "\\~usersettings.ini";
	}
	

	// Check if the name is valid, or if the user exited the window
	if (fileName == "" or fileName == "undefined") {
		show_message(scr_get_translation("error_ini-loading"));
		exit;
	}


	if (fileName == "" or not file_exists(fileName)) {
		exit;
	}



	var newInstList = ds_list_create();

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
		
		
			var map = ds_list_find_value(list, i);
		
		
			if (room == rm_openingScreen) {

				global.rememberMe = ds_map_find_value(map, "rememberMe");
				
				if (ds_map_find_value(map, "importType") != undefined) {
					global.importType = ds_map_find_value(map, "importType");
				}
			
				if (ds_map_find_value(map, "readHintHide") != undefined) {
					global.readHintHide = ds_map_find_value(map, "readHintHide");
				}
			
				if (ds_map_find_value(map, "autosaveTimerFull") != undefined) {
					global.autosaveTimerFull = ds_map_find_value(map, "autosaveTimerFull");
					global.autosaveTimer = global.autosaveTimerFull;
				}
				
				if (ds_map_find_value(map, "recentFilesMap") != undefined) {
					global.recentFilesMap = ds_map_find_value(map, "recentFilesMap");
				}
				if (ds_map_find_value(map, "recentFilesList") != undefined) {
					global.recentFilesList = ds_map_find_value(map, "recentFilesList");
				}
				if (ds_map_find_value(map, "usedImports") != undefined) {
					global.usedImports = ds_map_find_value(map, "usedImports");
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
	ds_list_destroy(newInstList);


}
