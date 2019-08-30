var currentUser = ds_grid_get(currentChainGrid, chainGrid_colAuthor, currentFocusedChainIndex);
var originalChainWordList = ds_grid_get(currentChainGrid, chainGrid_colWordIDList, currentFocusedChainIndex);
var currentChainWordList = ds_list_create();
ds_list_copy(currentChainWordList, originalChainWordList);
show_message(scr_getStringOfList(currentChainWordList));

var currentStackID = ds_list_find_value(obj_control.stackShowList, obj_control.currentStackShowListPosition);
if(string_lower(currentUser) == "gold") {
	var prevGoldStandardRow = ds_grid_value_y(goldStandardGrid, goldStandardGrid_colStackID, 0, goldStandardGrid_colStackID, ds_grid_height(goldStandardGrid), currentStackID);
	if(prevGoldStandardRow == -1) {
		ds_grid_resize(goldStandardGrid, goldStandardGridWidth, ds_grid_height(goldStandardGrid) + 1);
		ds_grid_set(goldStandardGrid, goldStandardGrid_colStackID, ds_grid_height(goldStandardGrid) - 1, currentStackID);
		ds_grid_set(goldStandardGrid, goldStandardGrid_colWordIDList, ds_grid_height(goldStandardGrid) - 1, currentChainWordList);
	}
	else {
		ds_grid_set(goldStandardGrid, goldStandardGrid_colStackID, prevGoldStandardRow, currentStackID);
		ds_grid_set(goldStandardGrid, goldStandardGrid_colWordIDList, prevGoldStandardRow, currentChainWordList);
	}
	// Clear the plate for the players
	scr_deleteEntireChain(ds_grid_get(currentChainGrid, chainGrid_colChainID, currentFocusedChainIndex));
	// Here, or during load in, this chain has to be removed, completely or just from view.
	//show_message("Stack: " + string(ds_grid_get(goldStandardGrid, goldStandardGrid_colStackID, ds_grid_height(goldStandardGrid) - 1)));
	//show_message("List: " + scr_getStringOfList(ds_grid_get(goldStandardGrid, goldStandardGrid_colWordIDList, ds_grid_height(goldStandardGrid) - 1)));
}
else if(string_lower(currentUser) == "player"){
	var correct = 0;
	var currentGoldStandardRow = ds_grid_value_y(goldStandardGrid, goldStandardGrid_colStackID, 0, goldStandardGrid_colStackID, ds_grid_height(goldStandardGrid), currentStackID);
	var currentGoldStandardWordIDList = ds_grid_get(goldStandardGrid, goldStandardGrid_colWordIDList, currentGoldStandardRow);
	show_message(scr_getStringOfList(currentGoldStandardWordIDList));
	// Compare the focused list with the preset list
	//if(ds_list_size(currentChainWordList) == ds_list_size(currentGoldStandardWordIDList)) {
		//correct = true;
	for(var goldStandardListLoop = 0; goldStandardListLoop < ds_list_size(currentGoldStandardWordIDList); goldStandardListLoop++) {
		//var playerWord = ds_list_find_value(currentChainWordList, goldStandardListLoop);
		var goldWord = ds_list_find_value(currentGoldStandardWordIDList, goldStandardListLoop);
		var goldInListPosition = ds_list_find_index(currentChainWordList, goldWord);
		if(goldInListPosition > -1) {
			ds_list_delete(currentChainWordList, goldInListPosition);
			correct++;
		}
	}
	for(var extraWordsLoop = 0; extraWordsLoop < ds_list_size(currentChainWordList); extraWordsLoop++) {
		correct -= 0.5;
		var redWord = ds_list_find_value(currentChainWordList, extraWordsLoop);
		ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, redWord - 1, obj_control.wordStateRed);
	}
	ds_list_clear(currentChainWordList);
	var percentCorrect = (correct / ds_list_size(currentGoldStandardWordIDList)) * 100;
	//}

	ds_grid_set(goldStandardGrid, goldStandardGrid_colScore, currentGoldStandardRow, percentCorrect);
	ds_grid_set(goldStandardGrid, goldStandardGrid_colUser, currentGoldStandardRow, currentUser);
	
	for(var goldStandardListLoop = 0; goldStandardListLoop < ds_list_size(currentGoldStandardWordIDList); goldStandardListLoop++) {
		var goldWord = ds_list_find_value(currentGoldStandardWordIDList, goldStandardListLoop);
		ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, goldWord - 1, obj_control.wordStateGold);	
	}
		
	//show_message("Stack: " + string(ds_grid_get(goldStandardGrid, goldStandardGrid_colStackID, currentGoldStandardRow)));
	//show_message("List: " + scr_getStringOfList(currentGoldStandardWordIDList));
	//show_message("User: " + string(ds_grid_get(goldStandardGrid, goldStandardGrid_colUser, currentGoldStandardRow)));
	show_message("Score: " + string(ds_grid_get(goldStandardGrid, goldStandardGrid_colScore, currentGoldStandardRow)) + "%");
}