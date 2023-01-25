

function scr_createTreeEntry(treeID, tokenID, order, addToTokenList) {
	
	var treeSubMap = global.treeMap[? treeID];
	var treeSetIDList = treeSubMap[? "setIDList"];
	var treeTokenList = treeSubMap[? "tokenList"];
	
	// get random hex and make a subMap for each entry
	var currentEntry = scr_generateRandomID();
	var currentEntrySubMap = ds_map_create();
	var currentTokenList = ds_list_create();
	ds_list_add(currentTokenList, tokenID);
	ds_map_add_map(global.treeMap, currentEntry, currentEntrySubMap);
		
	// give the entry some data
	ds_map_add_list(currentEntrySubMap, "tokenList", currentTokenList);
	ds_map_add(currentEntrySubMap, "order", order);
	ds_map_add(currentEntrySubMap, "level", -1);
	ds_map_add(currentEntrySubMap, "type", "treeEntry");
	ds_map_add(currentEntrySubMap, "entryX1", -1);
	ds_map_add(currentEntrySubMap, "entryY1", -1);
	ds_map_add(currentEntrySubMap, "entryX2", -1);
	ds_map_add(currentEntrySubMap, "entryY2", -1);
	ds_map_add(currentEntrySubMap, "sourceLink", "");
	ds_map_add_list(currentEntrySubMap, "goalLinkList", ds_list_create());
		
	// throw this new entry into the tree's setList (at the correct position)
	ds_list_insert(treeSetIDList, order, currentEntry);
	if (addToTokenList) ds_list_insert(treeTokenList, order, tokenID);
	
	return currentEntry;

}