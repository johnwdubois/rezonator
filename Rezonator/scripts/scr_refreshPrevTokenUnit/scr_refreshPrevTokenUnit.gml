function scr_refreshPrevTokenUnit(unitID){
	
	var unitSubMap = global.nodeMap[? unitID];
	if (!scr_isNumericAndExists(unitSubMap, ds_type_map)) exit;
	var currentEntryList = unitSubMap[? "entryList"];
	if (!scr_isNumericAndExists(currentEntryList, ds_type_list)) exit;
	var currentEntryListSize = ds_list_size(currentEntryList);

	for (var i = 0; i < currentEntryListSize; i++) {
		var currentEntry = currentEntryList[| i];
		var currentEntrySubMap = global.nodeMap[? currentEntry];
		var currentToken = currentEntrySubMap[? "token"];
		var currentTokenSubMap = global.nodeMap[? currentToken];
		
		if (ds_map_exists(currentTokenSubMap, "prevToken")) {
			ds_map_delete(currentTokenSubMap, "prevToken");
		}
	}

}