function scr_objControlKeyDelete() {

	// putting this stuff in its own script so that it's the same for Windows & Mac
	

	if (obj_control.gridView || instance_exists(obj_dialogueBox)|| instance_exists(obj_inputBox) || obj_control.navWindowTaggingID != "") {
		exit;	
	}

	show_debug_message("scr_objControlKeyDelete");


	if (global.ctrlHold) {
		
		// if there is a valid chain focused, prompt a dialogue box to confirm chain deletion
		if (ds_map_exists(global.nodeMap, obj_chain.currentFocusedChainID) && obj_chain.currentFocusedChainID != "" && is_string(obj_chain.currentFocusedChainID)) {
			if (!instance_exists(obj_dialogueBox)) {
				instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
				obj_control.selectedChainID = obj_chain.currentFocusedChainID;
				obj_dialogueBox.clearChain = true;
				obj_dialogueBox.questionWindowActive = true;
			}
		}
	}
	// If a normal delete, delete the singular focused link
	else {

		if (is_string(obj_chain.currentFocusedChainID) && obj_chain.currentFocusedChainID != "") {
			var focusedChainSubMap = global.nodeMap[? obj_chain.currentFocusedChainID];
			if (scr_isNumericAndExists(focusedChainSubMap, ds_type_map)) {
				
				var focusedChainSetIDList = focusedChainSubMap[? "setIDList"];
				if (scr_isNumericAndExists(focusedChainSetIDList, ds_type_list)) {
					if (ds_list_size(focusedChainSetIDList) >= 2) {
						scr_deleteFromChain(true);
					}
					else {
						var focusedChainType = focusedChainSubMap[? "type"];
						if (focusedChainType == "resonance") obj_control.deleteRez = true;
						else if (focusedChainType == "trail") obj_control.deleteTrack = true;
						else if (focusedChainType == "stack") obj_control.deleteStack = true;
						if (!instance_exists(obj_dialogueBox) && (obj_control.deleteRez || obj_control.deleteTrack || obj_control.deleteStack)) {
							instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
							obj_control.selectedChainID = obj_chain.currentFocusedChainID;
							obj_dialogueBox.questionWindowActive = true;
						}
					}
				}
			}
		}
	
		if (obj_chain.currentFocusedChunkID != "") {
			scr_deleteChunk(obj_chain.currentFocusedChunkID);
		}
		
		with (obj_panelPane) {
			if (functionChainList_currentTab == NAVTAB_SHOW && functionChainContents_showID != "") {
				scr_deleteShow(obj_control.selectedChainID);
			}	
			if (functionChainList_currentTab == NAVTAB_TREE && obj_panelPane.functionTree_treeLinkSelected != "") {
				scr_deleteTreeLink();
				exit;
			}
			if (functionChainList_currentTab == NAVTAB_TREE && obj_control.deleteEntryPressed == false) {
				scr_deleteTreeEntry();
				exit;
			}

		}
	
	}



}