

function scr_miniClipFile(chosenUnitList) {
	var discourseSubMap = global.nodeMap[? global.discourseNode];
	var unitList = discourseSubMap[? "unitList"];
	show_debug_message("scr_miniClipFile ... list of units: " + scr_getStringOfList(chosenUnitList));
	
	var startIndex = ds_list_find_index(unitList,chosenUnitList[|0]);
	var endIndex = ds_list_find_index(unitList, chosenUnitList[| ds_list_size(chosenUnitList)-1]);
	
	// check if we have a valid unitList
	if (!scr_isNumericAndExists(unitList, ds_type_list)) {
		show_debug_message("scr_miniClipFile ... unitList does not exist");
		exit;
	}
	
	// get complete node list
	var nodeList = global.nodeMap[? "nodeList"];
	
	// create minimap
	var miniMap = ds_map_create();
	
	// add default lists to minimap
	
	var miniNodeList = ds_list_create();
	var miniRezChainList = ds_list_create();
	var miniTrackChainList = ds_list_create();
	var miniStackChainList = ds_list_create();
	var miniShowList = ds_list_create();
	var miniChunkList = ds_list_create();
	ds_map_add_list(miniMap, "nodeList", miniNodeList);
	ds_map_add_list(miniMap, "resonanceList", miniRezChainList);
	ds_map_add_list(miniMap, "trailList", miniTrackChainList);
	ds_map_add_list(miniMap, "stackList", miniStackChainList);
	ds_map_add_list(miniMap, "showList", miniShowList);
	ds_map_add_list(miniMap, "chunkList", miniChunkList);
	
	
	// create a new discourse & corpus submap (it can have the same node ID as the regular one)
	var miniCorpusSubMap = ds_map_create();
	var miniCorpusDocList = ds_list_create();
	ds_map_add_list(miniCorpusSubMap, "docList", miniCorpusDocList);
	var miniDiscourseSubMap = ds_map_create();
	ds_map_add(miniCorpusSubMap, "type", "corpus");
	ds_map_add(miniDiscourseSubMap, "type", "doc");
	ds_map_add_map(miniMap, global.corpusNode, miniCorpusSubMap);
	ds_map_add_map(miniMap, global.discourseNode, miniDiscourseSubMap);
	ds_list_add(miniNodeList, global.corpusNode);
	ds_list_add(miniNodeList, global.discourseNode);
	ds_list_add(miniCorpusDocList, global.discourseNode);
	
	
	
	
	// add unitList, tokenList, and displayUnitList to new discourse node
	var miniUnitList = ds_list_create();
	var miniDisplayUnitList = ds_list_create();
	var miniTokenList = ds_list_create();
	ds_map_add_list(miniDiscourseSubMap, "unitList", miniUnitList);
	ds_map_add_list(miniDiscourseSubMap, "displayUnitList", miniDisplayUnitList);
	ds_map_add_list(miniDiscourseSubMap, "tokenList", miniTokenList);
	
	var discourseTokenSeq = 1;

	
	// loop through the units and copy them to a new sup nodemap
	var unitListSize = ds_list_size(unitList);
	startIndex = clamp(startIndex, 0, unitListSize);
	endIndex = clamp(endIndex, 0, unitListSize);
	for (var i = startIndex; i < endIndex+1; i++) {
		
		// get current unit, make sure it exists
		var currentUnit = unitList[| i];
		if (ds_list_find_index(chosenUnitList, currentUnit) == -1) {continue;}
		show_debug_message("scr_miniClipFile ... copying unit " + string(currentUnit));
		var currentUnitSubMap = json_decode(json_encode(global.nodeMap[? currentUnit]));
		if (!scr_isNumericAndExists(currentUnitSubMap, ds_type_map)) {
			show_debug_message("scr_miniClipFile ... unit " + string(currentUnit) + " does not exist");
			continue;
		}
		
		// add current unit's submap to our minimap
		ds_map_add_map(miniMap, currentUnit, currentUnitSubMap);
		ds_list_add(miniNodeList, currentUnit);
		
		// add current unit's ID to the discourse node's unitList and displayUnitList
		ds_list_add(miniUnitList, currentUnit);
		ds_list_add(miniDisplayUnitList, currentUnit);
		
		
		
		// get the current unit's entry list, and add those entries & tokens
		var currentEntryList = currentUnitSubMap[? "entryList"];
		if (!scr_isNumericAndExists(currentEntryList, ds_type_list)) continue;
		var currentEntryListSize = ds_list_size(currentEntryList);
		for (var j = 0; j < currentEntryListSize; j++) {
			
			// get current entry, make sure it exists
			var currentEntry = currentEntryList[| j];
			var currentEntrySubMap = json_decode(json_encode(global.nodeMap[? currentEntry]));
			if (!scr_isNumericAndExists(currentEntrySubMap, ds_type_map)) {
				show_debug_message("scr_miniClipFile ... entry " + string(currentEntry) + " does not exist");
				continue;
			}
			
			// get current token, make sure it exists
			var currentToken = currentEntrySubMap[? "token"];
			var currentTokenSubMap = json_decode(json_encode(global.nodeMap[? currentToken]));
			if (!scr_isNumericAndExists(currentTokenSubMap, ds_type_map)) {
				show_debug_message("scr_miniClipFile ... token " + string(currentToken) + " does not exist");
				continue;
			}
			
			// change discourse token seq of current token
			currentTokenSubMap[? "docTokenSeq"] = discourseTokenSeq;
			
			// add current token's submap to our minimap
			ds_map_add_map(miniMap, currentToken, currentTokenSubMap);
			ds_list_add(miniNodeList, currentToken);
			ds_list_add(miniTokenList, currentToken);
			
			// add current entry's submap to our minimap
			ds_map_add_map(miniMap, currentEntry, currentEntrySubMap);
			ds_list_add(miniNodeList, currentEntry);
			
			
			discourseTokenSeq++;
		}
	}
	
	
	// collect chains/entries/links
	var nodeListSize = ds_list_size(nodeList);
	for (var i = 0; i < nodeListSize; i++) {
		
		// get current node, make sure it exists
		var currentNode = nodeList[| i];
		var currentNodeSubMap = global.nodeMap[? currentNode];
		if (!scr_isNumericAndExists(currentNodeSubMap, ds_type_map)) continue;
		
		// check to see if type is something we want to copy
		var currentNodeType = currentNodeSubMap[? "type"];
		if (currentNodeType == "resonance" || currentNodeType == "rez"
		|| currentNodeType == "trail" || currentNodeType == "track"
		|| currentNodeType == "stack" || currentNodeType == "card"
		|| currentNodeType == "link" || currentNodeType == "chunk"
		|| currentNodeType == "map") {
			
			// copy this node
			var currentNodeSubMapCopy = json_decode(json_encode(currentNodeSubMap));
			ds_map_add_map(miniMap, currentNode, currentNodeSubMapCopy);
			ds_list_add(miniNodeList, currentNode);
			
			if (currentNodeType == "resonance") ds_list_add(miniRezChainList, currentNode);
			if (currentNodeType == "trail") ds_list_add(miniTrackChainList, currentNode);
			if (currentNodeType == "stack") ds_list_add(miniStackChainList, currentNode);
			
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	// copy tokenTagMap & unitTagMap unit the miniMap
	var tokenTagMapCopy = json_decode(json_encode(global.nodeMap[? "tokenTagMap"]));
	var unitTagMapCopy = json_decode(json_encode(global.nodeMap[? "unitTagMap"]));
	ds_map_add_map(miniMap, "tokenTagMap", tokenTagMapCopy);
	ds_map_add_map(miniMap, "unitTagMap", unitTagMapCopy);
	
	show_debug_message(directory_exists(obj_control.clipStackDir));
	
	// temporarily change the nodeMap to be our miniMap, then save the nodeMap, and finally change the nodeMap back
	global.fileSaveName = (directory_exists(obj_control.clipStackDir))? obj_control.clipStackDir+ "\\"+string(obj_control.clipStackName)+".rez" : "";
	var tempNodeMap = global.nodeMap;
	global.nodeMap = miniMap;
	scr_saveREZ(false);
	global.nodeMap = tempNodeMap;
	
	// destroy the minimap, its discourse node, and all of the default lists
	ds_map_destroy(miniMap);
	ds_map_destroy(miniDiscourseSubMap);
	ds_list_destroy(miniNodeList);
	ds_list_destroy(miniRezChainList);
	ds_list_destroy(miniTrackChainList);
	ds_list_destroy(miniStackChainList);
	ds_list_destroy(miniShowList);
	ds_list_destroy(miniUnitList);
	ds_list_destroy(miniDisplayUnitList);
	ds_list_destroy(miniTokenList);
	
	
	// reset all the discourse token seq values for our regular nodeMap
	var discourseSubMap = global.nodeMap[? global.discourseNode];
	var fullTokenList = discourseSubMap[? "tokenList"];
	var fullTokenListSize = ds_list_size(fullTokenList);
	for (var i = 0; i < fullTokenListSize; i++) {
		var currentToken = fullTokenList[| i];
		var currentTokenSubMap = global.nodeMap[? currentToken];
		if (scr_isNumericAndExists(currentTokenSubMap, ds_type_map)) {
			currentTokenSubMap[? "docTokenSeq"] = i + 1;
		}
	}
	


}