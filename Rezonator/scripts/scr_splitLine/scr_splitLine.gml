// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_splitLine(splitWordID){
	
	show_debug_message("scr_splitLine() ... wordID: " + string(splitWordID));
	
	// get lineGridRow and wordIDList
	var lineGrid = obj_control.lineGrid;
	var lineGridRow = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayRow, splitWordID - 1);
	var wordIDList = ds_grid_get(lineGrid, obj_control.lineGrid_colWordIDList, lineGridRow);
			
	// make sure that wordIDList exists
	if (is_numeric(wordIDList)) {
		if (ds_exists(wordIDList, ds_type_list)) {
				
			// find splitWordID in wordIDList
			var wordIDListSize = ds_list_size(wordIDList);
			var splitWordIndex = ds_list_find_index(wordIDList, splitWordID);
			show_debug_message("scr_splitLine() ... wordIDList: " + scr_getStringOfList(wordIDList));
			show_debug_message("scr_splitLine() ... splitWordIndex: " + string(splitWordIndex));
			
			// make sure that splitWordID is in wordIDList
			if (splitWordIndex >= 0) {
						
				// create a new row at the bottom of the lineGrid, then copy everything down a row
				ds_grid_resize(lineGrid, ds_grid_width(lineGrid), ds_grid_height(lineGrid) + 1);
				ds_grid_set_grid_region(lineGrid, lineGrid, 0, lineGridRow + 1, ds_grid_width(lineGrid), ds_grid_height(lineGrid) - 2, 0, lineGridRow + 2);
				ds_grid_set_grid_region(lineGrid, lineGrid, 0, lineGridRow, ds_grid_width(lineGrid), lineGridRow, 0, lineGridRow + 1);

				// split the existing wordIDList into 2 separate lists
				var splitIDList1 = ds_list_create();
				for (var i = 0; i < splitWordIndex; i++) {
					var currentWordID = ds_list_find_value(wordIDList, i);
					ds_list_add(splitIDList1, currentWordID);
				}
				var splitIDList2 = ds_list_create();
				for (var i = splitWordIndex; i < wordIDListSize; i++) {
					var currentWordID = ds_list_find_value(wordIDList, i);
					ds_list_add(splitIDList2, currentWordID);
				}
						
				show_debug_message("scr_splitLine() ... splitIDList1: " + scr_getStringOfList(splitIDList1));
				show_debug_message("scr_splitLine() ... splitIDList2: " + scr_getStringOfList(splitIDList2));
						
				// set the new split lists in the lineGrid
				ds_grid_set(lineGrid, obj_control.lineGrid_colWordIDList, lineGridRow, splitIDList1);
				ds_grid_set(lineGrid, obj_control.lineGrid_colWordIDList, lineGridRow + 1, splitIDList2);
						
						
				// add to the displayRow and pixelYOriginal for every following line in the lineGrid
				var prevDisplayRow = ds_grid_get(lineGrid, obj_control.lineGrid_colDisplayRow, lineGridRow);
				ds_grid_add_region(lineGrid, obj_control.lineGrid_colDisplayRow, lineGridRow + 1, obj_control.lineGrid_colDisplayRow, ds_grid_height(lineGrid), 1);
				ds_grid_add_region(lineGrid, obj_control.lineGrid_colPixelYOriginal, lineGridRow + 1, obj_control.lineGrid_colPixelYOriginal, ds_grid_height(lineGrid), obj_control.gridSpaceVertical);
			}
		}
	}
}