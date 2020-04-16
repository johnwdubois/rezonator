/// @description get rid of endNotes
	// get rid of endNotes
with (obj_control) {
	var wordGridHeight = ds_grid_height(wordGrid);
	for (var i = 0; i < wordGridHeight; i++) {
	
		var currentWordID = ds_grid_get(wordGrid, wordGrid_colWordID, i);
		var currentUnitID = ds_grid_get(wordGrid, wordGrid_colUnitID, i);
		var currentWordIDList = ds_grid_get(unitGrid, unitGrid_colWordIDList, currentUnitID - 1);
		var lastWordOfLine = ds_list_find_value(currentWordIDList, ds_list_size(currentWordIDList) - 1);
	
		if (lastWordOfLine == currentWordID) {
			if (ds_grid_get(wordGrid, wordGrid_colWordToken, i) != ds_grid_get(wordGrid, wordGrid_colWordTranscript, i)) {
				if (string_length(string_lettersdigits(ds_grid_get(wordGrid, wordGrid_colWordToken, i))) < 1) {
					var currentWordDisplayString = ds_grid_get(wordGrid, wordGrid_colWordTranscript, i);
					ds_grid_set(wordGrid, wordGrid_colWordToken, i, currentWordDisplayString);
				}
			}
		}
	}
}