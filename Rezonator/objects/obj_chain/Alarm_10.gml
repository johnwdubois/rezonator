/// @description Auto-fill stack caption

// get the unitIDList and get all the utterance strings
// so we can concatenate them and set that as the chain's caption
if (stackChainGridRowToCaption >= 0 && stackChainGridRowToCaption < ds_grid_height(stackChainGrid)) {
	
	// start out by clearing whatever string is in the caption
	ds_grid_set(stackChainGrid, chainGrid_colCaption, stackChainGridRowToCaption, "");
	
	var captionStr = "";
	var unitIDList = ds_grid_get(stackChainGrid, chainGrid_colWordIDList, stackChainGridRowToCaption);
	if (ds_exists(unitIDList, ds_type_list)) {
		var unitIDListSize = ds_list_size(unitIDList);
		for (var i = 0; i < unitIDListSize; i++) {
			var currentUnitID = ds_list_find_value(unitIDList, i);
			var currentWordIDList = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colWordIDList, currentUnitID - 1);
			var currentWordIDListSize = ds_list_size(currentWordIDList);
			// get the wordIDList for every unit, then concatenate every word in that unit 
			for (var j = 0; j < currentWordIDListSize; j++) {
				var currentWordID = ds_list_find_value(currentWordIDList, j);
				var currentWordDisplayStr = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, currentWordID - 1);
				captionStr += currentWordDisplayStr + " ";
			}
		}
	}
	
	ds_grid_set(stackChainGrid, chainGrid_colCaption, stackChainGridRowToCaption, captionStr);
}
stackChainGridRowToCaption = -1;