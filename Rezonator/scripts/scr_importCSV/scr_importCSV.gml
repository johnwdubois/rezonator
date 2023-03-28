function scr_importCSV(filename) {
	// Begin the import process of a single user specified CSV file
	if (!scr_isNumericAndExists(global.importGridColMap, ds_type_map)) {
		global.importGridColMap = ds_map_create();
	}

	//load csv into grid
	global.importCSVGrid = load_csv(filename);
	show_debug_message("scr_importCSV()... global.importCSVGridWidth: " + string(ds_grid_width(global.importCSVGrid)) + " global.importCSVGridHeight: " + string(ds_grid_height(global.importCSVGrid)));
	
	global.importFilename = filename;

	var blankCount = 0;
	//copy headers into list
	var importCSVGridWidth = ds_grid_width(global.importCSVGrid);
	for (var i = 0; i < importCSVGridWidth; i++) {
		var colHeader = ds_grid_get(global.importCSVGrid, i, 0);
		var strLen = string_length(colHeader);
		
		// check if header contains bad character
		var colHeaderNew = "";
		for (var j = 1; j <= strLen; j++) {
			var char = string_char_at(colHeader, j);
			if (ord(char) != 65279) colHeaderNew += char;
		}
		colHeader = colHeaderNew;
		strLen = string_length(colHeader);
		
		// if the first column ends with a quotation mark, this is likely an error from load_csv
		// so let's remove it
		if (i == 0 && strLen >= 1) {
			if (string_char_at(colHeader, strLen) == "\"") {
				colHeader = string_delete(colHeader, strLen, 1);
			}
		}
		
		if (strLen >= 1) {	
			ds_list_add(global.importGridColNameList, colHeader);
			ds_map_add(global.importGridColMap, colHeader, i);
			show_debug_message("scr_importCSV, colHeader: " + string(colHeader));
		}
		else {
			colHeader = "Col_" + string(blankCount)
			ds_list_add(global.importGridColNameList, colHeader);
			ds_map_add(global.importGridColMap, colHeader, i);
			blankCount++;
		}
	}

	show_debug_message("scr_importCSV()... global.importGridColNameList: " + scr_getStringOfList(global.importGridColNameList));
	show_debug_message("scr_importCSV()... global.importGridColNameList size: " + string(ds_list_size(global.importGridColNameList)));

	// if we get extra blank columns in the importCSVGrid, let's just get rid of them
	if (ds_grid_width(global.importCSVGrid) > ds_list_size(global.importGridColNameList)) {
		ds_grid_resize(global.importCSVGrid, ds_list_size(global.importGridColNameList), ds_grid_height(global.importCSVGrid));
	}




	//delete row of column headers
	scr_gridDeleteRow(global.importCSVGrid, 0);


	var importCSVGridHeight = ds_grid_height(global.importCSVGrid);

	//prepare import grid for copy
	ds_grid_resize(global.importGrid, importCSVGridWidth, importCSVGridHeight);

	//copy over to import grid
	ds_grid_copy(global.importGrid,global.importCSVGrid);

	global.importGridWidth = ds_grid_width(global.importGrid);
	global.importCSVGridWidth = ds_grid_width(global.importCSVGrid);

	//allows user to not need unit level data (not neccessary)
	global.importType = IMPORTTYPE_WORD;

	global.tabDelimitedText = true;

	show_debug_message("scr_importCSV() Going to import screen...");


	room_goto(rm_importScreen);



}
