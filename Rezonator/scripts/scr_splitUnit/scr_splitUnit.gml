function scr_splitUnit(currentToken, lastToken){
	var tokenSubMap = global.nodeMap[?currentToken];
	var unitToSplit = tokenSubMap[?"unit"];
	var oldUnitSubMap = global.nodeMap[?unitToSplit];
	var entryList = oldUnitSubMap[?"entryList"];
	var inChainsList = oldUnitSubMap[?"inChainsList"];
	var entryListSize = ds_list_size(entryList)
	for(var i = 0 ; i < entryListSize; i++){
		var currentEntry = entryList[|i];
		var entrySubMap = global.nodeMap[?currentEntry];
		var entryToken = entrySubMap[?"token"];
		if((i == entryListSize-1 && lastToken) or (!lastToken && i == 0) && (currentToken == entryToken))exit;
		if(currentToken == entryToken) break;
	}
	var entryListIndex = (lastToken)? i+1 : i;
	var newEntryList = ds_list_create();
	
	for(var i = entryListIndex ; i < entryListSize; i++){
		var currentEntry = entryList[|i];
		ds_list_add(newEntryList, currentEntry);
	}
	var deleteAmount = entryListSize - entryListIndex;
	repeat(deleteAmount){
		var currentEntry = entryList[|entryListIndex];
		scr_deleteFromList(entryList,currentEntry);	
	}
	
	
	var discourseSubMap = global.nodeMap[?global.discourseNode];
	var unitList = discourseSubMap[?"unitList"];
	var oldUnitTagMap = oldUnitSubMap[?"tagMap"];
	
	// make a new unit node for this row
	var newUnitNode = scr_addToNodeMap("unit");
	var newUnitSubMap = global.nodeMap[? newUnitNode];
	
	
	var indexOfOldUnit = ds_list_find_index(unitList,unitToSplit);
	var indexOfNewUnit =indexOfOldUnit + 1;
	
	
	ds_list_insert(unitList, indexOfNewUnit , newUnitNode);
	
	// make tag map for unit
	var unitTagMap = ds_map_create();
	ds_map_add_map(newUnitSubMap, "tagMap", unitTagMap);
	ds_map_copy(unitTagMap,oldUnitTagMap);
	// add values to unit node
	ds_map_add(newUnitSubMap, "unitSeq", indexOfNewUnit);
	ds_map_add_list(newUnitSubMap, "entryList", newEntryList);
	ds_map_add_list(newUnitSubMap, "inChainsList", ds_list_create());
	ds_map_add(newUnitSubMap, "pixelY", 0);
	ds_map_add(newUnitSubMap, "filter", false);
	ds_map_add(newUnitSubMap, "active", true);
	ds_map_add(newUnitSubMap, "doc", global.discourseNode);
	ds_map_add(newUnitSubMap, "unitStart", oldUnitSubMap[?"unitStart"]);
	ds_map_add(newUnitSubMap, "unitEnd",  oldUnitSubMap[?"unitEnd"]);
	show_debug_message("indexOfNewUnit:  "+ string(indexOfNewUnit));
	//update unit seq for all values after this unit
	var unitListSize =ds_list_size(unitList);
	for(var i = indexOfNewUnit; i < unitListSize;i++ ){
		var currentUnit = unitList[|i];
		var unitSubMap = global.nodeMap[?currentUnit];
		unitSubMap[?"unitSeq"] = unitSubMap[?"unitSeq"]+1;
	}
	

	var entryListSize = ds_list_size(newEntryList);
	for(var i  = 0 ; i < entryListSize; i++){
		var currentEntrySubMap = global.nodeMap[?newEntryList[|i]];
		var tokenID = currentEntrySubMap[?"token"];
		var tokenSubMap = global.nodeMap[?tokenID];
		tokenSubMap[?"unit"] = newUnitNode;
		currentEntrySubMap[?"unit"] = newUnitNode;
	}
	if(ds_list_size(inChainsList)> 0){
		var chainToFocus = inChainsList[|0];
		obj_chain.currentFocusedChainID = chainToFocus;
		scr_unitClicked(newUnitNode);
	}

	discourseSubMap[? "displayUnitList"] = unitList;
	
}