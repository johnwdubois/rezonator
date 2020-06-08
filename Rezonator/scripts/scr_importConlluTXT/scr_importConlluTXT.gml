var filename = argument0;
global.importFilename = filename;
var firstClusterTagList = argument1;
var firstCluster = argument2; 
var firstClusterEncountered = argument3;
var lineInCluster = argument4;

var newRow = false;
var blankRow = true;

var fileOpenRead = file_text_open_read(filename);
var colListCreated = false;
var lineInFile = file_text_readln(fileOpenRead);
	
	if (string_char_at(lineInFile, 1) != "#") {
		exit;
	}
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
			// Beginning of Brady's section
			var listOfColumns = ds_list_create();
			listOfColumns = scr_splitString(lineInFile,chr(9));
			var listOfColumnsSize = ds_list_size(listOfColumns);
			for(var i = 0; i <= listOfColumnsSize; i++){
				if(ds_list_find_value(listOfColumns,i) == "" or ds_list_find_value(listOfColumns,i) == " "){
					ds_list_delete(listOfColumns,i);
					i -= 1;
				}
			}
			if(widthOfImportGrid <= ds_list_size(listOfColumns)){
				widthOfImportGrid = ds_list_size(listOfColumns);
				global.importGridWidth = widthOfImportGrid
				if(!colListCreated){
					for(i = 0; i < global.importGridWidth; i++){
						var colName = " col";
						ds_list_add(global.importGridColNameList, colName + " " + string(i));
						ds_map_add(global.importGridColMap, colName, i);
					}
					colListCreated = true;
				}

				ds_grid_resize(global.importGrid, widthOfImportGrid, ds_grid_height(global.importGrid));
			}
			ds_grid_resize(global.importGrid, global.importGridWidth, ds_grid_height(global.importGrid)+1);
	
			var listOfColumnsSize = ds_list_size(listOfColumns);
			for(var i = 0; i <= listOfColumnsSize; i++){
		
				var fullColString = string(ds_list_find_value(listOfColumns,i));
				var colStringList = ds_list_create();
				colStringList = scr_splitString(fullColString, " ");
		
				if(ds_list_size(colStringList) > 1){
					ds_grid_set(global.importGrid, i , ds_grid_height(global.importGrid) -1, colStringList);
				}
				ds_grid_set(global.importGrid, i , ds_grid_height(global.importGrid) -1, fullColString);
			}
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
//global.plainText = true;
global.tabDeliniatedText = true;

//show_message(scr_getStringOfList(global.importGridColNameList));