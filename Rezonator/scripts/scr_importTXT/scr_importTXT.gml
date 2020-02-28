var filename = argument0;
global.importFilename = filename;

scr_getImportFileRipList(filename);

var fileOpenRead = file_text_open_read(filename);



var newRow = false;
var currentLine = 0;
var blankRow = true;


var firstClusterTagList = ds_list_create();
var firstCluster = true;
var lineInCluster = 0;

var tokenList = ds_list_create();


while (not file_text_eof(fileOpenRead)) {
	
	currentLine++;
	
	var lineInFile = file_text_readln(fileOpenRead);
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
	
	ds_list_clear(tokenList);
	tokenList = scr_splitString(lineInFile, " ");
	if (ds_list_size(tokenList) < 1) {
		continue;
	}
	var firstToken = ds_list_find_value(tokenList, 0);
	
	//show_message(lineInFile);
	
	
	if (string_char_at(lineInFile, 1) != "\\" && string_char_at(firstToken, string_length(firstToken)) != "\\") {
		
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
	
	var colNameLength = string_length(firstToken);
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

ds_list_destroy(tokenList);




if (ds_grid_width(global.importGrid) == 0) {
	scr_importPlainTXT(filename)
}

file_text_close(fileOpenRead);


room_goto(rm_importScreen);