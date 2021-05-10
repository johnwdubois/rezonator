// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_exportChainEntryGrid(chainList, headerList){
	
	show_debug_message("scr_exportChainEntryGrid ... headerList: " + scr_getStringOfList(headerList));
	
	if (!instance_exists(obj_chain) || !instance_exists(obj_control)) {
		exit;
	}
	
	// create entryGrid
	var gridWidth = ds_list_size(headerList);
	var grid = ds_grid_create(gridWidth, 0);
	
	// get chainListSize
	var chainListSize = ds_list_size(chainList);
	
	// make temp grid to sort trackChains based on their first token's unitSeq and tokenSeq
	var tempGrid_colChainID = 0;
	var tempGrid_colUnitSeq = 1;
	var tempGrid_colTokenSeq = 2;
	var tempGrid = ds_grid_create(3, chainListSize);
	
	// get the chain value
	for (var i = 0; i < chainListSize; i++) {
		
		var currentChain = chainList[| i];
		var currentChainSubMap = global.nodeMap[? currentChain];
		
		// go through the current track's vizSetIDList and determine which token is earliest in the timeline
		var vizSetIDList = currentChainSubMap[? "vizSetIDList"];
		var earliestTokenID = "";
		
		// the earliest token should be the linked by the first entry in the vizSetIDList
		if (ds_list_size(vizSetIDList) > 0) {
			var firstEntry = vizSetIDList[| 0];
			var firstEntrySubMap = global.nodeMap[? firstEntry];
			var firstEntryToken = firstEntrySubMap[? "token"];
			if (scr_isChunk(firstEntryToken)) {
				earliestTokenID = scr_getFirstWordOfChunk(firstEntryToken);
			}
			else {
				earliestTokenID = firstEntryToken;
			}
		}
		
		// by now, we should know what this chain's earliest token in the timeline is
		// so we can put that data into our tempGrid so that we can sort on it after
		var earliestTokenSubMap = global.nodeMap[? earliestTokenID];
		var earliestUnitSeq = earliestTokenSubMap[? "unit"];
		var earliestTokenSeq = earliestTokenSubMap[? "tokenSeq"];
		ds_grid_set(tempGrid, tempGrid_colChainID, i, currentChain);
		ds_grid_set(tempGrid, tempGrid_colUnitSeq, i, earliestUnitSeq);
		ds_grid_set(tempGrid, tempGrid_colTokenSeq, i, earliestTokenSeq);
	}
	
	
	// at this point, the tempGrid will be in the same order as the chainList
	// but we want it to be sorted by discourse time, so....
	// we sort the tempGrid based on 1) unitSeq and then 2) tokenSeq
	scr_gridMultiColSort(tempGrid, tempGrid_colUnitSeq, true, tempGrid_colTokenSeq, true);
	
	// get sorted list of chains
	var chainSeqList = ds_list_create();
	var tempGridHeight = ds_grid_height(tempGrid);
	for (var i = 0; i < tempGridHeight; i++) {
		var currentChain = ds_grid_get(tempGrid, tempGrid_colChainID, i);
		ds_list_add(chainSeqList, currentChain);
	}
	show_debug_message("scr_exportChainEntryGrid() ... chainSeqList: " + scr_getStringOfList(chainSeqList));
	
	ds_grid_destroy(tempGrid);
	
	
	
	
	
	
	
	
	// loop through the sorted list of chains and fill up entryGrid
	var chainSeqListSize = ds_list_size(chainSeqList);
	for (var i = 0; i < chainSeqListSize; i++) {
		
		// get current chain and its name
		var currentChain = chainSeqList[| i];
		var currentChainSubMap = global.nodeMap[? currentChain];
		
		if (!scr_isNumericAndExists(currentChainSubMap, ds_type_map)) continue;
		var currentChainName = currentChainSubMap[? "name"];
		
		// get the setList for current chain
		var currentVizSetIDList = currentChainSubMap[? "vizSetIDList"];
		if (!scr_isNumericAndExists(currentVizSetIDList, ds_type_list)) continue;
		
		// loop through setList and get the token values we will want for the entryGrid
		var currentVizSetIDListSize = ds_list_size(currentVizSetIDList);
		for (var j = 0; j < currentVizSetIDListSize; j++) {
		
			// get current entry and its corresponding token and fill up entryGrid
			var currentEntry = currentVizSetIDList[| j];
			var currentEntrySubMap = global.nodeMap[? currentEntry];
			
			// get currentEntry's token and check if its a chunk
			var currentToken = "";
			var isChunk = false;
			var isInChunk = false;
			if (scr_isNumericAndExists(currentEntrySubMap, ds_type_map)) {
				currentToken = currentEntrySubMap[? "token"];
				var currentTokenSubMap = global.nodeMap[? currentToken];
				isChunk = scr_isChunk(currentToken);
				
				// check if this token is in a chunk
				if (!isChunk) {
					var currentTokenInChunkList = currentTokenSubMap[? "inChunkList"];
					var currentTokenInChunkListSize = ds_list_size(currentTokenInChunkList);
					if (currentTokenInChunkListSize > 0) {
						isInChunk = true;
					}
				}
			}
			
			// make a new row for this entry
			scr_exportChainEntryGridNewRow(grid, currentChain, currentChainName, currentEntry, currentToken, i + 1, j + 1, isChunk, "");
			
			// if this is a chunk, then we will loop through all of the tokens in it and give them a new row too!
			if (isChunk) {
				var chunkSubMap = global.nodeMap[? currentToken];
				var chunkTokenList = chunkSubMap[? "tokenList"];
				var chunkTokenListSize = ds_list_size(chunkTokenList);
				for (var k = 0; k < chunkTokenListSize; k++) {
					var currentChunkToken = chunkTokenList[| k];
					scr_exportChainEntryGridNewRow(grid, currentChain, currentChainName, currentEntry, currentChunkToken, i + 1, j + 1, false, currentToken);
				}
			}
		}
	}
	
	ds_list_destroy(chainSeqList);
	
	return grid;
	
}