var currentChainWordList = ds_grid_get(currentChainGrid, chainGrid_colWordIDList, currentFocusedChainIndex);
var correct = false;
var currentStackID = ds_list_find_value(obj_control.stackShowList, obj_control.currentStackShowListPosition);
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
var currentUser = ds_grid_get(currentChainGrid, chainGrid_colAuthor, currentFocusedChainIndex);
ds_grid_set(goldStandardGrid, goldStandardGrid_colUser, currentGoldStandardRow, currentUser);
		
show_message("User: " + string(ds_grid_get(goldStandardGrid, goldStandardGrid_colUser, currentGoldStandardRow)));
show_message("Score: " + string(ds_grid_get(goldStandardGrid, goldStandardGrid_colScore, currentGoldStandardRow)));
		