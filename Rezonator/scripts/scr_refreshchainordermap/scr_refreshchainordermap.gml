function scr_refreshChainOrderMap(cliqueID) {
	
	show_debug_message("scr_refreshChainOrderMap, cliqueID: " + string(cliqueID));
	var cliqueSubMap = global.cliqueMap[? cliqueID];
	if (scr_isNumericAndExists(cliqueSubMap, ds_type_map)) {
		var chainList = cliqueSubMap[? "chainList"];
		
		show_debug_message("scr_refreshChainOrderMap, chainList: " + scr_getStringOfList(chainList));
		if (scr_isNumericAndExists(chainList, ds_type_list)) {
			
			// put all chainOrderMap data in its own submap
			var chainOrderMap = cliqueSubMap[? "chainOrderMap"];
			if (scr_isNumericAndExists(chainOrderMap, ds_type_map)) {
				scr_mapDeepDestroy(chainOrderMap);
				ds_map_delete(cliqueSubMap, "chainOrderMap");
			}
			chainOrderMap = ds_map_create();
			ds_map_add_map(cliqueSubMap, "chainOrderMap", chainOrderMap);
				
			// loop over the chain list for this clique
			var chainListSize = ds_list_size(chainList);
			for (var j = 0; j < chainListSize; j++) {
				
				// create a chainOrderList for this chain, put that list in the chainOrderMap
				var currentChain = chainList[| j];
				var currentChainOrderList = ds_list_create();
				ds_map_add_list(chainOrderMap, currentChain, currentChainOrderList);
				
				// get some data for this chain
				var currentChainSubMap = global.nodeMap[? currentChain];
				var currentChainSetIDList = currentChainSubMap[? "setIDList"];
				var currentChainSetIDListSize = ds_list_size(currentChainSetIDList);
					
				// loop over every entry in this chain to see what it will push
				for (var k = 0; k < currentChainSetIDListSize; k++) {
						
					var currentEntry = currentChainSetIDList[| k];
					var currentEntrySubMap = global.nodeMap[? currentEntry];
					var currentToken = currentEntrySubMap[? "token"];
					if (scr_isChunk(currentToken)) currentToken = scr_getFirstWordOfChunk(currentToken);
					var currentTokenSubMap = global.nodeMap[? currentToken];
					if (!scr_isNumericAndExists(currentTokenSubMap, ds_type_map)) continue;
					var currentUnit = currentTokenSubMap[? "unit"];
					var currentUnitSubMap = global.nodeMap[? currentUnit];
					var currentUnitEntryList = currentUnitSubMap[? "entryList"];
					var currentUnitEntryListSize = ds_list_size(currentUnitEntryList);
					var currentTokenSeq = currentTokenSubMap[? "tokenOrder"];
						
					if (currentEntrySubMap[? "stretch"]) continue;
						
						
					// check if there is a token in the chain that will be pushed by this chain
					var startJustify = scr_checkNativeJustification();
					var l = startJustify ? currentTokenSeq : currentTokenSeq - 2; // subtract 2 for end-justify because tokenSeq is 1 indexed
					var repeatAmount = 0;
					if (startJustify) repeatAmount = currentUnitEntryListSize - currentTokenSeq;
					else repeatAmount = currentUnitEntryListSize - (currentUnitEntryListSize - (currentTokenSeq - 1));

					repeat(repeatAmount) {
							
						if ((startJustify && l < currentTokenSeq) || (!startJustify && l > currentTokenSeq)) {
							l += startJustify ? 1 : -1;
							continue;
						}
							
							
						var breakLoop = false;
						var _currentEntry = currentUnitEntryList[| l];
						var _currentEntrySubMap = global.nodeMap[? _currentEntry];
						var _currentToken = _currentEntrySubMap[? "token"];
						var _currentTokenSubMap = global.nodeMap[? _currentToken];
						var _currentInChainsList = _currentTokenSubMap[? "inChainsList"];
						var _currentInChainsListSize = ds_list_size(_currentInChainsList);
							
						var currentInChunkList = _currentTokenSubMap[? "inChunkList"];
						var currentInChunkListSize = ds_list_size(currentInChunkList);
							
						// check everything in this token's inChainsList to see if it is a rezChain
						for (var m = 0; m < _currentInChainsListSize; m++) {
							var _currentChain = _currentInChainsList[| m];
							// make sure our original chain is not finding itself (side-links)
							show_debug_message("_currentChain: " + string(_currentChain));
							if (!scr_checkSideLink(_currentChain, _currentToken)) {
								show_debug_message("not a side link!");
								var _currentChainSubMap = global.nodeMap[? _currentChain];
								if (_currentChainSubMap[? "type"] == "resonance") {
									show_debug_message("resonance!");
									if (!_currentEntrySubMap[? "stretch"]) {
										show_debug_message("no stretch!");
										scr_addToListOnce(currentChainOrderList, _currentChain);
										breakLoop = true;
									}
								}
							}
						}
							
						
						for (var m = 0; m < currentInChunkListSize; m++) {
							var currentChunk = currentInChunkList[| m];
							if (scr_getFirstWordOfChunk(currentChunk) == _currentToken) {
								var currentChunkSubMap = global.nodeMap[? currentChunk];
								var currentChunkInChainsList = currentChunkSubMap[? "inChainsList"];
								var currentChunkInChainsListSize = ds_list_size(currentChunkInChainsList);
										
								// check everything in this chunk's inChainsList to see if it is in a rezChain
								for (var n = 0; n < currentChunkInChainsListSize; n++) {
										
									var chunksCurrentChain = currentChunkInChainsList[| n];
									var chunksCurrentChainSubMap = global.nodeMap[? chunksCurrentChain];
									if (!scr_checkSideLink(chunksCurrentChain, _currentToken)) {
										if (chunksCurrentChainSubMap[? "type"] == "resonance") {
											if (!_currentEntrySubMap[? "stretch"]) {
												scr_addToListOnce(currentChainOrderList, chunksCurrentChain);
												breakLoop = true;
											}	
										}
									}
								}
							}
						}
							
							
							

							
							
						// continue through unit
						l += startJustify ? 1 : -1;
							
						if (breakLoop) break;
					}
				}
			}
		}
	}

}