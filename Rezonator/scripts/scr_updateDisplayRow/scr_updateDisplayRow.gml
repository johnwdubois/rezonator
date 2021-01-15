// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_updateDisplayRow(){
	var lineGrid = obj_control.lineGrid;
	
	// loop through lineGrid and split lines that have more words than maxWordsPerLine
	for (var i = 0; i < ds_grid_height(lineGrid); i++) {
		var currentWordIDList = ds_grid_get(lineGrid, obj_control.lineGrid_colWordIDList, i);
		// make sure each word knows its displayRow and get size odf all words in list
		var currentWordIDListSize = ds_list_size(currentWordIDList);
		for (var j = 0; j < currentWordIDListSize; j++) {
			var currentWordID = ds_list_find_value(currentWordIDList, j);
			var currentWordStr = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, currentWordID - 1)
			ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayRow, currentWordID - 1, i);
		}
	}

}