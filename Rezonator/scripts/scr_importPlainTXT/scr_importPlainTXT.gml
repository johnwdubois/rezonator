var filename = argument0;
global.importFilename = filename;

var fileOpenRead = file_text_open_read(filename);

global.importToolboxGridWidth = 2
ds_grid_resize(global.importToolboxGrid, global.importToolboxGridWidth, ds_grid_height(global.importToolboxGrid));

global.importToolboxGridColName[0] = "Text";
ds_map_add(global.importToolboxGridColMap, "Text", 0);
global.importToolboxGridColName[1] = "Group";
ds_map_add(global.importToolboxGridColMap, "Group", 1);


var newRow = false;
var currentLine = 0;
var blankRow = true;
var group = 1;
while (not file_text_eof(fileOpenRead)) {
	
	currentLine++;
	
	var lineInFile = file_text_readln(fileOpenRead);
	var col = 0;

	
	if (string_length(string_lettersdigits(lineInFile)) < 1) {
		
		ds_grid_resize(global.importToolboxGrid, global.importToolboxGridWidth, ds_grid_height(global.importToolboxGrid) + 1);
		var row = ds_grid_height(global.importToolboxGrid) - 1;
		var colVal = string_copy(lineInFile, 0 , string_length(lineInFile));
		ds_grid_set(global.importToolboxGrid, col, row, colVal);
		group++;
	}
	else {
		ds_grid_resize(global.importToolboxGrid, global.importToolboxGridWidth, ds_grid_height(global.importToolboxGrid) + 1);
		var row = ds_grid_height(global.importToolboxGrid) - 1;
		var colVal = string_copy(lineInFile, 0 , string_length(lineInFile));
		ds_grid_set(global.importToolboxGrid, col, row, colVal);
		col++;
		ds_grid_set(global.importToolboxGrid, col, row, group);
		
	}
	

	
	//var colNameLength = string_pos(" ", lineInFile);
	//var colName = string_copy(lineInFile, 2, colNameLength - 2);

	
/*
	var col = ds_map_find_value(global.importToolboxGridColMap, colName);
	if (is_undefined(col)) {
		global.importToolboxGridWidth++;
		ds_grid_resize(global.importToolboxGrid, global.importToolboxGridWidth, ds_grid_height(global.importToolboxGrid));
		global.importToolboxGridColName[global.importToolboxGridWidth - 1] = colName;
		col = global.importToolboxGridWidth - 1;
		ds_map_add(global.importToolboxGridColMap, colName, col);
	}
*/


}


global.plainText = true;

show_message(ds_grid_height(global.importToolboxGrid));

room_goto(rm_importScreen);