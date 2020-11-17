function scr_importTabbedTXT(filename) {
	show_debug_message("scr_importTabbedTXT");
	global.importFilename = filename;

	var fileOpenRead = file_text_open_read(filename);
	var colListCreated = false;

	var widthOfImportGrid = 0;
	while (not file_text_eof(fileOpenRead)) {
	
		var lineInFile = file_text_readln(fileOpenRead);
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
	
	
		//show_message(scr_getStringOfList(listOfColumns));
	
	}
			if(!colListCreated){
				for(i = 0; i < global.importGridWidth; i++){
					var colName = " col";
					ds_list_add(global.importGridColNameList, colName + " " + string(i));
					ds_map_add(global.importGridColMap, colName, i);
				}
				colListCreated = true;
			}
	//global.plainText = true;
	global.tabDeliniatedText = true;

	//show_message(scr_getStringOfList(global.importGridColNameList));


}
