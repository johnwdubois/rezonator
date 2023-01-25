

function scr_combineChains(focusedChain, clickedChain) {
	
	show_debug_message("scr_combineChains: " + string(focusedChain) + ", " + string(clickedChain));
	
	// get the submaps for our chains and make sure they exist
	var focusedChainSubMap = ds_map_find_value(global.nodeMap, focusedChain);
	var clickedChainSubMap = ds_map_find_value(global.nodeMap, clickedChain);
	if (!scr_isNumericAndExists(focusedChainSubMap, ds_type_map)) exit;
	if (!scr_isNumericAndExists(clickedChainSubMap, ds_type_map)) exit;
	
	// make sure the chains are the same type
	var focusedChainType = ds_map_find_value(focusedChainSubMap, "type");
	var clickedChainType = ds_map_find_value(clickedChainSubMap, "type");
	if (focusedChainType != clickedChainType) {
		show_debug_message("scr_combineChains() ... chains are not the same type!");
		exit;
	}
	

	var focusedChainEntryList = focusedChainSubMap[? "setIDList"];
	var focusedChainLinkIDList = focusedChainSubMap[? "linkIDList"];
	var clickedChainEntryList = clickedChainSubMap[? "setIDList"];
	var clickedChainLinkIDList = clickedChainSubMap[? "linkIDList"];
	var focusedChainEntry = focusedChainEntryList[|0];
	var clickedChainRoot = "";
	
	var clickedChainEntryListSize = ds_list_size(clickedChainEntryList);
	var clickedChainLinkIDListSize = ds_list_size(clickedChainLinkIDList);
	
	for (var i = 0 ; i < clickedChainEntryListSize; i++) {
		var currentEntry = clickedChainEntryList[|i];
		var currentEntrySubMap = global.nodeMap[?currentEntry];
		if (currentEntrySubMap[? "sourceLink"] == "") {
			clickedChainRoot = currentEntry;
		}
		//update the chain id of each entry in clicked chain
		currentEntrySubMap[? "chain"] = focusedChain;
		
		//update token/unit relevant to chain
		var IDToUpdate = ds_map_find_value(currentEntrySubMap, (focusedChainType == "stack") ? "unit" : "token");
		var IDSubMap = global.nodeMap[?IDToUpdate];
		var IDInChainList = IDSubMap[? "inChainsList"];
		scr_deleteFromList(IDInChainList, clickedChain);
		scr_addToListOnce(IDInChainList, focusedChain);
		
		//add entry to focused chain
		scr_addToListOnce(focusedChainEntryList,currentEntry);
	}
	
	for (var i = 0 ; i < clickedChainLinkIDListSize; i++) {
		var currentLink = clickedChainLinkIDList[|i];
		scr_addToListOnce(focusedChainLinkIDList,currentLink);
	}
	scr_sortVizSetIDList(focusedChain);
		
	// delete the clicked chain
	scr_deleteFromNodeMap(clickedChain);
	ds_map_destroy(clickedChainSubMap);	
	scr_removeChainFromLists(clickedChain, clickedChainType);
	
	//create link to clickedChainRoot
	var linkSourceID = focusedChainEntry;
	var linkGoalID = clickedChainRoot;
	show_debug_message("linkSourceID: "+ string(linkSourceID)+ "  linkGoalID:   "+ string(linkGoalID))
	if (ds_map_exists(global.nodeMap,linkSourceID) and ds_map_exists(global.nodeMap,linkGoalID)) {
		// create a node for the link (now that we know its source & goal)
		show_debug_message("HEYYYYY GUYYYYYY");
		var linkID = scr_addToNodeMap("link");
		var linkSubMap = ds_map_find_value(global.nodeMap, linkID);
		ds_map_add(linkSubMap, "source", linkSourceID);
		ds_map_add(linkSubMap, "goal", linkGoalID);
		
		// determine subtype of this link
		var linkSubType = "";
		if (focusedChainType == "rez") linkSubType = "rez";
		else if (focusedChainType == "track") linkSubType = "track";
		else if (focusedChainType == "card") linkSubType = "stack";
		ds_map_add(linkSubMap, "subtype", linkSubType);
		
		
		// add this link to the chain's linkIDList
		var chainLinkIDList = ds_map_find_value(focusedChainSubMap, "linkIDList");
		ds_list_add(chainLinkIDList, linkID);
		
		// add this new link to the source's goalLinkList
		var sourceSetSubMap = ds_map_find_value(global.nodeMap, linkSourceID);
		if (scr_isNumericAndExists(sourceSetSubMap, ds_type_map)) {
			var sourceSetGoalLinkList = ds_map_find_value(sourceSetSubMap, "goalLinkList");
			if (scr_isNumericAndExists(sourceSetGoalLinkList, ds_type_list)) {
				ds_list_add(sourceSetGoalLinkList, linkID);
				show_debug_message("scr_combineChains() ... adding " + string(linkID) + " to " + string(sourceSetSubMap));
			}
			
			// set clicktime for source
			if (ds_map_exists(sourceSetSubMap, "clickTime")) ds_map_add(linkSubMap, "sourceClickTime", sourceSetSubMap[? "clickTime"]);
		}
		
		// add this new link to the goal's source
		var goalSetSubMap = ds_map_find_value(global.nodeMap, linkGoalID);
		if (scr_isNumericAndExists(goalSetSubMap, ds_type_map)) {
			ds_map_replace(goalSetSubMap, "sourceLink", linkID);
			show_debug_message("scr_newLink() ... adding " + string(linkID) + " to " + string(goalSetSubMap));
			
			// set clicktime for goal
			if (ds_map_exists(goalSetSubMap, "clickTime")) ds_map_add(linkSubMap, "goalClickTime", goalSetSubMap[? "clickTime"]);
		}
	}
}