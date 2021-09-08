function scr_loadINI() {


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
		
		
			if(room == rm_openingScreen){

				global.rememberMe = ds_map_find_value(map, "rememberMe");
				
				if(ds_map_find_value(map, "importType") != undefined){
					global.importType = ds_map_find_value(map, "importType");
				}
			
				if(ds_map_find_value(map, "readHintHide") != undefined){
					global.readHintHide = ds_map_find_value(map, "readHintHide");
				}
			
				if(ds_map_find_value(map, "autosaveTimerFull") != undefined){
					global.autosaveTimerFull = ds_map_find_value(map, "autosaveTimerFull");
					global.autosaveTimer = global.autosaveTimerFull;
				}


				if (global.rememberMe) {
					obj_openingScreen.inputText = string(ds_map_find_value(map, "userName"));

					obj_openingScreen.cursorPos = string_length(obj_openingScreen.inputText) + 1;
				}

				global.previousRezDirectory = ds_map_find_value(map, "previousRezDirectory"); 

				global.previousImportDirectory = ds_map_find_value(map, "previousImportDirectory"); 
		

				global.previousSpecialFields = ds_map_find_value(map, "previousSpecialFields");
				global.previousLevelEstimates = ds_map_find_value(map, "previousLevelEstimates");
			
				global.fontSize = ds_map_find_value(map, "fontSize");

				
			}		
			else if(room  == rm_mainScreen){
			

				obj_control.gridSpaceVertical = ds_map_find_value(map, "lineHeight"); 
				obj_control.gridSpaceHorizontal = ds_map_find_value(map, "columnWidth");
				obj_control.proseSpaceHorizontal = ds_map_find_value(map, "proseWidth");
				if (!is_numeric(obj_control.proseSpaceHorizontal)) obj_control.proseSpaceHorizontal = 100;
				
				obj_control.gridSpaceRatio = (obj_control.gridSpaceVertical/obj_control.prevGridSpaceVertical);
			
				// Multiply each line's pixelY by the new ratio
				ds_grid_multiply_region(obj_control.lineGrid, obj_control.lineGrid_colPixelYOriginal, 0, obj_control.lineGrid_colPixelYOriginal, ds_grid_height(obj_control.lineGrid), obj_control.gridSpaceRatio);
			
				var searchGridPopulated = ds_grid_height(obj_control.searchGrid);
				var filterGridPopulated = ds_grid_height(obj_control.filterGrid);
			
				// If the search or filter grids are populated, then set their pixelY's as well
				if(searchGridPopulated) {
					ds_grid_multiply_region(obj_control.searchGrid, obj_control.lineGrid_colPixelYOriginal, 0, obj_control.lineGrid_colPixelYOriginal, ds_grid_height(obj_control.searchGrid), obj_control.gridSpaceRatio);
				}
				if(filterGridPopulated) {
					ds_grid_multiply_region(obj_control.filterGrid, obj_control.lineGrid_colPixelYOriginal, 0, obj_control.lineGrid_colPixelYOriginal, ds_grid_height(obj_control.filterGrid), obj_control.gridSpaceRatio);
				}
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

	ds_list_destroy(newInstList);







}
