function scr_newToken(newTokenStr, refTokenID) {
	/*
		Purpose: Create a new word within the discourse based on user string input
	*/
	


	var refTokenSubMap = global.nodeMap[?refTokenID];
	if(!scr_isNumericAndExists(refTokenSubMap, ds_type_map)){ exit; }
	
	var newDiscourseTokenSeq = refTokenSubMap[?"discourseTokenSeq"];
	var newTokenSeq = refTokenSubMap[?"tokenSeq"];
	var newDisplayCol = refTokenSubMap[?"displayCol"];
	
	if(obj_control.before){
		newDiscourseTokenSeq -= 1;
		newTokenSeq -= 1;
		newDisplayCol -= 1;
	}
	else{
		newDiscourseTokenSeq += 1;
		newTokenSeq += 1;
		newDisplayCol += 1;
	}
	
	var unitID = refTokenSubMap[?"unit"];	
	var unitSubMap = global.nodeMap[?unitID];
	
	//create new token Node
	var newTokenID = scr_createTokenNode(newDiscourseTokenSeq, newTokenStr,newTokenSeq,newDisplayCol, unitID);
	
	

	
	var unitEntryList = unitSubMap[?"entryList"];
	var indexToAdd = -1;
	
	var sizeOfEntryList = ds_list_size(unitEntryList);
	
	for(var i = 0; i < sizeOfEntryList ; i ++){
		var entrySubMap = global.nodeMap[?unitEntryList[|i]];
		if(refTokenID == entrySubMap[?"token"]){
			indexToAdd = i;
		}
	}
	
	// make entry node
	var currentEntryNode = scr_addToNodeMap("entry");
	var currentEntrySubMap = global.nodeMap[? currentEntryNode];
	ds_map_add(currentEntrySubMap, "token", newTokenID);
	ds_map_add(currentEntrySubMap, "unit", unitID);
	
	//inserting entry node into unit's entry list
	ds_list_insert(unitEntryList,indexToAdd,currentEntryNode);
	
	
	
	var discourseSubMap = global.nodeMap[?global.discourseNode];
	var tokenList = discourseSubMap[?"tokenList"];
	var indexOfToken = ds_list_find_index(tokenList, refTokenID);
		
	if(obj_control.before){
		indexOfToken -= 1;
	}
	else{
		indexOfToken += 1;
	}
	
	//inserting token node into discourse node's token list
	ds_list_insert(tokenList, indexOfToken, newTokenID);
	
	
	var indexOfNextToken = ds_list_find_index(tokenList, newTokenID)+1;
	var sizeOfTokenList = ds_list_size(tokenList);
	for( var j = indexOfNextToken; j < sizeOfTokenList ; j++){
		var currentTokenSubMap = global.nodeMap[?tokenList[|j]];
		var currentUnitID = currentTokenSubMap[?"unit"];
		
		if(unitID == currentUnitID){
			currentTokenSubMap[?"tokenSeq"] ++;
		}
		
		currentTokenSubMap[?"discourseTokenSeq"] ++;
		
	}
	
/*
	
	var displayRow = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayRow, targetWord - 1);
	var lineWordIDList = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colWordIDList, displayRow);
	wordSeq = ds_list_find_index(lineWordIDList, targetWord) - 1;


	// Safety check
	if (unitID == -1 or obj_control.gridView or obj_control.currentActiveLineGrid == obj_control.searchGrid) {
		exit;
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
		var currentWordID = wordIDListLineGrid[| i];
		var currentWordSeq = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordSeq, currentWordID - 1);
		var currentDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 1);
	
		ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colWordSeq, currentWordID - 1, currentWordSeq + 1);	
		ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 1, currentDisplayCol + 1);
	
	}


	// Aquire the newly set wordID list in the Unit Grid 
	var wordIDListUnitGrid = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colWordIDList, unitID - 1);


	// If the filter is active, refresh the FilterGrid to contain the newWord
	if(obj_control.filterGridActive) {
		obj_toolPane.newWordInFilter = true;
		with (obj_control) {
			scr_renderFilter2();
		}
	}
	
	
	// loop through the wordIDList for this line and check if there are any chains that should be aligned
	var alignChainList = ds_list_create();
	for (var i = 0; i < wordIDListLineGridSize; i++) {
		var currentWord = wordIDListLineGrid[| i];
		var currentWordInChainsList = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInChainList, currentWord - 1);
		if (scr_isNumericAndExists(currentWordInChainsList, ds_type_list)) {
			var currentWordInChainsListSize = ds_list_size(currentWordInChainsList);
			for (var j = 0; j < currentWordInChainsListSize; j++) {
				var currentWordInChain = currentWordInChainsList[| j];
				var currentWordInChainSubMap = global.nodeMap[? currentWordInChain];
				if (scr_isNumericAndExists(currentWordInChainSubMap, ds_type_map)) {
					var currentWordInChainAlign = currentWordInChainSubMap[? "alignChain"];
					if (currentWordInChainAlign) {
						if (ds_list_find_index(alignChainList, currentWordInChain) <= 0) {
							ds_list_add(alignChainList, currentWordInChain);
						}
					}
				}
			}
		}
		
		var alignedChunkChain = scr_firstWordInAlignedChunk(currentWord);
		if (alignedChunkChain != "") {
			if (ds_list_find_index(alignChainList, alignedChunkChain) <= 0) {
				ds_list_add(alignChainList, alignedChunkChain);
			}
		}
	}
	show_debug_message("scr_newToken() ... alignChainList: " + scr_getStringOfList(alignChainList));
	
	var alignChainListSize = ds_list_size(alignChainList);
	for (var i = 0; i < alignChainListSize; i++) {
		scr_alignChain2ElectricBoogaloo(alignChainList[| i]);
	}
	
	ds_list_destroy(alignChainList);

	*/
}
