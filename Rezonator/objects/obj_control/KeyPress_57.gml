if (keyboard_check(vk_alt) && keyboard_check(vk_shift)) {
	wordWrap = !wordWrap;
}

draw_set_font(global.fontMain);
var camWidth = camera_get_view_width(view_get_camera(0));
show_debug_message("camWidth: " + string(camWidth));
//var lineGridHeight = ds_grid_height(lineGrid);
for (var i = 0; i < ds_grid_height(lineGrid); i++) {
	var wordIDList = ds_grid_get(lineGrid, lineGrid_colWordIDList, i);
	
	if (is_numeric(wordIDList)) {
		if (ds_exists(wordIDList, ds_type_list)) {
			var wordIDListSize = ds_list_size(wordIDList);
			show_debug_message("wordIDList: " + scr_getStringOfList(wordIDList));
		
			for (var j = 0; j < wordIDListSize; j++) {
			
				var currentWordID = ds_list_find_value(wordIDList, j);
				var currentWordX = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colPixelX, currentWordID - 1);
				var currentWordStr = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colDisplayString, currentWordID - 1);
				var currentWordStrWidth = string_width(currentWordStr);
			
				if (currentWordX + currentWordStrWidth > camWidth - global.scrollBarWidth) {
					ds_grid_resize(lineGrid, ds_grid_width(lineGrid), ds_grid_height(lineGrid) + 1);
					ds_grid_set_grid_region(lineGrid, lineGrid, 0, i + 1, ds_grid_width(lineGrid), ds_grid_height(lineGrid) - 2, 0, i + 2);

					
					var newPrevWordIDList = ds_list_create();
					for (var k = 0; k < j; k++) {
						var _currentWordID = ds_list_find_value(wordIDList, k);
						ds_list_add(newPrevWordIDList, _currentWordID);
					}
					show_debug_message("newPrevWordIDList: " + scr_getStringOfList(newPrevWordIDList));
					ds_grid_set(lineGrid, lineGrid_colWordIDList, i, newPrevWordIDList);
					
					var newNewWordIDList = ds_list_create();
					for (var k = j; k < wordIDListSize; k++) {
						var _currentWordID = ds_list_find_value(wordIDList, k);
						ds_list_add(newNewWordIDList, _currentWordID);
					}
					show_debug_message("newNewWordIDList: " + scr_getStringOfList(newNewWordIDList));

					
					ds_grid_set_grid_region(lineGrid, lineGrid, 0, i, ds_grid_width(lineGrid), i, 0, i + 1);
					var prevDisplayRow = ds_grid_get(lineGrid, lineGrid_colDisplayRow, i);
					ds_grid_add_region(lineGrid, lineGrid_colDisplayRow, i + 1, lineGrid_colDisplayRow, ds_grid_height(lineGrid), 1);
					ds_grid_add_region(lineGrid, lineGrid_colPixelYOriginal, i + 1, lineGrid_colPixelYOriginal, ds_grid_height(lineGrid), gridSpaceVertical);
					ds_grid_set(lineGrid, lineGrid_colWordIDList, i + 1, newNewWordIDList);
					
					
					i += 1;
					ds_list_destroy(wordIDList);
					break;
				}
			
			}
		
		}
	}
	
}