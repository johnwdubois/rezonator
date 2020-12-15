// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_proseCreateNewLines(){
	
	var lineGrid = obj_control.lineGrid;
	
	
	for (var i = 0; i < ds_grid_height(lineGrid); i++) {
		var currentWordIDList = ds_grid_get(lineGrid, obj_control.lineGrid_colWordIDList, i);
		
		var currentWordIDListSize = ds_list_size(currentWordIDList);
		for (var j = 0; j < currentWordIDListSize; j++) {
			var currentWordID = ds_list_find_value(currentWordIDList, j);
			ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayRow, currentWordID - 1, i);
		}
		
		show_debug_message("scr_proseCreateNewLines() ... currentWordIDList: " + scr_getStringOfList(currentWordIDList));
		if (ds_list_size(currentWordIDList) > 6) {
			var splitWordID = ds_list_find_value(currentWordIDList, 5);
			scr_splitLine(splitWordID);
		}
	}

}