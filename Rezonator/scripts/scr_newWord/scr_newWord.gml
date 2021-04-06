function scr_newWord(unitID, wordSeq, wordTranscript, targetWord) {
	/*
		Purpose: Create a new word within the discourse based on user string input
	*/

	
	var displayRow = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayRow, targetWord - 1);
	var lineWordIDList = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colWordIDList, displayRow);
	wordSeq = ds_list_find_index(lineWordIDList, targetWord) - 1;


	// Safety check
	if (unitID == -1 or obj_control.gridView or obj_control.currentActiveLineGrid == obj_control.searchGrid) {
		exit;
	}


	// Ask the user for the new word, if this is not a chunk
	if(argument_count == 5) {
		// If it is a Chunk, combine the words within the Chunk for the transcript
		var chunkID = argument[4];
		var currentChunkRow = chunkID - 1;
		if(currentChunkRow < 0) {
			exit;
		}
		var chunkWordIDList = ds_grid_get(obj_chain.chunkGrid, obj_chain.chunkGrid_colBoxWordIDList, currentChunkRow);
		wordTranscript = "";
		var chunkWordIDListSize = ds_list_size(chunkWordIDList);
		for(var transcriptLoop = 0; transcriptLoop < chunkWordIDListSize; transcriptLoop++) {
			var chunkWordID = ds_list_find_value(chunkWordIDList, transcriptLoop);
			var currentWordState = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, chunkWordID - 1);
	
			// Check if the word is a ChunkWord
			if(currentWordState == obj_control.wordStateChunk) {
				continue;
			}
			wordTranscript += (string(ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordToken, chunkWordID - 1)) + " ");
		}
	}
	// Set the word's token
	var wordToken = wordTranscript;

	if (string_length(wordTranscript) < 1) {
		exit;
	}

	obj_control.moveCounter++;



	if(obj_control.wordView == 2){
		var tokenColIndex = ds_list_find_value(obj_control.currentDisplayTokenColsList, obj_control.wordView-2);
	}
	else{				
		var tokenColIndex = ds_list_find_value(obj_control.currentDisplayTokenColsList, obj_control.wordView-3);
	}

	// Set the WordGrid to take in the new word
	ds_grid_resize(obj_control.wordGrid, obj_control.wordGridWidth, ds_grid_height(obj_control.wordGrid) + 1);
	var currentRowWordGrid = ds_grid_height(obj_control.wordGrid) - 1;

	ds_grid_resize(global.tokenImportGrid, global.tokenImportGridWidth, ds_grid_height(global.tokenImportGrid) + 1);
	var currentRowTokenImportGrid = ds_grid_height(global.tokenImportGrid) - 1;

	var wordID = ds_grid_height(obj_control.wordGrid);
	var utteranceID = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colUtteranceID, unitID - 1);

	// Fill in the new row of the WordGrid
	ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colWordID, currentRowWordGrid, wordID);
	ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colWID, currentRowWordGrid, wordID);
	ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colUnitID, currentRowWordGrid, unitID);
	ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colUtteranceID, currentRowWordGrid, utteranceID);
	ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colWordSeq, currentRowWordGrid, wordSeq + 1);
	ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colWordToken, currentRowWordGrid, wordToken);
	ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colWordTranscript, currentRowWordGrid, wordTranscript);
	ds_grid_set(global.tokenImportGrid, global.tokenImport_colTokenID, currentRowTokenImportGrid, wordID);
	ds_grid_set(global.tokenImportGrid, global.tokenImport_colUnitID, currentRowTokenImportGrid, unitID);
	ds_grid_set(global.tokenImportGrid, global.tokenImport_colWordToken, currentRowTokenImportGrid, wordToken);
	ds_grid_set(global.tokenImportGrid, global.tokenImport_colWordTranscript, currentRowTokenImportGrid, wordTranscript);

	for(var i = 4; i < global.tokenImportGridWidth; i++ ){
		//if(ds_grid_get(global.tokenImportGrid, i, currentRowTokenImportGrid) == undefined){
		//	ds_grid_set(global.tokenImportGrid, i, currentRowTokenImportGrid,"");
		//}
		//if(i == tokenColIndex){
			ds_grid_set(global.tokenImportGrid, i, currentRowTokenImportGrid,wordToken);
		//}
	}

	// Fill in the new row of the DynamicWordGrid
	scr_loadDynamicWordGridIndividual(ds_grid_height(obj_control.wordGrid) - 1);

	// Designate the new word as a new word or a Chunk word
	if(argument_count == 4) {
		ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, ds_grid_height(obj_control.dynamicWordGrid) - 1, obj_control.wordStateNew);
	}
	else {
		ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, ds_grid_height(obj_control.dynamicWordGrid) - 1, obj_control.wordStateChunk);
	}

	var rowInLineGrid = displayRow;//ds_grid_value_y(obj_control.lineGrid, obj_control.lineGrid_colUnitID, 0, obj_control.lineGrid_colUnitID, ds_grid_height(obj_control.lineGrid), unitID);
	if (rowInLineGrid < 0 or rowInLineGrid >= ds_grid_height(obj_control.lineGrid)) {
		exit;
	}
	
	

	var wordIDListLineGrid = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colWordIDList, rowInLineGrid);
	ds_list_insert(wordIDListLineGrid, wordSeq + 1, wordID);
	
	ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colWordIDList, unitID - 1, wordIDListLineGrid);



	var wordIDListLineGridSize = ds_list_size(wordIDListLineGrid);
	for (var i = wordSeq + 2; i < wordIDListLineGridSize; i++) {
		var currentWordID = ds_list_find_value(wordIDListLineGrid, i);
		var currentWordSeq = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordSeq, currentWordID - 1);
		var currentDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 1);
	
		ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colWordSeq, currentWordID - 1, currentWordSeq + 1);	
		ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 1, currentDisplayCol + 1);
	
	}


	// Aquire the newly set wordID list in the Unit Grid 
	var wordIDListUnitGrid = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colWordIDList, unitID - 1);

	// THIS ONLY WORKS FOR CHUNKS
	// Check the wordID right before the new word, if it is not at the end of a line we check to see if it is in a box
	if (ds_list_find_index(wordIDListUnitGrid,wordID) != (ds_list_size(wordIDListUnitGrid) - 1) || argument_count == 5) {
	
		// Find the ID of the word in front of the new word
		var prevWordID = ds_list_find_value(wordIDListUnitGrid, ds_list_find_index(wordIDListUnitGrid,wordID) - 1);
		if (prevWordID != undefined) {
		
			// Access the inchunkList from the dynWordGrid
			var prevInChunkList = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInBoxList, prevWordID - 1);
		
			// For each chunk the prev word is in, check if the prev word is not the last word in the chunk
			/*
			var prevInChunkListSize = ds_list_size(prevInChunkList);
			for(var chunkListLoop = 0; chunkListLoop < prevInChunkListSize; chunkListLoop++) {

			
				var currentChunkID = ds_list_find_value(prevInChunkList, chunkListLoop);
				var currentChunkRow = currentChunkID - 1;
				if(currentChunkRow < 0) {
					exit;
				}
				var currentChunkWordList = ds_grid_get(obj_chain.chunkGrid, obj_chain.chunkGrid_colBoxWordIDList, currentChunkRow);
				var newWordState = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, wordID - 1);

				// Allow nesting chunks to be apended
				if (newWordState == obj_control.wordStateChunk || ds_list_find_index(currentChunkWordList, prevWordID) != (ds_list_size(currentChunkWordList) - 1)) {

					// Add new word into that chunk list, and add to the new word's inChunkList
					ds_list_add(currentChunkWordList, wordID);
					var currentChunkInBoxList = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInBoxList, wordID - 1);
					ds_list_add(currentChunkInBoxList, currentChunkID);
				}
			}
			*/
		}
	}

	// If the filter is active, refresh the FilterGrid to contain the newWord
	if(obj_control.filterGridActive) {
		obj_toolPane.newWordInFilter = true;
		with (obj_control) {
			scr_renderFilter();
		}
	}


}
