// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_deleteFromChainVoidCheck(chainID, deletedWordID, deletedWordPushBack){
	
	show_debug_message("scr_deleteFromChainVoidCheck() chainID " + string(chainID) + ", deletedWordID: " + string(deletedWordID) + ", deletedWordPushBack: " + string(deletedWordPushBack));
	
	// get chain submap and make sure it exists
	var chainSubMap = global.nodeMap[? chainID];
	if (!is_numeric(chainSubMap)) exit;
	if (!ds_exists(chainSubMap, ds_type_map)) exit;
	var chainType = chainSubMap[? "type"];
	if (chainType != "rezChain") exit;
	var chainSetList = chainSubMap[? "vizSetIDList"];
	if (!is_numeric(chainSetList)) exit;
	if (!ds_exists(chainSetList, ds_type_list)) exit;
	var chainSetListSize = ds_list_size(chainSetList);
	

	var deletedWordIDChunkFirstWord = scr_getFirstWordOfChunk(deletedWordID);
	if(deletedWordIDChunkFirstWord  > 0){
		deletedWordID = deletedWordIDChunkFirstWord ;
	}
	
	
	if (deletedWordPushBack) {
		
		var deletedWordSeq = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordSeq, deletedWordID - 1);
		var deleteDisplayColDest = 0;
		if (deletedWordSeq > 1) {
			var prevDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, deletedWordID - 2);
			deleteDisplayColDest = prevDisplayCol + 1;
		}
		else {
			deleteDisplayColDest = 0;
		}
		ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, deletedWordID - 1, deleteDisplayColDest);
		
			
		var deleteDisplayRow = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayRow, deletedWordID - 1);
		var deleteDisplayRowWordIDList = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colWordIDList, deleteDisplayRow);
		var deleteDisplayRowWordIDListSize = ds_list_size(deleteDisplayRowWordIDList);
		var posInWordIDList = ds_list_find_index(deleteDisplayRowWordIDList, deletedWordID);
		if (posInWordIDList >= 0) {
			for (var i = posInWordIDList + 1; i < deleteDisplayRowWordIDListSize; i++) {
				var nextWordID = deleteDisplayRowWordIDList[| i];
				scr_wordCalculateVoid(nextWordID);
			}
		}
			
			
			
		var currentChunkFirstWord = -1;	
		for (var j = 0; j < chainSetListSize; j++) {
			var currentEntry = chainSetList[| j];
			var currentEntrySubMap = global.nodeMap[? currentEntry];
			if (!is_numeric(currentEntrySubMap)) continue;
			if (!ds_exists(currentEntrySubMap, ds_type_map)) continue;
			var currentWordID = currentEntrySubMap[? "token"];
			currentChunkFirstWord = scr_getFirstWordOfChunk(currentWordID);
			if(currentChunkFirstWord > 0){
				currentWordID = currentChunkFirstWord;
			}


			var deletedWordSeq = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordSeq, currentWordID - 1);
			var deleteDisplayColDest = 0;
			if (deletedWordSeq > 1) {
				var prevDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 2);
				deleteDisplayColDest = prevDisplayCol + 1;
			}
			else {
				deleteDisplayColDest = 0;
			}
			ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 1, deleteDisplayColDest);
			var deleteDisplayRow = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayRow, currentWordID - 1);
			var deleteDisplayRowWordIDList = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colWordIDList, deleteDisplayRow);
			var deleteDisplayRowWordIDListSize = ds_list_size(deleteDisplayRowWordIDList);
			var posInWordIDList = ds_list_find_index(deleteDisplayRowWordIDList, currentWordID);
			if (posInWordIDList >= 0) {
				for (var i = posInWordIDList + 1; i < deleteDisplayRowWordIDListSize; i++) {
					var nextWordID = deleteDisplayRowWordIDList[| i];
					scr_wordCalculateVoid(nextWordID);
				}
			}

		}
		
	}
	
	
	
	
	
	
	


	
	// check chain for voids (if this is a rezChain)
	if (chainType == "rezChain") {
		
		var smallVoidExists = false;
		var displayRowList = ds_list_create();
		for (var i = 0; i < chainSetListSize; i++) {
		
			var currentEntry = chainSetList[| i];
			var currentEntrySubMap = global.nodeMap[? currentEntry];
			if (!is_numeric(currentEntrySubMap)) continue;
			if (!ds_exists(currentEntrySubMap, ds_type_map)) continue;
			var currentWordID = currentEntrySubMap[? "token"];
			
			if(scr_isChunk(currentWordID)){
				currentWordID = scr_getFirstWordOfChunk(currentWordID);
			}
			
			
			var currentWordSeq = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordSeq, currentWordID - 1);
			var currentDisplayRow = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayRow, currentWordID - 1);
			
			//if (ds_list_find_index(displayRowList, currentDisplayRow) == -1) {
				ds_list_add(displayRowList, currentDisplayRow);
				
				var currentDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 1);
				if (currentWordSeq > 1) {
					var prevDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 2);
					if (is_numeric(prevDisplayCol)) {
						var currentVoid = currentDisplayCol - prevDisplayCol;
						show_debug_message("currentVoid: " + string(currentVoid));
						if (currentVoid <= 1) {
							smallVoidExists = true;
						}
					}
				}
				else if (currentDisplayCol == 0) {
					smallVoidExists = true;
				}
			//}
		}
		
	
		ds_list_clear(displayRowList);
		
		
		if (!smallVoidExists) {
			// bring all the words back so that they have a void of 1
			for (var i = 0; i < chainSetListSize; i++) {
				var currentEntry = chainSetList[| i];
				var currentEntrySubMap = global.nodeMap[? currentEntry];
				if (!is_numeric(currentEntrySubMap)) continue;
				if (!ds_exists(currentEntrySubMap, ds_type_map)) continue;
				
				var currentWordID = currentEntrySubMap[? "token"];
				
				if(scr_isChunk(currentWordID)){
					currentWordID = scr_getFirstWordOfChunk(currentWordID);
				}
				var currentWordSeq = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordSeq, currentWordID - 1);
				var currentDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 1);
			
				if (currentWordSeq > 1) {
					var prevDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 2);
					currentDisplayCol = prevDisplayCol + 1;
				}
				else {
					currentDisplayCol = 0;
				}
				
				ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 1, currentDisplayCol);
			}
		}
		
		scr_alignChain2ElectricBoogaloo(chainID);
		
		
		
		/*
		
		
		// for every word in this chain, look at the words after it in its display row and 
		// for any one of those words thats in a chain, run this script on that chain
		for (var i = 0; i < chainSetListSize; i++) {
			var currentEntry = chainSetList[| i];
			var currentEntrySubMap = global.nodeMap[? currentEntry];
			if (!is_numeric(currentEntrySubMap)) continue;
			if (!ds_exists(currentEntrySubMap, ds_type_map)) continue;
			
			var currentWordID = currentEntrySubMap[? "token"];
			var currentDisplayRow = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayRow, currentWordID - 1);
	
			if (ds_list_find_index(displayRowList, currentDisplayRow) == -1) {
				
				ds_list_add(displayRowList, currentDisplayRow);
			
				var displayRowWordIDList = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colWordIDList, currentDisplayRow);
				var displayRowWordIDListSize = ds_list_size(displayRowWordIDList);
			
				var posInWordIDList = ds_list_find_index(displayRowWordIDList, currentWordID);
				if (posInWordIDList >= 0) {
					for (var j = posInWordIDList + 1; j < displayRowWordIDListSize; j++) {
						var nextWordID = displayRowWordIDList[| j];
						var nextWordInChainsList = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInChainList, nextWordID - 1);
						var nextWordInChainsListSize = ds_list_size(nextWordInChainsList);
						for (var k = 0; k < nextWordInChainsListSize; k++) {
							var nextChainID = nextWordInChainsList[| k];
							if (nextChainID != chainID) {
								show_debug_message("here1");
								scr_deleteFromChainVoidCheck(nextChainID, nextWordID, false);
							}
						}
					}
				}
			}
		}
		
		show_debug_message("deletedWordID: " + string(deletedWordID));	
		
		// for every word in the displayRow that the deleted word was in, check if it has chains that need to be voidchecked
		var currentDisplayRow = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayRow, deletedWordID - 1);
		var displayRowWordIDList = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colWordIDList, currentDisplayRow);
		var displayRowWordIDListSize = ds_list_size(displayRowWordIDList);
		var posInWordIDList = ds_list_find_index(displayRowWordIDList, deletedWordID);
		if (posInWordIDList >= 0) {
			for (var j = posInWordIDList + 1; j < displayRowWordIDListSize; j++) {
				var nextWordID = displayRowWordIDList[| j];
				var nextWordInChainsList = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInChainList, nextWordID - 1);
				var nextWordInChainsListSize = ds_list_size(nextWordInChainsList);
				for (var k = 0; k < nextWordInChainsListSize; k++) {
					var nextChainID = nextWordInChainsList[| k];
					if (nextChainID != chainID) {
						show_debug_message("here2");
						scr_deleteFromChainVoidCheck(nextChainID, nextWordID, false);
					}
				}
			}
		}
		
		
		
		
		ds_list_destroy(displayRowList);
		*/
		
	}
	
	
}