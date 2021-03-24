// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_wordCalculateVoid(wordID){
	
	var wordInChainsList = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInChainList, wordID - 1);
	var wordInChainsListSize = ds_list_size(wordInChainsList);
	
	var currentWordSeq = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordSeq, wordID - 1);
	var currentWordDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, wordID - 1);
	var previousWordID = wordID - 1;

	var previousWordDisplayCol = 0;
	if (previousWordID >= 1 && currentWordSeq > 0) {
		previousWordDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, previousWordID - 1);
	}
		
	var currentWordVoid = currentWordDisplayCol - previousWordDisplayCol;
	ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colVoid, wordID - 1, currentWordVoid);
		
	if (currentWordVoid < 1 && previousWordID >= 0) {
		currentWordDisplayCol++;
		ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, wordID - 1, currentWordDisplayCol);
			
		// if we are pushing a word in a chain, realign that chain
		if (wordInChainsListSize > 0) {
			for (var i = 0; i < wordInChainsListSize; i++) {
				var currentChain = ds_list_find_value(wordInChainsList, i);
				scr_alignChain2ElectricBoogaloo(currentChain);
			}
		}
	}
	
	
	
	// if this word is not in a chain, but has a void greater than 1, bring it back!!
	if (wordInChainsListSize < 1) {
		if (currentWordVoid > 1) {
			if (currentWordSeq == 0) {
				currentWordDisplayCol = 0;
			}
			else {
				currentWordDisplayCol = previousWordDisplayCol + 1;
			}
			ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, wordID - 1, currentWordDisplayCol);
		}
	}

}