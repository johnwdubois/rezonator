function scr_quickStackCreation() {
	
	// make sure the first unit clicked on is the first unit in the list
	scr_deleteFromList(inRectUnitIDList, obj_chain.dragStartOriginalUnit);
	ds_list_insert(inRectUnitIDList, 0, obj_chain.dragStartOriginalUnit);
	
	show_debug_message("scr_quickStackCreation ... inRectUnitIDList: " + scr_getStringOfList(inRectUnitIDList));

	var inRectUnitIDListSize = ds_list_size(inRectUnitIDList);

	// Check for things caught in mouse drag rectangle
	obj_toolPane.currentTool = obj_toolPane.toolStackBrush;
	if (inRectUnitIDListSize > 0 && quickLinkAllowed) {
	
		// check if a chain is already focused
		var focusedChainIDSubMap = global.nodeMap[? obj_chain.currentFocusedChainID];
		if (scr_isNumericAndExists(focusedChainIDSubMap, ds_type_map)) {
			var focusedChainType = focusedChainIDSubMap[? "type"];
			if (focusedChainType == "stack") {
				// if the focused chain is a stack, let's check if its stacking is active
				var focusedChainStacking = focusedChainIDSubMap[? "stacking"];
				if (focusedChainStacking != obj_control.activeStacking) {
					if (!instance_exists(obj_dialogueBox)) {
						var inst = instance_create_layer(0, 0, "InstancesDialogue", obj_dialogueBox);
						with (inst) {
							questionWindowActive = true;
							stackingToActivate = focusedChainStacking;
						}
					}
					exit;
				}
			}
			else {
				// if the focused chain is not a stack, we deselect it
				scr_chainDeselect();
			}
		}
		
		// click on every unit in inRectUnitIDList
		for (var i = 0; i < inRectUnitIDListSize; i++) {
			
			// get current unit, make sure it exists
			var currentUnit = inRectUnitIDList[| i];
			var currentUnitSubMap = global.nodeMap[? currentUnit];
			if (!scr_isNumericAndExists(currentUnitSubMap, ds_type_map)) continue;
			
			// if the quickstack started on a unit that was not in a stack, and this unit is not in a stack, and there is a dragStartOriginalChain defined, let's refocus it
			var currentUnitInChainsList = currentUnitSubMap[? "inChainsList"];
			if (!scr_isNumericAndExists(currentUnitInChainsList, ds_type_list)) continue;
			if (ds_list_size(currentUnitInChainsList) == 0 && obj_chain.dragStartOriginalChain != "") {
				obj_chain.currentFocusedChainID = obj_chain.dragStartOriginalChain;
				obj_chain.stackPrevFocused = obj_chain.currentFocusedChainID;
				with (obj_panelPane) functionChainContents_chainID = obj_chain.currentFocusedChainID;
			}
			
			scr_unitClicked(currentUnit);
		}
		
		global.delayInput = 5;
		
		scr_chainDeselect();
	}

	if (global.steamAPI) {
		if (!steam_get_achievement("SA_quicklink")) {
			steam_set_achievement("SA_quicklink");
		}
	}
	// Reset mouse drag rectangle
	mouseRectMade = false;
	mouseRectReleased = false;
	quickStackAbleToInitiate = true;
	quickStackAbleToSwitch = true;
	mouseRectBeginBetweenWords = -1;
}