// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_createTree(tokenList){
	
	// make sure tokenList and treeList exist
	if (!scr_isNumericAndExists(tokenList, ds_type_list)) {
		show_debug_message("scr_createTree, tokenList does not exist");
		exit;
	}
	var treeList = global.nodeMap[? "treeList"];
	if (!scr_isNumericAndExists(treeList, ds_type_list)) {
		show_debug_message("scr_createTree, treeList does not exist");
		exit;
	}
	
	
	// get ID for this tree, and give it a subMap within the treeMap
	var treeNode = scr_generateRandomHex();
	show_debug_message("scr_createTree, treeNode: " + string(treeNode) + ", tokenList: " + scr_getStringOfList(tokenList));
	ds_map_add_map(global.treeMap, treeNode, ds_map_create());

	
	// add some cool data to the tree
	ds_list_add(treeList, treeNode);
	var treeSubMap = global.treeMap[? treeNode];
	var treeLinkIDList = ds_list_create();
	var treeSetIDList = ds_list_create();
	ds_map_add_list(treeSubMap, "linkIDList", treeLinkIDList);
	ds_map_add_list(treeSubMap, "setIDList", treeSetIDList);
	ds_map_add(treeSubMap, "name", "Tree " + string(ds_list_size(treeList)));
	ds_map_add(treeSubMap, "type", "tree");
	
	// add some dope entries to this tree
	var tokenListSize = ds_list_size(tokenList);
	for (var i = 0; i < tokenListSize; i++) {
		var currentToken = tokenList[| i];
		
		// get random hex and make a subMap for each entry
		var currentEntry = scr_generateRandomHex();
		var currentEntrySubMap = ds_map_create();
		ds_map_add_map(global.treeMap, currentEntry, currentEntrySubMap);
		
		// give the entry some data
		ds_map_add(currentEntrySubMap, "token", currentToken);
		ds_map_add(currentEntrySubMap, "order", i);
		ds_map_add(currentEntrySubMap, "level", -1);
		ds_map_add(currentEntrySubMap, "type", "entry");
		ds_map_add(currentEntrySubMap, "entryX1", -1);
		ds_map_add(currentEntrySubMap, "entryY1", -1);
		ds_map_add(currentEntrySubMap, "entryX2", -1);
		ds_map_add(currentEntrySubMap, "entryY2", -1);
		ds_map_add(currentEntrySubMap, "sourceLink", "");
		ds_map_add(currentEntrySubMap, "goalLinkList", ds_list_create());
		
		// throw this new entry into the tree's setList
		ds_list_add(treeSetIDList, currentEntry);
		
	}
	
	
}