///@description Remove Link or Chunk
function scr_deleteFromChain(sortVizSetList) {
	

	if (obj_toolPane.currentTool == obj_toolPane.toolBoxBrush || obj_toolPane.currentTool == obj_toolPane.toolNewWord || obj_control.newWordDeleted || obj_control.deleteNewWord || obj_control.deleteChunkWord) {
		//show_message("current Tool :   "+string(obj_toolPane.currentTool) + ",  newWordDeleted: " + string(obj_control.newWordDeleted)+ ",  deleteNewWord: " + string(obj_control.deleteNewWord)+ ",  deleteChunkWord: " + string(obj_control.deleteChunkWord))
		scr_deleteChunk();
	}
	
	show_debug_message("scr_deleteFromChain() , sortVizSetList: " + string(sortVizSetList));

	
	// get the focused chain's submap
	var chainSubMap = ds_map_find_value(global.nodeMap, obj_chain.currentFocusedChainID);
	if (!is_numeric(chainSubMap)) {
		show_debug_message("scr_deleteFromChain() ... chainSubMap is non-numeric");
		exit;
	}
	if (!ds_exists(chainSubMap, ds_type_map)) {
		show_debug_message("scr_deleteFromChain() ... chainSubMap does not exist");
		exit;
	}
	
	// get the focused entry's submap
	var focusedEntry = ds_map_find_value(chainSubMap, "focused");
	var focusedEntrySubMap = ds_map_find_value(global.nodeMap, focusedEntry);
	if (!is_numeric(focusedEntrySubMap)) {
		show_debug_message("scr_deleteFromChain() ... focusedEntrySubMap is non-numeric");
		exit;
	}
	if (!ds_exists(focusedEntrySubMap, ds_type_map)) {
		show_debug_message("scr_deleteFromChain() ... focusedEntrySubMap does not exist");
		exit;
	}
	
	show_debug_message("scr_deleteFromChain() , CHECK 1");
	var focusedEntryType = ds_map_find_value(focusedEntrySubMap, "type");
	
	// find where in the chain's setList the focused entry is
	var chainSetList = ds_map_find_value(chainSubMap, "setIDList");
	var chainVizSetList = ds_map_find_value(chainSubMap, "vizSetIDList");
	var chainLinkList = ds_map_find_value(chainSubMap, "linkIDList");
	
	// get the focused entry's sourceLink's submap
	var sourceLink = ds_map_find_value(focusedEntrySubMap, "sourceLink");
	
	// if this entry has no source...
	var focusedEntryGoalLinkList = ds_map_find_value(focusedEntrySubMap, "goalLinkList");
	var focusedEntryGoalLinkListSize = ds_list_size(focusedEntryGoalLinkList);
	if (sourceLink == "") {
		
		// if no source and no goal, we delete the entry and the chain!
		if (focusedEntryGoalLinkListSize < 1) {
			// remove the focusedEntry from this word's inChainsList (if it is a rez or track)
			if (focusedEntryType == "rez" || focusedEntryType == "track") {
				var focusedEntryWord = ds_map_find_value(focusedEntrySubMap, "word");
				
				if(obj_control.rightClickonWord and obj_control.deleteChunkWord){
					if(obj_control.rightClickWordID != focusedEntryWord){
						exit;
					}
				}
				
				var focusedEntryInChainsList = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInChainList, focusedEntryWord - 1);				
				var wordDrawCol = focusedEntryType == "rez" ? obj_control.wordDrawGrid_colBorder : obj_control.wordDrawGrid_colBorderRounded;
				ds_grid_set(obj_control.wordDrawGrid, wordDrawCol, focusedEntryWord - 1, false);
				ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colEffectColor, focusedEntryWord - 1, 0);
				scr_deleteFromList(focusedEntryInChainsList, obj_chain.currentFocusedChainID);
			}
			else if (focusedEntryType == "stack"){
				var focusedEntryUnit = ds_map_find_value(focusedEntrySubMap, "unit");
				ds_grid_set(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colStack, focusedEntryUnit-1,-1);
				ds_grid_set(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colStackType, focusedEntryUnit-1, -1);	
			}
			show_debug_message("scr_deleteFromChain() , CHECK 2");
			// delete and destroy the focused entry and its chain
			ds_map_delete(global.nodeMap, focusedEntry);
			ds_map_delete(global.nodeMap, obj_chain.currentFocusedChainID);
			ds_map_destroy(focusedEntrySubMap);
			ds_map_destroy(chainSubMap);
			var listOfChainsKey = "rezChainList";
			if (focusedEntryType == "track") listOfChainsKey = "trackChainList";
			else if (focusedEntryType == "stack") listOfChainsKey = "stackChainList";
			var listOfChains = ds_map_find_value(global.nodeMap, listOfChainsKey);
			scr_deleteFromList(listOfChains, obj_chain.currentFocusedChainID);
			
			// remove chain from filter/selected list if necessary
			var filteredChainList = -1;
			var selectedChainList = -1;
			if (focusedEntryType == "rez") {
				filteredChainList = obj_chain.filteredRezChainList;
				selectedChainList = obj_control.selectedRezChainList;
			}
			else if (focusedEntryType == "track") {
				filteredChainList = obj_chain.filteredTrackChainList;
				selectedChainList = obj_control.selectedTrackChainList;
			}
			else if (focusedEntryType == "stack") {
				filteredChainList = obj_chain.filteredStackChainList;
				selectedChainList = obj_control.selectedStackChainList;
			}
			scr_deleteFromList(filteredChainList, obj_chain.currentFocusedChainID);
			scr_deleteFromList(selectedChainList, obj_chain.currentFocusedChainID);
			
			// unfocus chain
			obj_chain.currentFocusedChainID = "";
			exit;
		}
		// if no source but it has at least 1 goal, we will restructure the links
		else {
			show_debug_message("scr_deleteFromChain() , CHECK 3");
			var firstGoalLink = ds_list_find_value(focusedEntryGoalLinkList, 0);
			var firstGoalLinkSubMap = ds_map_find_value(global.nodeMap, firstGoalLink);
			if (!is_numeric(firstGoalLinkSubMap)) {
				show_debug_message("scr_deleteFromChain() ... firstGoalLinkSubMap is non-numeric");
				exit;
			}
			if (!ds_exists(firstGoalLinkSubMap, ds_type_map)) {
				show_debug_message("scr_deleteFromChain() ... firstGoalLinkSubMap does not exist");
				exit;
			}
			var goalEntry = ds_map_find_value(firstGoalLinkSubMap, "goal");
			var goalEntrySubMap = ds_map_find_value(global.nodeMap, goalEntry);
			if (!is_numeric(goalEntrySubMap)) {
				show_debug_message("scr_deleteFromChain() ... goalEntrySubMap is non-numeric");
				exit;
			}
			if (!ds_exists(goalEntrySubMap, ds_type_map)) {
				show_debug_message("scr_deleteFromChain() ... goalEntrySubMap does not exist");
				exit;
			}
				show_debug_message("scr_deleteFromChain() , CHECK 4");
			// go through all goalLinks (excluding firstGoalLink) and set their sources to be goalEntry
			var goalEntryGoalLinkList = ds_map_find_value(goalEntrySubMap, "goalLinkList");
			for (var i = 0; i < focusedEntryGoalLinkListSize; i++) {
				 var currentGoalEntryGoalLink = ds_list_find_value(focusedEntryGoalLinkList, i);
				 if (currentGoalEntryGoalLink != firstGoalLink) {
					 var currentGoalEntryGoalLinkSubMap = ds_map_find_value(global.nodeMap, currentGoalEntryGoalLink);
					 ds_map_replace(currentGoalEntryGoalLinkSubMap, "source", goalEntry);
					 ds_list_add(goalEntryGoalLinkList, currentGoalEntryGoalLink);
				 }
			}
			
			// remove the focusedEntry from this word's inChainsList (if it is a rez or track)
			if (focusedEntryType == "rez" || focusedEntryType == "track") {
				var focusedEntryWord = ds_map_find_value(focusedEntrySubMap, "word");
				var focusedEntryInChainsList = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInChainList, focusedEntryWord - 1);				
				var wordDrawCol = focusedEntryType == "rez" ? obj_control.wordDrawGrid_colBorder : obj_control.wordDrawGrid_colBorderRounded;
				ds_grid_set(obj_control.wordDrawGrid, wordDrawCol, focusedEntryWord - 1, false);
				ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colEffectColor, focusedEntryWord - 1, 0);
				scr_deleteFromList(focusedEntryInChainsList, obj_chain.currentFocusedChainID);
			}
			else if (focusedEntryType == "stack"){
				var focusedEntryUnit = ds_map_find_value(focusedEntrySubMap, "unit");
				ds_grid_set(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colStack, focusedEntryUnit-1,-1);
				ds_grid_set(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colStackType, focusedEntryUnit-1, -1);	
			}
			show_debug_message("scr_deleteFromChain() , CHECK 5");
			// remove the focused entry from its chain's setList and delete it from nodeMap
			scr_deleteFromList(chainSetList, focusedEntry);
			ds_map_delete(global.nodeMap, focusedEntry);
			ds_map_destroy(focusedEntrySubMap);
			
			// remove the entry from the vizSetList
			scr_deleteFromList(chainVizSetList, focusedEntry);
			
			// delete & destroy the firstGoalLink and all references to it
			ds_map_destroy(firstGoalLinkSubMap);
			var chainLinkListIndex = ds_list_find_index(chainLinkList, firstGoalLink);
			ds_list_delete(chainLinkList, chainLinkListIndex);
			ds_map_replace(goalEntrySubMap, "sourceLink", "");
			ds_map_delete(global.nodeMap, firstGoalLink);
			
			// sort vizSetList!
			if (sortVizSetList) {
				scr_sortVizSetIDList(obj_chain.currentFocusedChainID);
			}
			
			scr_deleteFromChainVoidCheck(obj_chain.currentFocusedChainID);
			
			// focus goalEntry
			ds_map_replace(chainSubMap, "focused", goalEntry);
			exit;
		}
	}
	
	var sourceLinkSubMap = ds_map_find_value(global.nodeMap, sourceLink);
	if (!is_numeric(sourceLinkSubMap)) {
		show_debug_message("scr_deleteFromChain() ... sourceLinkSubMap is non-numeric");;
	}
	if (!ds_exists(sourceLinkSubMap, ds_type_map)) {
		show_debug_message("scr_deleteFromChain() ... sourceLinkSubMap does not exist");
		exit;
	}

	// get the sourceLink's source (sourceEntry) submap
	var sourceEntry = ds_map_find_value(sourceLinkSubMap, "source");
	var sourceEntrySubMap = ds_map_find_value(global.nodeMap, sourceEntry);
	if (!is_numeric(sourceEntrySubMap)) {
		show_debug_message("scr_deleteFromChain() ... sourceEntrySubMap is non-numeric");
		exit;
	}
	if (!ds_exists(sourceEntrySubMap, ds_type_map)) {
		show_debug_message("scr_deleteFromChain() ... sourceEntrySubMap does not exist");
		exit;
	}
	
	show_debug_message("scr_deleteFromChain() , CHECK 6");
	
	// remove the sourceLink from sourceEntry's goalLinkList
	var sourceEntryGoalLinkList = ds_map_find_value(sourceEntrySubMap, "goalLinkList");
	var goalLinkListIndex = ds_list_find_index(sourceEntryGoalLinkList, sourceLink);
	show_debug_message("scr_deleteFromChain() ... goalLinkListIndex: " + string(goalLinkListIndex));
	ds_list_delete(sourceEntryGoalLinkList, goalLinkListIndex);
	
	// remove the sourceLink from chain's linkList
	var chainLinkListIndex = ds_list_find_index(chainLinkList, sourceLink);
	show_debug_message("scr_deleteFromChain() ... chainLinkListIndex: " + string(chainLinkListIndex));
	ds_list_delete(chainLinkList, chainLinkListIndex);
	
	// remove sourceLink from nodeMap and destroy sourceLink
	ds_map_delete(global.nodeMap, sourceLink);
	ds_map_destroy(sourceLinkSubMap);
	
	// loop through the goals for the current entry and reset their sources to be sourceEntry
	for (var i = 0; i < focusedEntryGoalLinkListSize; i++) {
		
		var currentGoalLink = ds_list_find_value(focusedEntryGoalLinkList, i);
		var currentGoalLinkSubMap = ds_map_find_value(global.nodeMap, currentGoalLink);
		ds_map_replace(currentGoalLinkSubMap, "source", sourceEntry);
		
		// add the currentGoalLink to its new source's goalLinkList
		ds_list_add(sourceEntryGoalLinkList, currentGoalLink);
		
	}
	
	// remove the focusedEntry from its chain's setList
	scr_deleteFromList(chainSetList, focusedEntry);
	
	// remove the entry from the vizSetList
	scr_deleteFromList(chainVizSetList, focusedEntry);
	
	// unfocus focusedEntry
	var newFocusedEntry = (ds_exists(sourceEntrySubMap, ds_type_map)) ? sourceEntry : "";
	show_debug_message("chainSubMap: " + string(chainSubMap) + ", newFocusedEntry: " + string(newFocusedEntry));
	ds_map_replace(chainSubMap, "focused", newFocusedEntry);
	
	// removed chain from focusedEntry's word's inChainsList (if it is a rez or track)
	if (focusedEntryType == "rez" || focusedEntryType == "track") {
		var focusedEntryWord = ds_map_find_value(focusedEntrySubMap, "word");
		var focusedEntryWordInChainsList = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInChainList, focusedEntryWord - 1);		
		var wordDrawCol = focusedEntryType == "rez" ? obj_control.wordDrawGrid_colBorder : obj_control.wordDrawGrid_colBorderRounded;
		ds_grid_set(obj_control.wordDrawGrid, wordDrawCol, focusedEntryWord - 1, false);
		ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colEffectColor, focusedEntryWord - 1, 0);
		scr_deleteFromList(focusedEntryWordInChainsList, obj_chain.currentFocusedChainID);
	}
	else if (focusedEntryType == "stack"){
		var focusedEntryUnit = ds_map_find_value(focusedEntrySubMap, "unit");
		ds_grid_set(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colStack, focusedEntryUnit-1,-1);
		ds_grid_set(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colStackType, focusedEntryUnit-1, -1);	
	}
	// remove focusedEntry from nodeMap and destroy focusedEntry
	ds_map_delete(global.nodeMap, focusedEntry);
	ds_map_destroy(focusedEntrySubMap);
	
	// sort vizSetList!
	if (sortVizSetList) {
		scr_sortVizSetIDList(obj_chain.currentFocusedChainID);
	}
	
	
	scr_deleteFromChainVoidCheck(obj_chain.currentFocusedChainID);
	show_debug_message("scr_deleteFromChain() , FINAL CHECK");

}
