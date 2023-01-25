

function scr_getTokensOfChain(chainID) {
	var tokenList = ds_list_create();
	if (ds_map_exists(global.nodeMap, chainID) && chainID != "") {	
		
		var currentFocusedChainMap = global.nodeMap[? chainID];
		var currentChainType = currentFocusedChainMap[? "type"];
		
		if (currentChainType == "stack") {
			var currentChainStackList = currentFocusedChainMap[? "setIDList"];
			for (var i = 0; i < ds_list_size(currentChainStackList); i++) {
				var stackSubMap  = global.nodeMap[? currentChainStackList[| i]];
				var unitSubMap  = global.nodeMap[? stackSubMap[? "unit"]];
				var entryList = unitSubMap[? "entryList"];
				for (var j = 0; j < ds_list_size(entryList); j++) {
					var entrySubMap = global.nodeMap[? entryList[|j]];
					ds_list_add(tokenList, entrySubMap[? "token"]);
				}
			}
		}
		else{
			ds_list_copy(tokenList, scr_getChainTempList(chainID, false));
		}
		
	}
	return tokenList;
}