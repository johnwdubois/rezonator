function scr_importTXT(argument0) {
	var filename = argument0;
	global.importFilename = filename;

	scr_getImportFileRipList(filename);

	var fileOpenRead = file_text_open_read(filename);

	ds_grid_clear(global.importTXTLineGrid, 0);
	ds_grid_resize(global.importTXTLineGrid, global.importTXTLineGridWidth, 0);



	var newRow = false;
	var blankRow = true;


	var firstClusterTagList = ds_list_create();
	var firstCluster = true;
	var firstClusterEncountered = false;
	var lineInCluster = 0;


	while (not file_text_eof(fileOpenRead)) {
	
		var lineInFile = file_text_readln(fileOpenRead);
		
		// remove line breaks from line
		lineInFile = string_replace_all(lineInFile, "\n", "");
		lineInFile = string_replace_all(lineInFile, "\r", "");
	
		ds_grid_resize(global.importTXTLineGrid, global.importTXTLineGridWidth, ds_grid_height(global.importTXTLineGrid) + 1);
		ds_grid_set(global.importTXTLineGrid, global.importTXTLineGrid_colLine, ds_grid_height(global.importTXTLineGrid) - 1, lineInFile);
		ds_grid_set(global.importTXTLineGrid, global.importTXTLineGrid_colException, ds_grid_height(global.importTXTLineGrid) - 1, false);
		
		// if this is not an IGT import, we will run our old import method
		if (global.importType != global.importType_IGT) {
	
			if (!firstClusterEncountered) {
				if (string_char_at(lineInFile, 1) == "\\") {
					firstClusterEncountered = true;
				}
				else {
					continue;
				}
			}
	
			if (string_length(string_lettersdigits(lineInFile)) < 1) {
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
	
	
	
	// automatically mark lines as exceptions in importTXTGrid
	scr_markAutoExceptions();
	
	
	if (global.importType == global.importType_IGT) {
		// IGT import
		scr_importIGT();
	}
	else if (global.importType == global.importType_CoNLLU) {
		// CoNLL-U import
		scr_importConlluTXT(filename);
	}
	else if (global.importType == global.importType_TabDelimited) {
		// tab delimited import
		scr_importTabbedTXT(filename);
	}
	else if (global.importType == global.importType_PlainText) {	
		// plain text import
		// temporarily making this use tab-delimited import
		//scr_importPlainTXT(filename);
		scr_importTabbedTXT(filename);
	}

	file_text_close(fileOpenRead);

	// if something went wrong in the import process, we exit back to the openingScreen
	// otherwise we continue to the importScreen
	if (global.exitOut) {
		room_goto(rm_openingScreen);
	}
	else {
		room_goto(rm_importScreen);
	}


}
