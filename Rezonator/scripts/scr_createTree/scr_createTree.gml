

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
	var treeNode = scr_generateRandomID();
	//show_debug_message("scr_createTree, treeNode: " + string(treeNode) + ", tokenList: " + scr_getStringOfList(tokenList));
	ds_map_add_map(global.treeMap, treeNode, ds_map_create());

	
	// add some cool data to the tree
	ds_list_add(treeList, treeNode);
	var treeSubMap = global.treeMap[? treeNode];
	var treeLinkIDList = ds_list_create();
	var treeSetIDList = ds_list_create();
	ds_map_add_list(treeSubMap, "linkIDList", treeLinkIDList);
	ds_map_add_list(treeSubMap, "setIDList", treeSetIDList);
	ds_map_add_list(treeSubMap, "tokenList", tokenList);
	ds_map_add(treeSubMap, "name", "Tree " + string(ds_list_size(treeList)));
	ds_map_add(treeSubMap, "type", "tree");
	
	// add some dope entries to this tree
	var tokenListSize = ds_list_size(tokenList);
	for (var i = 0; i < tokenListSize; i++) {
		
		var currentToken = tokenList[| i];
		scr_createTreeEntry(treeNode, currentToken, i, false);
		
	}
	
	// set the new tree to be focused in nav window
	with (obj_panelPane) {
		functionTree_treeSelected = treeNode;
	}
	
	
	
}