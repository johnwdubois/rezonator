function scr_cliqueDetection() {
	show_debug_message("scr_cliqueDetection, START" + scr_printTime());

	var discourseSubMap = global.nodeMap[? global.discourseNode];
	var unitList = discourseSubMap[? "unitList"];

	var unitListSize = ds_list_size(unitList);

	for (var i = 0; i < unitListSize; i++) {
		var currentUnit = unitList[| i];
		if (ds_list_find_index(obj_chain.encounteredUnitList,currentUnit) == -1) {
			var unitSubMap =  global.nodeMap[? currentUnit];
			var entryList = unitSubMap[? "entryList"];
			
			var entryListSize = ds_list_size(entryList);

			for (var j = 0; j < entryListSize; j++) {
				var entryID = entryList[| j];
				var entrySubMap = global.nodeMap[? entryID];
				var tokenID = entrySubMap[? "token"];
				var tokenSubMap = global.nodeMap[? tokenID];
				var inChainsList = tokenSubMap[? "inChainsList"];
				var inChainsListSize = ds_list_size(inChainsList);
			
				for (var k = 0; k < inChainsListSize; k++) {
					var currentChainID = inChainsList[|k];
					if (ds_list_find_index(global.nodeMap[? "resonanceList"], currentChainID) >= 0) {
						// found rez in unit lets create a clique based off this token
						ds_list_add(obj_chain.encounteredTokenList, tokenID);
					}
				}
				
				var inChunkList = tokenSubMap[? "inChunkList"];
				var inChunkListSize = ds_list_size(inChunkList);
				
				for (var k = 0; k < inChunkListSize; k++) {
					var chunkID =  inChunkList[|k];
					if (scr_getFirstWordOfChunk(chunkID) == tokenID) {
						var chunkSubMap = global.nodeMap[? chunkID];
						var chunkInChainsList = chunkSubMap[? "inChainsList"];
						var chunkInChainsListSize = ds_list_size(chunkInChainsList);
						for (var l = 0; l < chunkInChainsListSize; l++) {
							var currentChainID = chunkInChainsList[|l];
							if (ds_list_find_index(global.nodeMap[? "resonanceList"], currentChainID) >= 0) {
								// found rez in unit lets create a clique based off this token
								ds_list_add(obj_chain.encounteredTokenList, tokenID);
							}
						}
					}
				}

			}
			scr_cliqueGeneration();
		}
	}
	ds_list_clear(obj_chain.encounteredUnitList);
	obj_chain.cliqueCount = 0;
	
	show_debug_message("scr_cliqueDetection, END" + scr_printTime());
}