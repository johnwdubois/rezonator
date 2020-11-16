function scr_replaceWord(wordID, replaceStr) {
	// Replace the displayString of a word with the specified string

	//var originalStr = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, wordID - 1);

	ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colReplaceWord, wordID - 1, replaceStr);
	ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, wordID - 1, replaceStr);
}
