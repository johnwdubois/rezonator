function scr_cliqueCheckChain(chain, cliqueChainList, cliqueUnitList){
	
	var discoveredUnitList = ds_list_create();
	var chainSubMap = global.nodeMap[? chain];
	var setIDList = chainSubMap[? "setIDList"];
	var setIDListSize = ds_list_size(setIDList);
	for (var i = 0; i < setIDListSize; i++) {
		var currentEntry = setIDList[| i];
		var currentEntrySubMap = global.nodeMap[? currentEntry];
		var currentToken = currentEntrySubMap[? "token"];
		var currentTokenSubMap = global.nodeMap[? currentToken];
		
		// the token could actually be a chunk, either way we need to get the unit its on
		var currentUnit = "";
		var currentTokenType = currentTokenSubMap[? "type"];
		if (currentTokenType == "token") {
			currentUnit = currentTokenSubMap[? "unit"];
		}
		else if (currentTokenType == "chunk") {
			var chunkFirstToken = scr_getFirstWordOfChunk(currentToken);
			var chunkFirstTokenSubMap = global.nodeMap[? chunkFirstToken];
			currentUnit = chunkFirstTokenSubMap[? "unit"];
		}
	
		if (ds_list_find_index(cliqueUnitList, currentUnit) == -1) {
			ds_list_add(cliqueUnitList, currentUnit);
			ds_list_add(discoveredUnitList, currentUnit);
		}
	}
	
	var discoveredUnitListSize = ds_list_size(discoveredUnitList);
	for (var i = 0; i < discoveredUnitListSize; i++) {
		var currentUnit = discoveredUnitList[| i];
		scr_cliqueCheckUnit(currentUnit, cliqueChainList, cliqueUnitList);
	}
	ds_list_destroy(discoveredUnitList);
	

}