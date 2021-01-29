/*
	scr_newLink(wordID);
	
	Last Updated: 2018-09-11
	
	Called from: obj_chain
	
	Purpose: the user has created a link, so this script will add it to the node map
	
	Mechanism: create new node in map for link
	
	Author: Terry DuBois
*/
function scr_newLink(wordID) {
	
	show_debug_message("scr_newLink() ... wordID: " + string(wordID));

	//New funtionality for recording chain modification
	while (ds_list_find_index(obj_chain.chainIDModifyList, currentFocusedChainID) > -1) {
		var ind = ds_list_find_index(obj_chain.chainIDModifyList, currentFocusedChainID);
		ds_list_delete(obj_chain.chainIDModifyList, ind);
	}
	ds_list_insert(obj_chain.chainIDModifyList, 0, currentFocusedChainID);

	var focus = true;


	if (wordID == undefined) {
		exit;
	}

	var unitID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, wordID - 1);
	if (unitID == undefined) {
		exit;
	}
	
	if (obj_toolPane.currentTool == obj_toolPane.toolStackBrush) {
		var idSet = unitID;
		if (obj_control.quickStackAbleToInitiate) {
			obj_control.moveCounter++;
		}
	}
	else {
		var idSet = wordID;
		obj_control.mostRecentlyAddedWord = wordID;
	}

	if (currentFocusedChainID = "") {
		show_debug_message("scr_newLink() ... ERROR: currentFocusedChainID is blank string. Exiting...");
		exit;
	}
	
	// determine the tier/type of this link
	var nodeType = "rez";
	var currentChainTier = obj_chain.rezTier;
	if (obj_toolPane.currentTool == obj_toolPane.toolTrackBrush) {
		currentChainTier = obj_chain.trackTier;
		nodeType = "track";
	}
	else if (obj_toolPane.currentTool == obj_toolPane.toolStackBrush) {
		currentChainTier = obj_chain.stackTier;
		nodeType = "stack";
	}
	
	var linkSourceID = ""; 
	
	// add an item/entry (rez/track/stack) to the nodeMap
	// find this chain's node in the nodeMap
	var nodeID = "";
	var chainSubMap = ds_map_find_value(global.nodeMap, currentFocusedChainID);
	if (is_numeric(chainSubMap)) {
		if (ds_exists(chainSubMap, ds_type_map)) {
			
			// get the sourceID for the link
			linkSourceID = ds_map_find_value(chainSubMap, "focused");
			
			// get the setIDList for this chain's node
			var idList = ds_map_find_value(chainSubMap, "setIDList");
			if (is_numeric(idList)) {
				if (ds_exists(idList, ds_type_list)) {
					
					// create a new node for this entry with type being rez, track, or stack
					nodeID = scr_addToNodeMap(nodeType);
					
					// set entry node values in nodeMap
					var setSubMap = ds_map_find_value(global.nodeMap, nodeID)
					is_numeric(setSubMap) {
						if (ds_exists(setSubMap, ds_type_map)) {
							ds_map_add(setSubMap, "chain", currentFocusedChainID);
							ds_map_add(setSubMap, (obj_toolPane.currentTool == obj_toolPane.toolStackBrush) ? "unit" : "word", idSet);
							ds_map_add(setSubMap, "sourceLink", "");
							ds_map_add_list(setSubMap, "goalLinkList", ds_list_create());
							if (obj_toolPane.currentTool == obj_toolPane.toolRezBrush) {
								ds_map_add(setSubMap, "alignEntry", true);
							}
							else if (obj_toolPane.currentTool == obj_toolPane.toolTrackBrush) {
								ds_map_add(setSubMap, "alignEntry", false);
							}
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
					if (nodeType == "rez" || nodeType == "track") {
						var chainColor = ds_map_find_value(chainSubMap, "chainColor");
						ds_grid_set(obj_control.wordDrawGrid, (nodeType == "rez") ? obj_control.wordDrawGrid_colBorder : obj_control.wordDrawGrid_colBorderRounded, wordID - 1, true);
						ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colEffectColor, wordID - 1, chainColor);
						
						// sort the displayed links
						scr_sortVizSetIDList(currentFocusedChainID);
					}
					
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
	if (nodeType == "rez" || nodeType == "track") {
		var entryWordInChainsList = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInChainList, idSet - 1);
		if (ds_list_find_index(entryWordInChainsList, obj_chain.currentFocusedChainID) == -1) {
			ds_list_add(entryWordInChainsList, obj_chain.currentFocusedChainID);
		}
	}
	// if this is a stack, we will make sure this unit is updated in the unitInStackGrid
	else if (nodeType == "stack") {
		ds_grid_set(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colStack, idSet - 1, currentFocusedChainID);
		ds_grid_set(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colStackType, idSet - 1, 0);
		show_debug_message("scr_newLink() ... idSet: " + string(idSet));
	}
	
		// switch panel pane to corresponding tab
	with (obj_panelPane) {
		switch (nodeType) {
			case "rez":
				functionChainList_currentTab = functionChainList_tabRezBrush;
				break;
			case "track":
				functionChainList_currentTab = functionChainList_tabTrackBrush;
				break;
			case "stack":
				functionChainList_currentTab = functionChainList_tabStackBrush;
				break;
			default:
				break;
		}
		
		if (currentFunction == functionChainContents) {
			functionChainContents_hop = idSet;
		}
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

}
