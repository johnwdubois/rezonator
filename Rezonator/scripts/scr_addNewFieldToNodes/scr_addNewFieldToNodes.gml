

function scr_addNewFieldToNodes(type, field){
	
	var chainList = ds_list_create();
	var entryList = ds_list_create();

	var nodeList = -1;
	var docNode = global.nodeMap[? global.discourseNode];
	if (type == "token") nodeList = docNode[? "tokenList"];
	else if (type == "unit") nodeList = docNode[? "unitList"];
	else if (type == "chunk") nodeList = global.nodeMap[? "chunkList"];
	else if (type == "Link"){
		
		var treeList = global.nodeMap[? "treeList"];
		var treeListSize = ds_list_size(treeList);
		for (var i = 0; i < treeListSize; i++) {
			var currentTree = chainList[| i];
			var currentTreeSubMap = global.nodeMap[? currentTree];
			var currentLinkIDList = currentTreeSubMap[? "linkIDList"];
			var currentLinkIDListSize = ds_list_size(currentLinkIDList);
			for (var j = 0; j < currentLinkIDListSize; j++) scr_addToListOnce(nodeList, currentLinkIDList[| j]);
		}
	}
	else {
		
		// make a temp list of all chains (rez, track, & stack)
		var resonanceList = global.nodeMap[? "resonanceList"];
		var trailList = global.nodeMap[? "trailList"];
		var stackList = global.nodeMap[? "stackList"];
		var resonanceListSize = ds_list_size(resonanceList);
		var trailListSize = ds_list_size(trailList);
		var stackListSize = ds_list_size(stackList);
		for (var i = 0; i < resonanceListSize; i++) ds_list_add(chainList, resonanceList[| i]);
		for (var i = 0; i < trailListSize; i++) ds_list_add(chainList, trailList[| i]);
		for (var i = 0; i < stackListSize; i++) ds_list_add(chainList, stackList[| i]);
		
		if (type == "chain") nodeList = chainList;
		else if (type == "entry") {
			
			// for every chain, add its entry to a list
			var chainListSize = ds_list_size(chainList);
			for (var i = 0; i < chainListSize; i++) {
				var currentChain = chainList[| i];
				var currentChainSubMap = global.nodeMap[? currentChain];
				var currentSetIDList = currentChainSubMap[? "setIDList"];
				var currentSetIDListSize = ds_list_size(currentSetIDList);
				for (var j = 0; j < currentSetIDListSize; j++) scr_addToListOnce(entryList, currentSetIDList[| j]);
			}
			nodeList = entryList;
		}
	
	}
	
	
	
	
	// loop over all tokens and give their tagmaps this new field
	if (scr_isNumericAndExists(nodeList, ds_type_list)) {
		
		var nodeListSize = ds_list_size(nodeList);
		for (var i = 0; i < nodeListSize; i++) {
			
			// get the current token's tagmap
			var currentNode = nodeList[| i];
			var currentNodeSubMap = global.nodeMap[? currentNode];
			var currentTagMap = currentNodeSubMap[? "tagMap"];
			
			// add the new field to this tagmap, with the default value being ""
			if (!ds_map_exists(currentTagMap, field)) {
				show_debug_message("CMOOOONNNNN: "+ string(field));
				ds_map_add(currentTagMap, field, "");
			}
		}
	}
	
	// we dont need the temp list anymore
	ds_list_destroy(chainList);
	ds_list_destroy(entryList);
	
}