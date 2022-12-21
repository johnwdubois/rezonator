function scr_importPlainTXT() {
	



	ds_grid_clear(global.importGrid, 0);
	global.importGridWidth = 2
	ds_grid_resize(global.importGrid, global.importGridWidth, ds_grid_height(global.importGrid));

	//global.importGridColName[0] = "Text";
	ds_list_add(global.importGridColNameList, "Text");
	ds_map_add(global.importGridColMap, "Text", 0);
	//global.importGridColName[1] = "Group";
	ds_list_add(global.importGridColNameList, "Group");
	ds_map_add(global.importGridColMap, "Group", 1);

	var txtGridHeight = ds_grid_height(global.importTXTLineGrid);
	
	//var newRow = false;
	var currentLine = 0;
	//var blankRow = true;
	var group = 1;
	repeat (txtGridHeight) {
	

	
		var lineInFile = global.importTXTLineGrid[# global.importTXTLineGrid_colLine,currentLine];
		var col = 0;

	
		if (scr_isStrOnlyWhitespace(lineInFile)) {
			
			if(global.importType == global.importType_Paragraph){
				ds_grid_resize(global.importGrid, global.importGridWidth, ds_grid_height(global.importGrid) + 1);
				var row = ds_grid_height(global.importGrid) - 1;
				var colVal = string_copy(lineInFile, 0 , string_length(lineInFile));				
				ds_grid_set(global.importGrid, col, row, colVal);
			}
			group++;
		}
		else {
			ds_grid_resize(global.importGrid, global.importGridWidth, ds_grid_height(global.importGrid) + 1);
			var row = ds_grid_height(global.importGrid) - 1;
			var colVal = string_copy(lineInFile, 0 , string_length(lineInFile));
			show_debug_message("row: " + string(row) + ", colVal: " + string(colVal));
			if (currentLine == txtGridHeight - 1 && col == 0) {
				show_debug_message("last line, removing last char");
				if (string_length(colVal) >= 2) {
					colVal = string_delete(colVal, string_length(colVal) - 1, 1);
				}
			}
			
			
			colVal = scr_inputSpaces(colVal);

			
			ds_grid_set(global.importGrid, col, row, colVal);
			col++;
			ds_grid_set(global.importGrid, col, row, group);
		
		}
	

		currentLine++;
	}


	global.plainText = true;


	room_goto(rm_importScreen);


}
