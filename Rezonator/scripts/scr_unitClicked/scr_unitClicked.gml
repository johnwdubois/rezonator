function scr_unitClicked(unitID) {
	
	if (global.delayInput > 0) exit;
	
	
	// get submap for this unit and make sure it exists
	var unitSubMap = global.nodeMap[? unitID];
	if (!scr_isNumericAndExists(unitSubMap, ds_type_map)) exit;
	show_debug_message("scr_unitClicked ... unitID: " + string(unitID));
	
	
	//deselect tree pane chain entities
	obj_panelPane.functionTree_treeLinkSelected = "";
	obj_chain.currentFocusedEntryID = "";
	
	// With Audio, jump to this line's start time in the Audio File
	if (instance_exists(obj_audioUI)) {
		if (obj_audioUI.visible and file_exists(obj_audioUI.audioFile) and obj_audioUI.audioSound != -1) {
			scr_audioJumpToUnit(unitID);
		}
	}
	
	
	// get inChainsList for this unit
	var inChainsList = unitSubMap[? "inChainsList"];
	var inChainsListSize = ds_list_size(inChainsList);
	
	obj_toolPane.currentTool = obj_toolPane.toolStackBrush;
	
	// get stack, if this unit is in one
	var stackID = "";
	if (inChainsListSize >= 1) {
		stackID = inChainsList[| 0];
	}
	
	// merge stacks
	show_debug_message("scr_unitClicked, stackID: " + string(stackID) + ", mergeStackID: " + string(obj_chain.mergeStackID));
	if (inChainsListSize >= 1 && is_string(obj_chain.mergeStackID) && obj_chain.mergeStackID != "" && is_string(stackID) && stackID != "") {
		//scr_combineChains(obj_chain.mergeStackID, stackID);
		//with (obj_chain) mergeStackID = "";
		with (obj_control) combineChainsSelected = stackID;
		var inst = instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
		with (inst) {
			questionWindowActive = true;
			combineChains = true;
		}
		exit;
	}
	
	
	
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
			show_debug_message("TAGGIN THAT CHAIN BB");
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
						
					var entryTokenID = entrySubMap[? "unit"];
						
					if (entryTokenID == unitID) {
						var tagMap = entrySubMap[? "tagMap"];
						if (scr_isNumericAndExists(tagMap,ds_type_map)) {
							tagMap[?obj_panelPane.functionField_entryFieldSelected] = obj_panelPane.functionField_entryTagSelected;
						}	
					}
				}
			}
		}
	}
	// set field/tags if in read mode
	if (obj_toolPane.currentMode == obj_toolPane.modeRead && !keyboard_check(vk_alt) && !keyboard_check(vk_shift)) {
		if (obj_panelPane.functionField_unitFieldSelected != "" && obj_panelPane.functionField_unitTagSelected != ""
		&& is_string(obj_panelPane.functionField_unitFieldSelected) && is_string(obj_panelPane.functionField_unitTagSelected)) {
			var unitTagMap = unitSubMap[? "tagMap"];
			if (scr_isNumericAndExists(unitTagMap, ds_type_map)) {
				if (obj_panelPane.functionField_unitTagSelected == scr_get_translation("menu_clear")) {
					unitTagMap[? obj_panelPane.functionField_unitFieldSelected] = "";
				}
				else{
					unitTagMap[? obj_panelPane.functionField_unitFieldSelected] = obj_panelPane.functionField_unitTagSelected;
					show_debug_message("scr_unitClicked ... setting unit: " + string(unitID) + ", field:" + string(obj_panelPane.functionField_unitFieldSelected) + ", tag: " + string(obj_panelPane.functionField_unitTagSelected));
				}
			}
		}
	}
	
	
	// refocus any chain that this unit is in
	for (var i = 0; i < inChainsListSize; i++) {
		var currentChainID = inChainsList[| i];
		var currentChainSubMap = global.nodeMap[? currentChainID];

		if (!scr_isNumericAndExists(currentChainSubMap, ds_type_map)) {continue;}
		var currentChainType = currentChainSubMap[? "type"];
			
		// check whether we should refocus this word's entry or not
		var refocusEntry = (currentChainType == "stack");
		if (refocusEntry) {
			obj_chain.currentFocusedChainID = currentChainID;
			scr_refocusChainEntry(unitID);
			exit;
		}
	}


	// if there is not a focused chain, we create a new chain
	if (!ds_map_exists(global.nodeMap, obj_chain.currentFocusedChainID)) {
		scr_newChain(unitID);
	}

	// add new link and refresh chain grid
	scr_newLink(unitID);

	obj_control.allSaved = false;
	
	scr_refocusChainEntry(unitID);
	
}