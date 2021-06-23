function scr_importTabbedTXT(delimiter) {
	show_debug_message("scr_importTabbedTXT");

	var colListCreated = false;
	var widthOfImportGrid = 0;
	var importTXTLineGridHeight = ds_grid_height(global.importTXTLineGrid);
	var j = 0;

	repeat(importTXTLineGridHeight) {
	
		var lineStr = global.importTXTLineGrid[# global.importTXTLineGrid_colLine, j];
		var listOfColumns = ds_list_create();
		listOfColumns = scr_splitStringImport(lineStr, delimiter);
		var listOfColumnsSize = ds_list_size(listOfColumns);
		
		
		if(widthOfImportGrid <= ds_list_size(listOfColumns)){
			widthOfImportGrid = ds_list_size(listOfColumns);
			global.importGridWidth = widthOfImportGrid

			ds_grid_resize(global.importGrid, widthOfImportGrid, ds_grid_height(global.importGrid));
		}

		ds_grid_resize(global.importGrid, global.importGridWidth, ds_grid_height(global.importGrid)+1);
	
		var listOfColumnsSize = ds_list_size(listOfColumns);
		for(var i = 0; i < listOfColumnsSize; i++){
		
			var fullColString = string(ds_list_find_value(listOfColumns,i));
			
			fullColString = scr_inputSpaces(fullColString);
			
			var colStringList = ds_list_create();
			colStringList = scr_splitString(fullColString, " ");
		
			if(ds_list_size(colStringList) > 1){
				ds_grid_set(global.importGrid, i , ds_grid_height(global.importGrid) -1, colStringList);
			}
			ds_grid_set(global.importGrid, i , ds_grid_height(global.importGrid) -1, fullColString);
		}
	
	
		//show_message(scr_getStringOfList(listOfColumns));
		j++;
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
