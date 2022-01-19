// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_treeAllStacks(stackChainList){
	var stackChainListSize = ds_list_size(stackChainList);
	
	for(var i = 0; i < stackChainListSize; i++){
		var tokenList = ds_list_create();
		var stackSubMap = global.nodeMap[? stackChainList[|i]];
		var setIDList = stackSubMap[?"setIDList"];
		var setIDListSize = ds_list_size(setIDList);

		for (var j = 0; j < setIDListSize; j++) {
			var currentChainEntry = setIDList[| j];
			var currentEntrySubMap = global.nodeMap[? currentChainEntry];
							
			var currentUnit = currentEntrySubMap[? "unit"];
							
			var unitSubMap = global.nodeMap[? currentUnit];
							
			var entryList = unitSubMap[? "entryList"];
			var entryListSize = ds_list_size(entryList);

			for (var k = 0; k < entryListSize; k++) {
				var currentEntry = entryList[| k];
				var currentEntrySubMap = global.nodeMap[? currentEntry];
				var currentToken = currentEntrySubMap[? "token"];
				ds_list_add(tokenList, currentToken);
			}
							
		}
		scr_createTree(tokenList);
	}
	
}