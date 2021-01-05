/*
	scr_newLink(wordID, goal);
	
	Last Updated: 2018-09-11
	
	Called from: obj_chain
	
	Purpose: the user has created a link, so this script will add it to the linkGrid
	
	Mechanism: add row to linkGrid and fill in column information from given arguments
	
	Author: Terry DuBois
*/
function scr_newLink(wordID, goal) {
	
	show_debug_message("scr_newLink() ... wordID: " + string(wordID) + ", goal: " + string(goal));

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
			obj_control.moveCounter ++;
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
	
	// find this chain's node in the nodeMap
	var nodeID = "";
	var subMap = ds_map_find_value(global.nodeMap, currentFocusedChainID);
	if (is_numeric(subMap)) {
		if (ds_exists(subMap, ds_type_map)) {
			
			// get the idList for this chain's node
			var idList = ds_map_find_value(subMap, "idList");
			if (is_numeric(idList)) {
				if (ds_exists(idList, ds_type_list)) {
					
					// create a new node for this link with type being rez, track, or stack
					nodeID = scr_addToNodeMap(nodeType);
					
					// set link node values in nodeMap
					var subMap = ds_map_find_value(global.nodeMap, nodeID)
					is_numeric(subMap) {
						if (ds_exists(subMap, ds_type_map)) {
							ds_map_add(subMap, "chain", currentFocusedChainID);
						}
					}
					
					// check if this chain already contains this node
					// otherwise add it to the chain's idList
					if (ds_list_find_index(idList, nodeID) == -1) {
						ds_list_add(idList, nodeID);
					}
					
					show_debug_message("scr_newLink() ... link nodeID: " + string(nodeID));
				}
			}
		}
	}
	
	if (nodeID == "") {
		show_debug_message("scr_newLink() ... ERROR: nodeID is blank string. Exiting...");
		exit;
	}

	// add new row to linkGrid
	ds_grid_resize(obj_chain.linkGrid, obj_chain.linkGridWidth, ds_grid_height(obj_chain.linkGrid) + 1);
	var currentLinkGridRow = ds_grid_height(obj_chain.linkGrid) - 1;
	if (obj_chain.linkIDCounter == undefined) {
		obj_chain.linkIDCounter = 0;
	}
	obj_chain.linkIDCounter++;


	// if this new word is the goal of a previous link, we must update the linkGrid on that row
	var focusedRow = scr_findInGridTwoParameters(obj_chain.linkGrid, obj_chain.linkGrid_colChainID, currentFocusedChainID, obj_chain.linkGrid_colGoal, -1);
	
	// Does not need to happen when a link was deleted
	if (focusedRow > -1 and focusedRow < ds_grid_height(obj_chain.linkGrid) and not obj_control.linkDeleted) {
		ds_grid_set(obj_chain.linkGrid, obj_chain.linkGrid_colGoal, focusedRow, idSet);
		ds_grid_set(obj_chain.linkGrid, obj_chain.linkGrid_colGoalClickTime, focusedRow, (current_time - obj_control.sessionStartTime) / 1000);
	}

	
	// fill in info for new row in linkGrid
	ds_grid_set_region(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, 0, obj_chain.linkGrid_colFocus, ds_grid_height(obj_chain.linkGrid), false);
	ds_grid_set(obj_chain.linkGrid, obj_chain.linkGrid_colChainID, currentLinkGridRow, currentFocusedChainID);
	ds_grid_set(obj_chain.linkGrid, obj_chain.linkGrid_colLinkID, currentLinkGridRow, nodeID);
	ds_grid_set(obj_chain.linkGrid, obj_chain.linkGrid_colTier, currentLinkGridRow, currentChainTier);
	ds_grid_set(obj_chain.linkGrid, obj_chain.linkGrid_colSource, currentLinkGridRow, idSet);
	ds_grid_set(obj_chain.linkGrid, obj_chain.linkGrid_colGoal, currentLinkGridRow, goal);
	ds_grid_set(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, currentLinkGridRow, focus);
	ds_grid_set(obj_chain.linkGrid, obj_chain.linkGrid_colDead, currentLinkGridRow, false);
	ds_grid_set(obj_chain.linkGrid, obj_chain.linkGrid_colTilt, currentLinkGridRow, 0);
	ds_grid_set(obj_chain.linkGrid, obj_chain.linkGrid_colSourceClickTime, currentLinkGridRow, (current_time - obj_control.sessionStartTime) / 1000);
	ds_grid_set(obj_chain.linkGrid, obj_chain.linkGrid_colGoalClickTime, currentLinkGridRow, -1);

	// sort linkGrid based on tier, chainID, and dead
	scr_gridMultiColSort(linkGrid, linkGrid_colTier, true, linkGrid_colChainID, true, linkGrid_colDead, true);

	// switch panel pane to corresponding tab
	with (obj_panelPane) {
		switch (obj_toolPane.currentTool) {
			case obj_toolPane.toolRezBrush:
				functionChainList_currentTab = functionChainList_tabRezBrush;
				break;
			case obj_toolPane.toolTrackBrush:
				functionChainList_currentTab = functionChainList_tabTrackBrush;
				break;
			case obj_toolPane.toolStackBrush:
				functionChainList_currentTab = functionChainList_tabStackBrush;
				break;
			default:
				break;
		}
		
		if (currentFunction == functionChainContents) {
			functionChainContents_hop = idSet;
		}
	}
	

	if (obj_toolPane.currentTool == obj_toolPane.toolRezBrush) {
		scr_addToCliqueGrid(wordID, currentFocusedChainID);
	}

	alarm[3] = 1;
	with(obj_panelPane) {
		ds_list_clear(rowInLinkGridList);	
	}


}
