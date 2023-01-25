function scr_checkUnitStillInClique(unitID, entryDeleted) {
	
	var unitSubMap = global.nodeMap[? unitID];
	var unitEntryList = unitSubMap[? "entryList"];
	var unitEntryListSize = ds_list_size(unitEntryList);
	
	for (var i = 0; i < unitEntryListSize; i++) {
		var currentEntry = unitEntryList[| i];
		var currentEntrySubMap = global.nodeMap[? currentEntry];
		var currentToken = currentEntrySubMap[? "token"];
		var currentTokenSubMap = global.nodeMap[? currentToken];
		var currentTokenInEntryList = currentTokenSubMap[? "inEntryList"];
		var currentTokenInEntryListSize = ds_list_size(currentTokenInEntryList);
		for (var j = 0; j < currentTokenInEntryListSize; j++) {
			var currentTokenInEntry = currentTokenInEntryList[| j];
			show_debug_message("currentTokenInEntry: " + string(currentTokenInEntry));
			if (currentTokenInEntry != entryDeleted && is_string(currentTokenInEntry) && ds_map_exists(global.nodeMap, currentTokenInEntry)) {
				var currentTokenInEntrySubMap = global.nodeMap[? currentTokenInEntry];
				if (currentTokenInEntrySubMap[? "type"] == "rez") {
					// we have found another rez entry in this unit (other than the one that was deleted) so this unit can remain in its clique
					return;
				}
			}
		}
	}
	
	// if we've made it this far in the function, we must remove this unit from the clique
	unitSubMap[? "inClique"] = "";
	

}