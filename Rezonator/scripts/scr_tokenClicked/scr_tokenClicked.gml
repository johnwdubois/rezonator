function scr_tokenClicked(tokenID) {
	
	if (global.delayInput > 0) exit;
	
	// get this token's submap and make sure it exists
	var tokenSubMap = global.nodeMap[?tokenID];
	if (!scr_isNumericAndExists(tokenSubMap, ds_type_map)) {exit;}
	show_debug_message("scr_tokenClicked ... tokenID: " + string(tokenID));
	
	var unitID = tokenSubMap[? "unit"];

	if (obj_control.gridView or (obj_control.mouseoverPanelPane and not obj_stacker.splitSave) or obj_control.dialogueBoxActive or instance_exists(obj_dialogueBox) or instance_exists(obj_dropDown) or instance_exists(obj_flyout) or obj_toolPane.mouseOverToolPane) {
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
	with (obj_panelPane) functionTree_treeLinkSelected = "";
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
	
	var inChainsList = tokenSubMap[? "inChainsList"];
	show_debug_message("scr_tokenClicked ... inChainsList: " + scr_getStringOfList(inChainsList));
	
	var shouldExit = false;
	// loop through the chains that this token is already in (if any) to refocus that chain
	if (obj_toolPane.currentTool != obj_toolPane.toolPlaceChains and obj_toolPane.currentTool != obj_toolPane.toolBoxBrush) {
		var inChainsListSize = ds_list_size(inChainsList);
		for (var i = 0; i < inChainsListSize; i++) {
			var currentChainID = inChainsList[| i];
			var currentChainSubMap = global.nodeMap[? currentChainID];
			var currentChainType = currentChainSubMap[? "type"];
			
			// check whether we should refocus this word's entry or not
			var refocusEntry = (currentChainType == "resonance" && obj_toolPane.currentMode == obj_toolPane.modeRez)
			or (currentChainType == "trail" && obj_toolPane.currentMode == obj_toolPane.modeTrack)
			or (obj_toolPane.currentMode == obj_toolPane.modeRead);
	
			if (refocusEntry) {
				obj_chain.currentFocusedChainID = currentChainID;				
				scr_refocusChainEntry(tokenID);
				shouldExit = true;
			}
		}
	}
	
	// set field/tags if in read mode

	if (keyboard_check(vk_shift)) {
		if (obj_panelPane.functionField_chainFieldSelected != "" && obj_panelPane.functionField_chainTagSelected != ""
		&& is_string(obj_panelPane.functionField_chainFieldSelected) && is_string(obj_panelPane.functionField_chainTagSelected)) {
				
				
			var inChainsListSize = ds_list_size(inChainsList);
			for (var i = 0; i < inChainsListSize; i++) {
				var currentChainID = inChainsList[| i];
				var currentChainSubMap = global.nodeMap[? currentChainID];
				
				if (scr_isNumericAndExists(currentChainSubMap, ds_type_map)) {
					var tagMap = currentChainSubMap[? "tagMap"];
					tagMap[? obj_panelPane.functionField_chainFieldSelected] = obj_panelPane.functionField_chainTagSelected;
				}
			}
		}
	}
	else if (keyboard_check(vk_alt)) {
		if (obj_panelPane.functionField_entryFieldSelected != "" && obj_panelPane.functionField_entryTagSelected != ""
		&& is_string(obj_panelPane.functionField_entryFieldSelected) && is_string(obj_panelPane.functionField_entryTagSelected)) {
				
			var inChainsListSize = ds_list_size(inChainsList);
			for (var i = 0; i < inChainsListSize; i++) {
				var currentChainID = inChainsList[| i];
				var currentChainSubMap = global.nodeMap[? currentChainID];
				
				var setIDList = currentChainSubMap[? "setIDList"];
				var setIDListSize = ds_list_size(setIDList);
					
				for (var j = 0; j < setIDListSize;j++) {
						
					var currentEntry = setIDList[|j];
					var entrySubMap = global.nodeMap[?currentEntry];
						
					var entryTokenID = entrySubMap[? "token"];
						
					if (entryTokenID == tokenID) {
						var tagMap = entrySubMap[? "tagMap"];
						if (scr_isNumericAndExists(tagMap,ds_type_map)) {
							tagMap[?obj_panelPane.functionField_entryFieldSelected] = obj_panelPane.functionField_entryTagSelected;
						}	
					}
				}
			}
		}
	}
	
	
	if (obj_toolPane.currentMode == obj_toolPane.modeRead && !keyboard_check(vk_alt) && !keyboard_check(vk_shift)) {
		if (obj_panelPane.functionField_tokenFieldSelected != "" && obj_panelPane.functionField_tokenTagSelected != ""
		&& is_string(obj_panelPane.functionField_tokenFieldSelected) && is_string(obj_panelPane.functionField_tokenTagSelected)) {
			var tokenTagMap = tokenSubMap[? "tagMap"];
			if (scr_isNumericAndExists(tokenTagMap, ds_type_map)) {
				if (obj_panelPane.functionField_tokenTagSelected == scr_get_translation("menu_clear")) {
					tokenTagMap[? obj_panelPane.functionField_tokenFieldSelected] = "";
				}
				else{
				if (global.steamAPI) {
					if (!steam_get_achievement("SA_tag-token")) {
						steam_set_achievement("SA_tag-token");
					}
				}
				tokenTagMap[? obj_panelPane.functionField_tokenFieldSelected] = obj_panelPane.functionField_tokenTagSelected;
				show_debug_message("scr_tokenClicked ... setting token: " + string(tokenID) + ", field:" + string(obj_panelPane.functionField_tokenFieldSelected) + ", tag: " + string(obj_panelPane.functionField_tokenTagSelected));
				}
			}
		}
	}
	
	// if we are in read mode, don't go any further
	if (obj_toolPane.currentMode == obj_toolPane.modeRead or shouldExit) {
		exit;
	}

	// if there is not a focused chain, we create a new chain
	if (!ds_map_exists(global.nodeMap, obj_chain.currentFocusedChainID)) {
		scr_newChain(tokenID);
	}
	else {
		if (scr_checkUnitSideLink(unitID, obj_chain.currentFocusedChainID)) {
			var inst = instance_create_layer(0, 0, "InstancesDialogue", obj_dialogueBox);
			with (inst) {
				questionWindowActive = true;
				confirmSideLink = true;
			}
			obj_control.sideLinkTokenID = tokenID;
			exit;
		}
	}

	// add new link and refresh chain grid
	scr_newLink(tokenID);
	
	obj_control.allSaved = false;
	
	
	scr_refocusChainEntry(tokenID);
}