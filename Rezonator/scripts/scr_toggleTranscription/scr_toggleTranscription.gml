wordTranscriptView = !wordTranscriptView;

for (var i = 0; i < ds_grid_height(dynamicWordGrid); i++) {
	var currentWordTranscript = ds_grid_get(wordGrid, wordGrid_colWordTranscript, i);
	var currentWordToken = ds_grid_get(wordGrid, wordGrid_colWordToken, i);
	var currentReplaceWord = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colReplaceWord, i);
	
	if (string_length(currentReplaceWord) > 0) {
		ds_grid_set(dynamicWordGrid, dynamicWordGrid_colDisplayString, i, currentReplaceWord);
	}
	else {
		if (wordTranscriptView) {
			ds_grid_set(dynamicWordGrid, dynamicWordGrid_colDisplayString, i, currentWordToken);
		}
		else {
			ds_grid_set(dynamicWordGrid, dynamicWordGrid_colDisplayString, i, currentWordTranscript);
		}
	}
	
	if (string_length(currentWordToken) < 1) {
		var currentWordState = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colWordState, i);
		if (currentWordState == wordStateNormal) {
			ds_grid_set(dynamicWordGrid, dynamicWordGrid_colWordState, i, wordStateDead);
		}
		else if (currentWordState == wordStateDead) {
			ds_grid_set(dynamicWordGrid, dynamicWordGrid_colWordState, i, wordStateNormal);
		}
	}
}