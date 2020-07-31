var filename = argument0;
global.importFilename = filename;


var firstClusterTagList = ds_list_create();
var firstCluster = true;
var firstClusterEncountered = false;
var lineInCluster = 0;
var currentCluster = 0;

var newRow = false;
var blankRow = true;
var row = 0;


var fileOpenRead = file_text_open_read(filename);
var colListCreated = false;
var lineInFile = file_text_readln(fileOpenRead);
var first3Char = string_char_at(lineInFile, 1) + string_char_at(lineInFile, 2) + string_char_at(lineInFile, 3);
	
	if (string_char_at(lineInFile, 1) != "#" and first3Char != "GUM") {
		exit;
	}

global.importType = global.importType_CoNLLU

var widthOfImportGrid = 0;
while (not file_text_eof(fileOpenRead)) {
	
	var lineInFile = file_text_readln(fileOpenRead);
	
	// Beginning of Terry's section
	ds_grid_resize(global.importTXTLineGrid, global.importTXTLineGridWidth, ds_grid_height(global.importTXTLineGrid) + 1);
	ds_grid_set(global.importTXTLineGrid, global.importTXTLineGrid_colLine, ds_grid_height(global.importTXTLineGrid) - 1, lineInFile);
	ds_grid_set(global.importTXTLineGrid, global.importTXTLineGrid_colException, ds_grid_height(global.importTXTLineGrid) - 1, false);
	
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
	if (string_length(string_lettersdigits(lineInFile)) < 1) {
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
	

	
	// Check for Token level data
	if (string_char_at(lineInFile, 1) != "#") {
		
		if (!firstCluster and lineInCluster - 1 < ds_list_size(firstClusterTagList)) {
			lineInFile = ds_list_find_value(firstClusterTagList, lineInCluster - 1) + " " + lineInFile;
		}
		else {
			// Split the tokens into their individual columns
			var listOfColumns = ds_list_create();
			listOfColumns = scr_splitString(lineInFile,chr(9));
			var listOfColumnsSize = ds_list_size(listOfColumns);
			
			// Take out any spaces or blank tokens
			for(var i = 0; i <= listOfColumnsSize; i++){
				if(ds_list_find_value(listOfColumns,i) == "" or ds_list_find_value(listOfColumns,i) == " "){
					ds_list_delete(listOfColumns,i);
					i -= 1;
				}
			}
			
			// Increase the width of the import grid to accomodate new columns
			if(widthOfImportGrid <= ds_list_size(listOfColumns) + 3){
				widthOfImportGrid = ds_list_size(listOfColumns) + 3;
				global.importGridWidth = widthOfImportGrid
				if(!colListCreated){
					for(i = 3; i < global.importGridWidth; i++){
						var colName = " col";
						ds_list_add(global.importGridColNameList, colName + " " + string(i));
						ds_map_add(global.importGridColMap, colName, i);
					}
					colListCreated = true;
				}

				ds_grid_resize(global.importGrid, widthOfImportGrid, ds_grid_height(global.importGrid));
			}
			ds_grid_resize(global.importGrid, global.importGridWidth, ds_grid_height(global.importGrid)+1);
			
			// place tokens into the import grid
			var listOfColumnsSize = ds_list_size(listOfColumns);
			for(var i = 3; i <= listOfColumnsSize + 3; i++){
		
				var fullColString = string(ds_list_find_value(listOfColumns,i-3));
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
	}
	if (string_count(" ", lineInFile) < 1) {
		continue;
	}
	if (newRow) {
		ds_grid_resize(global.importGrid, global.importGridWidth, ds_grid_height(global.importGrid) + 1);
		newRow = false;
	}
	
	
	
	
	
	
	// Check for Unit Level Data
	if (string_char_at(lineInFile, 1) == "#") {
		var colNameLength = string_pos("=", lineInFile);
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

		ds_grid_set(global.importGrid, col, row, colVal);
	}
	
}
			
//global.plainText = true;
global.tabDeliniatedText = true;

//show_message(scr_getStringOfList(global.importGridColNameList));