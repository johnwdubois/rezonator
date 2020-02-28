var filename = argument0;
global.importFilename = filename;

var fileOpenRead = file_text_open_read(filename);

global.importGridWidth = 2
ds_grid_resize(global.importGrid, global.importGridWidth, ds_grid_height(global.importGrid));

//global.importGridColName[0] = "Text";
ds_list_add(global.importGridColNameList, "Text");
ds_map_add(global.importGridColMap, "Text", 0);
//global.importGridColName[1] = "Group";
ds_list_add(global.importGridColNameList, "Group");
ds_map_add(global.importGridColMap, "Group", 1);


var newRow = false;
var currentLine = 0;
var blankRow = true;
var group = 1;
while (not file_text_eof(fileOpenRead)) {
	
	currentLine++;
	
	var lineInFile = file_text_readln(fileOpenRead);
	var col = 0;

	
	if (string_length(string_lettersdigits(lineInFile)) < 1) {
		
		ds_grid_resize(global.importGrid, global.importGridWidth, ds_grid_height(global.importGrid) + 1);
		var row = ds_grid_height(global.importGrid) - 1;
		var colVal = string_copy(lineInFile, 0 , string_length(lineInFile));
		ds_grid_set(global.importGrid, col, row, colVal);
		group++;
	}
	else {
		ds_grid_resize(global.importGrid, global.importGridWidth, ds_grid_height(global.importGrid) + 1);
		var row = ds_grid_height(global.importGrid) - 1;
		var colVal = string_copy(lineInFile, 0 , string_length(lineInFile));
		ds_grid_set(global.importGrid, col, row, colVal);
		col++;
		ds_grid_set(global.importGrid, col, row, group);
		
	}
	

	
	//var colNameLength = string_pos(" ", lineInFile);
	//var colName = string_copy(lineInFile, 2, colNameLength - 2);

	
/*
	var col = ds_map_find_value(global.importGridColMap, colName);
	if (is_undefined(col)) {
		global.importGridWidth++;
		ds_grid_resize(global.importGrid, global.importGridWidth, ds_grid_height(global.importGrid));
		global.importGridColName[global.importGridWidth - 1] = colName;
		col = global.importGridWidth - 1;
		ds_map_add(global.importGridColMap, colName, col);
	}
*/


}


global.plainText = true;

//show_message(ds_grid_height(global.importGrid));

room_goto(rm_importScreen);