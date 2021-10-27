// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_unitClicked(unitID){
	
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
		if (obj_audioUI.visible and obj_audioUI.audioSound != -1) {
			scr_audioJumpToUnit(unitID);
		}
	}
	
	
	// get inChainsList for this unit
	var inChainsList = unitSubMap[? "inChainsList"];
	var inChainsListSize = ds_list_size(inChainsList);
	
	obj_toolPane.currentTool = obj_toolPane.toolStackBrush;
	
	if(keyboard_check(vk_shift)){
		if (obj_panelPane.functionField_chainFieldSelected != "" && obj_panelPane.functionField_chainTagSelected != ""
		&& is_string(obj_panelPane.functionField_chainFieldSelected) && is_string(obj_panelPane.functionField_chainTagSelected)) {
				
				
			var inChainsListSize = ds_list_size(inChainsList);
			for (var i = 0; i < inChainsListSize; i++) {
				var currentChainID = inChainsList[| i];
				var currentChainSubMap = global.nodeMap[? currentChainID];
				
				if (scr_isNumericAndExists(currentChainSubMap, ds_type_map)) {
					var tagMap = currentChainSubMap[?"tagMap"];
					tagMap[? obj_panelPane.functionField_chainFieldSelected] = obj_panelPane.functionField_chainTagSelected;
				}
			}
			show_debug_message("TAGGIN THAT CHAIN BB");
		}
	}
	else if(keyboard_check(vk_alt)){
		if (obj_panelPane.functionField_entryFieldSelected != "" && obj_panelPane.functionField_entryTagSelected != ""
		&& is_string(obj_panelPane.functionField_entryFieldSelected) && is_string(obj_panelPane.functionField_entryTagSelected)) {
				
			var inChainsListSize = ds_list_size(inChainsList);
			for (var i = 0; i < inChainsListSize; i++) {
				var currentChainID = inChainsList[| i];
				var currentChainSubMap = global.nodeMap[? currentChainID];
				
				var setIDList = currentChainSubMap[?"setIDList"];
				var setIDListSize = ds_list_size(setIDList);
					
				for(var j = 0; j < setIDListSize;j ++){
						
					var currentEntry = setIDList[|j];
					var entrySubMap = global.nodeMap[?currentEntry];
						
					var entryTokenID = entrySubMap[?"unit"];
						
					if(entryTokenID == unitID){
						var tagMap = entrySubMap[?"tagMap"];
						if(scr_isNumericAndExists(tagMap,ds_type_map)){
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
				unitTagMap[? obj_panelPane.functionField_unitFieldSelected] = obj_panelPane.functionField_unitTagSelected;
				show_debug_message("scr_unitClicked ... setting unit: " + string(unitID) + ", field:" + string(obj_panelPane.functionField_unitFieldSelected) + ", tag: " + string(obj_panelPane.functionField_unitTagSelected));
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