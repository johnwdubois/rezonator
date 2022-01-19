

function scr_quickStackCreation(){
	
	// make sure the first unit clicked on is the first unit in the list
	scr_deleteFromList(inRectUnitIDList, obj_chain.dragStartOriginalUnit);
	ds_list_insert(inRectUnitIDList, 0, obj_chain.dragStartOriginalUnit);
	
	show_debug_message("scr_quickStackCreation ... inRectUnitIDList: " + scr_getStringOfList(inRectUnitIDList));

	var inRectUnitIDListSize = ds_list_size(inRectUnitIDList);

	// Check for things caught in mouse drag rectangle
	obj_toolPane.currentTool = obj_toolPane.toolStackBrush;
	if (inRectUnitIDListSize > 0 && quickLinkAllowed) {
	
		// if there is a focused chain that's not a stack, deselect it
		var focusedChainIDSubMap = global.nodeMap[? obj_chain.currentFocusedChainID];
		if (scr_isNumericAndExists(focusedChainIDSubMap, ds_type_map)) {
			var focusedChainType = focusedChainIDSubMap[? "type"];
			if (focusedChainType != "stack") {
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
			}
			
			scr_unitClicked(currentUnit);
		}
		
		global.delayInput = 5;
		
		scr_chainDeselect();
	}

	if(global.steamAPI){
		if(!steam_get_achievement("SA_quicklink")){
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