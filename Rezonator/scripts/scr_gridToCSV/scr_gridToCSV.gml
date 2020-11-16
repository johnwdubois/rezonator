function scr_gridToCSV(grid, fileName) {
	// Write grid info into a CSV table format

	var file = file_text_open_write(fileName);
	var gridHeight = ds_grid_height(grid);
	var gridWidth = ds_grid_width(grid);

	for (var i = -1; i < gridHeight; i++) {	
	
		var lineStr = "";
		for (var j = 0; j < gridWidth; j++) {
		
			var itemStr = "";
			if (i == -1) {
				// get column name for CSV header
				itemStr = scr_getColNameString(grid, j);
			}
			else if (i >= 0) {
				// get cell string
				itemStr = scr_drawGridViewerGetItemString(grid, j, i);
			}
		
			if (scr_isItemAList(grid, j, i) or string_count(",", itemStr) > 0) {
				itemStr = "\"" + itemStr + "\"";
			}
		
			lineStr += itemStr;
		
			if (i >= -1 and j < ds_grid_width(grid) - 1) {
				lineStr += ",";
			}
		}
		
		// remove any line breaks from line
		lineStr = string_replace_all(lineStr, "\r", "");
		lineStr = string_replace_all(lineStr, "\n", "");
		file_text_write_string(file, lineStr);
		file_text_writeln(file);
	}

	file_text_close(file);


}
