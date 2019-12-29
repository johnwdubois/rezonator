var filename = argument0;

var fileOpenRead = file_text_open_read(filename);



var newRow = false;
var currentLine = 0;
var blankRow = true;

while (not file_text_eof(fileOpenRead)) {
	
	currentLine++;
	
	var lineInFile = file_text_readln(fileOpenRead);
	if (string_length(string_lettersdigits(lineInFile)) < 1) {
		blankRow = true;
		continue;
	}
	else {
		if (blankRow) {
			newRow = true;
			blankRow = false;
		}
	}
	
	if (string_char_at(lineInFile, 1) != "\\") {
		continue;
	}
	if (string_count(" ", lineInFile) < 1) {
		continue;
	}
	if (newRow) {
		ds_grid_resize(global.importToolboxGrid, global.importToolboxGridWidth, ds_grid_height(global.importToolboxGrid) + 1);
		newRow = false;
	}
	
	var colNameLength = string_pos(" ", lineInFile);
	var colName = string_copy(lineInFile, 2, colNameLength - 2);
	var colVal = string_copy(lineInFile, colNameLength + 1, string_length(lineInFile) - colNameLength);
	

	var col = ds_map_find_value(global.importToolboxGridColMap, colName);
	if (is_undefined(col)) {
		global.importToolboxGridWidth++;
		ds_grid_resize(global.importToolboxGrid, global.importToolboxGridWidth, ds_grid_height(global.importToolboxGrid));
		global.importToolboxGridColName[global.importToolboxGridWidth - 1] = colName;
		col = global.importToolboxGridWidth - 1;
		ds_map_add(global.importToolboxGridColMap, colName, col);
	}
	var row = ds_grid_height(global.importToolboxGrid) - 1;
	ds_grid_set(global.importToolboxGrid, col, row, colVal);
}


room_goto(rm_importScreen);