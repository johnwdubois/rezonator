function scr_importPlainTXT(filename) {
	global.importFilename = filename;

	var fileOpenRead = file_text_open_read(filename);
	ds_grid_clear(global.importGrid, 0);
	global.importGridWidth = 2
	ds_grid_resize(global.importGrid, global.importGridWidth, ds_grid_height(global.importGrid));

	//global.importGridColName[0] = "Text";
	ds_list_add(global.importGridColNameList, "Text");
	ds_map_add(global.importGridColMap, "Text", 0);
	//global.importGridColName[1] = "Group";
	ds_list_add(global.importGridColNameList, "Group");
	ds_map_add(global.importGridColMap, "Group", 1);


	//var newRow = false;
	var currentLine = 0;
	//var blankRow = true;
	var group = 1;
	while (not file_text_eof(fileOpenRead)) {
	
		currentLine++;
	
		var lineInFile = file_text_readln(fileOpenRead);
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
			
			var newString = "";
			
			var letterCount = string_length(colVal);
			for(var i = 1;i <= letterCount; i++){
				var charFromFile = string_char_at(colVal,i);
				var nextChar = string_char_at(colVal,i+1);
				var unicodeValue = ord(charFromFile);
				var nextUnicodeValue = ord(nextChar);
				
				newString += charFromFile;
				
				if ( (12288 <= unicodeValue  and unicodeValue <= 40959)  or
				(63744 <= unicodeValue  and unicodeValue <= 64255) or
				(131072 <= unicodeValue  and unicodeValue <= 183983) or
				(194560 <= unicodeValue  and unicodeValue <= 195103) ){
					newString += " ";
				}
				else if ( (12288 <= nextUnicodeValue  and nextUnicodeValue <= 40959)  or
				(63744 <= nextUnicodeValue  and nextUnicodeValue <= 64255) or
				(131072 <= nextUnicodeValue  and nextUnicodeValue <= 183983) or
				(194560 <= nextUnicodeValue  and nextUnicodeValue <= 195103) ){
					newString += " ";
				}
				
			}

			
			ds_grid_set(global.importGrid, col, row, newString);
			col++;
			ds_grid_set(global.importGrid, col, row, group);
		
		}
	


	}


	global.plainText = true;

	//show_message(ds_grid_height(global.importGrid));

	room_goto(rm_importScreen);


}
