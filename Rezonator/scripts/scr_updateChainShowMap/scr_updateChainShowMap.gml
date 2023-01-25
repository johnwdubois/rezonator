

function scr_updateChainShowMap(chainID, entryID, tokenID) {

	var chainShowSubMap = obj_chain.chainShowMap[? chainID];
	var chainShowMapList = -1;
	
	if (scr_isNumericAndExists(chainShowSubMap, ds_type_map)) {
		chainShowMapList = chainShowSubMap[? "entryList"];
	}
	else {
		chainShowSubMap = ds_map_create();
		ds_map_add_map(obj_chain.chainShowMap, chainID, chainShowSubMap);
		chainShowMapList = ds_list_create();
		ds_map_add_list(chainShowSubMap, "entryList", chainShowMapList);
	}
	
	var sideLinkCheck = (!startJustify || drawLineState == lineState_rtl);
	var isBad = (shape == shapeBlock && drawLineState == lineState_rtl && !startJustify);
	
	if (sideLinkCheck && !isBad) {
		var prevEntry = chainShowSubMap[? "prevEntry"];
		if (is_string(prevEntry)) {
			var tokenSubMap = global.nodeMap[? tokenID];
			var unitID = tokenSubMap[? "unit"];
			var prevEntrySubMap = global.nodeMap[? prevEntry];
			var prevEntryToken = prevEntrySubMap[? "token"];
			if (scr_isChunk(prevEntryToken)) prevEntryToken = scr_getFirstWordOfChunk(prevEntryToken);
			var prevEntryTokenSubMap = global.nodeMap[? prevEntryToken];
			var prevEntryUnit = prevEntryTokenSubMap[? "unit"];
			
			// check for side link
			if (unitID == prevEntryUnit) {
				var index = ds_list_find_index(chainShowMapList, prevEntry);
				ds_list_insert(chainShowMapList, index, entryID);
				chainShowSubMap[? "prevEntry"] = entryID;
				exit;
			}
		}
	}


	scr_addToListOnce(chainShowMapList, entryID);
	chainShowSubMap[? "prevEntry"] = entryID;

	
}