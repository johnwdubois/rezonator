function scr_createTree(tokenList) {
	
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
	var _treeNavList = global.nodeMap[? "treeNavList"];
	if (!scr_isNumericAndExists(_treeNavList, ds_type_list)) {
		show_debug_message("scr_createTree, treeNavList does not exist");
		exit;
	}
	
	// get ID for this tree, and give it a subMap within the treeMap
	var _treeID = scr_generateRandomID();
	ds_map_add_map(global.treeMap, _treeID, ds_map_create());
	
	// get treeSeq from stack layer map
	var _stackLayerMap = global.stackingMap[? obj_control.activeStacking];
	var _treeSeq = _stackLayerMap[? "treeSeq"];
	if (!is_numeric(_treeSeq)) _treeSeq = ds_list_size(_treeNavList);
	_treeSeq++;
	_stackLayerMap[? "treeSeq"] = _treeSeq;
	
	// add some cool data to the tree
	ds_list_add(treeList, _treeID);
	ds_list_add(_treeNavList, _treeID);
	var treeSubMap = global.treeMap[? _treeID];
	var treeLinkIDList = ds_list_create();
	var treeSetIDList = ds_list_create();
	ds_map_add_list(treeSubMap, "linkIDList", treeLinkIDList);
	ds_map_add_list(treeSubMap, "setIDList", treeSetIDList);
	ds_map_add_list(treeSubMap, "tokenList", tokenList);
	ds_map_add(treeSubMap, "name", "Tree " + string(_treeSeq));
	ds_map_add(treeSubMap, "type", "tree");
	ds_map_add(treeSubMap, "layer", obj_control.activeStacking);
	
	// add some dope entries to this tree
	var tokenListSize = ds_list_size(tokenList);
	for (var i = 0; i < tokenListSize; i++) {
		var currentToken = tokenList[| i];
		scr_createTreeEntry(_treeID, currentToken, i, false);
	}
	
	// set the new tree to be focused in nav window
	with (obj_panelPane) {
		functionTree_treeSelected = _treeID;
	}
	
}