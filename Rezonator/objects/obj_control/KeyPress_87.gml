///@description Transcript View
if (!shortcutsEnabled) {
	exit;
}

wordTranscriptView = !wordTranscriptView;

for (var i = 0; i < ds_grid_height(dynamicWordGrid); i++) {
	var currentWordTranscript = ds_grid_get(wordGrid, wordGrid_colWordTranscript, i);
	var currentWordToken = ds_grid_get(wordGrid, wordGrid_colWordToken, i);
	
	if (wordTranscriptView) {
		ds_grid_set(dynamicWordGrid, dynamicWordGrid_colDisplayString, i, currentWordToken);
	}
	else {
		ds_grid_set(dynamicWordGrid, dynamicWordGrid_colDisplayString, i, currentWordTranscript);
	}
}