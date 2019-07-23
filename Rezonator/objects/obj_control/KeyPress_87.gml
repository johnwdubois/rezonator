///@description Transcript View
if (!shortcutsEnabled || dialogueBoxActive) {
	exit;
}

if (keyboard_check(vk_control)) {
	
	if (showDevVars) {
		if (!instance_exists(obj_network)) {
			instance_create(0, 0, obj_network);
		}
		with (obj_network) {
			scr_sendGridToServer(obj_control.wordGrid);
		}
	}
	exit;
}

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
}