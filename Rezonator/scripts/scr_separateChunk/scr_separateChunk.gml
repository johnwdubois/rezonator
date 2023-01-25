

function scr_separateChunk() {
	var ltr = (obj_control.drawLineState == obj_control.lineState_ltr);	
	//get tree entry lists
	var treeSubMap = global.treeMap[? obj_panelPane.functionTree_treeSelected];
	var treeSetIDList = treeSubMap[? "setIDList"];

	
	//get token list of selected entry
	var selectedEntry = obj_control.rightClickID;
	var selectedEntrySubMap = global.treeMap[? selectedEntry];
	
	var tokenList = selectedEntrySubMap[? "tokenList"];
	var tokenListSize = ds_list_size(tokenList);
	
	var selectedOrder = selectedEntrySubMap[? "order"];
	var newEntryIndex = (ltr) ? ds_list_find_index(treeSetIDList, selectedEntry)+1 : ds_list_find_index(treeSetIDList, selectedEntry);
	var encounteredTokens = ds_list_create();
	//create entry for every token past the first
	var i = 1;
	repeat(tokenListSize -1) {
		var tokenID = tokenList[|i];
		show_debug_message(string(tokenID))
		// get random hex and make a subMap for each entry
		var currentEntry = scr_generateRandomID();
		var currentEntrySubMap = ds_map_create();
		var currentTokenList = ds_list_create();
		ds_list_add(currentTokenList,tokenID);
		ds_map_add_map(global.treeMap, currentEntry, currentEntrySubMap);
		
		// give the entry some data
		ds_map_add_list(currentEntrySubMap, "tokenList", currentTokenList);
		ds_map_add(currentEntrySubMap, "order", selectedOrder+1);
		ds_map_add(currentEntrySubMap, "level", -1);
		ds_map_add(currentEntrySubMap, "type", "entry");
		ds_map_add(currentEntrySubMap, "entryX1", -1);
		ds_map_add(currentEntrySubMap, "entryY1", -1);
		ds_map_add(currentEntrySubMap, "entryX2", -1);
		ds_map_add(currentEntrySubMap, "entryY2", -1);
		ds_map_add(currentEntrySubMap, "sourceLink", "");
		ds_map_add(currentEntrySubMap, "goalLinkList", ds_list_create());
		
		// throw this new entry into the tree's setList
		ds_list_insert(treeSetIDList, newEntryIndex, currentEntry);
		
		ds_list_add(encounteredTokens, tokenID);
		i++;
		selectedOrder++;
		
		newEntryIndex = (ltr) ? ds_list_find_index(treeSetIDList, currentEntry)+1 : ds_list_find_index(treeSetIDList, currentEntry);
		show_debug_message("newEntryIndex: "+ string(newEntryIndex));
	}
	
	var encounteredTokensSize = ds_list_size(encounteredTokens);
	//loop again to remove extra tokens from original token list
	for (var i = 0;  i < encounteredTokensSize; i++) {
		var tokenID = encounteredTokens[|i];
		//remove this token from orginal token list
		scr_deleteFromList(tokenList,tokenID);
	}
	
	
	var entryListSize = ds_list_size(treeSetIDList);
	for (var i = newEntryIndex; i < entryListSize; i++) {
		var currentEntry = treeSetIDList[|i];
		var currentEntrySubMap = global.treeMap[? currentEntry];
		currentEntrySubMap[? "order"] = i;
	}
	
	ds_list_destroy(encounteredTokens);
		
}