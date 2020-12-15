// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_proseCreateNewLines(){
	
	var lineGrid = obj_control.lineGrid;
	var maxWordsPerLine = (window_get_width() - obj_control.wordLeftMargin) / obj_control.gridSpaceHorizontal;
	
	// loop through lineGrid and split lines that have more words than maxWordsPerLine
	for (var i = 0; i < ds_grid_height(lineGrid); i++) {
		var currentWordIDList = ds_grid_get(lineGrid, obj_control.lineGrid_colWordIDList, i);
		
		// make sure each word knows its displayRow
		var currentWordIDListSize = ds_list_size(currentWordIDList);
		for (var j = 0; j < currentWordIDListSize; j++) {
			var currentWordID = ds_list_find_value(currentWordIDList, j);
			ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayRow, currentWordID - 1, i);
		}
		
		// if this line has more words than maxWordsPerLine, we will split the line
		if (ds_list_size(currentWordIDList) > maxWordsPerLine) {
			var splitWordID = ds_list_find_value(currentWordIDList, maxWordsPerLine - 1);
			scr_splitLine(splitWordID);
		}
	}

}