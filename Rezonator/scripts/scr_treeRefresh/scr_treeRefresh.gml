

function scr_treeRefresh(treeSubMap) {
	
	var setIDList = treeSubMap[? "setIDList"];
	var setIDListSize = ds_list_size(setIDList);
	treeSubMap[? "maxLevel"] = -1;
	for (var i = 0; i < setIDListSize; i++) {
		var currentEntry = setIDList[| i];
		var currentEntrySubMap = global.treeMap[? currentEntry];
		var currentEntrySource = currentEntrySubMap[? "sourceLink"];
		var currentEntryLevel = currentEntrySubMap[? "level"];
		show_debug_message("currentEntry: " + string(currentEntry) + ", currentEntrySource: " + string(currentEntrySource) + ", currentEntryLevel: " + string(currentEntryLevel));
		if (currentEntrySource == "" && currentEntryLevel >= 0) {
			show_debug_message("TIME TO REFRESH")
			scr_treeRefreshLevel(treeSubMap, currentEntry, 0);
		}
	}
}