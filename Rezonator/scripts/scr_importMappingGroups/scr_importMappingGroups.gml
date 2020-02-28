var groupNumber = 0;
var alreadyCheckedList = ds_list_create();


for (var currentTagCol = 0; currentTagCol < ds_grid_width(global.importGrid); currentTagCol++) {
	
	var matchingTagsList = -1;
	if (ds_list_find_index(alreadyCheckedList, currentTagCol) > -1) {
		continue;
	}

	for (var i = 0; i < ds_grid_height(global.importGrid); i++) {
	
		var currentTagCell = ds_grid_get(global.importGrid, currentTagCol, i);
		var currentTagCellList = scr_splitStringImport(currentTagCell);
	
		var currentMatchingTagsList = ds_list_create();
	
		for (var j = 0; j < ds_grid_width(global.importGrid); j++) {
		
			if (j == currentTagCol) {
				continue;
			}
			var currentCell = ds_grid_get(global.importGrid, j, i);
			if (currentCell == "0") {
				continue;
			}
			var currentCellList = scr_splitStringImport(currentCell);
		
			if (ds_list_size(currentCellList) == ds_list_size(currentTagCellList)) {
				ds_list_add(currentMatchingTagsList, j);
			}
		}
	
		if (ds_exists(matchingTagsList, ds_type_list)) {
			if (ds_list_size(currentMatchingTagsList) < ds_list_size(matchingTagsList)) {
				matchingTagsList = currentMatchingTagsList;
			}
		}
		else {
			matchingTagsList = currentMatchingTagsList;
		}
	}

	if (ds_exists(matchingTagsList, ds_type_list)) {
		if (ds_list_size(matchingTagsList) > 0) {
			groupNumber++;
			ds_grid_set(obj_importMapping.tagInfoGrid, obj_importMapping.tagInfoGrid_colGroup, currentTagCol, groupNumber);
			for (var i = 0; i < ds_list_size(matchingTagsList); i++) {
		
				var currentTagColSet = ds_list_find_value(matchingTagsList, i);
				ds_grid_set(obj_importMapping.tagInfoGrid, obj_importMapping.tagInfoGrid_colGroup, currentTagColSet, groupNumber);
				ds_list_add(alreadyCheckedList, currentTagColSet);
			}
		}
		ds_list_destroy(matchingTagsList);
	}
	if (ds_exists(matchingTagsList, ds_type_list)) {
		ds_list_destroy(currentMatchingTagsList);
	}
}