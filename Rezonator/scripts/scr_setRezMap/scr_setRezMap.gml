function scr_setRezMap(stackID, par) {

	var chainMap = ds_map_create();
	var stackSubMap = global.nodeMap[?stackID];
	if (!scr_isNumericAndExists(stackSubMap, ds_type_map)) {exit;}

	var unitList = scr_getChainTempList(stackID,true);
	
	var unitListSize = ds_list_size(unitList);
	
	for (var i = 0; i < unitListSize; i++) {
	
		var currentUnit = unitList[|i];
		var currentUnitSubMap = global.nodeMap[?currentUnit];
		var entryList = currentUnitSubMap[? "entryList"];
		if (!scr_isNumericAndExists(entryList, ds_type_list)) {exit;}
		var entryListSize = ds_list_size(entryList);

		for (var j = 0; j < entryListSize; j++) {
			var currentEntry = entryList[|j];
			var currentEntrySubMap = global.nodeMap[?currentEntry];
			var currentToken = currentEntrySubMap[? "token"];
			
			var currentTokenSubMap = global.nodeMap[?currentToken];
			
			var tagMap = currentTokenSubMap[? "tagMap"];
			var displayString = tagMap[?global.displayTokenField];
			var inChainsList = currentTokenSubMap[? "inChainsList"];
			var inChainsListSize = ds_list_size(inChainsList);
			for (var k = 0; k < inChainsListSize; k++) {
			
				var currentChainID = inChainsList[|k];
				
				if (ds_map_exists(chainMap,currentChainID)) {
					var chainList = chainMap[?currentChainID];
					scr_addToListOnce(chainList, displayString)
				}
				else{
					var newList = ds_list_create();
					ds_list_add(newList, displayString)
					ds_map_add_list(chainMap, currentChainID, newList);
				}
			}			
		}		
	}
	
	var chainMapSize = ds_map_size(chainMap);
	var tokenMap = ds_map_create();
	var key = ds_map_find_first(chainMap);
	
	var totalScore = 0;
	
	repeat(chainMapSize) {
		
		var chainList = chainMap[?key];
		var chainSubMap = global.nodeMap[?key];
		
		var chainListSize = ds_list_size(chainList);
		
		for (var i = 0; i < chainListSize; i++) {
			
			var currentToken = chainList[|i];
			if (!ds_map_exists(tokenMap,currentToken)) {
				var tokenList = ds_list_create();
				ds_list_add(tokenList,currentToken);
				ds_map_add_list(tokenMap,currentToken,tokenList);
			}
			else{
				var tokenList = tokenMap[?currentToken];
			}
			
			for (var j = 0; j < chainListSize; j++) {	
				var currentTokenToAdd = chainList[|j];
				if (j == i) {continue;}
				scr_addToListOnce(tokenList,currentTokenToAdd);
			}
			
		}
		
		var entryList = chainSubMap[? "setIDList"];
		
		var entryListSize = ds_list_size(entryList);
		totalScore += power(entryListSize,2);
		
		key = ds_map_find_next(chainMap, key);
	
	}
	
	
	
	// if this stack already has a rezmap, we'll destroy that one
	if (ds_map_exists(stackSubMap, "rezMap")) {
		var oldRezMap = stackSubMap[? "rezMap"];
		if (scr_isNumericAndExists(oldRezMap, ds_type_map)) {
			ds_map_destroy(oldRezMap);
		}
		ds_map_delete(stackSubMap, oldRezMap);
	}
	
	// add new rez map to this stack
	ds_map_add_map(stackSubMap, "rezMap", tokenMap);
	ds_map_add(stackSubMap, "par", par);
	ds_map_add(stackSubMap, "totalScore", totalScore);
	ds_map_add(stackSubMap, "movesMade", 0);
	
	// delete all rez chains in this stack
	/*
	var stackUnitList = scr_getChainTempList(stackID, false);
	var deleteChainList = ds_list_create();
	var rezList = global.nodeMap[? "resonanceList"];
	var rezListSize = ds_list_size(rezList);
	for (var i = 0; i < rezListSize; i++) {
		var currentRezChain = rezList[| i];
		var currentRezChainSubMap = global.nodeMap[? currentRezChain];
		if (scr_isNumericAndExists(currentRezChainSubMap, ds_type_map)) {
			var setIDList = currentRezChainSubMap[? "setIDList"];
			var setIDListSize = ds_list_size(setIDList);
			for (var j = 0; j < setIDListSize; j++) {
				var currentRezEntry = setIDList[| j];
				var currentRezEntrySubMap = global.nodeMap[? currentRezEntry];
				if (scr_isNumericAndExists(currentRezEntrySubMap, ds_type_map)) {
					var currentRezEntryToken = currentRezEntrySubMap[? "token"];
					var currentRezEntryTokenSubMap = global.nodeMap[? currentRezEntryToken];
					if (scr_isNumericAndExists(currentRezEntryTokenSubMap, ds_type_map)) {
						var currentRezEntryUnit = currentRezEntryTokenSubMap[? "unit"];
						if (ds_list_find_index(stackUnitList, currentRezEntryUnit) >= 0) {
							scr_addToListOnce(deleteChainList, currentRezChain);
						}
					}
				}
			}
		}
	}
	show_debug_message("deleteChainList: " + scr_getStringOfList(deleteChainList));
	scr_deleteAllChains(deleteChainList);
	ds_list_destroy(deleteChainList);
	ds_list_destroy(stackUnitList);
	*/

	
}