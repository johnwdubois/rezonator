function scr_cliqueCheckUnit(unit, cliqueChainList, cliqueUnitList){

	var unitSubMap = global.nodeMap[? unit];
	var unitEntryList = unitSubMap[? "entryList"];
	var unitEntryListSize = ds_list_size(unitEntryList);

	var discoveredChainsList = ds_list_create();
	for (var i = 0; i < unitEntryListSize; i++) {
		var currentEntry = unitEntryList[| i];
		var currentEntrySubMap = global.nodeMap[? currentEntry];
		var currentToken = currentEntrySubMap[? "token"];
		var currentTokenSubMap = global.nodeMap[? currentToken];
		var currentInChainsList = currentTokenSubMap[? "inChainsList"];
		
		var currentInChainsListSize = ds_list_size(currentInChainsList);
		for (var j = 0; j < currentInChainsListSize; j++) {
			var currentChain = currentInChainsList[| j];
			var currentChainSubMap = global.nodeMap[? currentChain];
			var currentChainType = currentChainSubMap[? "type"];
			if (currentChainType == "resonance" && ds_list_find_index(cliqueChainList, currentChain) == -1) {
				ds_list_add(cliqueChainList, currentChain);
				ds_list_add(discoveredChainsList, currentChain);
			}
		}
	}
	
	
	
	var discoveredChainsListSize = ds_list_size(discoveredChainsList);
	for (var i = 0; i < discoveredChainsListSize; i++) {
		var currentChain = discoveredChainsList[| i];
		scr_cliqueCheckChain(currentChain, cliqueChainList, cliqueUnitList);
	}
	ds_list_destroy(discoveredChainsList);
	
	
}