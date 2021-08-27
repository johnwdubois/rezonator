function scr_importTXTExceptions() {
	var newRow = false;
	var blankRow = true;


	var firstClusterTagList = ds_list_create();
	var firstCluster = true;
	var lineInCluster = 0;

	if(!global.tabDeliniatedText){
		ds_grid_clear(global.importGrid, 0);
		global.importGridWidth = 0;
		ds_grid_resize(global.importGrid, global.importGridWidth, 0);
		ds_map_clear(global.importGridColMap);
		ds_list_clear(global.importGridColNameList);


		var importTXTLineGridHeight = ds_grid_height(global.importTXTLineGrid);
		for (var i = 0; i < importTXTLineGridHeight; i++) {
	
			if (ds_grid_get(global.importTXTLineGrid, global.importTXTLineGrid_colException, i)) {
				continue;
			}
	
			var lineInFile = ds_grid_get(global.importTXTLineGrid, global.importTXTLineGrid_colLine, i);
			if (scr_isStrOnlyWhitespace(lineInFile)) {
				blankRow = true;
				lineInCluster = 0;
				if (firstCluster) {
					firstCluster = false;
				}
				continue;
			}
			else {
				if (blankRow) {
					newRow = true;
					blankRow = false;
				}
				lineInCluster++;
			}
	
	
	
			if (string_char_at(lineInFile, 1) != "\\") {
		
				if (!firstCluster and lineInCluster - 1 < ds_list_size(firstClusterTagList)) {
					lineInFile = ds_list_find_value(firstClusterTagList, lineInCluster - 1) + " " + lineInFile;
				}
				else {
					continue;
				}
			}
			if (string_count(" ", lineInFile) < 1) {
				continue;
			}
			if (newRow) {
				ds_grid_resize(global.importGrid, global.importGridWidth, ds_grid_height(global.importGrid) + 1);
				newRow = false;
			}
	
	
			if (string_char_at(lineInFile, 1) == "\\") {
				var colNameLength = string_pos(" ", lineInFile);
				var colName = string_copy(lineInFile, 1, colNameLength - 1);
				var colVal = string_copy(lineInFile, colNameLength + 1, string_length(lineInFile) - colNameLength);
	
				if (firstCluster) {
					ds_list_add(firstClusterTagList, colName);
				}
	

				var col = ds_map_find_value(global.importGridColMap, colName);
				if (is_undefined(col)) {
					global.importGridWidth++;
					ds_grid_resize(global.importGrid, global.importGridWidth, ds_grid_height(global.importGrid));
					ds_list_add(global.importGridColNameList, colName);
					col = global.importGridWidth - 1;
					ds_map_add(global.importGridColMap, colName, col);
				}
				var row = ds_grid_height(global.importGrid) - 1;
				ds_grid_set(global.importGrid, col, row, colVal);
			}
		}

	}

	if (ds_grid_width(global.importGrid) == 0) {
		show_message(scr_get_translation("msg_no_tags_found"));
		show_debug_message("Going to openingScreen, scr_importTXTExceptions");
		room_goto(rm_openingScreen);
	}


}
