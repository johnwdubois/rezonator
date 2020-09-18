function scr_wordOptions(argument0) {
	//wordOptions
	var optionSelected = argument0;

	switch (optionSelected)
	{
		case "Text":
			if(!obj_control.wordTokenView) {
				obj_control.wordTokenView = !obj_control.wordTokenView;
			
				var dynamicWordGridHeight = ds_grid_height(obj_control.dynamicWordGrid);	
				for (var i = 0; i < dynamicWordGridHeight; i++) {
					var currentWordTranscript = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordTranscript, i);
					var currentWordToken = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordToken, i);
					var currentReplaceWord = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colReplaceWord, i);
	
					if (string_length(currentReplaceWord) > 0) {
						ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, i, currentReplaceWord);
					}
					else {
						if (obj_control.wordTokenView) {
							ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, i, currentWordToken);
						}
						else {
							ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, i, currentWordTranscript);
						}
					}
	
					if (string_length(currentWordToken) < 1) {
						var currentWordState = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, i);
						if (currentWordState == obj_control.wordStateNormal) {
							ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, i, obj_control.wordStateDead);
						}
						else if (currentWordState == obj_control.wordStateDead) {
							ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, i, obj_control.wordStateNormal);
						}
					}
				}
			}
		break;
		case "Transcript":// show word transcript
			if(obj_control.wordTokenView) {
				obj_control.wordTokenView = !obj_control.wordTokenView;
			
				var dynamicWordGridHeight = ds_grid_height(obj_control.dynamicWordGrid);	
				for (var i = 0; i < dynamicWordGridHeight; i++) {
					var currentWordTranscript = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordTranscript, i);
					var currentWordToken = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordToken, i);
					var currentReplaceWord = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colReplaceWord, i);
	
					if (string_length(currentReplaceWord) > 0) {
						ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, i, currentReplaceWord);
					}
					else {
						if (obj_control.wordTokenView) {
							ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, i, currentWordToken);
						}
						else {
							ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, i, currentWordTranscript);
						}
					}
	
					if (string_length(currentWordToken) < 1) {
						var currentWordState = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, i);
						if (currentWordState == obj_control.wordStateNormal) {
							ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, i, obj_control.wordStateDead);
						}
						else if (currentWordState == obj_control.wordStateDead) {
							ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, i, obj_control.wordStateNormal);
						}
					}
				}
			}
		break;
		default:
		break;
	
	}


}
