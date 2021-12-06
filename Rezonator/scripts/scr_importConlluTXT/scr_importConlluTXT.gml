function scr_importConlluTXT(filename) {
	global.importFilename = filename;

	var tokensAdded = false;
	var firstClusterTagList = ds_list_create();
	var firstCluster = true;
	var firstClusterEncountered = false;
	var lineInCluster = 0;
	var currentCluster = 0;

	var newRow = false;
	var blankRow = true;
	var row = 0;

	var CoNLLUColNameList = ds_list_create();
	ds_list_add(CoNLLUColNameList, " ID", " FORM", " LEMMA", " UPOS", " XPOS", " FEATS", " HEAD", " DEPREL", " DEPS", " MISC");


	var tokenColListCreated = false;
	var lineInFile = "";

	global.importType = global.importType_CoNLLU;

	var importSourceRow = -1;
	var rowCounter = 0;
	var nextItterator = 0;

	var importTXTLineGridHeight = ds_grid_height(global.importTXTLineGrid);
	var widthOfImportGrid = 0;
	while (importSourceRow < importTXTLineGridHeight) {
		
		importSourceRow++;
		if (importSourceRow >= importTXTLineGridHeight) continue;
		var lineInFile = global.importTXTLineGrid[# global.importTXTLineGrid_colLine, importSourceRow];
	
	
		// Here we check if we are encountering the first cluster
		if (!firstClusterEncountered) {
			if (string_char_at(lineInFile, 1) == "#") {
				firstClusterEncountered = true;
			}
			else {
				continue;
			}
		}
	
	
		// Check for blank rows to iterate clusters
		if (scr_isStrOnlyWhitespace(lineInFile)) {
			blankRow = true;
			lineInCluster = 0;
			currentCluster++;
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
		
		var tokenLevel = (string_char_at(lineInFile, 1) != "#");
		var unitLevel = !tokenLevel;
		
		show_debug_message("START lineInFile: " + string(lineInFile) + ", tokenLevel: " + string(tokenLevel));
		
	
		// Check for Token level data
		if (tokenLevel) {
			var firstClusterTagListSize = ds_list_size(firstClusterTagList);
		

				// Split the tokens into their individual columns
				var listOfColumns = ds_list_create();
				listOfColumns = scr_splitString(lineInFile,chr(9));
				show_debug_message("listOfColumns: " + scr_getStringOfList(listOfColumns));
				var listOfColumnsSize = ds_list_size(listOfColumns);
				/*
				// Take out any spaces or blank tokens
				for(var i = 0; i <= listOfColumnsSize; i++){
					if(ds_list_find_value(listOfColumns,i) == "" or ds_list_find_value(listOfColumns,i) == " "){
						ds_list_delete(listOfColumns,i);
						i -= 1;
					}
				}
				*/
				// Increase the width of the import grid to accomodate new columns
				if(widthOfImportGrid <= ds_list_size(listOfColumns)){
					var i = widthOfImportGrid;
					var indexOfColNameList = 0;
				
					if(!tokensAdded){
						nextItterator = widthOfImportGrid;
						widthOfImportGrid += ds_list_size(listOfColumns);
						global.importGridWidth = widthOfImportGrid;
						tokensAdded =true;
					}

					while( i < global.importGridWidth){

						if (indexOfColNameList >= ds_list_size(CoNLLUColNameList)) {
							var colName = " Col " + string(i);
						}
						else {
							var colName = string(ds_list_find_value(CoNLLUColNameList, indexOfColNameList));
						}
					
						var col = ds_map_find_value(global.importGridColMap, colName);
						
						if (is_undefined(col)) {
							ds_list_add(global.importGridColNameList, colName);
							ds_map_add(global.importGridColMap, colName, i);
						}
						i++;
						indexOfColNameList++;
					}	
					

					ds_grid_resize(global.importGrid, widthOfImportGrid, ds_grid_height(global.importGrid));
				}
			
				ds_grid_resize(global.importGrid, global.importGridWidth, ds_grid_height(global.importGrid)+1);
				rowCounter++;
			
				// place tokens into the import grid
				var listOfColumnsSize = ds_list_size(listOfColumns);
				for(var i = nextItterator; i < nextItterator+listOfColumnsSize; i++){
		
					var fullColString = string(ds_list_find_value(listOfColumns,i-nextItterator));
					// if the piece has more then one token, make it into a list
					var colStringList = ds_list_create();
					colStringList = scr_splitString(fullColString, " ");
			
					if(ds_list_size(colStringList) > 1){
						ds_grid_set(global.importGrid, i , ds_grid_height(global.importGrid) -1, colStringList);
					}
					ds_grid_set(global.importGrid, i , row, fullColString);
				
				}
			
				row++;

		}
	

		if (string_count(" ", lineInFile) < 1) {
			continue;
		}
		if (newRow) {
			ds_grid_resize(global.importGrid, global.importGridWidth, ds_grid_height(global.importGrid) + 1);
			newRow = false;
		}
	
	
	
		// Check for Unit Level Data
		if (unitLevel) {
			var colNameLength = string_pos("=", lineInFile);
			var colName = string_copy(lineInFile, 1, colNameLength - 1);
			var colVal = string_copy(lineInFile, colNameLength + 1, string_length(lineInFile) - colNameLength);
			var colNameMeta = (string_count("meta::", colName) > 0);
			var colValMeta = (string_count("meta::", colVal) > 0);
			
			if (colNameMeta) global.CoNLLUwithMeta = true;
			if (colNameMeta || colValMeta) continue; // skip over meta fields
			
			
			show_debug_message("unit level - lineInFile: " + string(lineInFile));
		
		
			if (firstCluster) {
				ds_list_add(firstClusterTagList, colName);
			}
		

			var col = ds_map_find_value(global.importGridColMap, colName);

			if (is_undefined(col)) {
				
				show_debug_message("is_undefined colName: " + string(colName));

				widthOfImportGrid++;
				global.importGridWidth = widthOfImportGrid;
				ds_grid_resize(global.importGrid, global.importGridWidth, ds_grid_height(global.importGrid));
				ds_list_add(global.importGridColNameList, colName);
				col = global.importGridWidth - 1;

				ds_map_add(global.importGridColMap, colName, col);
			}
			ds_grid_set(global.importGrid, col, row, colVal);

		}
	
	}

	ds_grid_resize(global.importGrid, global.importGridWidth, rowCounter);
			

	global.tabDeliniatedText = true;


}
