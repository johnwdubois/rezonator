function scr_replaceWord(wordID, replaceStr) {
	// Replace the displayString of a word with the specified string

	//var originalStr = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, wordID - 1);
	if(replaceStr == undefined){
		exit;
	}
	
	ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colReplaceWord, wordID - 1, replaceStr);
	ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, wordID - 1, replaceStr);
	
	var tokenImportIndex = -1;
	if(obj_control.wordView > 2){
		tokenImportIndex = ds_list_find_value(obj_control.currentDisplayTokenColsList, obj_control.wordView - 3);
	}
	else{
		tokenImportIndex = ds_list_find_value(obj_control.currentDisplayTokenColsList, obj_control.wordView - 2);				
	}
	var tokenImportColName = ds_list_find_value(global.tokenImportColNameList, tokenImportIndex);
	var importColPos = ds_list_find_index(global.importGridColNameList, tokenImportColName);
				


	
	ds_grid_set(global.tokenImportGrid, tokenImportIndex, wordID - 1, replaceStr);
	
}
