// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_tokenClicked(tokenID){
	
	if (global.delayInput > 0) exit;
	
	// get this token's submap and make sure it exists
	var tokenSubMap = global.nodeMap[?tokenID];
	if(!scr_isNumericAndExists(tokenSubMap, ds_type_map)){exit;}
	show_debug_message("scr_tokenClicked ... tokenID: " + string(tokenID));
	
	var unitID = tokenSubMap[?"unit"];

	if (obj_control.gridView or (obj_control.mouseoverPanelPane and not obj_stacker.splitSave) or obj_control.dialogueBoxActive or instance_exists(obj_dialogueBox) or instance_exists(obj_dropDown) or instance_exists(obj_flyout)) {
		var shouldExit = true;
		if (obj_control.dialogueBoxActive or instance_exists(obj_dialogueBox)) {
			if (obj_dialogueBox.combineChains) {
				shouldExit = false;	
			}
		}
		if (shouldExit) {
			exit;
		}
	}
	
	//deselect tree pane chain entities
	obj_panelPane.functionTree_treeLinkSelected = "";
	obj_chain.currentFocusedEntryID = "";
	

	// jump audio position to unitStart time (if audioUI is visible)
	if (instance_exists(obj_audioUI)) {
		if (obj_audioUI.visible and file_exists(obj_audioUI.audioFile) and obj_audioUI.audioSound != -1) {
			scr_audioJumpToUnit(unitID);
		}
	}
	
	
	// if there is a focused chain, but you are not on the tool of that chain, cancel this click
	if (obj_chain.focusedChainWrongTool) {
		exit;
	}
	
	if (ds_list_size(obj_control.inRectWordIDList) <= 1 && obj_toolPane.currentTool != obj_toolPane.toolBoxBrush) {
		obj_control.moveCounter++;
	}
	
	var inChainsList = tokenSubMap[?"inChainsList"];
	show_debug_message("scr_tokenClicked ... inChainsList: " + scr_getStringOfList(inChainsList));
	
	
	// loop through the chains that this token is already in (if any) to refocus that chain
	if (obj_toolPane.currentTool != obj_toolPane.toolPlaceChains and obj_toolPane.currentTool != obj_toolPane.toolBoxBrush) {
		var inChainsListSize = ds_list_size(inChainsList);
		for (var i = 0; i < inChainsListSize; i++) {
			var currentChainID = inChainsList[| i];
			var currentChainSubMap = global.nodeMap[? currentChainID];
			var currentChainType = currentChainSubMap[? "type"];
			
			// check whether we should refocus this word's entry or not
			var refocusEntry = (currentChainType == "rezChain" && obj_toolPane.currentMode == obj_toolPane.modeRez)
			or (currentChainType == "trackChain" && obj_toolPane.currentMode == obj_toolPane.modeTrack)
			or (obj_toolPane.currentMode == obj_toolPane.modeRead);
	
			if (refocusEntry) {
				obj_chain.currentFocusedChainID = currentChainID;				
				scr_refocusChainEntry(tokenID);
				exit;
			}
		}
	}
	
	// set field/tags if in read mode
	if (obj_toolPane.currentMode == obj_toolPane.modeRead) {
		if (obj_panelPane.functionField_tokenFieldSelected != "" && obj_panelPane.functionField_tokenTagSelected != ""
		&& is_string(obj_panelPane.functionField_tokenFieldSelected) && is_string(obj_panelPane.functionField_tokenTagSelected)) {
			var tokenTagMap = tokenSubMap[? "tagMap"];
			if (scr_isNumericAndExists(tokenTagMap, ds_type_map)) {
				tokenTagMap[? obj_panelPane.functionField_tokenFieldSelected] = obj_panelPane.functionField_tokenTagSelected;
				show_debug_message("scr_tokenClicked ... setting token: " + string(tokenID) + ", field:" + string(obj_panelPane.functionField_tokenFieldSelected) + ", tag: " + string(obj_panelPane.functionField_tokenTagSelected));
			}
		}
	}
	
	// if we are in read mode, don't go any further
	if (obj_toolPane.currentMode == obj_toolPane.modeRead) {
		exit;
	}

	// if there is not a focused chain, we create a new chain
	if (!ds_map_exists(global.nodeMap, obj_chain.currentFocusedChainID)) {
		scr_newChain(tokenID);
	}

	// add new link and refresh chain grid
	scr_newLink(tokenID);
	
	obj_control.allSaved = false;
	
	
	scr_refocusChainEntry(tokenID);
}