function scr_checkUnitSideLink(unitID, chainID){
	
	// if this function finds an entry within the chain that already exists on the given unit, return true
	// otherwise return false
	
	// make sure we get valid IDs
	if (!is_string(unitID) || unitID == "" || !is_string(chainID) || chainID == "") return false;
	
	var chainSubMap = global.nodeMap[? chainID];
	if (!scr_isNumericAndExists(chainSubMap, ds_type_map)) return false;
	
	var setIDList = chainSubMap[? "setIDList"];
	if (!scr_isNumericAndExists(setIDList, ds_type_list)) return false;
	
	var setIDListSize = ds_list_size(setIDList);
	for (var i = 0; i < setIDListSize; i++) {
		var currentEntry = setIDList[| i];
		var currentEntrySubMap = global.nodeMap[? currentEntry];
		if (!scr_isNumericAndExists(currentEntrySubMap, ds_type_map)) continue;
		
		var currentEntryToken = currentEntrySubMap[? "token"];
		var currentEntryUnit = "";
		if (scr_isChunk(currentEntryToken)) {
			var firstToken = scr_getFirstWordOfChunk(currentEntryToken);
			var firstTokenSubMap = global.nodeMap[? firstToken];
			if (!scr_isNumericAndExists(firstTokenSubMap, ds_type_map)) continue;
			currentEntryUnit = firstTokenSubMap[? "unit"];
		}
		else {
			var currentEntryTokenSubMap = global.nodeMap[? currentEntryToken];
			if (!scr_isNumericAndExists(currentEntryTokenSubMap, ds_type_map)) continue;
			currentEntryUnit = currentEntryTokenSubMap[? "unit"];
		}
		
		if (currentEntryUnit == unitID) return true;
	}
	

}