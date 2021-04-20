/*	
	Purpose: the user has created a link, so this script will add it to the node map
*/
function scr_newLink(ID) {
	
	show_debug_message("scr_newLink() ... ID: " + string(ID));
	ds_list_clear(obj_control.chainStretchCheckList);
		
	// make sure this is a valid ID
	var idSubMap = global.nodeMap[? ID];
	if (!scr_isNumericAndExists(idSubMap, ds_type_map)) exit;
	
	
	var unitID = "";
	var tokenID = "";
	var IDsubMap = global.nodeMap[?ID];
	var type = IDsubMap[?"type"];
	if(type == "unit"){
		unitID = ID
		var entryList = IDsubMap[?"entryList"];
		var firstEntry = entryList[|0];
		var entrySubMap = global.nodeMap[?firstEntry];
		tokenID = entrySubMap[?"token"]
	}
	else if(type == "token"){	
		unitID = IDsubMap[?"unit"];
		tokenID = ID
	}
	
	

	var isChunk = scr_isChunk(ID);
	
	// determine whether to treat as unit (stack) or word (rez/track)
	var idSet = "";
	if (type == "unit") {
		idSet = unitID;
		if (obj_control.quickStackAbleToInitiate) {
			obj_control.moveCounter++;
		}
	}
	else {
		idSet = tokenID;
		obj_control.mostRecentlyAddedWord = tokenID;
	}
	

	// make sure there is a focused chain
	if (obj_chain.currentFocusedChainID = "") {
		show_debug_message("scr_newLink() ... ERROR: currentFocusedChainID is blank string. Exiting...");
		exit;
	}
	
	// get type of focused chain
	var focusedChainSubMap = global.nodeMap[? obj_chain.currentFocusedChainID];
	var focusedChainType = focusedChainSubMap[? "type"];
	
	// determine the tier/type of this link
	var nodeType = "rez";
	var currentChainTier = obj_chain.rezTier;
	if (focusedChainType == "trackChain") {
		currentChainTier = obj_chain.trackTier;
		nodeType = "track";
	}
	else if (focusedChainType == "stackChain") {
		currentChainTier = obj_chain.stackTier;
		nodeType = "stack";
	}
	
	var linkSourceID = ""; 
	
	// add an entry (rez/track/stack) to the nodeMap
	// find this chain's node in the nodeMap
	var nodeID = "";
	var chainSubMap = global.nodeMap[? obj_chain.currentFocusedChainID];
	if (is_numeric(chainSubMap)) {
		if (ds_exists(chainSubMap, ds_type_map)) {
			
			// get the sourceID for the link
			linkSourceID = chainSubMap[? "focused"];
			
			// get the setIDList for this chain's node
			var idList = chainSubMap[? "setIDList"];
			if (is_numeric(idList)) {
				if (ds_exists(idList, ds_type_list)) {
					
					// create a new node for this entry with type being rez, track, or stack
					nodeID = scr_addToNodeMap(nodeType);
					obj_control.newestEntry = nodeID;
					
					// set entry node values in nodeMap
					var setSubMap = ds_map_find_value(global.nodeMap, nodeID)
					is_numeric(setSubMap) {
						if (ds_exists(setSubMap, ds_type_map)) {
							ds_map_add(setSubMap, "chain", obj_chain.currentFocusedChainID);
							ds_map_add(setSubMap, (obj_toolPane.currentTool == obj_toolPane.toolStackBrush) ? "unit" : "word", idSet);
							ds_map_add(setSubMap, "sourceLink", "");
							ds_map_add_list(setSubMap, "goalLinkList", ds_list_create());
							if (obj_toolPane.currentTool == obj_toolPane.toolRezBrush) {
								ds_map_add(setSubMap, "alignEntry", true);
							}
							else if (obj_toolPane.currentTool == obj_toolPane.toolTrackBrush) {
								ds_map_add(setSubMap, "alignEntry", false);
							}
							
							// add tagmap to this entry's submap
							var tagMap = ds_map_create();
							ds_map_add_map(setSubMap, "tagMap", tagMap);
							
							ds_map_add(setSubMap, "stretch", false);
						}
					}

					// check if this chain already contains this node
					// otherwise add it to the chain's idList
					if (ds_list_find_index(idList, nodeID) == -1) {
						ds_list_add(idList, nodeID);
						
						// let's also tell this chain that this new node should be focused
						ds_map_replace(chainSubMap, "focused", nodeID);
					}
					

					
					// set wordDrawGrid if this is a rez or track
					if ((nodeType == "rez" || nodeType == "track") && !isChunk) {
						var chainColor = ds_map_find_value(chainSubMap, "chainColor");
						//ds_grid_set(obj_control.wordDrawGrid, (nodeType == "rez") ? obj_control.wordDrawGrid_colBorder : obj_control.wordDrawGrid_colBorderRounded, wordID - 1, true);
						//ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colEffectColor, wordID - 1, chainColor);
					}
					
					
					
					// sort the displayed links
					scr_sortVizSetIDList(obj_chain.currentFocusedChainID);
					
					show_debug_message("scr_newLink() ... entry nodeID: " + string(nodeID));
				}
			}
		}
	}
	
	
	if (nodeID == "") {
		show_debug_message("scr_newLink() ... ERROR: nodeID is blank string. Exiting...");
		exit;
	}
		
		
	// if this is a rez or track, we will make sure we are adding to the word's inChainsList
	if (nodeType == "rez" || nodeType == "track" || nodeType == "stack") {
		var entryWordInChainsList = -1;
		if (isChunk) {
			var chunkSubMap = global.nodeMap[?ID];
			if(scr_isNumericAndExists(chunkSubMap, ds_type_map)){
				entryWordInChainsList = chunkSubMap[? "inChainsList"];
			}
		}
		else {
			var tokenSubMap = global.nodeMap[?idSet];
			if(scr_isNumericAndExists(tokenSubMap, ds_type_map)){
				entryWordInChainsList = tokenSubMap[? "inChainsList"];
			}
		}
		if(scr_isNumericAndExists(entryWordInChainsList, ds_type_list)){
			if (ds_list_find_index(entryWordInChainsList, obj_chain.currentFocusedChainID) == -1) {
				ds_list_add(entryWordInChainsList, obj_chain.currentFocusedChainID);
			}
		}
	}
	
	// switch panel pane to corresponding tab
	with (obj_panelPane) {
		switch (nodeType) {
			case "rez":
				//functionChainList_currentTab = functionChainList_tabRezBrush;
				break;
			case "track":
				//functionChainList_currentTab = functionChainList_tabTrackBrush;
				break;
			case "stack":
				//functionChainList_currentTab = functionChainList_tabStackBrush;
				break;
			default:
				break;
		}
		
		
		/*
		set id to hop to nav window to
		var chunksFirstWord = -1;
		if (currentFunction == functionChainContents) {
			chunksFirstWord = scr_getFirstWordOfChunk(idSet);
			if (chunksFirstWord >= 0){
				functionChainContents_hop = chunksFirstWord;
			}
			else{
				functionChainContents_hop = idSet;
			}
		}
		*/
	}
	
	var linkGoalID = nodeID;
	if(ds_map_exists(global.nodeMap,linkSourceID) and ds_map_exists(global.nodeMap,linkGoalID) ){
		// create a node for the link (now that we know its source & goal)
		
		var linkID = scr_addToNodeMap("link");
		var linkSubMap = ds_map_find_value(global.nodeMap, linkID);
		ds_map_add(linkSubMap, "source", linkSourceID);
		ds_map_add(linkSubMap, "goal", linkGoalID);
		
		// add this link to the chain's linkIDList
		var chainLinkIDList = ds_map_find_value(chainSubMap, "linkIDList");
		ds_list_add(chainLinkIDList, linkID);
		
		// add this new link to the source's goalLinkList
		var sourceSetSubMap = ds_map_find_value(global.nodeMap, linkSourceID);
		if (is_numeric(sourceSetSubMap)) {
			if (ds_exists(sourceSetSubMap, ds_type_map)) {
				var sourceSetGoalLinkList = ds_map_find_value(sourceSetSubMap, "goalLinkList");
				if (is_numeric(sourceSetGoalLinkList)) {
					if (ds_exists(sourceSetGoalLinkList, ds_type_list)) {
						ds_list_add(sourceSetGoalLinkList, linkID);
						show_debug_message("scr_newLink() ... adding " + string(linkID) + " to " + string(sourceSetSubMap));
					}
				}
			}
		}
		
		// add this new link to the goal's source
		var goalSetSubMap = ds_map_find_value(global.nodeMap, linkGoalID);
		if (is_numeric(goalSetSubMap)) {
			if (ds_exists(goalSetSubMap, ds_type_map)) {
				ds_map_replace(goalSetSubMap, "sourceLink", linkID);
				show_debug_message("scr_newLink() ... adding " + string(linkID) + " to " + string(goalSetSubMap));
			}
		}
	}
	
	if (obj_toolPane.currentTool == obj_toolPane.toolRezBrush) {
		scr_alignChain2ElectricBoogaloo(obj_chain.currentFocusedChainID);
	}
	
	show_debug_message("scr_newLink() ... end of script for ID: " + string(ID));

}
