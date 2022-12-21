

function scr_createTreeFromStack(chainID){
	
	show_debug_message("scr_createTreeFromStack, chainID: " + string(chainID));

	var chainSubMap = global.nodeMap[? chainID];
	if (scr_isNumericAndExists(chainSubMap, ds_type_map)) {
		var tokenList = ds_list_create();
		var setIDList = chainSubMap[? "vizSetIDList"];
		var setIDListSize = ds_list_size(setIDList);
		show_debug_message("setIDListSize:   "+ string(setIDListSize));
		for (var i = 0; i < setIDListSize; i++) {
			var currentChainEntry = setIDList[| i];
			var currentEntrySubMap = global.nodeMap[? currentChainEntry];
							
			var currentUnit = currentEntrySubMap[? "unit"];
			var unitSubMap = global.nodeMap[? currentUnit];
							
			var entryList = unitSubMap[? "entryList"];
			var entryListSize = ds_list_size(entryList);
			show_debug_message("entryListSize:   "+ string(entryListSize));
			for (var j = 0; j < entryListSize; j++) {
				var currentEntry = entryList[| j];
				var currentEntrySubMap = global.nodeMap[? currentEntry];
				var currentToken = currentEntrySubMap[? "token"];
				ds_list_add(tokenList, currentToken);
			}
							
		}
		scr_createTree(tokenList);	
	}

}