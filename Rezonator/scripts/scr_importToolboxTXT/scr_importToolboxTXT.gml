var filename = argument0;

var fileOpenRead = file_text_open_read(filename);

var firstRef = false;
global.importToolboxGridColName[0] = "ref";

while (not file_text_eof(fileOpenRead)) {
	
	var lineInFile = file_text_readln(fileOpenRead);
	if (string_length(string_letters(lineInFile)) < 1) {
		continue;
	}
	if (string_char_at(lineInFile, 1) != "\\") {
		continue;
	}
	if (string_count(" ", lineInFile) < 1) {
		continue;
	}
	
	
	var colNameLength = string_pos(" ", lineInFile);
	var colName = string_copy(lineInFile, 2, colNameLength - 2);
	var colVal = string_copy(lineInFile, colNameLength + 1, string_length(lineInFile) - colNameLength);
	
	var lineInFileTrim = "";
	if (string_count("\\ref ", lineInFile)) {
		lineInFileTrim = string_delete(lineInFile, 1, string_length("\\ref "));
		ds_grid_resize(global.importToolboxGrid, global.importToolboxGridWidth, ds_grid_height(global.importToolboxGrid) + 1);
		ds_grid_set(global.importToolboxGrid, global.importToolboxGrid_colRef, ds_grid_height(global.importToolboxGrid) - 1, lineInFileTrim);
		firstRef = true;
	}
	else if (firstRef) {
		var col = ds_map_find_value(global.importToolboxGridColMap, colName);
		if (is_undefined(col)) {
			global.importToolboxGridWidth++;
			global.importToolboxGridColName[global.importToolboxGridWidth - 1] = colName;
			ds_grid_resize(global.importToolboxGrid, global.importToolboxGridWidth, ds_grid_height(global.importToolboxGrid));
			col = global.importToolboxGridWidth - 1;
			ds_map_add(global.importToolboxGridColMap, colName, col);
		}
		ds_grid_set(global.importToolboxGrid, col, ds_grid_height(global.importToolboxGrid) - 1, colVal);
	}

}

room_goto(rm_mainScreen);