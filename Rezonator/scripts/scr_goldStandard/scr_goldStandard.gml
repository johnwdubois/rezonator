var currentUser = ds_grid_get(currentChainGrid, chainGrid_colAuthor, currentFocusedChainIndex);
var currentChainWordList = ds_grid_get(currentChainGrid, chainGrid_colWordIDList, currentFocusedChainIndex);

var currentStackID = ds_list_find_value(obj_control.stackShowList, obj_control.currentStackShowListPosition);
if(string_lower(currentUser) == "gold") {
	ds_grid_resize(goldStandardGrid, goldStandardGridWidth, ++goldStandardGridHeight);
	ds_grid_set(goldStandardGrid, goldStandardGrid_colStackID, goldStandardGridHeight - 1, currentStackID);
	ds_grid_set(goldStandardGrid, goldStandardGrid_colWordIDList, goldStandardGridHeight - 1, currentChainWordList);
	// Here, or during load in, this chain has to be removed, completely or just from view.
	show_message("Stack: " + string(ds_grid_get(goldStandardGrid, goldStandardGrid_colStackID, goldStandardGridHeight - 1)));
	show_message("List: " + scr_getStringOfList(ds_grid_get(goldStandardGrid, goldStandardGrid_colWordIDList, goldStandardGridHeight - 1)));
}
else if(string_lower(currentUser) == "player"){
	var correct = false;
	var currentGoldStandardRow = ds_grid_value_y(goldStandardGrid, goldStandardGrid_colStackID, 0, goldStandardGrid_colStackID, ds_grid_height(goldStandardGrid), currentStackID);
	var currentGoldStandardWordIDList = ds_grid_get(goldStandardGrid, goldStandardGrid_colWordIDList, currentGoldStandardRow);
	// Compare the focused list with the preset list
	if(ds_list_size(currentChainWordList) == ds_list_size(currentGoldStandardWordIDList)) {
		correct = true;
		for(var goldStandardListLoop = 0; goldStandardListLoop < ds_list_size(currentGoldStandardWordIDList); goldStandardListLoop++) {
			var playerWord = ds_list_find_value(currentChainWordList, goldStandardListLoop);
			var goldWord = ds_list_find_value(currentGoldStandardWordIDList, goldStandardListLoop);
			if(playerWord != goldWord) {
				correct = false;
				continue;
			}
		}
	}
	if(correct) {
		ds_grid_set(goldStandardGrid, goldStandardGrid_colScore, currentGoldStandardRow, 100);
	}
	else {
		ds_grid_set(goldStandardGrid, goldStandardGrid_colScore, currentGoldStandardRow, 0);
	}

	ds_grid_set(goldStandardGrid, goldStandardGrid_colUser, currentGoldStandardRow, currentUser);
		
	//show_message("Stack: " + string(ds_grid_get(goldStandardGrid, goldStandardGrid_colStackID, currentGoldStandardRow)));
	//show_message("List: " + scr_getStringOfList(currentGoldStandardWordIDList));
	//show_message("User: " + string(ds_grid_get(goldStandardGrid, goldStandardGrid_colUser, currentGoldStandardRow)));
	show_message("Score: " + string(ds_grid_get(goldStandardGrid, goldStandardGrid_colScore, currentGoldStandardRow)));
}