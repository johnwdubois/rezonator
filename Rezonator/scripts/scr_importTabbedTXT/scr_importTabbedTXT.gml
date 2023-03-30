function scr_importTabbedTXT(delimiter) {
	
	show_debug_message("scr_importTabbedTXT, delimiter: '{0}'", delimiter);


	global.importGridWidth = 0;
	var importTXTLineGridHeight = ds_grid_height(global.importTXTLineGrid);
	for (var i = 0; i < importTXTLineGridHeight; i++) {
	
		// get current line from importTXTLineGrid and split it by tabs/commas
		var lineStr = global.importTXTLineGrid[# global.importTXTLineGrid_colLine, i];
		var colList = scr_splitString(lineStr, delimiter);
		var colListSize = ds_list_size(colList);
		
		// importGrid should be as wide as how many splits we found
		global.importGridWidth = max(global.importGridWidth, ds_list_size(colList));
		
		// grow importGrid by one row
		ds_grid_resize(global.importGrid, global.importGridWidth, ds_grid_height(global.importGrid) + 1);
		
		// put each split in importGrid
		var colListSize = ds_list_size(colList);
		for (var j = 0; j < colListSize; j++) {
			var fullColString = string(colList[| j]);
			fullColString = scr_inputSpaces(fullColString);
			global.importGrid[# j, ds_grid_height(global.importGrid) - 1] = fullColString;
		}
	}
	

	
	for (i = 0; i < global.importGridWidth; i++) {
		var colName = "";
		if (global.importType == IMPORTTYPE_AICHAT && i <= 1) {
			// name participant & text columns accordingly
			if (i == 0) colName = "Participant";
			else if (i == 1) colName = "Text";
		}
		else {
			// give every column in importGrid a name: Col_1, Col_2, etc
			colName = "Col_" + string(i + 1);
		}
		ds_list_add(global.importGridColNameList, colName);
		ds_map_add(global.importGridColMap, colName, i);
	}



	global.tabDelimitedText = true;

}
