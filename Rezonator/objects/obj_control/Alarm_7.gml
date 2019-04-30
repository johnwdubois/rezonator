///@description QuickStack Creation
// Create the quickStack

// Check for things caught in mouse drag rectangle
if (ds_list_size(inRectUnitIDList) > 1 and (obj_toolPane.currentTool == obj_toolPane.toolStackBrush)) {
	var firstUnitID = ds_list_find_value(inRectUnitIDList, 0);
	var firstWordID = ds_list_find_value(inRectWordIDList, 0);
	// Loop through words found in rectangle at time of mouse release
	for(var quickStackLoop = 0; quickStackLoop < ds_list_size(inRectUnitIDList); quickStackLoop++) {
		var currentWordID = ds_list_find_value(inRectWordIDList, quickStackLoop);
		var currentUnitID = ds_list_find_value(inRectUnitIDList, quickStackLoop);
		with (obj_chain) {
			scr_wordClicked(currentWordID, currentUnitID);
			scr_wordClicked(firstWordID, firstUnitID);
		/*var listToSearch = ds_grid_get(unitInStackGrid, unitInStackGrid_colStack, firstUnitID - 1);
		var stackToFocus = ds_list_find_value(listToSearch, 0);
		ds_grid_set(stackChainGrid, chainGrid_colChainState, stackToFocus, chainStateFocus);*/	
		}
	}
	scr_unFocusAllChains();
}

for (var i = 0; i < ds_list_size(inRectUnitIDList); i++) {
	var currentUnitID = ds_list_find_value(inRectUnitIDList, i);
	
	/*
	var stackID = -1;
	if (ds_grid_height(obj_chain.stackChainGrid) > 0) {
		var stackGridRow = ds_grid_value_y(obj_chain.stackChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.stackChainGrid), obj_chain.chainStateFocus);
		if (stackGridRow >= 0 and stackGridRow < ds_grid_height(obj_chain.stackChainGrid)) {
			stackID = ds_grid_get(obj_chain.stackChainGrid, obj_chain.chainGrid_colChainID, stackGridRow);
		}
	}
	*/
	
	//show_message("stackID: " + string(stackID));
	
}

//show_message(scr_getStringOfList(inRectUnitIDList));
// Clear lists for next quickStack
if (ds_list_size(inRectUnitIDList) > 0) {
	ds_list_clear(inRectUnitIDList);
	ds_list_clear(inRectWordIDList);
}

// Reset mouse drag rectangle
mouseHoldRectX1 = 0; 
mouseHoldRectX2 = 0; 
mouseHoldRectY1 = 0; 
mouseHoldRectX2 = 0; 
mouseRectMade = false;
mouseRectReleased = false;
quickStackAbleToInitiate = true;
quickStackAbleToSwitch = true;