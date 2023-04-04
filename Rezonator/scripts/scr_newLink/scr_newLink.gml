/*	
	Purpose: the user has created a link, so this script will add it to the node map
*/
function scr_newLink(ID) {
	
	
	if (obj_toolPane.currentMode == obj_toolPane.modeRead) exit;
	if (obj_control.mouseoverBackArrowStopClick || obj_control.mouseoverBackArrow) exit;
	
	
	ds_list_clear(obj_control.chainStretchCheckList);
		
	// make sure this is a valid ID
	var idSubMap = global.nodeMap[? ID];
	if (!scr_isNumericAndExists(idSubMap, ds_type_map)) {
		show_debug_message("scr_newLink, ID does not exist: " + string(ID) + ", exiting...")
		exit;
	}
	
	
	var unitID = "";
	var tokenID = "";
	var type = idSubMap[? "type"];
	show_debug_message("scr_newLink ... ID: " + string(ID) + ", type: " + string(type));
	
	
	if (type == "unit") {
		unitID = ID
		var entryList = idSubMap[? "entryList"];
		if (!scr_isNumericAndExists(entryList, ds_type_list)) exit;
		if (ds_list_size(entryList) < 1) exit;
		var firstEntry = entryList[|0];
		var entrySubMap = global.nodeMap[?firstEntry];
		tokenID = entrySubMap[? "token"];
	}
	else if (type == "token") {
		unitID = idSubMap[? "unit"];
		tokenID = ID;
	}
	else if (type == "chunk") {
		var tokenList = idSubMap[? "tokenList"];
		if (scr_isNumericAndExists(tokenList, ds_type_list)) {
			if (ds_list_size(tokenList) >= 1) {
				var firstToken = tokenList[| 0];
				var firstTokenSubMap = global.nodeMap[? firstToken];
				unitID = firstTokenSubMap[? "unit"];
			}
		}
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
		if (isChunk) {
			idSet = ID;
		}
		else {
			idSet = tokenID;
		}
		obj_control.mostRecentlyAddedWord = tokenID;
	}
	

	// make sure there is a focused chain
	if (!is_string(obj_chain.currentFocusedChainID) || obj_chain.currentFocusedChainID = "") {
		show_debug_message("scr_newLink ... ERROR: currentFocusedChainID is invalid. Exiting...");
		exit;
	}
	
	// get type of focused chain
	var focusedChainSubMap = global.nodeMap[? obj_chain.currentFocusedChainID];
	var focusedChainType = focusedChainSubMap[? "type"];
	
	// determine the tier/type of this link
	var nodeType = "rez";
	if (focusedChainType == "trail") {
		nodeType = "track";
	}
	else if (focusedChainType == "stack") {
		nodeType = "card";
		
		// if this is a stack, let's check if its stacking is active
		var focusedChainStacking = focusedChainSubMap[? "stacking"];
		if (focusedChainStacking != obj_control.activeStacking) {
			show_debug_message("scr_newLink, focusedChainStacking inactive");
			exit;
		}
	}
	
	var linkSourceID = ""; 
	
	// add an entry (rez/track/stack) to the nodeMap
	// find this chain's node in the nodeMap
	var nodeID = "";
	var chainSubMap = global.nodeMap[? obj_chain.currentFocusedChainID];
	if (scr_isNumericAndExists(chainSubMap, ds_type_map)) {
			
		// get the sourceID for the link
		linkSourceID = chainSubMap[? "focused"];
			
		// get the setIDList for this chain's node
		var idList = chainSubMap[? "setIDList"];
		if (scr_isNumericAndExists(idList, ds_type_list)) {
					
			// create a new node for this entry with type being rez, track, or stack
			nodeID = scr_addToNodeMap(nodeType);
			obj_control.newestEntry = nodeID;
					
			// set entry node values in nodeMap
			var setSubMap = ds_map_find_value(global.nodeMap, nodeID)
			if (scr_isNumericAndExists(setSubMap, ds_type_map)) {

				ds_map_add(setSubMap, "chain", obj_chain.currentFocusedChainID);
				ds_map_add(setSubMap, (focusedChainType == "stack") ? "unit" : "token", idSet);
				ds_map_add(setSubMap, "sourceLink", "");
				ds_map_add(setSubMap, "clickTime", scr_getCurrentSessionTime() / 1000);
				ds_map_add_list(setSubMap, "goalLinkList", ds_list_create());
							
				// add tagmap to this entry's submap
				var tagMap = ds_map_create();
				ds_map_add_map(setSubMap, "tagMap", tagMap);
							
				ds_map_add(setSubMap, "stretch", false);
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
					
			show_debug_message("scr_newLink ... entry nodeID: " + string(nodeID));
		}
		
		
		// if this is a rez-chain, we will evaluate what clique it should be in
		if (nodeType == "rez") {
			var unitSubMap = global.nodeMap[? unitID];
			var unitInCliqueID = unitSubMap[? "inClique"];
			var chainInCliqueID = chainSubMap[? "inClique"];
			show_debug_message("scr_newLink, unitInCliqueID: " + string(unitInCliqueID) + ", chainInCliqueID: " + string(chainInCliqueID));
			if (is_string(chainInCliqueID) && chainInCliqueID != "") {
				if (is_string(unitInCliqueID) && unitInCliqueID != "") {
					if (unitInCliqueID != chainInCliqueID) {
						// in this case, we have two different cliques, we must merge the two
						scr_mergeCliques(chainInCliqueID, unitInCliqueID);
					}
				}
				else {
					// unit is not in any clique, therefore we can assign this unit to this chain's clique
					unitInCliqueID = chainInCliqueID;
					unitSubMap[? "inClique"] = unitInCliqueID;
					scr_refreshClique(unitInCliqueID);
				}
			}
		}
	}
	
	
	if (nodeID == "") {
		show_debug_message("scr_newLink ... ERROR: nodeID is blank string. Exiting...");
		exit;
	}
		
		
	// if this is a rez or track, we will make sure we are adding to the word's inChainsList
	if (nodeType == "rez" || nodeType == "track" || nodeType == "card") {
		var entryWordInChainsList = -1;
		var entryWordInEntryList = -1;
		if (isChunk) {
			var chunkSubMap = global.nodeMap[?ID];
			if (scr_isNumericAndExists(chunkSubMap, ds_type_map)) {
				entryWordInChainsList = chunkSubMap[? "inChainsList"];
				entryWordInEntryList = chunkSubMap[? "inEntryList"];
			}
		}
		else {
			var tokenSubMap = global.nodeMap[?idSet];
			if (scr_isNumericAndExists(tokenSubMap, ds_type_map)) {
				entryWordInChainsList = tokenSubMap[? "inChainsList"];
				entryWordInEntryList = tokenSubMap[? "inEntryList"];
			}
		}
		if (scr_isNumericAndExists(entryWordInChainsList, ds_type_list)) {
			scr_addToListOnce(entryWordInChainsList, obj_chain.currentFocusedChainID);
		}
		if (scr_isNumericAndExists(entryWordInEntryList, ds_type_list)) {
			scr_addToListOnce(entryWordInEntryList, nodeID);
		}
	}
	
	

	

	
	var linkGoalID = nodeID;
	if (ds_map_exists(global.nodeMap,linkSourceID) and ds_map_exists(global.nodeMap,linkGoalID)) {
		// create a node for the link (now that we know its source & goal)
		
		var linkID = scr_addToNodeMap("link");
		var linkSubMap = ds_map_find_value(global.nodeMap, linkID);
		ds_map_add(linkSubMap, "source", linkSourceID);
		ds_map_add(linkSubMap, "goal", linkGoalID);
		
		// determine subtype of this link
		var linkSubType = "";
		if (nodeType == "rez") linkSubType = "rez";
		else if (nodeType == "track") linkSubType = "track";
		else if (nodeType == "card") linkSubType = "stack";
		ds_map_add(linkSubMap, "subtype", linkSubType);
		
		
		// add this link to the chain's linkIDList
		var chainLinkIDList = ds_map_find_value(chainSubMap, "linkIDList");
		ds_list_add(chainLinkIDList, linkID);
		
		// add this new link to the source's goalLinkList
		var sourceSetSubMap = ds_map_find_value(global.nodeMap, linkSourceID);
		if (scr_isNumericAndExists(sourceSetSubMap, ds_type_map)) {
			var sourceSetGoalLinkList = ds_map_find_value(sourceSetSubMap, "goalLinkList");
			if (scr_isNumericAndExists(sourceSetGoalLinkList, ds_type_list)) {
				ds_list_add(sourceSetGoalLinkList, linkID);
				show_debug_message("scr_newLink ... adding " + string(linkID) + " to " + string(sourceSetSubMap));
			}
			
			// set clicktime for source
			if (ds_map_exists(sourceSetSubMap, "clickTime")) ds_map_add(linkSubMap, "sourceClickTime", sourceSetSubMap[? "clickTime"]);
		}
		
		// add this new link to the goal's source
		var goalSetSubMap = ds_map_find_value(global.nodeMap, linkGoalID);
		if (scr_isNumericAndExists(goalSetSubMap, ds_type_map)) {
			ds_map_replace(goalSetSubMap, "sourceLink", linkID);
			show_debug_message("scr_newLink ... adding " + string(linkID) + " to " + string(goalSetSubMap));
			
			// set clicktime for goal
			if (ds_map_exists(goalSetSubMap, "clickTime")) ds_map_add(linkSubMap, "goalClickTime", goalSetSubMap[? "clickTime"]);
		}
	}
	
	if (focusedChainType == "resonance") {
		show_debug_message("quickLink created:  "+ string(obj_chain.quickLinkCreated));
		
		var chainInCliqueID = chainSubMap[? "inClique"];
		scr_refreshChainOrderMap(chainInCliqueID);
		
		obj_chain.currentClique = chainInCliqueID;
		scr_cycleDetection(obj_chain.currentFocusedChainID);
		ds_list_clear(obj_chain.encounteredChainList);
		
		scr_alignChain2ElectricBoogaloo(obj_chain.currentFocusedChainID);
	}
	
	
	
	
	
	if (STEAMAPI) {
		var currentMaxChainLength = steam_get_stat_int("SA_entry-count");
		var currentChainLength = ds_list_size(idList);
		if (currentChainLength > currentMaxChainLength) {
			steam_set_stat_int("SA_entry-count",currentChainLength);
			if (steam_get_stat_int("SA_entry-count") >= 100 ) {
				if (!steam_get_achievement("SA_trail-100")) {
					steam_set_achievement("SA_trail-100");
				}
			}
		}
	}
	
	
	if (is_string(obj_chain.newChainRefreshClique) && obj_chain.newChainRefreshClique != "") {
		scr_refreshClique(obj_chain.newChainRefreshClique);
		with (obj_chain) newChainRefreshClique = "";
	}
	
	
	show_debug_message("scr_newLink ... end of script for ID: " + string(ID));
	
	

}
