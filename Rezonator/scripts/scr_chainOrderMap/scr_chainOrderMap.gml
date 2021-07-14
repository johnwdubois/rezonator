// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_chainOrderMap(){
	
	show_debug_message("scr_chainOrderMap, START" + scr_printTime());
	
	var cliqueList = obj_chain.cliqueList;
	var cliqueListSize = ds_list_size(cliqueList);
	var cliqueMap = global.nodeMap[? "cliqueMap"];
	
	// loop over every clique
	for (var i = 0; i < cliqueListSize; i++) {
		
		// get current clique & it's chain list
		var currentClique = cliqueList[| i];
		var currentCliqueSubMap = cliqueMap[? currentClique];
		if (scr_isNumericAndExists(currentCliqueSubMap, ds_type_map)) {
			var currentChainList = currentCliqueSubMap[? "chainList"];
			if (scr_isNumericAndExists(currentChainList, ds_type_list)) {
				
				// loop over the chain list for this clique
				var currentChainListSize = ds_list_size(currentChainList);
				for (var j = 0; j < currentChainListSize; j++) {
					
					var currentChain = currentChainList[| j];
					var currentChainOrderList = ds_list_create();
					ds_map_add_list(currentCliqueSubMap, currentChain, currentChainOrderList);
					
					var currentChainSubMap = global.nodeMap[? currentChain];
					var currentChainSetIDList = currentChainSubMap[? "setIDList"];
					var currentChainSetIDListSize = ds_list_size(currentChainSetIDList);
					
					// loop over every entry in this chain to see what it will push
					for (var k = 0; k < currentChainSetIDListSize; k++) {
						
						var currentEntry = currentChainSetIDList[| k];
						var currentEntrySubMap = global.nodeMap[? currentEntry];
						var currentToken = currentEntrySubMap[? "token"];
						var currentTokenSubMap = global.nodeMap[? currentToken];
						var currentUnit = currentTokenSubMap[? "unit"];
						var currentUnitSubMap = global.nodeMap[? currentUnit];
						var currentUnitEntryList = currentUnitSubMap[? "entryList"];
						var currentUnitEntryListSize = ds_list_size(currentUnitEntryList);
						var currentTokenSeq = currentTokenSubMap[? "tokenSeq"];
						
						// check if there is a token in the chain that will be pushed by this chain
						for (var l = currentTokenSeq; l < currentUnitEntryListSize; l++) {
							
							var breakLoop = false;
							var _currentEntry = currentUnitEntryList[| l];
							var _currentEntrySubMap = global.nodeMap[? _currentEntry];
							var _currentToken = _currentEntrySubMap[? "token"];
							var _currentTokenSubMap = global.nodeMap[? _currentToken];
							var _currentInChainsList = _currentTokenSubMap[? "inChainsList"];
							var _currentInChainsListSize = ds_list_size(_currentInChainsList);
							
							// check everything in this token's inChainsList to see if it is a rezChain
							for (var m = 0; m < _currentInChainsListSize; m++) {
								var _currentChain = _currentInChainsList[| m];
								var _currentChainSubMap = global.nodeMap[? _currentChain];
								if (_currentChainSubMap[? "type"] == "rezChain") {
									scr_addToListOnce(currentChainOrderList, _currentChain);
									breakLoop = true;
								}
							}
							
							if (breakLoop) break;
						}
					}
				}
			}
		}
	}
	
	show_debug_message("scr_chainOrderMap, END" + scr_printTime());


}