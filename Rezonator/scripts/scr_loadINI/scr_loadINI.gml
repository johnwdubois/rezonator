function scr_loadINI() {


	if (os_type == os_macosx) {
		var fileName = global.rezonatorDirString + "/~usersettings.ini";
	}
	else {
		var fileName = global.rezonatorDirString + "\\~usersettings.ini";
	}
	
	//show_message(fileName);

	// Check if the name is valid, or if the user exited the window
	if (fileName == "" or fileName == "undefined") {
		show_message(scr_get_translation("error_ini-loading"));
		exit;
	}


	if (fileName == "" or not file_exists(fileName)) {
		//show_message("leaving cuz file not found");
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
	
		//show_message("global.tokenImportGridWidth: " + string(ds_grid_width(global.tokenImportGrid)) + ", global.tokenImportGridHeight: " + string(ds_grid_height(global.tokenImportGrid)));
	
		var listSize = ds_list_size(list);
		for (var i = 0; i < listSize; i++) {
		
		
			var map = ds_list_find_value(list, i);
		
		
			if(room == rm_openingScreen){

				global.rememberMe = ds_map_find_value(map, "rememberMe");
			
				if(ds_map_find_value(map, "readHintHide") != undefined){
					global.readHintHide = ds_map_find_value(map, "readHintHide");
				}
			
				if(ds_map_find_value(map, "autosaveTimer") != undefined){
					global.autosaveTimer = ds_map_find_value(map, "autosaveTimer");
				}


				if (global.rememberMe) {
					obj_openingScreen.inputText = string(ds_map_find_value(map, "userName"));

					obj_openingScreen.cursorPos = string_length(obj_openingScreen.inputText) + 1;
				}

				global.previousRezDirectory = ds_map_find_value(map, "previousRezDirectory"); 

				global.previousImportDirectory = ds_map_find_value(map, "previousImportDirectory"); 
		
				if(ds_map_find_value(map, "fileExtentionOrder") != undefined){
					global.fileExtentionOrder = ds_map_find_value(map, "fileExtentionOrder"); 
				}

				global.previousSpecialFields = ds_map_find_value(map, "previousSpecialFields");
				global.previousLevelEstimates = ds_map_find_value(map, "previousLevelEstimates");
			
				global.fontSize = ds_map_find_value(map, "fontSize");

				
			}		
			else if(room  == rm_mainScreen){
			

				obj_control.gridSpaceVertical = ds_map_find_value(map, "lineHeight"); 
				obj_control.gridSpaceHorizontal = ds_map_find_value(map, "columnWidth"); 
				
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

			
			
				if (instance_exists(obj_gridViewer)) {
					if (is_numeric(obj_gridViewer.gridViewColXListMap)) {
						if (ds_exists(obj_gridViewer.gridViewColXListMap, ds_type_map)) {
							var tempMap = ds_map_find_value(map, "gridViewColXListMap");
							
							
							if (is_numeric(tempMap)) {
								if (ds_exists(tempMap, ds_type_map)) {	
									if (ds_map_size(tempMap) == ds_map_size(obj_gridViewer.gridViewColXListMap)) {
										//show_message("map sizes equal");
										ds_map_clear(obj_gridViewer.gridViewColXListMap);
										ds_map_copy(obj_gridViewer.gridViewColXListMap, tempMap);
									}
								}
							}
							//show_message("scr_loadINI()... Unit: " + scr_getStringOfList(ds_map_find_value(obj_gridViewer.gridViewColXListMap, "Unit")));
						}
					}
				
				}

		

			}
				
				
					
		}
	}

	ds_list_destroy(newInstList);







}
