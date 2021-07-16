// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_checkSideLink(chainID, tokenID){
	
	var tokenSubMap = global.nodeMap[? tokenID];
	if (scr_isNumericAndExists(tokenSubMap, ds_type_map)) {
		var unit = tokenSubMap[? "unit"];
		var unitSubMap = global.nodeMap[? unit];
		if (scr_isNumericAndExists(unitSubMap, ds_type_map)) {
			
			var entryList = unitSubMap[? "entryList"];
			if (scr_isNumericAndExists(entryList, ds_type_list)) {
				
				
				
				for (var i = 0; i < entryList; i++) {
					
					var currentEntry = entryList[| i];
					var currentEntrySubMap = global.nodeMap[? currentEntry];
					var currentToken = currentEntrySubMap[? "token"];
					var currentTokenSubMap = global.nodeMap[? currentToken];
					var currentInChainsList = currentTokenSubMap[? "inChainsList"];
					
					// not a side link, return false
					if (currentToken == tokenID) {
						return false;
					}
					else {
					
						var currentInChainsListSize = ds_list_size(currentInChainsList);
						for (var j = 0; j < currentInChainsListSize; j++) {
							// side link found
							var currentChain = currentInChainsList[| j];
							if (chainID == currentChain) {
								
								// find the original token in the original chain and mark that entry as a stretch
								var chainSubMap = global.nodeMap[? chainID];
								var chainEntryList = chainSubMap[? "setIDList"];
								var chainEntryListSize = ds_list_size(chainEntryList);
								for (var k = 0; k < chainEntryListSize; k++) {
									var currentChainEntry = chainEntryList[| k];
									var currentChainEntrySubMap = global.nodeMap[? currentChainEntry];
									var currentChainEntryToken = currentChainEntrySubMap[? "token"];
									if (currentChainEntryToken == tokenID) {
										currentChainEntrySubMap[? "stretch"] = true;
									}
								}
								
								// side link found, return true
								return true;
							}
						}
					}
				}
			}
		}
	}
	
}