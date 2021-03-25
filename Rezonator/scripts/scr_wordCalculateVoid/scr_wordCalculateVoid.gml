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
	if (currentWordVoid > 1) {
		if (wordInChainsListSize < 1) {
				if (currentWordSeq == 0) {
					currentWordDisplayCol = 0;
				}
				else {
					currentWordDisplayCol = previousWordDisplayCol + 1;
				}
				ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, wordID - 1, currentWordDisplayCol);
		}
		else {
			// if this word is in a chain, and it has >1 void, let's quickly check that chain to see if it has any words with <=1 void
			// if it doesn't, let's pull that shit back!!!!
			for (var i = 0; i < wordInChainsListSize; i++) {
				var currentChain = wordInChainsList[| i];
				
				var currentChainSubMap = global.nodeMap[? currentChain];
				if (!is_numeric(currentChainSubMap)) continue;
				if (!ds_exists(currentChainSubMap, ds_type_map)) continue;
				var currentChainType = currentChainSubMap[? "type"];
				

				if (currentChainType == "rezChain") {
					if (ds_list_find_index(chainVoidCheckList, currentChain) == -1) {
						ds_list_add(chainVoidCheckList, currentChain);
						
						var currentChainSetList = currentChainSubMap[? "vizSetIDList"];
						if (!is_numeric(currentChainSetList)) continue;
						if (!ds_exists(currentChainSetList, ds_type_list)) continue;
						var currentChainSetListSize = ds_list_size(currentChainSetList);
						var smallVoidExists = false;
						
						for (var j = 0; j < currentChainSetListSize; j++) {
							var currentEntry = currentChainSetList[| j];
							var currentEntrySubMap = global.nodeMap[? currentEntry];
							if (!is_numeric(currentEntrySubMap)) continue;
							if (!ds_exists(currentEntrySubMap, ds_type_map)) continue;
							var currentWordID = currentEntrySubMap[? "word"];
							var currentVoid = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colVoid, currentWordID - 1);
							if (currentVoid <= 1) smallVoidExists = true;
						}
						
						if (!smallVoidExists) {
							for (var j = 0; j < currentChainSetListSize; j++) {
								var currentEntry = currentChainSetList[| j];
								var currentEntrySubMap = global.nodeMap[? currentEntry];
								if (!is_numeric(currentEntrySubMap)) continue;
								if (!ds_exists(currentEntrySubMap, ds_type_map)) continue;
								var currentWordID = currentEntrySubMap[? "word"];
								var currentDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 1);
								currentDisplayCol--;
								ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 1, currentDisplayCol);
							}
						}
					}
				}

			}
		}
	}
}