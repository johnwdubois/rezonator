

function scr_resetTreeLevel(currentEntry) {
	show_debug_message("scr_resetTreeLevel called.... entry: "  +string(currentEntry));
	var treeSubMap = global.treeMap[? obj_panelPane.functionTree_treeSelected];
	var currentEntrySubMap = global.treeMap[?currentEntry];
	currentEntrySubMap[? "sourceLink"] = "";
	currentEntrySubMap[? "level"] = -1;
	var goalLinkList = currentEntrySubMap[? "goalLinkList"];
	var goalLinkListSize = ds_list_size(goalLinkList);
	
	//loop over goal link list
	for (var i = 0 ; i < goalLinkListSize; i++) {
		var currentGoalLink = goalLinkList[|0];
		var currentGoalLinkSubMap = global.treeMap[?currentGoalLink];

		//if goal link exists delete it and remove from goal link list of prev node
		if (scr_isNumericAndExists(currentGoalLinkSubMap, ds_type_map)) {
			
			var goalEntry = currentGoalLinkSubMap[? "goal"];
			var goalEntrySubMap = global.treeMap[? goalEntry];
	
			var sourceEntry = currentGoalLinkSubMap[? "source"];
			var goalEntry = currentGoalLinkSubMap[? "goal"];

			var sourceEntrySubMap = global.treeMap[? sourceEntry];
			if (scr_isNumericAndExists(sourceEntrySubMap, ds_type_map)) {
				scr_deleteFromList(sourceEntrySubMap[? "goalLinkList"], currentGoalLink);
			}

			scr_deleteFromList(treeSubMap[? "linkIDList"], currentGoalLink);
			ds_map_delete(global.treeMap, currentGoalLink);	
			ds_map_destroy(currentGoalLinkSubMap);
		
		
			//now reset function with goal link as input for each goal
			scr_resetTreeLevel(goalEntry);
		}
	}
}