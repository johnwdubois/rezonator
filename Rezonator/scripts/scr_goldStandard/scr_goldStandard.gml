function scr_goldStandard() {
	/*
		scr_goldStandard();
	
		Last Updated: 2020-01-23
	
		Called from: obj_dialogueBox
	
		Purpose: Prototypical grading system for the Stackshow games
	
		Mechanism: Compare user's specified chain to the "correct" chain saved in the goldStandardGrid
	
		Author: Georgio Klironomos
	*/


	var currentChainIndex = -1;
	if (currentFocusedChainIndex > -1) {
		currentChainIndex = currentFocusedChainIndex;	
	}
	if(currentFocusedChainIndex < 0 && ds_grid_height(trackChainGrid) > 0) {
		currentChainIndex = ds_grid_height(trackChainGrid) - 1;					
	}

	var currentUser = ds_grid_get(currentChainGrid, chainGrid_colAuthor, currentChainIndex);
	var originalChainWordList = ds_grid_get(currentChainGrid, chainGrid_colWordIDList, currentChainIndex);
	var currentChainWordList = ds_list_create();
	if(originalChainWordList > -1 and originalChainWordList != undefined) {
		ds_list_copy(currentChainWordList, originalChainWordList);
	} 
	else {
		exit;
	}
	
	//show_message(scr_getStringOfList(currentChainWordList));

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
		scr_deleteChain(ds_grid_get(currentChainGrid, chainGrid_colChainID, currentChainIndex));
		// Here, or during load in, this chain has to be removed, completely or just from view.
		//show_message("Stack: " + string(ds_grid_get(goldStandardGrid, goldStandardGrid_colStackID, ds_grid_height(goldStandardGrid) - 1)));
		//show_message("List: " + scr_getStringOfList(ds_grid_get(goldStandardGrid, goldStandardGrid_colWordIDList, ds_grid_height(goldStandardGrid) - 1)));
	}
	else { //if(string_lower(currentUser) == "player"){
		var correct = 0;
		var currentGoldStandardRow = ds_grid_value_y(goldStandardGrid, goldStandardGrid_colStackID, 0, goldStandardGrid_colStackID, ds_grid_height(goldStandardGrid), currentStackID);
		if(currentGoldStandardRow < 0 or currentGoldStandardRow == undefined) {
			exit;
		}
		var currentGoldStandardWordIDList = ds_grid_get(goldStandardGrid, goldStandardGrid_colWordIDList, currentGoldStandardRow);
		//show_message(scr_getStringOfList(currentGoldStandardWordIDList));
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
			// If the word is a Chunk, find its wordID list an mark those instead.
			if(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, redWord - 1) == obj_control.wordStateChunk) {
				var currentChunkGridRow = ds_grid_value_y(obj_chain.chunkGrid, obj_chain.chainGrid_colName, 0, obj_chain.chainGrid_colName, ds_grid_height(obj_chain.chunkGrid), redWord);
				var currentChunkWordIDList = ds_grid_get(obj_chain.chunkGrid, obj_chain.chunkGrid_colBoxWordIDList, currentChunkGridRow);
				for(var chunkWordsLoop = 0; chunkWordsLoop < ds_list_size(currentChunkWordIDList); chunkWordsLoop++) {
					var currentChunkWord = ds_list_find_value(currentChunkWordIDList, chunkWordsLoop);
					if(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, currentChunkWord - 1) != obj_control.wordStateChunk) {
						ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, currentChunkWord - 1, obj_control.wordStateRed);
					}
				}
			}
			else {
				ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, redWord - 1, obj_control.wordStateRed);
			}
		}
		ds_list_clear(currentChainWordList);
		var percentCorrect = (correct / ds_list_size(currentGoldStandardWordIDList)) * 100;
		//}

		ds_grid_set(goldStandardGrid, goldStandardGrid_colScore, currentGoldStandardRow, percentCorrect);
		ds_grid_set(goldStandardGrid, goldStandardGrid_colUser, currentGoldStandardRow, currentUser);
	
		for(var goldStandardListLoop = 0; goldStandardListLoop < ds_list_size(currentGoldStandardWordIDList); goldStandardListLoop++) {
			var goldWord = ds_list_find_value(currentGoldStandardWordIDList, goldStandardListLoop);
			// If the word is a Chunk, find its wordID list an mark those instead.
			if(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, goldWord - 1) == obj_control.wordStateChunk) {
				var currentChunkGridRow = ds_grid_value_y(obj_chain.chunkGrid, obj_chain.chainGrid_colName, 0, obj_chain.chainGrid_colName, ds_grid_height(obj_chain.chunkGrid), goldWord);
				var currentChunkWordIDList = ds_grid_get(obj_chain.chunkGrid, obj_chain.chunkGrid_colBoxWordIDList, currentChunkGridRow);
				for(var chunkWordsLoop = 0; chunkWordsLoop < ds_list_size(currentChunkWordIDList); chunkWordsLoop++) {
					var currentChunkWord = ds_list_find_value(currentChunkWordIDList, chunkWordsLoop);
					if(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, currentChunkWord - 1) != obj_control.wordStateChunk) {
						ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, currentChunkWord - 1, obj_control.wordStateGold);
					}
				}
			}
			else {
				ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, goldWord - 1, obj_control.wordStateGold);
			}
		}
		
		// My shame
		show_message(scr_get_translation("label_score") + string(ds_grid_get(goldStandardGrid, goldStandardGrid_colScore, currentGoldStandardRow)) + "%");
	}


}
